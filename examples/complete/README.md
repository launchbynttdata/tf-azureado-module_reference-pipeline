# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.96 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pipeline"></a> [pipeline](#module\_pipeline) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | n/a | yes |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | n/a | yes |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `"000"` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `"000"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the associated resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) The project ID or project name. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository block as documented below. | <pre>object({<br>    branch_name           = string<br>    repo_id               = string<br>    repo_type             = string<br>    service_connection_id = optional(string)<br>    yml_path              = optional(string)<br>    github_enterprise_url = optional(string)<br>    report_build_status   = optional(bool)<br>  })</pre> | n/a | yes |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | The repository block as documented below. | <pre>object({<br>    days_to_build              = list(string)<br>    schedule_only_with_changes = optional(bool)<br>    start_hours                = optional(string)<br>    start_minutes              = optional(string)<br>    time_zone                  = optional(string)<br>    branch_filter = optional(object({<br>      include = optional(list(string))<br>      exclude = optional(list(string))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_pull_request_trigger"></a> [pull\_request\_trigger](#input\_pull\_request\_trigger) | Pull Request Integration trigger. | <pre>object({<br>    use_yaml       = bool<br>    initial_branch = optional(string)<br>    forks = object({<br>      enabled       = bool<br>      share_secrets = bool<br>    })<br>    override = optional(object({<br>      auto_cancel = bool<br>      branch_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      path_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>    }))<br>  })</pre> | <pre>{<br>  "forks": {<br>    "enabled": false,<br>    "share_secrets": false<br>  },<br>  "use_yaml": false<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_revision"></a> [revision](#output\_revision) | n/a |
| <a name="output_schedule_id"></a> [schedule\_id](#output\_schedule\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
