// --- main.tf ---
provider "aws" {
  region = var.aws_region
  // Assuming credentials are provided by the CI/CD pipeline, e.g., via OIDC
}

// Create SNS topics if they don't exist (or reference existing ones with data sources)
resource "aws_sns_topic" "rds_alerts" {
  for_each = local.notification_sns_topics
  name     = each.key
}

module "rds_alarm" {
  source   = "./modules/rds_alarm"
  for_each = local.rds_alarms_flat

  aws_account_number  = var.aws_account_number
  environment         = var.environment
  rds_instance_id     = each.value.rds_instance_id
  region              = var.aws_region
  rds_engine_type     = each.value.rds_engine
  notification_method = each.value.notification_method
  alarm_config        = each.value
  sns_topic_arns      = { for k, v in aws_sns_topic.rds_alerts : k => v.arn }
}