# default aws terraform provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# aws cloud provider
provider "aws" {
  region     = "ap-northeast-1"
  access_key = "<your_key>"
  secret_key = "<your_secret>"
}

# creating ECR repository
resource "aws_ecr_repository" "my_ecr_repo" {
  name = "mkdocuments"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  encryption_configuration {
    encryption_type = "AES256"
  }
}
