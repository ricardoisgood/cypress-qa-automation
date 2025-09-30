@ui @alerts @frames @windows
Feature: Alerts, Frames & Windows

@ui @alerts
Scenario: Handle immediate alert
  Given I open the Alerts page
  When I click the "Click me" alert button
  Then I should see a browser alert containing "You clicked a button"

@ui @alerts
Scenario: Handle timed alert
  Given I open the Alerts page
  When I click the "On button click, alert will appear after 5 seconds" alert button
  Then I should see a browser alert containing "This alert appeared after 5 seconds"

@ui @alerts
Scenario: Confirm dialog - accept and dismiss
  Given I open the Alerts page
  When I accept the confirm dialog
  Then the confirm result text should be "You selected Ok"
  When I dismiss the confirm dialog
  Then the confirm result text should be "You selected Cancel"

@ui @alerts
Scenario: Prompt dialog with input
  Given I open the Alerts page
  When I enter "CypressUser" in the prompt dialog
  Then the prompt result text should include "CypressUser"

@ui @frames
Scenario: Read text from single frame
  Given I open the Frames page
  Then the frame "frame1" should contain "This is a sample page"

@ui @frames
Scenario: Read text from nested frames
  Given I open the Nested Frames page
  Then the parent frame should contain "Parent frame"
  And the child frame should contain "Child Iframe"

@ui @windows
Scenario: Open new tab and verify sample page
  Given I open the Browser Windows page
  When I open a new tab
  Then the new tab should show content containing "This is a sample page"