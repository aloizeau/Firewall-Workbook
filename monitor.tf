resource "azurerm_log_analytics_workspace" "law" {
  name                = "fw-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azurerm_monitor_diagnostic_categories" "fw" {
  resource_id = azurerm_firewall.fw.id
}

resource "azurerm_monitor_diagnostic_setting" "fw" {
  name                       = "diagnostic_setting"
  target_resource_id         = data.azurerm_monitor_diagnostic_categories.fw.resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw.metrics
    content {
      category = metric.value

      retention_policy {
        enabled = true
        days    = 7
      }
    }
  }

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw.log_category_types
    content {
      category = enabled_log.value

      retention_policy {
        enabled = true
        days    = 7
      }
    }
  }

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.fw.log_category_groups
    content {
      category_group = enabled_log.value

      retention_policy {
        enabled = true
        days    = 7
      }
    }
  }
}

resource "random_uuid" "firewall_workbook" {
}

resource "azurerm_application_insights_workbook" "firewall_workbook" {
  name                = random_uuid.firewall_workbook.result
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Azure Firewall Workbook"
  source_id           = lower(azurerm_log_analytics_workspace.law.id)
  category            = "workbook"
  data_json           = jsonencode(templatefile("./workbooks/AzureFirewallWorkbookTemplate.json", { workbookSourceId = azurerm_log_analytics_workspace.law.id }))
}
