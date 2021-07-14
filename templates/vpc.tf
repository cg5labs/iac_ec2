variable "region" {
  description = "AWS region"
}

provider "aws" {
}

resource "random_string" "suffix" {
  length  = 3
  special = false
}


