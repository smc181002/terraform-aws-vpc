resource "aws_vpc" "mod_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "mod_subnet" {
  depends_on = [
    aws_vpc.mod_vpc
  ]

  count      = length(var.subnet_cidr_block)
  vpc_id     = aws_vpc.mod_vpc.id
  cidr_block = element(var.subnet_cidr_block, count.index)

  tags = {
    Name = element(var.subnet_names, count.index)
  }
}

resource "aws_internet_gateway" "mod_igw" {
  depends_on = [
    aws_vpc.mod_vpc
  ]
  vpc_id = aws_vpc.mod_vpc.id

  tags = {
    Name = var.gateway_name
  }
}

resource "aws_route_table" "mod_route_table" {
  depends_on = [
    aws_vpc.mod_vpc
  ]

  vpc_id = aws_vpc.mod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mod_igw.id
  }

  tags = {
    Name = var.route_table_name
  }

}

resource "aws_route_table_association" "mod_route_association" {
  depends_on = [
    aws_vpc.mod_vpc,
    aws_subnet.mod_subnet
  ]

  count          = length(aws_subnet.mod_subnet)
  subnet_id      = aws_subnet.mod_subnet[count.index].id
  route_table_id = aws_route_table.mod_route_table.id
}
