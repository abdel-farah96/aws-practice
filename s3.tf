
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

