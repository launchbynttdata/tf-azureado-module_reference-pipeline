package testimpl

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"os/exec"
	"strings"
	"testing"
)

func TestComposableAzPipeline(t *testing.T, ctx types.TestContext) {

	pipelineID := terraform.Output(t, ctx.TerratestTerraformOptions(), "pipeline_id")
	scheduleID := terraform.Output(t, ctx.TerratestTerraformOptions(), "schedule_id")
	revisionID := terraform.Output(t, ctx.TerratestTerraformOptions(), "revision_id")

	azurePipelineID := getAzureDevopsPipeline("id", pipelineID)
	azureScheduleID := getAzureDevopsPipeline("schedule", scheduleID)
	azureRevisionID := getAzureDevopsPipeline("revision", revisionID)

	assert.Equal(t, azurePipelineID, pipelineID, "Pipeline ID is not matching")
	assert.Equal(t, azureScheduleID, scheduleID, "Schedule ID is not matching")
	assert.Equal(t, azureRevisionID, revisionID, "Revision ID is not matching")
}

func getAzureDevopsPipeline(field string, pipelineID string) string {
	organization := "https://dev.azure.com/launch-dso"
	project := "TfsGit"

	cmd := exec.Command("az", "pipelines", "show", "--id", pipelineID, "--org", organization, "--project", project, "query", field)
	output, err := cmd.Output()
	if err != nil {
		fmt.Printf("Error in getting pipeline details: %v", field, err)
		return ""
	}
	return strings.TrimSpace(string(output))
}
