resource "azurerm_storage_account" "func_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "func_deployment" {
  name                  = "deploymentpackage"
  storage_account_id    = azurerm_storage_account.func_storage.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "func_plan" {
  name                = "plan-queimadas-rm565037"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "FC1"
}

resource "azurerm_function_app_flex_consumption" "func" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.func_plan.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.func_storage.primary_blob_endpoint}${azurerm_storage_container.func_deployment.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.func_storage.primary_access_key

  runtime_name    = "python"
  runtime_version = "3.11"

  maximum_instance_count = 50
  instance_memory_in_mb  = 2048

  site_config {}

  app_settings = {
    SQL_SERVER = azurerm_mysql_flexible_server.mysql.fqdn
    SQL_USER   = var.mysql_admin_user
    SQL_PASS   = var.mysql_admin_password
    SQL_DB     = var.sql_db_name
  }
}
