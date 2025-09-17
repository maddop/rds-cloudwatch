variable "aws_account_number" {
  description = "The AWS Account ID."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)."
  type        = string
}

variable "rds_instance_id" {
  description = "The ID of the RDS instance."
  type        = string
}

variable "region" {
  description = "The AWS region."
  type        = string
}

variable "rds_engine_type" {
  description = "The database engine type of the RDS instance."
  type        = string
}

variable "notification_method" {
  description = "The notification method (e.g., Email, PagerDuty)."
  type        = string
}

variable "alarm_config" {
  description = "A map containing the configuration for a single alarm."
  type = object({
    alarm_name   = string
    metric_name  = string
    threshold    = number
    period       = number
    eval_periods = number
    statistic    = string
    operator     = string
    description  = string
  })
}

variable "sns_topic_arns" {
  description = "A map of notification methods to SNS topic ARNs."
  type        = map(string)
}