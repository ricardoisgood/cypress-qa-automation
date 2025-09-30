Feature: Practice Form

  Background:
    Given I open the Practice Form page

  @ui @forms
  Scenario: Submitting an empty form shows required errors
    When I submit the Practice Form
    Then the required errors should be shown on the Practice Form

@ui @forms
Scenario: Submitting a fully completed Practice Form shows success modal
  Given I open the Practice Form page
  When I fill "First Name" with "John"
  And I fill "Last Name" with "Doe"
  And I fill "Email" with "john.doe@example.com"
  And I choose gender "Male"
  And I fill "Mobile" with "9876543210"
  And I open the Date of Birth picker
  And I pick the date "10 Oct 1990"
  And I type "Maths" and press Enter in Subjects
  And I choose hobbies ["Sports","Reading"]
  And I upload picture "tiny.jpg"
  And I fill "Current Address" with "123 Cypress Street"
  And I select State "NCR"
  And I select City "Delhi"
  And I submit the Practice Form
  Then I should see the Practice Form success modal
  And the submitted student name should be "John Doe"
  And the modal should show picture file name containing "tiny.jpg"

  @ui @forms
  Scenario: Submitting the form with valid special characters succeeds
  Given I open the Practice Form page
  When I fill "First Name" with "Anne-Marie"
  And I fill "Last Name" with "D'Angelo"
  And I fill "Email" with "john_doe-test.123@example-mail.com"
  And I choose gender "Male"
  And I fill "Mobile" with "9876543210"
  And I open the Date of Birth picker
  And I pick the date "10 Oct 1990"
  And I type "Maths" and press Enter in Subjects
  And I choose hobbies ["Sports","Reading"]
  And I upload picture "tiny.jpg"
  And I fill "Current Address" with "Rua São João, nº 123 - Bloco B / Apto 4B"
  And I select State "NCR"
  And I select City "Delhi"
  And I submit the Practice Form
  Then I should see the Practice Form success modal
  And the submitted student name should be "Anne-Marie D'Angelo"

  @ui @forms @picture
Scenario: Upload a PNG file
  Given I open the Practice Form page
  When I fill minimal required fields
  And I upload picture "tiny.png"
  And I submit the Practice Form
  Then I should see the Practice Form success modal
  And the modal should show picture file name containing "tiny.png"

@ui @forms @picture
Scenario: Upload a JPG file
  Given I open the Practice Form page
  When I fill minimal required fields
  And I upload picture "tiny.jpg"
  And I submit the Practice Form
  Then I should see the Practice Form success modal
  And the modal should show picture file name containing "tiny.jpg"

@ui @forms @picture
Scenario: Upload a JPEG file
  Given I open the Practice Form page
  When I fill minimal required fields
  And I upload picture "tiny.jpeg"
  And I submit the Practice Form
  Then I should see the Practice Form success modal
  And the modal should show picture file name containing "tiny.jpeg"

@ui @forms
Scenario: Error visuals clear after fixing required fields
  Given I open the Practice Form page
  When I submit the Practice Form
  Then the required errors should be shown on the Practice Form
  When I fill "First Name" with "John"
  And I fill "Last Name" with "Doe"
  And I choose gender "Male"
  And I fill "Mobile" with "1234567890"
  Then the required errors should be cleared on the Practice Form

  @ui @forms
  Scenario: Submitting a valid form shows success
    When I fill the Practice Form with minimal valid data
    And I submit the Practice Form
    Then I should see the Practice Form success modal
    And the submitted student name should be "John Doe"

  @ui @forms
  Scenario: First/Last Name, Gender, and Mobile are required
    When I submit the Practice Form
    Then the required errors should be shown on the Practice Form

  @ui @forms
  Scenario: Invalid email prevents submission when filled
    When I fill "First Name" with "John"
    And I fill "Last Name" with "Doe"
    And I choose gender "Male"
    And I fill "Mobile" with "9999999999"
    And I fill "Email" with "john@invalid"
    And I submit the Practice Form
    Then the Email field should be invalid

  @ui @forms
  Scenario: Mobile requires exactly 10 digits (9 is invalid)
    When I fill minimal required fields except "Mobile"
    And I fill "Mobile" with "123456789"
    And I submit the Practice Form
    Then the Mobile field should be invalid

  @ui @forms
  Scenario: Mobile with 10 digits is valid
    When I fill minimal required fields
    And I fill "Mobile" with "1234567890"
    And I submit the Practice Form
    Then I should see the Practice Form success modal

  @ui @forms
  Scenario: Mobile has maxlength 10 and accepts only digits
    Then the Mobile field should have maxlength 10
    When I type "1234567890123abc" into "Mobile"
    Then the "Mobile" field value should be "1234567890"

  @ui @forms
  Scenario: Date of Birth is controlled by datepicker (readonly)
    Then the Date of Birth field should be readonly
    When I open the Date of Birth picker
    And I pick the date "10 Oct 1990"
    Then the Date of Birth value should be "10 Oct 1990"

  @ui @forms
  Scenario: Subjects accepts only valid options
    When I type "Math" and press Enter in Subjects
    Then the Subjects chips should include "Maths"
    When I type "NotASubject" and press Enter in Subjects
    Then the Subjects chips should still be exactly ["Maths"]

  @ui @forms
  Scenario: Hobbies allows multiple selections
    When I choose hobbies ["Sports", "Music"]
    Then the selected hobbies should be ["Sports", "Music"]

  @ui @forms
  Scenario: Upload field accepts images only
    Then the Picture field should have accept ".png,.jpg,.jpeg"

  @ui @forms
  Scenario: Valid image upload appears in the summary
    When I upload picture "avatar.jpg"
    And I fill minimal required fields
    And I submit the Practice Form
    Then I should see the Practice Form success modal
    And the modal should show picture file name containing "avatar.jpg"

  @ui @forms
  Scenario: Address accepts long text and preserves line breaks
    When I fill "Current Address" with a 300-char multiline text
    Then the Current Address value length should be 300
    And the Current Address value should contain line breaks

  @ui @forms @city
  Scenario: City lists options compatible with the chosen State
    When I select State "NCR"
    Then the City options should include ["Delhi", "Gurgaon", "Noida"]

  @ui @forms
  Scenario: First/Last Name accept accents and hyphen
    When I fill "First Name" with "Ana-María"
    And I fill "Last Name" with "Souzà"
    And I choose gender "Female"
    And I fill "Mobile" with "1112223333"
    And I submit the Practice Form
    Then I should see the Practice Form success modal
    And the submitted student name should be "Ana-María Souzà"
