terraform {
  backend "s3" {
    bucket  = "sandbox-tf-bucket"
    key     = "terraform.tfstate" # Folder-like path in S3
    region  = "us-east-2"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2" # Change to your preferred AWS region }
}


