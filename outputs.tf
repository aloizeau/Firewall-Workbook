output "firewall_public_ip" {
  value       = azurerm_public_ip.fw.ip_address
  description = "The Public IP Address associated to the firewall."
}
