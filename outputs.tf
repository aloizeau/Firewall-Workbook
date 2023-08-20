output "firewall_diagnostic_categories" {
  value       = data.azurerm_monitor_diagnostic_categories.fw
  description = "Diagnostic categories details on Azure firewall resource."
}

output "firewall_public_ip" {
  value       = azurerm_public_ip.fw.ip_address
  description = "The Public IP Address associated to the firewall."
}
