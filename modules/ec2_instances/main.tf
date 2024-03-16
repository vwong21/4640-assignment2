variable "subnet_ids" {}
variable "security_group_id" {}

variable "instance_count" {
  default = 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "a2-instance"
}

resource "aws_instance" "ec2_instances" {
  count           = var.instance_count
  ami             = "ami-080e1f13689e07408"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]
  tags = {
    Name = var.instance_name
  }
}
