terraform {
  experiments = [module_variable_optional_attrs]
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    iterator = each
    content {
      name               = each.value.name
      write_capacity     = each.value.write_capacity
      read_capacity      = each.value.read_capacity
      hash_key           = each.value.hash_key
      range_key          = each.value.range_key
      projection_type    = coalesce(each.value.projection_type, "ALL")
      non_key_attributes = each.value.non_key_attributes == null ? [] : each.value.non_key_attributes
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    iterator = each
    content {
      name               = each.value.name
      range_key          = each.value.range_key.name
      projection_type    = coalesce(each.value.projection_type, "ALL")
      non_key_attributes = each.value.non_key_attributes == null ? [] : each.value.non_key_attributes
    }
  }

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = var.tags 
}