module "dynamo_table" {
  source         = "./module"
  name           = "LeanKeyValueStore"
  provisioned_capacity = {
    read = 5
    write = 5
  }
  hash_key = {
    name = "TenantId"
    type = "S"
  }
  range_key = {
    name = "EntityId"
    type = "S"
  }

  global_secondary_indexes = [{
    name = "IxByUserId"
    hash_key = {
      name = "UserId"
      type = "S"
    }
    range_key = {
      name = "TenantId"
      type = "S"
    }
  }]
  tags = {
    Environment = "Prod"
  }
}
