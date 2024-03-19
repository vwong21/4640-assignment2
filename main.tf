# Specifies provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# calls networking module and passes availability zone variable through
module "networking" {
  source = "./modules/networking"
}

# calls ec2_instances module and passes subnet_ids and security_group_id as variables from networking module
module "ec2_instances" {
  source = "./modules/ec2_instances"

  public_subnet_1_id        = module.networking.public_subnet_1_id
  public_subnet_2_id        = module.networking.public_subnet_2_id
  security_group_id = module.networking.security_group_id
}
