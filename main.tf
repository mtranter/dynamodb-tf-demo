module "dynamo_table" {
  source         = "./module"
  name           = "LeanKeyValueStore"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "TenantId"
  range_key      = "EntityId"
  global_secondary_indexes = [{
    name      = "IxByUserId"
    hash_key  = "UserId"
    range_key = "TenantId"
  }]
  attributes = [{
    name = "TenantId"
    type = "S"
    }, {
    name = "EntityId",
    type = "S"
    }, {
    name = "UserId",
    type = "S"
  }]
  tags = {
    Environment = "Prod"
  }
}
