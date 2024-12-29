locals {
  regions = {
    us_east_1 = {
      name = "us-east-1"
      cidr = "10.0.0.0/16"
    }
    us_east_2 = {
      name = "us-east-2"
      cidr = "10.1.0.0/16"
    }
  }

  common_tags = {
    Environment = "production"
    Terraform   = "true"
  }
}
