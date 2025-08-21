terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }

  backend "s3" {
    bucket         = "simple-serverless-app-tf-state-bucket-1755394363"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "app-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "Bucket for application"
    Environment = "Dev"
  }
}

