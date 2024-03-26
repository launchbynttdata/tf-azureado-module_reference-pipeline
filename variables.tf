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

variable "product_family" {
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  type        = string
  default     = "dso"
}

variable "product_service" {
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  type        = string
  default     = "kube"
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "region" {
  description = "AWS Region in which the infra needs to be provisioned"
  type        = string
  default     = "eastus"
}

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-module-resource_name to generate resource names"
  type = map(object(
    {
      name       = string
      max_length = optional(number, 60)
    }
  ))
  default = {
    pipeline = {
      name       = "pipe"
      max_length = 60
    }
  }
}

variable "project_id" {
  description = "(Required) The project ID or project name."
  type        = string
}

variable "path" {
  description = "The folder path of the build definition."
  type        = string
  default     = null
}

variable "agent_pool_name" {
  description = "The agent pool that should execute the build. Defaults to Azure Pipelines."
  type        = string
  default     = "Azure Pipelines"
}

variable "ci_trigger" {
  description = "The repository block as documented below."
  type = object({
    use_yaml = optional(bool)
    override = optional(object({
      batch = optional(bool)
      branch_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      path_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      max_concurrent_builds_per_branch = number
      polling_interval                 = number
      polling_job_id                   = string
    }))
  })
  default = {
    use_yaml = false
  }
}

variable "pull_request_trigger" {
  description = "Pull Request Integration trigger."
  type = object({
    use_yaml       = bool
    initial_branch = optional(string)
    forks = object({
      enabled       = bool
      share_secrets = bool
    })
    override = optional(object({
      auto_cancel = bool
      branch_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
      path_filter = optional(object({
        include = optional(list(string))
        exclude = optional(list(string))
      }))
    }))
  })
  default = {
    use_yaml = false
    forks = {
      enabled       = false
      share_secrets = false
    }
  }
}

variable "variable_groups" {
  description = "A list of variable group IDs (integers) to link to the build definition. Defaults to {}."
  type        = list(number)
  default     = null
}

variable "features" {
  description = "A list of variable group IDs (integers) to link to the build definition. Defaults to {}."
  type = object({
    skip_first_run = optional(bool)
  })
  default = {}
}

variable "queue_status" {
  description = "The queue status of the build definition. Valid values: enabled or paused or disabled. Defaults to enabled."
  type        = string
  default     = "enabled"
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
