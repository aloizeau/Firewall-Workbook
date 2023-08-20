variable "location" {
  default     = "West Europe"
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = contains(["West Europe", "North Europe", "France Central"], var.location)
    error_message = "Only Europe and France regions are authorized, please choice between these options: West Europe, North Europe, France Central."
  }
}
