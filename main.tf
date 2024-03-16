provider "aws" {
  region = "us-east-1"
}

variable "availability_zones" {
  description = "List of availability zones to use for creating subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

module "networking" {
  source = "./modules/networking"

  availability_zones = var.availability_zones
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  subnet_ids        = module.networking.public_subnets
  security_group_id = module.networking.security_group_id
}
