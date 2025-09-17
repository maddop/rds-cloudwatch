// --- variables.tf ---
variable "aws_account_number" {
  description = "The AWS Account ID to deploy resources into."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)."
  type        = string
}

variable "rds_instances_config" {
  description = "A map of RDS instances to configure alarms for. The key is the RDS instance identifier."
  type = map(object({
    engine_type         = string
    notification_method = string
    alarms = optional(map(object({
      threshold    = number
      period       = optional(number, 300)
      eval_periods = optional(number, 5)
      statistic    = optional(string, "Average")
      operator     = optional(string, "GreaterThanThreshold")
      description  = optional(string, "Alarm description")
    })), {})
  }))
  default = {}
}