variable "region" {
  description = "AWS region"
}

provider "aws" {
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 3
  special = false
}

