// --- locals.tf ---
locals {
  // Default alarm configurations
  default_alarms = {
    CPUUtilization = {
      metric_name = "CPUUtilization"
      threshold   = 80
      period      = 300
      eval_periods = 5
      statistic   = "Average"
      operator    = "GreaterThanThreshold"
      description = "CPU utilization is high."
    }
    FreeStorageSpace = {
      metric_name = "FreeStorageSpace"
      threshold   = 10737418240 // 10 GB in bytes
      period      = 300
      eval_periods = 5
      statistic   = "Average"
      operator    = "LessThanThreshold"
      description = "Free storage space is low."
    }
    DatabaseConnections = {
      metric_name = "DatabaseConnections"
      threshold   = 100
      period      = 300
      eval_periods = 5
      statistic   = "Average"
      operator    = "GreaterThanThreshold"
      description = "Database connections are high."
    }
    ReadIOPS = {
      metric_name = "ReadIOPS"
      threshold   = 1000
      period      = 300
      eval_periods = 5
      statistic   = "Average"
      operator    = "GreaterThanThreshold"
      description = "Read IOPS are high."
    }
    WriteIOPS = {
      metric_name = "WriteIOPS"
      threshold   = 1000
      period      = 300
      eval_periods = 5
      statistic   = "Average"
      operator    = "GreaterThanThreshold"
      description = "Write IOPS are high."
    }
  }

  notification_sns_topics = {
    "Email"     = "arn:aws:sns:${var.aws_region}:${var.aws_account_number}:email-rds-alerts"
    "PagerDuty" = "arn:aws:sns:${var.aws_region}:${var.aws_account_number}:pagerduty-rds-alerts"
  }

  // Flatten the alarms for each RDS instance, merging defaults with overrides
  rds_alarms_flat = merge([
    for rds_id, rds_config in var.rds_instances_config : {
      for alarm_name, alarm_config in local.default_alarms :
      "${rds_id}-${alarm_name}" => {
        rds_instance_id     = rds_id
        rds_engine          = rds_config.engine_type
        notification_method = rds_config.notification_method
        alarm_name          = alarm_name
        metric_name         = alarm_config.metric_name
        threshold           = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).threshold
        period              = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).period
        eval_periods        = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).eval_periods
        statistic           = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).statistic
        operator            = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).operator
        description         = lookup(lookup(rds_config, "alarms", {}), alarm_name, alarm_config).description
      }
    }
  ]...)
}

