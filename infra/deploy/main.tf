terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.23.0"
    }
  }

  backend "s3" {
    bucket         = "epldt-devops"
    key            = "tf-state-deploy"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "devops-tf-lock"
    workspace_key_prefix = "tf-state-deploy-env"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      contact     = var.contact
      ManageBy    = "Terraform/deploy"
    }
  }
}

locals {
    prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}
