# all resources created with this provider will have default tags
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = local.tags
  }
}
