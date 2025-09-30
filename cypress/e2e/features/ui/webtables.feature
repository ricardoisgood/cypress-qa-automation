Feature: Web Tables CRUD and Pagination
  As a QA engineer
  I want to validate add, delete, pagination and validation behaviors
  So that the Web Tables feature works as expected

  Background:
    Given I open the DemoQA home page
    When I go to "Elements" from the left menu
    And I select "Web Tables"

  @ui @delete
  Scenario: Delete is idempotent when the user may not exist
    When I delete the row with email "alex@test.com"
    Then I should not see the row with email "alex@test.com"

  @ui @create
  Scenario Outline: Try to submit the form with only one field filled
    When I open the add user modal
    And I fill only "<Field>" with "<Value>"
    And I try to submit the user form
    Then the add user modal should still be visible

    Examples:
      | Field      | Value          |
      | First Name | OnlyFirst      |
      | Last Name  | OnlyLast       |
      | Email      | only@test.com  |
      | Age        | 30             |
      | Salary     | 1000           |
      | Department | QA             |

  @ui @create
  Scenario: Submit with all fields empty
    When I open the add user modal
    And I try to submit the user form
    Then the add user modal should still be visible
    And I should see validation icons for all required fields

  @ui @create
  Scenario: Submit with invalid email (ricardo.com)
    When I open the add user modal
    And I fill only "Email" with "ricardo.com"
    And I try to submit the user form
    Then the add user modal should still be visible
    And I should see validation icon for field "Email"

  @ui @create
  Scenario: Submit with negative salary
    When I open the add user modal
    And I fill only "Salary" with "-1000"
    And I try to submit the user form
    Then the add user modal should still be visible
    And I should see validation icon for field "Salary"

  @ui @create
  Scenario: Submit with salary including decimals
    When I open the add user modal
    And I fill only "Salary" with "1234.56"
    And I try to submit the user form
    Then the add user modal should still be visible
    And I should see validation icon for field "Salary"

  @ui @create
  Scenario: Submit with Age = 00 (should accept)
    And I add a user with:
      | First Name | Last Name | Email          | Age | Salary | Department |
      | Age00      | Test      | age00@test.com | 00  | 3000   | QA        |
    Then I should see the row(s) with Age "00"

  @ui @create
  Scenario: Submit with Age = 99 (should accept)
    And I add a user with:
      | First Name | Last Name | Email          | Age | Salary | Department |
      | Age99      | Test      | age99@test.com | 99  | 3000   | QA        |
    Then I should see the row(s) with Age "99"

  # Use exactly 25 characters in each boundary string below.
  @ui @create @boundary
  Scenario: First Name with 25 characters
    And I add a user with:
      | First Name                 | Last Name | Email           | Age | Salary | Department |
      | AAAAAAAAAAAAAAAAAAAAAAAAA  | Test      | name25@test.com | 30  | 3000   | QA        |
    Then I should see the row with First Name "AAAAAAAAAAAAAAAAAAAAAAAAA"

  @ui @create @boundary
  Scenario: Last Name with 25 characters
    And I add a user with:
      | First Name | Last Name                 | Email            | Age | Salary | Department |
      | Test       | BBBBBBBBBBBBBBBBBBBBBBBBB | lname25@test.com | 30  | 3000   | QA        |
    Then I should see the row(s) with Last Name "BBBBBBBBBBBBBBBBBBBBBBBBB"

  @ui @create @boundary
  Scenario: Salary with 10 characters
    And I add a user with:
      | First Name | Last Name | Email             | Age | Salary     | Department |
      | Test       | Salary    | salary10@test.com | 30  | 1234567890 | QA        |
    Then I should see the row(s) with Salary "1234567890"

  @ui @create @boundary
  Scenario: Department with 25 characters
    And I add a user with:
      | First Name | Last Name | Email                  | Age | Salary | Department                 |
      | Test       | Dept      | department25@test.com  | 30  | 3000   | DDDDDDDDDDDDDDDDDDDDDDDDD  |
    Then I should see the row(s) with Department "DDDDDDDDDDDDDDDDDDDDDDDDD"

  @ui @create @delete
  Scenario: Create a user, validate it exists, delete it, and validate it disappears
    And I add a user with:
      | First Name | Last Name | Email         | Age | Salary | Department |
      | Alex       | Test      | alex@test.com | 25  | 3000   | QA        |
    Then I should see the row with email "alex@test.com"
    When I delete the row with email "alex@test.com"
    Then I should not see the row(s) with email "alex@test.com"

  @ui @update
  Scenario: Edit all fields of a user with valid values
    And I add a user with:
      | First Name | Last Name | Email          | Age | Salary | Department |
      | EditMe     | User      | edit@test.com  | 30  | 3000   | QA        |
    Then I should see the row with email "edit@test.com"

    When I edit the row with email "edit@test.com" and update fields:
      | First Name | Last Name | Email           | Age | Salary | Department |
      | EditMe2    | User2     | edit2@test.com  | 32  | 3002   | QA2       |

    Then the row with email "edit2@test.com" should have values:
      | First Name | Last Name | Age | Salary | Department |
      | EditMe2    | User2     | 32  | 3002   | QA2       |

  @ui @update
  Scenario: Edit user with invalid email (ricardo.com)
    And I add a user with:
      | First Name | Last Name | Email            | Age | Salary | Department |
      | Invalid    | Email     | invalid@test.com | 25  | 2500   | QA        |
    Then I should see the row with email "invalid@test.com"

    When I edit the row with email "invalid@test.com" and update fields:
      | Email       |
      | ricardo.com |
    Then the add user modal should still be visible
    And I should see validation icon for field "Email"

  @ui @update
  Scenario: Edit user with negative salary
    And I add a user with:
      | First Name | Last Name | Email              | Age | Salary | Department |
      | Invalid    | Salary    | invalid2@test.com  | 26  | 2600   | QA        |
    Then I should see the row with email "invalid2@test.com"

    When I edit the row with email "invalid2@test.com" and update fields:
      | Salary |
      | -1000  |
    Then the add user modal should still be visible
    And I should see validation icon for field "Salary"

  @ui @update
  Scenario: Edit user with salary including decimals
    And I add a user with:
      | First Name | Last Name | Email               | Age | Salary | Department |
      | Invalid    | SalaryDec | invalid3@test.com   | 27  | 2700   | QA        |
    Then I should see the row with email "invalid3@test.com"

    When I edit the row with email "invalid3@test.com" and update fields:
      | Salary  |
      | 1234.56 |
    Then the add user modal should still be visible
    And I should see validation icon for field "Salary"

  @ui @update
  Scenario: Edit user and submit with all fields empty
    And I add a user with:
      | First Name | Last Name | Email           | Age | Salary | Department |
      | EmptyEdit  | User      | empty@test.com  | 28  | 2800   | QA        |
    Then I should see the row with email "empty@test.com"

    When I edit the row with email "empty@test.com" and update fields:
      | First Name | Last Name | Email | Age | Salary | Department |
      |            |           |       |     |        |           |
    Then the add user modal should still be visible
    And I should see validation icons for all required fields

@ui @pagination
Scenario: Next/Previous move between pages and respect disabled states
  When I add N users 11
  Then the total number of pages should be 2
  Then the Previous page button should be disabled
  Then the Next page button should be enabled
  When I click Next page
  Then I should be on page "2"
  Then the Next page button should be disabled
  Then the Previous page button should be enabled
  When I click Previous page
  Then I should be on page "1"
  Then the Previous page button should be disabled

@ui @pagination
Scenario: Next can reach the last page; Previous can return to the first page
  When I add N users 25
  Then the total number of pages should be 3
  Then I should be on the first page
  When I click Next page
  Then I should be on page "2"
  When I click Next page
  Then I should be on the last page
  Then the Next page button should be disabled
  When I click Previous page
  Then I should be on page "2"
  When I click Previous page
  Then I should be on the first page

@ui @pagination
Scenario: Navigate forward to last page and back to first page
  When I add N users 25
  Then the total number of pages should be 3
  When I click Next page
  Then I should be on page "2"
  When I click Next page
  Then I should be on the last page
  When I click Previous page
  Then I should be on page "2"
  When I click Previous page
  Then I should be on the first page

@ui @pagination
Scenario: On the last page Next is disabled and Previous is enabled
  When I add N users 11
  Then the total number of pages should be 2
  When I go to page "2"
  Then I should be on the last page
  Then the Next page button should be disabled
  Then the Previous page button should be enabled

@ui @pagination
Scenario: Previous and Next are disabled when there is only one page
  Then I should see the pagination controls
  Then the Previous page button should be disabled
  Then the Next page button should be disabled

@ui @pagination
Scenario: Clicking disabled pagination buttons does not change the page
  Then the Previous page button should be disabled
  Then the Next page button should be disabled
  When I attempt to click Previous page even if disabled
  When I attempt to click Next page even if disabled
  Then I should be on the first page

@ui @search
Scenario: Search by partial first name (case-insensitive) shows only matching rows
  And I add a user with:
    | First Name | Last Name | Email              | Age | Salary | Department |
    | Alice      | One       | alice1@test.com    | 25  | 2000   | QA        |
  And I add a user with:
    | First Name | Last Name | Email              | Age | Salary | Department |
    | alicia     | Two       | alicia2@test.com   | 26  | 2100   | QA        |
  And I add a user with:
    | First Name | Last Name | Email              | Age | Salary | Department |
    | Bob        | Three     | bob3@test.com      | 27  | 2200   | QA        |

  When I search for "ali"
  Then I should see exactly 2 row(s) on the current page
  And the search box should contain "ali"

@ui @search
Scenario: Search by email exact match shows exactly one row
  And I add a user with:
    | First Name | Last Name | Email           | Age | Salary | Department |
    | Carol      | Test      | carol@test.com  | 30  | 3000   | QA        |
  When I search for "carol@test.com"
  Then I should see exactly 1 row(s) on the current page

@ui @search
Scenario: Clearing the search restores rows
  And I add N users 3
  When I search for "User"
  Then I should see at least 1 row(s) on the current page
  When I clear the search filter
  Then I should see at least 1 row(s) on the current page






