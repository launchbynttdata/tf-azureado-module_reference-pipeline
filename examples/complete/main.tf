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

module "pipeline" {
  source = "../.."

  product_family     = var.product_family
  product_service    = var.product_service
  environment        = var.environment
  environment_number = var.environment_number
  resource_number    = var.resource_number
  region             = var.region


  project_id           = var.project_id
  repository           = var.repository
  pull_request_trigger = var.pull_request_trigger
  schedules            = var.schedules
}
