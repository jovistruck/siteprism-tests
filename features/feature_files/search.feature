@search
Feature: Find Journals for the provided manuscript

  As a member of the transfers desk
  In order to see journals that the manuscript can be transferred to
  I need to be able to find journals that would be appropriate for the manuscript

  Background:
    Given I am on the find journals page

  Scenario: I am able to see the correct journal suggested for a specific manuscript

    When I submit a manuscript with doi id 10.1186/s40535-016-0018-x
    Then the corresponding journal for the manuscript with doi id 10.1186/s40535-016-0018-x is displayed

  Scenario: I am able to see results and megajournals

    When I submit a manuscript with doi id 10.1186/s40535-016-0018-x
    Then the results contain 10 items
    And I want to see more suggestions
    Then the results contain 20 items
    And the megajournals display 3 items

  Scenario Outline: I am able to see Springer, BMC(Oscar) and SO(Oscar) journals linked correctly

    When I submit a manuscript with doi id <doi>
    Then the link is correct for the corresponding journal for the manuscript with doi id <doi>
    Examples:
      | doi                       | type         |
      | 10.1186/s12864-015-2313-7 | BMC          |
      | 10.1186/s40535-016-0018-x | SpringerOpen |
      | 10.1007/s11084-015-9472-z | Springer     |

  Scenario: I am able to filter results by Impact Factor

    When I submit a manuscript with doi id 10.1007/s10503-017-9434-x
    And I want to see more suggestions
    Then the results contain items within the IF range 0.600 and 0.700

  @wip @for_testing
  Scenario: I am able to see matching results for all the test manuscripts

    Then I submit and validate results for all test manuscripts