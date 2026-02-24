Feature: Recommend concerts on login

  Scenario: Registered customer with browser location enabled sees nearby concerts
    Given a customer already registered
    And their browser location permission is "allowed"
    And the browser provides their current location
    When the customer logs in
    Then they should be given a list of concerts near their current location

  Scenario: Registered customer is prompted for browser location permission on login
    Given a customer already registered
    And their browser location permission is "not decided"
    When the customer logs in
    Then they should be prompted to enable browser location
    And if they decline or the browser does not return a location
    Then they should be given a list of concerts from their last login area

  Scenario: Registered customer without browser location enabled but with purchase history sees concerts from last login area
    Given a customer already registered
    And their browser location permission is "denied"
    But they have a previous purchase history
    When the customer logs in
    Then they should be given a list of concerts from their last login area

  Scenario: Unregistered visitor is prompted to register
    Given a customer is not registered
    When they visit the website
    Then they should be provided with a registration page
