resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc

  tags = {
    Name = "vpc-${var.enviroment}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet

  tags = {
    Name = "subnet-${var.enviroment}"
  }
}
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gateway-${var.enviroment}"
  }
}


resource "aws_route_table" "rout_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "rout-table-${var.enviroment}"
  }
}

resource "aws_route_table_association" "art" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rout_table.id
}

resource "aws_security_group" "security_group" {
  name   = "security_group-${var.enviroment}"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}