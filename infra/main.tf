variable "aws_access_key_id" {
  type      = string
  sensitive = true
}
variable "aws_secret_access_key" {
  type      = string
  sensitive = true
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
  region = "eu-central-1"

  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
