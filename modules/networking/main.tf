# Defines Availability Zone variable
variable "availability_zones" {}

# Creates VPC called a2_vpc
resource "aws_vpc" "a2_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Creates Internet Gateway called a2_igw
resource "aws_internet_gateway" "a2_igw" {
  vpc_id = aws_vpc.a2_vpc.id
}

# Creates public subnets. Uses availability zone variable to specify each subnet
resource "aws_subnet" "public_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.a2_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

# Creates Security Group called a2_sg. Defines ingress for ssh and http.
resource "aws_security_group" "a2_sg" {
  vpc_id = aws_vpc.a2_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Outputs variables
output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "security_group_id" {
  value = aws_security_group.a2_sg.id
}
