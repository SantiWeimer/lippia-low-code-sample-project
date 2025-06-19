@TimeEntry
Feature: Time entry

  Background:
    Given base url $(env.base_url_clockify)
    And header x-api-key = $(env.api_key)

  @FindAllUsersOnWorkspace
  Scenario: Find all users on workspace
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/users
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = "66e04912a23a2036c147157e"
    * define idUser = $.[0].id