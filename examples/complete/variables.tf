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

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "class_env" {
  type        = string
  description = "Environment where resource is going to be deployed. For example. dev, qa, uat"
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", coalesce(var.class_env, "dev"))) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = "000"

  validation {
    condition     = coalesce(var.instance_env, 0) >= 0 && coalesce(var.instance_env, 0) <= 100
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = "000"

  validation {
    condition     = coalesce(var.instance_resource, 0) >= 0 && coalesce(var.instance_resource, 0) <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "location" {
  type        = string
  description = "The location of the associated resources"
  nullable    = false
}

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
    service_connection_id = optional(string)
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
  default = null
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
  nullable = true
  default = {
    use_yaml = false
    forks = {
      enabled       = false
      share_secrets = false
    }
  }
}
