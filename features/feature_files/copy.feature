@copy
Feature: Copy Selected Search Results

  As a member of the transfers desk
  In order to compose the email with the relevant results
  I need to be able to copy search results after selecting the relevant ones

  Background:
    Given I am on the find journals page
    And I submit a manuscript with doi id 10.1186/s40535-016-0018-x

  Scenario: I am able to copy to clipboard by selecting results
    And I do not select anything and copy the results
    Then the copy button indicates an unsuccessful copy
    And the message template has no content
    And I select and copy the results 1,5,7
    Then the copy button indicates a successful copy
    And the message template has content