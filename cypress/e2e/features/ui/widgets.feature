@ui @widgets
Feature: Widgets

@ui @widgets
Scenario: Accordion expand and collapse
  Given I open the Accordion page
  When I expand accordion section "What is Lorem Ipsum?"
  Then the accordion content should be visible
  When I collapse accordion section "What is Lorem Ipsum?"
  Then the accordion content should not be visible

@ui @widgets
Scenario: Auto Complete adds multiple chips
  Given I open the Auto Complete page
  When I add auto-complete values ["Red","Blue"]
  Then the auto-complete chips should include ["Red","Blue"]

@ui @bonus @widgets @tabs
Scenario Outline: Tabs show panel for each tab
  Given I open the Tabs page
  When I select the tab "<tab>"
  Then the tab panel for "<tab>" should be visible

Examples:
  | tab   |
  | What  |
  | Origin|
  | Use   |

@ui @widgets
Scenario: Tool Tips shows on hover
  Given I open the Tool Tips page
  When I hover the "Hover me to see" button
  Then I should see a tooltip containing "You hovered over the Button"