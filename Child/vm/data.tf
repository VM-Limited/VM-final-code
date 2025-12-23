data azurerm_public_ip pip {
  name                = var.pip_name
  resource_group_name = var.rg_name
}
data azurerm_subnet subnet {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
}

data azurerm_network_interface nic {
  name                = var.nic_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name_kv
}

data "azurerm_key_vault_secret" "password" {
  name         = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}



data "azurerm_key_vault_secret" "username" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}



