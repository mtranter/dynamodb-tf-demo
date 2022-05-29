

variable "name" {
  type = string
}

variable "point_in_time_recovery_enabled" {
  type = bool
  default = true
}

variable "provisioned_capacity" {
  type = object({
    read  = number
    write = number
  })
  default     = null
  description = <<EOF
The provisioned capacity for this table. e.g. 
provisioned_capacity = {
  read = 1
  write = 1
}
EOF
}

variable "hash_key" {
  type = object({
    name = string
    type = string
  })

  description = <<EOF
The hash key definition for this table. e.g.
hash_key = {
  name = "id"
  type = "S"
}
EOF
}

variable "range_key" {
  type = object({
    name = string
    type = string
  })
  default     = null
  description = <<EOF
The range key definition for this table. e.g.
range_key = {
  name = "id"
  type = "S"
}
EOF
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
    provisioned_capacity = optional(object({
      read_capacity  = number
      write_capacity = number
    }))
    hash_key = object({
      name = string
      type = string
    })
    range_key = optional(object({
      name = string
      type = string
    }))
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

variable "alert_config" {
  type = object({
    on_conditional_check_failed_per_minute = optional(number)
    on_read_throttles_per_minute           = optional(number)
    on_write_throttles_per_minute          = optional(number)
    on_failed_to_replicate                 = optional(bool)
    on_system_errors                       = optional(bool)
    on_transaction_conflict_per_minute     = optional(number)

  })
  default = {
    on_conditional_check_failed_per_minute = null
    on_read_throttles_per_minute           = null
    on_write_throttles_per_minute          = null
    on_system_errors                       = true
    on_transaction_conflict_per_minute     = null
  }
  description = <<EOF
Configuration for Cloudwatch alarms. e.g
alert_config = {
    on_conditional_check_failed_per_minute = null
    on_read_throttles_per_minute           = 10
    on_write_throttles_per_minute          = 5
    on_system_errors                       = true
    on_transaction_conflict_per_minute     = null
}
EOF
}
