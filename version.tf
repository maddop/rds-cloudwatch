# terraform/versions.tf
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configure S3 backend for Terraform state management
  backend "s3" {
    bucket         = "maddo-cloudwatch-tf-state-2016" # Replace with a unique bucket name
    key            = "maddo-cloudwatch/terraform.tfstate"
    region         = "eu-west-1" # State bucket should be in a fixed region
    encrypt        = true
    use_lockfile   = true
  }
}