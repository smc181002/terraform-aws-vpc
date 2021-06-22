# AWS VPC Launcing module

This Terraform module is used to create a VPC with certain options.

## Usage

### Inputs [arguments]

- `vpc_cidr_block`(Required): VPC network name. ex: `10.0.0.0/16`
- `vpc_name`(Optional):  label the vpc with `Name` Key
- `subnet_cidr_block`(Required): list of VPC subnet network name.
  ex: `[10.0.0.0/24, 10.0.1.0/24]`
- `subnet_names`(Optional): label the subnet with `Name` Key as a list
  ex: `[subnet1, subnet2]`
- `gateway_name`(Optional): label the interet gateway with `Name` Key
- `route_table_name`(Optional): label the routing table with `Name` Key

## Example

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # Replace with the region of your choice
  profile = "default"
}

module "module_test" {
  source = "../aws-vpc-launch"

  vpc_name = "tf_vpc"
  vpc_cidr_block = "10.0.0.0/16"
  subnet_names = ["subnet1", "subnet2"]
  subnet_cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
  gateway_name = "tf_igw"
  route_table_name = "tf_route_table"
}

output "aws_vpc_id" {
  value = module.module_test.vpc.id
}

output "aws_gateway_id" {
  value = module.module_test.gateway.id
}
```

