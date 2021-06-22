output "vpc" {
  value = aws_vpc.mod_vpc
}

output "subnet" {
  value = aws_subnet.mod_subnet
}

output "gateway" {
  value = aws_internet_gateway.mod_igw
}
