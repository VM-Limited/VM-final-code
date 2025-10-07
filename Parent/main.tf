module "rg" {
  source      = "../Child/resource_group"
  rg_name     = "rg_mq"
  rg_location = "centralindia"
}

module "vnet" {
  depends_on         = [module.rg]
  source             = "../Child/vnet"
  vnet_name          = "vnet_mq"
  rg_location      = "centralindia"
  rg_name            = "rg_mq"
  address_space = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on              = [module.vnet]
  source                  = "../Child/subnet"
  subnet_name             = "frontendsubnet_mq"
  rg_name                 = "rg_mq"
  vnet_name               = "vnet_mq"
  address_prefixes        = ["10.0.1.0/24"]
}

module "backend_subnet" {
  depends_on              = [module.vnet]
  source                  = "../Child/subnet"
  subnet_name             = "backendsubnet_mq"
  rg_name                 = "rg_mq"
  vnet_name               = "vnet_mq"
  address_prefixes = ["10.0.2.0/24"]
}


module "public_ip_frontend" {

  source            = "../Child/public_ip"
  depends_on      = [module.rg]
  pip_name          = "pip_frontend_mq"
  rg_name           = "rg_mq"
  rg_location       = "centralindia"
  allocation_method = "Static"
  

}

module "public_ip_backend" {

  source            = "../Child/public_ip"
  depends_on      = [module.rg]
  pip_name          = "pip_backend_mq"
  rg_name           = "rg_mq"
  rg_location       = "centralindia"
  allocation_method = "Static"

}

module "Frontend_virtual_machine" {
  depends_on      = [module.frontend_subnet, module.public_ip_frontend]
  source          = "../Child/vm"
  vm_name         = "frontvm-mq"
  rg_name         = "rg_mq"
  rg_location     = "centralindia"
  admin_username  = "mansoorvm"
  admin_password  = "Password1234!"
  nic_name        = "nicfront_mq"
  vm_size         = "Standard_B1s"
  publisher       = "Canonical"
  offer          = "UbuntuServer"
  sku            = "18.04-LTS"
  
  vnet_name       = "vnet_mq"
  os_disk_name    = "osdisk-frontend-mq"
 os_disk_caching = "ReadWrite"
  subnet_name     = "frontendsubnet_mq"
  pip_name        = "pip_frontend_mq"

}


module "backend_virtual_machine" {
  depends_on      = [module.backend_subnet, module.public_ip_backend]
  source          = "../Child/vm"
  vm_name         = "backendvm-mq"
  rg_name         = "rg_mq"
  rg_location     = "centralindia"
  admin_username  = "umairvm"
  admin_password  = "Password12345!"
  nic_name        = "nicback_mq"
  vm_size         = "Standard_B1s"
  publisher       = "Canonical"
  offer          = "0001-com-ubuntu-server-focal"
  sku            = "20_04-lts"
  
  os_disk_name    = "osdisk-backend-mq"
  os_disk_caching = "ReadWrite"
  vnet_name       = "vnet_mq"
  subnet_name     = "backendsubnet_mq"
  pip_name        = "pip_backend_mq"

}

module "sql_server" {
   depends_on = [module.Frontend_virtual_machine]
  source                = "../Child/sqlserver_module"
sql_server_name       = "sqlserver-mq"
 resource_group_name   = "rg_mq"
location              = "centralindia"
admin_login           = "sqlmq"
admin_password        = "Password1234!"
}

 sql server id is only known once sql server is created. copy from portal sql server json view

module "sql_database" {
   depends_on = [module.sql_server]
  source                = "../Child/sqldatabase_module"
 sql_database_name     = "sqldatabase-mq"

resource_group_name   = "rg_mq"
mssql_server_name     = "sqlserver-mq"
}
