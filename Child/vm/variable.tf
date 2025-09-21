
variable "rg_name" {}

variable "vm_size" {}
variable "publisher" {}
variable "offer" {}
variable "sku" {}    




variable "vm_name" {}
variable "vm_version" {
  default = "latest"
}
variable "admin_username" {}
variable "admin_password" {}
variable "os_disk_name" {}
variable "os_disk_caching" {}   
variable "pip_name" {}
variable "nic_name" {}
variable "subnet_name" {}
variable "vnet_name" {}
variable "rg_location" {}