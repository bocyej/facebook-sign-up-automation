*** Settings ***
Resource          automation_activity_resource.robot
Test Teardown     Close Browser
Library    Telnet

*** Test Cases ***
# NUMBER 1
Create Account with Valid Credentials
    Given Browser is opened to Facebook registration page
    When Enter Valid Account Details
    Then Confirm email page is displayed

# NUMBER 2
Return Error when Selecting 31st on a 30-day month
    Given Browser is opened to Facebook registration page
    When Fill Birthdate with Day 31 in a 30-Day Month
    Then Selected date is invalid

# NUMBER 3
Return Error when Selecting 29-31 of February on non-leap year
    Given Browser is opened to Facebook registration page
    When Fill Birthdate with Invalid Day on February of Non-Leap Year
    Then Selected date is invalid

# NUMBER 4
Return Error when Selecting 30-31 of February on leap year
    Given Browser is opened to Facebook registration page
    When Fill Birthdate with Invalid Day on February of Leap Year
    Then Selected date is invalid

# NUMBER 5
Return Error when Birth Year indicates Age under 13 
    Given Browser is opened to Facebook registration page
    When Fill Birth Year indicating Age Under 13 years old
    Then Error creating new account

# NUMBER 6
Return Error when Birth Month indicates Age under 13
    Given Browser is opened to Facebook registration page
    When Fill Birth Month indicating Age Under 13 years old
    Then Error creating new account

# NUMBER 7
Return Error when Birth Day indicates Age under 13
    Given Browser is opened to Facebook registration page
    When Fill Birth Day indicating Age Under 13 years old
    Then Error creating new account

# NUMBER 8
Return Error when birthdate is left blank
    Given Browser is opened to Facebook registration page
    When Default Birthdate
    Then Error creating new account

# NUMBER 9
Allow Account Creation when turning 13 years old today
    Given Browser is opened to Facebook registration page
    When Fill Birthdate indicating 13 years old Today
    Then Confirm email page is displayed


# ----------------------------------------
Input Password with Lowercase Characters
    Given Browser is opened to Facebook registration page
    When User inputs more than one lowercase character
    Then Confirm email page is displayed

Input Password with ONLY ONE Lowercase Character
    Given Browser is opened to Facebook registration page
    When User inputs ONLY one lowercase character
    Then Confirm email page is displayed

Input Password with NO Lowercase Character
    Given Browser is opened to Facebook registration page
    When User DOES NOT ADD a lowercase character
    Then Confirm email page is displayed

Input Password with Special Lowercase Character
    Given Browser is opened to Facebook registration page
    When User adds a special lowercase character
    Then Confirm email page is displayed



*** Keywords ***
Browser is opened to Facebook registration page
    Open Browser To Registration Page    

Confirm email page is displayed
    Wait Until Page Contains    Enter the code from your email    timeout=25s
    Title Should Be    Facebook

Unable to process registration
    Wait Until Page Contains    Sorry, we are not able to process your registration.    timeout=20s

Error creating new account
    Wait Until Page Contains    We Couldn't Create Your Account    timeout=20s

Selected date is invalid
    Wait Until Page Contains    The selected date is not valid.    timeout=20s

Registration Error
    Wait Until Page Contains    There was an error with your registration. Please try registering again.    timeout=20s