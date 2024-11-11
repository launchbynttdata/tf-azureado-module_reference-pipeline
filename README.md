# tf-azureado-module_reference-pipeline

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This repository contains a reference terraform module

## How to Use This Repo

This repo is intended to be used as a template for any new TF module. In some cases, we're able to use our VCS to template for us. In other cases, we aren't.

### Prerequisites

- [asdf](https://github.com/asdf-vm/asdf) used for tool version management
- [make](https://www.gnu.org/software/make/) used for automating various functions of the repo
- [repo](https://android.googlesource.com/tools/repo) used to pull in all components to create the full repo template

### Repo Init

Run the following commands to prep repo and enable all `Makefile` commands to run

```shell
asdf plugin add terraform
asdf plugin add tflint
asdf plugin add golang
asdf plugin add golangci-lint
asdf plugin add nodejs
asdf plugin add opa
asdf plugin add conftest
asdf plugin add pre-commit
asdf plugin add terragrunt

asdf install
```

### Templating

#### Manual Templating

This applies to systems like Azure DevOps and CodeCommit.

We need to clone the repo, rename it, and start a fresh git history to get rid of the `lcaf-skeleton-terraform` history. Below is a loose explanation of how to do this.

``` shell
git clone <this repo's URL>
mv lcaf-skeleton-terraform tf-<whatever it is you're building>
cd tf-<whatever it is you're building>
rm -rf .git
git init
vi .git/HEAD
Change the HEAD to point to `main` instead of `master` and save the `HEAD`
```

#### Remove Educational Material

We need to clear out the example code (different from the boilerplate code). We want to save the repo structure; we don't need the contents. There are `examples`, and `tests` that apply to the boilerplate that we're not going to need as developers of new modules.

Note before you clear these things out, it's useful to actually understand what they are and why they're there. We'll be building our own as we go forward so we need to know what it is we're removing. If this isn't your first module, it's safe to fly through this. If this is your first (or your first several, even), take the time to read the code before you remove it.

```shell
cd path/to/this/repo
rm -rf examples/*
rm -rf README.md
mv TEMPLATED_README.md README.md
```

#### Version Control (VCS) Templating

This applies to systems like GitHub.

TBD

### Repo Setup

#### Overriding Make Behavior

When run, `make` will look for a file called `.lcafenv` in the repository root. This file if present will be included, and it can be used to override variables without altering the [Makefile](Makefile). A few examples of variables that can be substituted are commented out in [the file](.lcafenv).

#### Module Configuration

- You'll need to update [`versions.tf`](./versions.tf) based on your provider needs.

## Explanation of the Skeleton

### Resources and Providers

- Terraform modules define resources that can be instantiated via provider
- Possible providers include but are not limited to `aws`, `azurerm`, and `gcp`
- In this module we generate text resources with the `random` provider

### Module Guidelines

- Each repository should have a default module in its root
  - Should have default values and be instantiable with minimal to no inputs
  - We can think of these default values as the "default example"
- A `Makefile` provides tasks for terraform module development
  - It will clone and cache `caf-components-tf-module` and `caf-components-platform` git repositories when a `make configure` is ran
  - For clearing cached components, it provides a `make clean` command
  - Linter config and all other tasks are defined in `caf-components-tf-module`
- An `examples` folder contains example uses of the default and nested modules
  - There should be at least one example for each nested module
- A `tests` folder contains Go functional tests
  - Make pre-deploy tests that validate terraform plan json where applicable
  - Make post-deploy tests that validate the deployment where applicable
- Provider should be configured by the user, not the module
  - Modules only define what providers/versions are required

### Go Functional Tests

- Modules are how Go manages dependencies
- To initiate a new modules run the command: `go mod init [repo_url]`
  - It is recommended to use the absolute repository url (e.g. github.com/launchbynttdata/lcaf-skeleton-terraform)
- Relative path is highly discouraged in Go, use absolute path to import a package
  - (e.g. `github.com/launchbynttdata/lcaf-skeleton-terraform/[path_to_file]`)
- To update paths or versions run the command: `go get -t ./...`  go will update the dependencies accordingly
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.96 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_pipeline"></a> [pipeline](#module\_pipeline) | terraform.registry.launch.nttdata.com/module_primitive/pipelines/azureado | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_product_family"></a> [product\_family](#input\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"dso"` | no |
| <a name="input_product_service"></a> [product\_service](#input\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"azdo"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | Azure location of the associated resources | `string` | `"eastus"` | no |
| <a name="input_use_azure_region_abbr"></a> [use\_azure\_region\_abbr](#input\_use\_azure\_region\_abbr) | Whether to use Azure region abbreviation for azure region | `bool` | `true` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "pipeline": {<br>    "max_length": 60,<br>    "name": "pipeline"<br>  }<br>}</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) The project ID or project name. | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | The folder path of the build definition. | `string` | `null` | no |
| <a name="input_agent_pool_name"></a> [agent\_pool\_name](#input\_agent\_pool\_name) | The agent pool that should execute the build. Defaults to Azure Pipelines. | `string` | `"Azure Pipelines"` | no |
| <a name="input_ci_trigger"></a> [ci\_trigger](#input\_ci\_trigger) | The repository block as documented below. | <pre>object({<br>    use_yaml = optional(bool)<br>    override = optional(object({<br>      batch = optional(bool)<br>      branch_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      path_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      max_concurrent_builds_per_branch = number<br>      polling_interval                 = number<br>      polling_job_id                   = string<br>    }))<br>  })</pre> | <pre>{<br>  "use_yaml": false<br>}</pre> | no |
| <a name="input_pull_request_trigger"></a> [pull\_request\_trigger](#input\_pull\_request\_trigger) | Pull Request Integration trigger. | <pre>object({<br>    use_yaml       = bool<br>    initial_branch = optional(string)<br>    forks = object({<br>      enabled       = bool<br>      share_secrets = bool<br>    })<br>    override = optional(object({<br>      auto_cancel = bool<br>      branch_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>      path_filter = optional(object({<br>        include = optional(list(string))<br>        exclude = optional(list(string))<br>      }))<br>    }))<br>  })</pre> | <pre>{<br>  "forks": {<br>    "enabled": false,<br>    "share_secrets": false<br>  },<br>  "use_yaml": false<br>}</pre> | no |
| <a name="input_variable_groups"></a> [variable\_groups](#input\_variable\_groups) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | `list(number)` | `null` | no |
| <a name="input_features"></a> [features](#input\_features) | A list of variable group IDs (integers) to link to the build definition. Defaults to {}. | <pre>object({<br>    skip_first_run = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_queue_status"></a> [queue\_status](#input\_queue\_status) | The queue status of the build definition. Valid values: enabled or paused or disabled. Defaults to enabled. | `string` | `"enabled"` | no |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | The repository block as documented below. | <pre>object({<br>    days_to_build              = list(string)<br>    schedule_only_with_changes = optional(bool)<br>    start_hours                = optional(string)<br>    start_minutes              = optional(string)<br>    time_zone                  = optional(string)<br>    branch_filter = optional(object({<br>      include = optional(list(string))<br>      exclude = optional(list(string))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository block as documented below. | <pre>object({<br>    branch_name           = string<br>    repo_id               = string<br>    repo_type             = string<br>    service_connection_id = optional(string)<br>    yml_path              = optional(string)<br>    github_enterprise_url = optional(string)<br>    report_build_status   = optional(bool)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_revision"></a> [revision](#output\_revision) | n/a |
| <a name="output_schedule_id"></a> [schedule\_id](#output\_schedule\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
