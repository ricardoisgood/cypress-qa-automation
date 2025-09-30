@ui
Feature: Dynamic Properties

  Background:
    Given I open the Dynamic Properties page

  @enable
  Scenario: Enable After becomes enabled
    Then the "Enable After" button should be disabled initially
    When I fast-forward 5 seconds
    Then the "Enable After" button should be enabled

  @color
  Scenario: Color Change button changes color
    Then the "Color Change" button should not have the danger color initially
    When I fast-forward 5 seconds
    Then the "Color Change" button should have the danger color

  @visible
  Scenario: Visible After appears
    Then the "Visible After" button should not be visible initially
    When I fast-forward 5 seconds
    Then the "Visible After" button should be visible

  @random
  Scenario: Random text is visible
    Then I should see the "This text has random Id" text with a non-empty id

  @ui @dynamic @enable_time
Scenario: Enable After becomes enabled within 10s
  Given I open the Dynamic Properties page
  When I start the timer
  Then the "Enable After" button should be enabled
  Then the elapsed time should be below 10000 ms

@ui @dynamic @color_css
Scenario: Color Change has the danger CSS color when done
  Given I open the Dynamic Properties page
  Then the "Color Change" button should have the danger CSS color

@ui @dynamic @controls_exist
Scenario: Dynamic controls are present with correct tags and ids
  Given I open the Dynamic Properties page
  Then the dynamic controls should exist with correct ids and tags

@ui @dynamic @visible_click
Scenario: Visible After becomes visible and is clickable
  Given I open the Dynamic Properties page
  Then the "Visible After" button should be visible
  When I click the Visible After button once visible
  Then the "Visible After" button should be visible

@ui @dynamic @random_id_regenerates
Scenario: Random id changes after reload
  Given I open the Dynamic Properties page
  When I capture the random id as "first"
  When I reload the page
  Then the "Visible After" button should be visible
  When I capture the random id as "second"
  Then the random ids "first" and "second" should be different

@ui @dynamic @enable_click_stays
Scenario: Clicking Enable After does not navigate away
  Given I open the Dynamic Properties page
  When I click the Enable After button after it enables
  Then the current path should still be "/dynamic-properties"  

  @ui @dynamic @reset_after_reload
Scenario: Dynamic effects run again after reload
  Given I open the Dynamic Properties page
  Then the "Enable After" button should be enabled
  Then the "Color Change" button should have the danger color
  Then the "Visible After" button should be visible
  When I reload the page
  Then the "Enable After" button should be enabled
  Then the "Color Change" button should have the danger color
  Then the "Visible After" button should be visible

@ui @dynamic @random_id_unique
Scenario: Random id is unique in the document
  Given I open the Dynamic Properties page
  Then the "This text has random Id" text with a non-empty id should exist
  Then the random id should be unique in the document