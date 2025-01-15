resource "aws_vpc" "First" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "First-vpc"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.First.id

  tags = {
    Name = "First-IGW"
  }
}
resource "aws_subnet" "First" {
    vpc_id = aws_vpc.First.id
    cidr_block = "10.0.16.0/20"
    map_public_ip_on_launch = true
    tags = {
        Name = "First-1"
    }
}
resource "aws_subnet" "First-2" {
    vpc_id = aws_vpc.First.id
    cidr_block = "10.0.32.0/20"
    tags = {
        Name = "First-2"
    }
}
resource "aws_route_table" "First-RT" {
    vpc_id = aws_vpc.First.id
    tags = {
        Name = "First-RT"
    }
}
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.First-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.First.id
  route_table_id = aws_route_table.First-RT.id
}
