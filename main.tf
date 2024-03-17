# Specifies provider
provider "aws" {
  region = "us-east-1"
}

# Creates availability zone variable
variable "availability_zones" {
  description = "List of availability zones to use for creating subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# calls networking module and passes availability zone variable through
module "networking" {
  source = "./modules/networking"

  availability_zones = var.availability_zones
}

# calls ec2_instances module and passes subnet_ids and security_group_id as variables from networking module
module "ec2_instances" {
  source = "./modules/ec2_instances"

  subnet_ids        = module.networking.public_subnets
  security_group_id = module.networking.security_group_id
}
