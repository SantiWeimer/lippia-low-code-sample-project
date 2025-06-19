@TimeEntry
Feature: Time entry

  Background:
    Given base url $(env.base_url_clockify)
    And header x-api-key = $(env.api_key)

  @GetTimeEntriesForAUserOnWorkspace
  Scenario: Get time entries for a user on workspace
    And call Workspace.feature@GetAllMyWorkspaces
    And call Users.feature@FindAllUsersOnWorkspace
    And endpoint /v1/workspaces/{{idWorkspace}}/user/{{idUser}}/time-entries
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = "685171e47e359d43b57f7c33"
    * define idTimeEntry = $.[0].id

  @AddANewTimeEntry
  Scenario: Add a new time entry
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/time-entries
    And header Content-Type = "application/json"
    And body jsons/bodies/addTimeEntry.json
    When execute method POST
    Then the status code should be 201
    * define idTimeEntry = $.id

  @AddANewTimeEntryInProject
  Scenario: Add a new time entry in project
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/time-entries
    And header Content-Type = "application/json"
    And body jsons/bodies/addTimeEntryInProject.json
    When execute method POST
    Then the status code should be 201
    And response should be $.projectId = 6842f551fcdb353c9cfced8b

  @UpdateTimeEntryOnWorkspace
  Scenario: Update time entry on workspace
    And call TimeEntry.feature@GetTimeEntriesForAUserOnWorkspace
    And endpoint /v1/workspaces/{{idWorkspace}}/time-entries/{{idTimeEntry}}
    And header Content-Type = "application/json"
    And body jsons/bodies/updateTimeEntry.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.description = "Descripcion de prueba"


  @DeleteTimeEntryFromWorkspace
  Scenario: Delete time entry from workspace
    And call Workspace.feature@GetAllMyWorkspaces
    And call TimeEntry.feature@AddANewTimeEntry
    And endpoint /v1/workspaces/{{idWorkspace}}/time-entries/{{idTimeEntry}}
    When execute method DELETE
    Then the status code should be 204
