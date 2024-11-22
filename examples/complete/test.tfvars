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
project_id = "platform-accelerators"
repository = {
  repo_type             = "GitHub"
  repo_id               = "launchbynttdata/tf-azureado-module_reference-pipeline"
  branch_name           = "main"
  yml_path              = "examples/complete/pipeline.yml"
  service_connection_id = "<service_connection_name>"
}
pull_request_trigger = null
schedules = {
  branch_filter = {
    include = ["main"]
  }
  days_to_build = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
}
