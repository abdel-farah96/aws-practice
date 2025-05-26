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


resource "aws_security_group" "my_sg" {
  name = "my_security_group"

  description = "Allow SSH and HTTP inbound traffic"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.77.253.1/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "abdel-learning-bucket${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}


resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "s3_profile" {
  name = "test_profile"
  role = aws_iam_role.test_role.name
}

resource "aws_instance" "my_ec2" {
  ami                    = "ami-0030e9fc5c777545a" # Amazon Linux 2 AMI (Free Tier)
  instance_type          = "t2.micro"              # Free-tier eligible instance
  key_name               = "sandbox-key-region-2"  # Replace with your SSH key pair name
  iam_instance_profile   = aws_iam_instance_profile.s3_profile.name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "MyFirstEC2"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
