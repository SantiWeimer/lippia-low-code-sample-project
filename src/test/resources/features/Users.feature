@TimeEntry
Feature: Time entry

  Background:
    Given base url https://api.clockify.me/api

  @FindAllUsersOnWorkspace
  Scenario: Find all users on workspace
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/users
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = "66e04912a23a2036c147157e"
    * define idUser = $.[0].id