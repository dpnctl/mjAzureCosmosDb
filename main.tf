# Declare the provider - Azure in our case
provider "azurerm" {
  features {}
}

# Details of CosmosDB Account
resource "azurerm_cosmosdb_account" "default" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = var.region
    failover_priority = 0
  }

  capabilities {
    name = "EnableCassandra"
  }
}

# Details of the CosmosDB container
resource "azurerm_cosmosdb_sql_container" "default" {
  name                = var.container_name
  cosmosdb_account_id = azurerm_cosmosdb_account.default.id
  database_name       = var.database_name
  partition_key_path  = var.partition_key_path

  indexing_policy {
    automatic = true
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
      indexes {
        kind    = "Hash"
        data_type = "String"
      }
    }

    excluded_path {
      path = "/path/to/exclude/*"
    }
  }
}

# Details of Redis Cache for enhanced response time 
resource "azurerm_redis_cache" "default" {
  count = var.enable_cache ? 1 : 0

  name                = "${var.name}-redis"
  location            = var.region
  resource_group_name = var.resource_group_name
  capacity            = var.redis_capacity
  family              = "C"
  sku {
    name = var.redis_sku
    capacity = var.redis_capacity
  }
}

output "cosmosdb_account_name" {
  description = "The name of the Cosmos DB account."
  value       = azurerm_cosmosdb_account.default.name
}

output "cosmosdb_sql_container_name" {
  description = "The name of the Cosmos DB SQL container."
  value       = azurerm_cosmosdb_sql_container.default.name
}

output "redis_cache_instance" {
  description = "The Redis cache instance name (if enabled)."
  value       = azurerm_redis_cache.default[0].name
  condition   = var.enable_cache
}
