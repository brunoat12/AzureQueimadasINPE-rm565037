output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}

output "function_app_url" {
  value = "https://${azurerm_function_app_flex_consumption.func.name}.azurewebsites.net"
}
