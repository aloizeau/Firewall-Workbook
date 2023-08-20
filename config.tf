terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.68.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  tenant_id       = "40d0d33d-94bb-4ec5-9333-c571e343b393"
  subscription_id = "120733fd-b9b2-4fe2-9eca-f4a95ffed4ae" #Training
  # subscription_id = "23f06756-f093-4d64-9ea3-e5cea54805c8" # VM 

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers. 

  # All options are listed here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {
    # https://github.com/hashicorp/terraform-provider-azurerm/issues/8968
    # key_vault {
    #   purge_soft_delete_on_destroy = false
    # }
    # resource_group {
    #   prevent_deletion_if_contains_resources = true
    # }
  }
}
