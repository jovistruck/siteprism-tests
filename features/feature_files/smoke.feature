@smoke
Feature: Suggest Journals for the provided manuscript

  As a member of the transfers desk
  In order to see journals that the manuscript can be transferred to
  I need to be able to see journals that would be appropriate for the manuscript

  Scenario: I am able to see the correct journal suggested for a randomly picked manuscript

    Given I am on the find journals page
    And I submit a manuscript
    Then the results contain the corresponding journal for the manuscript