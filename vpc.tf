resource "aws_vpc" "custom_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "custom_vpc"
  }
}

resource "aws_subnet" "custom_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "custom_subnet"
  }

}
