terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "anwarias_cloudchallenge_terraform_state"
    force_destroy = true
}

resource "aws_s3_bucket_acl" "private_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}