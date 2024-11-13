#This file contains description of properties of resources we are creating and their types
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "region" {
  description = "The Azure region where the Cosmos DB instance will be created."
  type        = string
  validation {
    condition     = contains(["East US", "West US", "East US 2", "West Europe"], var.region)
    error_message = "The region must be one of 'East US', 'West US', 'East US 2', or 'West Europe'."
  }
}

variable "name" {
  description = "The name of the Cosmos DB instance."
  type        = string
}

variable "database_name" {
  description = "The name of the Cosmos DB database."
  type        = string
}

variable "container_name" {
  description = "The name of the Cosmos DB container (collection)."
  type        = string
}

variable "partition_key_path" {
  description = "The path for partitioning the Cosmos DB container (e.g., '/id')."
  type        = string
}

variable "index_properties" {
  description = "A list of index properties to optimize query performance."
  type = list(object({
    name           = string
    property_name  = string
    direction      = string
  }))
  default = []
}

variable "enable_cache" {
  description = "Whether to enable Redis or other caching services."
  type        = bool
  default     = false
}

variable "redis_capacity" {
  description = "The capacity of the Redis cache instance."
  type        = number
  default     = 1
}

variable "redis_sku" {
  description = "The SKU for the Redis cache instance."
  type        = string
  default     = "Basic"
}
