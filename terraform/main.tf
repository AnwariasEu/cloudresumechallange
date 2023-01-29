terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket         = "anwarias-cloudchallenge-terraform-state"
    key            = "tf-infra/terraform.tfstate"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
    region         = "eu-central-1"
  }
}
