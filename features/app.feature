Feature: intial greeting

  In order to know that the app is running
  As a user using the app
  I want to see a initial greeting!

  Scenario: initial greeting
    When I run `bin/run`
    And I type "QUIT"
    Then the output should contain:
    """
    Hello!!!
    """
