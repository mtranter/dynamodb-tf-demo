
module "conditional_check_failed_alarm" {

  count   = var.alert_config.on_conditional_check_failed_per_minute != null ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "dynamodb-table-${aws_dynamodb_table.basic-dynamodb-table.name}-delivery-failed"
  alarm_description   = "DynamoDB Table ${aws_dynamodb_table.basic-dynamodb-table.name} has exceeded configured conditional check failure threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alert_config.on_conditional_check_failed_per_minute
  period              = 60
  unit                = "Count"

  namespace   = "AWS/DynamoDB"
  metric_name = "ConditionalCheckFailedRequests"
  statistic   = "Sum"

  dimensions = {
    TableName = aws_dynamodb_table.basic-dynamodb-table.name
  }
}

module "read_throttles_alarm" {

  count   = var.alert_config.on_read_throttles_per_minute != null ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "dynamodb-table-${aws_dynamodb_table.basic-dynamodb-table.name}-read-throttles"
  alarm_description   = "DynamoDB Table ${aws_dynamodb_table.basic-dynamodb-table.name} has exceeded configured read throttles threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alert_config.on_read_throttles_per_minute
  period              = 60
  unit                = "Count"

  namespace   = "AWS/DynamoDB"
  metric_name = "ReadThrottleEvents"
  statistic   = "Sum"

  dimensions = {
    TableName = aws_dynamodb_table.basic-dynamodb-table.name
  }
}

module "write_throttles_alarm" {

  count   = var.alert_config.on_write_throttles_per_minute != null ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "dynamodb-table-${aws_dynamodb_table.basic-dynamodb-table.name}-write-throttles"
  alarm_description   = "DynamoDB Table ${aws_dynamodb_table.basic-dynamodb-table.name} has exceeded configured write throttles threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alert_config.on_read_throttles_per_minute
  period              = 60
  unit                = "Count"

  namespace   = "AWS/DynamoDB"
  metric_name = "WriteThrottleEvents"
  statistic   = "Sum"

  dimensions = {
    TableName = aws_dynamodb_table.basic-dynamodb-table.name
  }
}

module "system_errors_alarm" {

  count   = var.alert_config.on_system_errors == true ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "dynamodb-table-${aws_dynamodb_table.basic-dynamodb-table.name}-system-errors"
  alarm_description   = "DynamoDB Table ${aws_dynamodb_table.basic-dynamodb-table.name} has raised a system error"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 1
  period              = 60
  unit                = "Count"

  namespace   = "AWS/DynamoDB"
  metric_name = "SystemErrors"
  statistic   = "Sum"

  dimensions = {
    TableName = aws_dynamodb_table.basic-dynamodb-table.name
  }
}

module "transaction_conflict_alarm" {

  count   = var.alert_config.on_system_errors == true ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "dynamodb-table-${aws_dynamodb_table.basic-dynamodb-table.name}-tx-conflict"
  alarm_description   = "DynamoDB Table ${aws_dynamodb_table.basic-dynamodb-table.name} has exceeded configured transaction conflicts threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 1
  period              = 60
  unit                = "Count"

  namespace   = "AWS/DynamoDB"
  metric_name = "TransactionConflict"
  statistic   = "Sum"

  dimensions = {
    TableName = aws_dynamodb_table.basic-dynamodb-table.name
  }
}


