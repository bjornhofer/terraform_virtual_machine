

resource "azurerm_public_ip" "main" {
  count               = var.virtual_machine_public_ip ? 1 : 0
  name                = "${var.virtual_machine_name}_pip"
  location            = var.virtual_machine_location
  resource_group_name = var.virtual_machine_resource_group
  allocation_method   = "Dynamic"
  domain_name_label   = var.virtual_machine_domain_name_label == null ? var.virtual_machine_name : var.virtual_machine_domain_name_label
  provider = azurerm.virtual_machine
}

resource "azurerm_network_interface" "main" {
  name                = "${var.virtual_machine_name}_nic"
  location            = var.virtual_machine_location
  resource_group_name = var.virtual_machine_resource_group

  ip_configuration {
    name                          = "${var.virtual_machine_name}_ipconfig"
    subnet_id                     = var.virtual_machine_subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = var.virtual_machine_public_ip ? azurerm_public_ip.main[0].id : null
  }
  depends_on = [
    azurerm_public_ip.main
  ]
  provider = azurerm.virtual_machine
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.virtual_machine_name
  location                        = var.virtual_machine_location
  resource_group_name             = var.virtual_machine_resource_group
  size                            = var.virtual_machine_size
  admin_username                  = var.virtual_machine_admin_user
  admin_password                  = var.virtual_machine_admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]
  // Disabled due to problems
  /*
  admin_ssh_key {
    username   = var.virtual_machine_admin_user
    // Disabled due to problems
    //public_key = var.virtual_machine_public_key
    admin_password = var.virtual_machine_admin_password
  }
  */

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.main
  ]
  provider = azurerm.virtual_machine
}