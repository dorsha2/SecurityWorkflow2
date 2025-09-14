terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.0" }
  }
}

provider "aws" {
  region = "us-east-1"
  # INSECURE (לדמו Secret Scanning): הסרה של ההערה תגרור חסימת push
  # access_key = "AKIAIOSFODNN7EXAMPLE"
  # secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "random_password" "db_pwd" {
  length  = 16
  special = true
}

resource "aws_security_group" "bad_sg" {
  name        = "bad-sg"
  description = "INSECURE: open SSH to the world"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # INSECURE
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"] # INSECURE
  }
}

resource "aws_s3_bucket" "public_bucket" {
  bucket        = "ghas-demo-public-bucket-CHANGE-ME"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.public_bucket.id
  acl    = "public-read" # INSECURE
}

resource "aws_s3_bucket_versioning" "v" {
  bucket = aws_s3_bucket.public_bucket.id
  versioning_configuration { status = "Suspended" } # INSECURE
}
