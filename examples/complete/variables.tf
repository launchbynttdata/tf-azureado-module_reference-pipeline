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

variable "project_id" {
  description = "(Required) The project ID or project name."
  type        = string
}

variable "repository" {
  description = "The repository block as documented below."
  type = object({
    branch_name           = string
    repo_id               = string
    repo_type             = string
    service_connection_id = string
    yml_path              = optional(string)
    github_enterprise_url = optional(string)
    report_build_status   = optional(bool)
  })
}

variable "schedules" {
  description = "The repository block as documented below."
  type = object({
    days_to_build              = list(string)
    schedule_only_with_changes = optional(bool)
    start_hours                = optional(string)
    start_minutes              = optional(string)
    time_zone                  = optional(string)
    branch_filter = optional(object({
      include = optional(list(string))
      exclude = optional(list(string))
    }))
  })
}
