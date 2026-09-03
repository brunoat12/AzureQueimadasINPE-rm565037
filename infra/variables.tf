variable "location" {
  default = "eastus2"
}

variable "resource_group_name" {
  default = "rg-monitor-queimadas-rm565037"
}

variable "mysql_admin_user" {
  default = "adminuser"
}

variable "mysql_admin_password" {
  type      = string
  sensitive = true
}

variable "sql_db_name" {
  default = "db_queimadas_rm565037"
}

variable "function_app_name" {
  default = "func-queimadas-rm565037"
}

variable "storage_account_name" {
  default = "stqueimadasfuncrm565037"
}
