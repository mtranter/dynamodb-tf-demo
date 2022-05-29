

variable "name" {
  type = string
}

variable "billing_mode" {
  type = string
}

variable "read_capacity" {
  type = number
}

variable "write_capacity" {
  type = number
}

variable "hash_key" {
  type = string
}

variable "range_key" {
  type = string
}

variable "attributes" {
  type = set(object({
      name = string
      type = string
  }))
}


variable "local_secondary_indexes" {
  default = []
  type = set(object({
    name = string
    range_key = optional(object({
      name = string
      type = string
    }))
    projection_type    = optional(string)
    non_key_attributes = optional(list(string))
  }))
  description = <<EOF
Any local secondary indexes for this table. e.g.
local_secondary_indexes = [{
  name "IxByName"
  range_key = {
    name = "name"
    type = "S"
  }
  projection_type = "INCLUDE" //Optional. Defaults to ALL
  non_key_attributes = ["id", "age", "dob"] //Required if projection_type = "INCLUDE"
}]
EOF
}

variable "global_secondary_indexes" {
  default = []
  type = set(object({
    name = string
    read_capacity = optional(number)
    write_capacity = optional(number)
    hash_key = string
    range_key = string
    projection_type    = optional(string)
    non_key_attributes = optional(list(string))
  }))
  description = <<EOF
Any global secondary indexes for this table. e.g.
local_secondary_indexes = [{
  name "IxByOrderAndProduct"
  provisioned_capacity = {
    read = 1
    write = 1
  }
  hash_key = {
    name = "orderId"
  }
  range_key = {
    name = "productId"
  }
  projection_type = "INCLUDE" //Optional. Defaults to ALL
  non_key_attributes = ["sku", "price", "description"] //Required if projection_type = "INCLUDE"
}]
EOF
}


variable "tags" {
  type = map(string)
}
