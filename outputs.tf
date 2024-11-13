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
