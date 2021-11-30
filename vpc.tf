resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/20"
  enable_dns_hostnames = true
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    "Name" = "test-vpc",
  }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"
  tags = {
    "Name" = "test-gw",
  }
}

resource "aws_subnet" "az1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    "Name" = "web-private-use1a"
  }
}

resource "aws_subnet" "az2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.10.2.0/24"
  availability_zone = "us-east-1b"
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    "Name" = "web-private-use1b"
  }
}

resource "aws_nat_gateway" "web-use1a" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.az1.id
}


resource "aws_nat_gateway" "web-use1b" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.az2.id
}
