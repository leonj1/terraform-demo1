terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default provider configuration for LocalStack
provider "aws" {
  region = "us-east-1"
  
  # LocalStack configuration
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style          = true

  endpoints {
    ecs            = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    route53        = "http://localhost:4566"
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  
  # LocalStack configuration
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style          = true

  endpoints {
    ecs            = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    route53        = "http://localhost:4566"
  }
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
  
  # LocalStack configuration
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style          = true

  endpoints {
    ecs            = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    route53        = "http://localhost:4566"
  }
}
