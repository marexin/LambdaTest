terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
  # we will use s3 bucket to store terraform state file
  backend "s3" {}
}

locals {
  tags = {
    Project_name = "Lambda Layers"
    Owner        = "marek.pekarovic@gmail.com"
    Managed_by   = "Terraform"
  }
}
