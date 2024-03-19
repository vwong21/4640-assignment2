# Creates VPC called a2_vpc
resource "aws_vpc" "a2_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Creates Internet Gateway called a2_igw
resource "aws_internet_gateway" "a2_igw" {
  vpc_id = aws_vpc.a2_vpc.id
}

# Creates Route Table
resource "aws_route_table" "a2_rt" {
  vpc_id = aws_vpc.a2_vpc.id
}

# Sets Route to Internet Gateway
resource "aws_route" "a2_route" {
  route_table_id = aws_route_table.a2_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.a2_igw.id
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.a2_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.a2_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# Associates Route Table with subnets
resource "aws_route_table_association" "association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.a2_rt.id
}
resource "aws_route_table_association" "association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.a2_rt.id
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
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "security_group_id" {
  value = aws_security_group.a2_sg.id
}
