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

  alert_config = {
    on_conditional_check_failed_per_minute = 1
    on_failed_to_replicate = false
    on_read_throttles_per_minute = 50
    on_system_errors = true
    on_transaction_conflict_per_minute = 1
    on_write_throttles_per_minute = 10
  }
  tags = {
    Environment = "Prod"
  }
}
