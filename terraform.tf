terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "ap-northeast-1"
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "mkdocs-containers"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  encryption_configuration {
    encryption_type = "AES256"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_ecr_repo.repository_url
}