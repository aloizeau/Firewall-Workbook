variable "location" {
  default     = "West Europe"
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = contains(["West Europe", "North Europe", "France Central"], var.location)
    error_message = "Only Europe and France regions are authorized, please choice between these options: West Europe, North Europe, France Central."
  }
}

variable "retention_in_days" {
  default = 30
  description = "Value in days for retention logs."
  type = number
  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 365
    error_message = "The retention value must be between 30 and 365 days."
  }
}