terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.0" }
  }
}

provider "aws" {
  region = "us-east-1"
  # access_key = "AKIAIOSFODNN7EXAMPLE"   # לשימוש Secret Scanning
  # secret_key = "wJalrXUtnFEMI/EXAMPLE"
}

resource "random_password" "db_pwd" {
  length  = 16
  special = true
}

resource "aws_security_group" "bad_sg" {
  name = "bad-sg"
  ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  egress  { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }
}
