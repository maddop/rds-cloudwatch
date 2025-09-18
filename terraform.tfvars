aws_account_number = "195275674418"
aws_region         = "eu-west-1"
#tf_s3_bucket      = "maddo-cloudwatch-tf-state-2016"
#tf_s3_key         = "maddo-cloudwatch/terraform.tfstate"
environment        = "prod"
rds_master_username = "maddop"
rds_master_password = "changeMe123!"

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