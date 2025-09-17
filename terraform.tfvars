aws_account_number = "195275674418"
aws_region         = "eu-west-1"
environment        = "prod"

rds_instances_config = {
  "my-rds-instance-1" = {
    engine_type         = "PostgreSQL"
    notification_method = "PagerDuty"
    alarms = {
      CPUUtilization = {
        threshold = 90
      }
      FreeStorageSpace = {
        threshold = 5368709120 // 5 GB in bytes
      }
    }
  }
  "my-rds-instance-2" = {
    engine_type         = "MySQL"
    notification_method = "Email"
    alarms = {
      CPUUtilization = {
        threshold = 75
      }
    }
  }
}