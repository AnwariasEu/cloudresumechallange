resource "aws_s3_bucket" "databucket" {
  bucket        = var.databucket
  force_destroy = true
}

