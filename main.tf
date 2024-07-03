// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  logical_product_family  = var.product_family
  logical_product_service = var.product_service
  region                  = join("", split("-", var.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
}

module "pipeline" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/pipelines/azureado"
  version = "~> 1.0"

  project_id           = var.project_id
  name                 = module.resource_names["pipeline"].standard
  path                 = var.path
  agent_pool_name      = var.agent_pool_name
  ci_trigger           = var.ci_trigger
  pull_request_trigger = var.pull_request_trigger
  variable_groups      = var.variable_groups
  features             = var.features
  queue_status         = var.queue_status
  repository           = var.repository
  schedules            = var.schedules
}
