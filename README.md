# Terraform Module: Azure Cosmos DB with Caching

## Description

    This Terraform module provisions an Azure Cosmos DB instance in NoSQL mode optimized for query performance. 
    Additionally, you can enable Redis caching to improve read performance.

## Prerequisites

1.  A valid Azure account with billing enabled.
2.  A resource group in Azure.
3.  Terraform (v1.x or later).

## (IMPORTANT) What is not covered in this Cosmos DB POC.

        1.  Networking concepts like VNET integration , private / public
            accessibility of Cosmos DB, private end point and etc.
        2.  IAM concepts like Service Principals , Azure MSI for RBAC.
        3.  Backup & Disaster recovery, global replication / availability of
            Cosmos DB.
        4.  Upstream and Downstream application.
        5.  Application integration like App Service Plan , Microservices (AKS).
        6.  Resouce Tagging
        7.  Monitoring for availability and Performance with tools like Grafana
        8.  Cosmos DB throughput in RUs
        9.  How to connect to CosmosDB created using this pipeline
        10.  Terraform statefile whether it should be remote or local - to achieve this we need to configure the backend parameter accordingly in main.tf.
        11.  Fetching and storing the access keys in Azure keyvault or any other similar tool.

##     Usage

        module "cosmosdb_with_cache" { source = "path/to/module"
        resource_group_name = "your-resource-group" region = "East US" name =
        "my-cosmosdb-instance" database_name = "UserDatabase" container_name =
        "UserContainer" partition_key_path = "/id" enable_cache = true
        redis_capacity = 2 redis_sku = "Premium" }


#     Instructions to run the IaC Terraform code

        Download latest version of terraform software to local machine (laptop/jumpserver).
        Download VSCode , git command line (tortoise git) for text editing and repo code management respectively.
        Configure terraform software to connect to respective Azure subscriptions with client ID, client secret and other details.
        Configure git or tortoise git tool to work with GitHub.com using Personal Access Token or SSH keys.
        Create a feature branch from development branch on GitHub.com to make required changes.
        Clone the code from GitHub.com to local machine (laptop/jumpserver) to a folder.
        Using git or any similar tool switch to the branch we cloned the code.
        Use VSCode kind of IDE to make changes to code and open the respective folder.

## Details of code

        main.tf         - skeleton code for all deployments
        variables.tf    - description of variables tf.vars - terraform file with
        tfvars files    - values files for different environments and regions 
#     Variables
            resource_group_name: The name of the Azure resource group.
            region: The Azure region where the Cosmos DB instance will be created. (Valid values: East US, West US, East US 2, West Europe).
            name: The name of the Cosmos DB instance.
            database_name: The name of the Cosmos DB database.
            container_name: The name of the Cosmos DB container (SQL container).
            partition_key_path: The partition key path for Cosmos DB containers (e.g., /id).
            index_properties: A list of index definitions to optimize query performance.
            enable_cache: Flag to enable Redis caching (default: false).
            redis_capacity: The capacity of the Redis cache instance (default: 1).
            redis_sku: The Redis SKU (default: Basic).
#     Outputs
            cosmosdb_account_name: The name of the Cosmos DB account.
            cosmosdb_sql_container_name: The name of the Cosmos DB SQL container.
            redis_cache_instance: The Redis cache instance name (if enabled).


## Running the code
        Within VSCode , open a shell. Navigate to the
        directory where code is downloaded / cloned/ checked out run terraform
        init (this action is only required for first time OR any major
        modifications are done in providers terraform plan (this action will
        give us details of what resources will be created) terraform apply
        -var-file="respective region/environment var file" ex: to deploy
        CosmosDB in Dev environment in North Europe region run terraform apply
        -var-file="tfvars.dev.neu" Output can be validated in outputs.tf file.

## Details of Resources Created
        A CosmosDB with indexing policies along
        with a redis cache to further enhance the performance of CosmosDB
        response time.

Contact me for any issues faced.
