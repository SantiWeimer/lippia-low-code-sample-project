@Workspace
Feature: Workspace

  Background:
    Given base url https://api.clockify.me/api

  @GetAllMyWorkspaces
  Scenario: Get all my workspaces - Ok 200
    And endpoint /v1/workspaces
    And header x-api-key = OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3
    When execute method GET
    Then the status code should be 200
    And response should be $.[6].name = "prueba"
    * define idWorkspace = $.[6].id


  @GetAllMyWorkspacesError
  Scenario: Get all my workspaces - Error 401
    And endpoint /v1/workspaces
    And header x-api-key = ""
    When execute method GET
    Then the status code should be 401
    And response should be $.message = "Api key does not exist"