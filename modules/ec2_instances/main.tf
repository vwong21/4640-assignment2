# Variables from networking
variable "subnet_ids" {}
variable "security_group_id" {}

# Instance count to specify individual instances
variable "instance_count" {
  default = 2
}

# EC2 machine type
variable "instance_type" {
  default = "t2.micro"
}

# Variable for instance name
variable "instance_name" {
  default = "a2-instance"
}

# Variable for key pair name
variable "key_pair_name" {
  default = "a2_key"
}

# Creates ec2 instances and runs ansible configuration
resource "aws_instance" "ec2_instances" {
  count           = var.instance_count
  ami             = "ami-080e1f13689e07408"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]
  key_name = var.key_pair_name
  tags = {
    Name = var.instance_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook -i "${self.public_ip}," ~/4640-assignment2/ansible/deploy.yml
    EOT
  }
}

