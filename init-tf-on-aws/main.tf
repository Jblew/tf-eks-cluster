variable "access_key" {
  type      = string
  sensitive = true
}
variable "secret_key" {
  type      = string
  sensitive = true
}
variable "region" {
  type      = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region

  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_s3_bucket" "bucket_terraform_state" {
  bucket = "tf-eks-cluster-terraform-state"
}

resource "aws_s3_bucket_versioning" "bucket_terraform_state_versioning" {
  bucket = aws_s3_bucket.bucket_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_terraform_state_encryption" {
  bucket = aws_s3_bucket.bucket_terraform_state.id
  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-eks-cluster-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
