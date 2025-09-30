terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "aa50dcb0-04de-41e4-bb3e-260e54d18bec"
}
