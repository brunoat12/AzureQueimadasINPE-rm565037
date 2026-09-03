terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-rm565037"
    storage_account_name = "sttfstaterm565037"
    container_name       = "tfstate"
    key                  = "monitor-queimadas.tfstate"
  }
}


provider "azurerm" {
  features {}
}
