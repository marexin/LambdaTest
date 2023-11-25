terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
  backend "s3" {}
}

locals {
  tags = {
    Project_name = "Lambda Layers"
    Owner        = "marek.pekarovic@gmail.com"
    Managed_by   = "Terraform"
  }
}
