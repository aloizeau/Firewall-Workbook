terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.70.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
  # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers. 
  skip_provider_registration = true
  # All options are listed here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
