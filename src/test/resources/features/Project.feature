@Project
Feature: Project

  Background:
    Given base url https://api.clockify.me/api

  @GetAllMyProjects
  Scenario: Get all my projects - ID
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    When execute method GET
    Then the status code should be 200
    And response should be $.[2].id = "6721517dda93b313ccebac0f"
    * define idProject = $.[2].id

  @CreateNewProject
  Scenario Outline: Create new project
    And call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    And header Content-Type = "application/json"
    And set value <name> of key name in body jsons/bodies/createNewProject.json
    When execute method POST
    Then the status code should be 201
    And response should be $.name = <name>

    Examples:
    |name           |
    |New Project    |

  @FindProjectByID
  Scenario: Find project by ID
    And call Project.feature@GetAllMyProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    And header Content-Type = "application/json"
    When execute method GET
    Then the status code should be 200
    And response should be $.id = {{idProject}}

  @FindProjectByIDNoAutorized
  Scenario: Find project by ID - No autorized 401
    And call Project.feature@GetAllMyProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header Content-Type = "application/json"
    When execute method GET
    Then the status code should be 401

  @FindProjectByIDBadRequest
  Scenario: Find project by ID - Bad request 400
    And call Project.feature@GetAllMyProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/0
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    And header Content-Type = "application/json"
    When execute method GET
    Then the status code should be 400

  @FindProjectByIDNotFound
  Scenario: Find project by ID - Not found 404
    And call Project.feature@GetAllMyProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/0
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    And header Content-Type = "application/json"
    When execute method GET
    Then the status code should be 404

  @EditProject
  Scenario Outline: Edit project
    And call Project.feature@GetAllMyProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And header x-api-key = "OWM5NmY5ZmUtNGJlZS00NzVmLTljNzAtNjRmZDJmODhlOWI3"
    And header Content-Type = "application/json"
    And set value <name> of key name in body jsons/bodies/editProject.json
    And set value <bool> of key billable in body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.name = <name>
    And response should be $.billable = <bool>

    Examples:
      |name          |bool      |
      |Nuevo nombre  |true      |
      |Nuevo nombre2 |false     |

