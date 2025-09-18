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
    bucket       = var.tf_s3_bucket
    key          = var.tf_s3_key
    region       = "eu-west-1" # State bucket should be in a fixed region
    encrypt      = true
    use_lockfile = true
  }
}