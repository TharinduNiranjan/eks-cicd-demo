resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id


}

resource "aws_route_table_association" "public" {
  count          = length(var.public_cidrs)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.*.id[count.index]
}

resource "aws_eip" "nat_eip" {

}

resource "aws_nat_gateway" "tool_svrs_nat_gw" {
  subnet_id     = aws_subnet.public[1].id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "tool_servers_nat_gw"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.public_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "private_subnet_${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_cidrs)
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.id
}



resource "aws_route" "default_private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.tool_svrs_nat_gw.id
}

resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  tags = {
    Name = "private_default_route_table"
  }
}
