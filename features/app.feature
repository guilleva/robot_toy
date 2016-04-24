Feature: intial greeting
  In order to know that the app is running
  As a user using the app
  I want to see a initial greeting!

  Scenario: initial greeting
    When I run `bin/run` interactively
    And I type "QUIT"
    Then the output should contain:
    """
    Hello!!!
    """

  Scenario: Example a
    When I run `bin/run` interactively
    And I type "PLACE 0,0,NORTH"
    And I type "MOVE"
    And I type "REPORT"
    And I type "QUIT"
    Then the output should contain:
    """
    0,1,NORTH
    """

  Scenario: Example b
    When I run `bin/run` interactively
    And I type "PLACE 0,0,NORTH"
    And I type "LEFT"
    And I type "REPORT"
    And I type "QUIT"
    Then the output should contain:
    """
    0,0,WEST
    """

  Scenario: Example c
    When I run `bin/run` interactively
    And I type "PLACE 1,2,EAST"
    And I type "MOVE"
    And I type "MOVE"
    And I type "LEFT"
    And I type "MOVE"
    And I type "REPORT"
    And I type "QUIT"
    Then the output should contain:
    """
    3,3,NORTH
    """
  Scenario: Ignores MOVE, LEFT AND RIGHT commands before PLACE
    When I run `bin/run` interactively
    And I type "MOVE"
    And I type "LEFT"
    And I type "RIGHT"
    And I type "REPORT"
    And I type "QUIT"
    Then the output should contain:
    """
    I'm in the limbo!
    """
  Scenario: Ignores MOVE that would cause the robot to fall
    When I run `bin/run` interactively
    And I type "PLACE 0,0,SOUTH"
    And I type "MOVE"
    And I type "RIGHT"
    And I type "MOVE"
    And I type "REPORT"
    And I type "QUIT"
    Then the output should contain:
    """
    0,0,WEST
    """
