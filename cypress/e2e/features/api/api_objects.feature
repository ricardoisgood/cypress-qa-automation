Feature: Objects API (CRUD on restful-api.dev)

  Background:
    Given the API base url is "https://api.restful-api.dev"
  
  @api @get
Scenario: GET all resources returns a non-empty list
  When I list all API objects
  Then the last response status should be 200
  And the last response should be a JSON array
  And the last response array length should be greater than 0

  @api @get
Scenario: GET a single mock resource by ID
  When I get the mock API object with id "3"
  Then the last response status should be 200
  And the last response field "id" should equal "3"

  @api @objects
  Scenario: Create and fetch an object
    When I create an API object named "MacBook" with data
      | year | 2020 |
      | cpu  | M1   |
    Then the last response status should be one of "200,201"
    And I save the response field "id" as "objectId"
    When I get the API object by saved id
    Then the last response status should be 200
    And the last response field "name" should equal "MacBook"
    And the last response field "data.year" should equal 2020
  
  @api @objects
  Scenario: Update the object and verify
    Given I have a created API object named "Temp" with data
      | foo | bar |
    When I update the API object name to "Renamed"
    Then the last response status should be 200
    When I get the API object by saved id
    Then the last response field "name" should equal "Renamed"

  @api @objects
  Scenario: Delete the object and confirm 404 on GET
    Given I have a created API object named "ToDelete" with data
      | a | 1 |
    When I delete the API object by saved id
    Then the last response status should be 200
    When I get the API object by saved id (allowing failure)
    Then the last response status should be 404

  @api @objects @hardening
    Scenario: Deleting the same object twice returns 404 on the second attempt
      Given I have a created API object named "ToDeleteTwice" with data
       | a | 1 |
    When I delete the API object by saved id
    Then the last response status should be 200
    When I delete the API object by saved id (allowing failure)
    Then the last response status should be 404

    @api @objects @hardening
Scenario: After delete, listing all objects should not include the deleted id
  Given I have a created API object named "ToDeleteList" with data
    | a | 1 |
  When I delete the API object by saved id
  Then the last response status should be 200
  When I list all API objects
  Then the last response status should be 200
  And the last response should be a JSON array
  And the last response array should not include an object with id from alias "objectId"

  @api @errors
  Scenario: GET non-existent id returns 404
    Given a non-existent object id is prepared
    When I get the API object by saved id (allowing failure)
    Then the last response status should be 404

  @api @errors
  Scenario: PUT non-existent id returns 404
    Given a non-existent object id is prepared
    When I update the API object name to "ShouldFail" (allowing failure)
    Then the last response status should be 404

  @api @errors
  Scenario: DELETE non-existent id returns 404
    Given a non-existent object id is prepared
    When I delete the API object by saved id (allowing failure)
    Then the last response status should be 404

  @api @headers
  Scenario: Responses are JSON
    Given I have a created API object named "HeaderCheck" with data
      | ok | true |
    When I get the API object by saved id
    Then the last response header "content-type" should contain "application/json"

@api @get @consistency
Scenario: GET all then GET by the first id should match
  When I list all API objects
  Then the last response status should be 200
  And the last response should be a JSON array
  And the last response array length should be greater than 0
  And I save the first array item field "id" as "pickedId"
  When I get the mock API object with id from alias "pickedId"
  Then the last response status should be 200
  And the last response field "id" should equal alias "pickedId"

  @api @delete @hardening
Scenario: Deleting the same object twice returns 404 on the second attempt
  Given I have a created API object named "ToDeleteTwice" with data
    | a | 1 |
  When I delete the API object by saved id
  Then the last response status should be 200
  When I delete the API object by saved id (allowing failure)
  Then the last response status should be 404

  @api @perf
Scenario: GET by id responds under 1500 ms
  Given I have a created API object named "Perf" with data
    | ok | true |
  When I get the API object by saved id
  Then the last response time should be under 1500 ms