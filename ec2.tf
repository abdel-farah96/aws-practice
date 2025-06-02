
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
