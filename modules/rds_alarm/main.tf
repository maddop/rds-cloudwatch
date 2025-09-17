// --- modules/rds_alarm/main.tf ---
resource "aws_cloudwatch_metric_alarm" "rds_metric_alarm" {
  alarm_name          = "${var.rds_instance_id}-${var.environment}-${var.alarm_config.alarm_name}"
  comparison_operator = var.alarm_config.operator
  evaluation_periods  = var.alarm_config.eval_periods
  metric_name         = var.alarm_config.metric_name
  namespace           = "AWS/RDS"
  period              = var.alarm_config.period
  statistic           = var.alarm_config.statistic
  threshold           = var.alarm_config.threshold

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  alarm_description = "Alarm for ${var.alarm_config.metric_name} on RDS instance ${var.rds_instance_id} (${var.rds_engine_type}) in Account ${var.aws_account_number}, Region ${var.region}. ${var.alarm_config.description}"

  alarm_actions = [lookup(var.sns_topic_arns, var.notification_method, "")]
  ok_actions    = [lookup(var.sns_topic_arns, var.notification_method, "")]
}