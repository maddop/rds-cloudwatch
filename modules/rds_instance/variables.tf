variable "identifier" {
  description = "The name of the RDS instance."
  type        = string
}

variable "username" {
  description = "Master username for the database."
  type        = string
}

variable "password" {
  description = "Master password for the database."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name."
  type        = string
}
