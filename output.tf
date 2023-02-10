output "virtual_machine_id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "virtual_machine_nic" {
  value = azurerm_network_interface.main
}

output "virtual_machine_public_ip" {
  value = var.virtual_machine_public_ip ? azurerm_public_ip.main[0] : null
}
