variable "vpc_name" {
  type    = string
  default = null
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"

  validation {
    condition = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.vpc_cidr_block))

    error_message = "The VPC cidr block is an invalid network name. Choose a valid network network name."
  }
}

variable "subnet_names" {
  type    = list(any)
  default = null
}

variable "subnet_cidr_block" {
  type    = list(any)
  default = ["10.0.0.0/24"]

  validation {
    condition     = can([for cidr in var.subnet_cidr_block : regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", cidr)])
    error_message = "The Subnet cidr block is an invalid network name. Choose a valid network network name."
  }
}

variable "gateway_name" {
  type    = string
  default = null
}

variable "route_table_name" {
  type    = string
  default = null
}
