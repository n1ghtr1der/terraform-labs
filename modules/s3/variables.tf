variable "project_name" {
  type = string
  description = "Project Name"
}
variable "environment" {
  type = string
  description = "Environment name"
  default = "dev"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}

#S3 Versioning
variable "versioning_status" {
  type = string
  default = "Disabled"
  validation {
    condition = contains(["Enabled", "Disabled", "Suspended"], var.versioning_status)
    error_message = "This variable value must be one of: Enabled, Disabled or Suspended"
  }
}

variable "enable_lifecycle" {
  type = bool
  default = false
}

#S3 Lifecycle
variable "lifecycle_days_to_standard_ia" {
    type = number
    default = 30
}

variable "lifecycle_days_to_glacier" {
    type = number
    default = 90
}

variable "lifecycle_days_to_delete" {
    type = number
    default = 365
}