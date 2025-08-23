provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "tf-labs"
    }
  }
}

terraform {
  required_version = ">=1.8.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.61.0"
    }
    random = {
        source = "hashicorp/random"
        version = "= 3.1.3"
    }
    template = {
        source = "hashicorp/template"
        version = "= 2.2.0"
    }
  }
}