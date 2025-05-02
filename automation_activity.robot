*** Settings ***
Resource          automation_activity_resource.robot
Test Teardown     Close Browser
Library    Telnet

*** Test Cases ***
# NUMBER 1
Valid Create New Account
    Given Browser is opened to Facebook registration page
    When User enters valid credentials
    Then Confirm email page is displayed

# NUMBER 2
Create New Account Selecting Month with Days not more than 30
    Given Browser is opened to Facebook registration page
    When User selects Month with Days not more than 30 and more than 13 years old
    Then Selected date is invalid

# NUMBER 3
Create New Account Selecting February - Non Leap Year - with Date on 29 30 or 31
    Given Browser is opened to Facebook registration page
    When User selects FEBRUARY 29 30 or 31 on NON leap year and more than 13 years old
    Then Selected date is invalid

# NUMBER 4
Create New Account Selecting February - Leap Year - with Date on 30 or 31
    Given Browser is opened to Facebook registration page
    When User selects FEBRUARY 30 or 31 on leap year and more than 13 years old
    Then Selected date is invalid

# NUMBER 5
Age is Less Than 13 Years Old - In Years
    Given Browser is opened to Facebook registration page
    When User enters birthdate with less than 13 years of age - in years
    Then Error creating new account

# NUMBER 6
Age is Less Than 13 Years Old - In Months
    Given Browser is opened to Facebook registration page
    When User enters birthdate with less than 13 years of age - in months
    Then Error creating new account

# NUMBER 7
Age is Less Than 13 Years Old - In Days
    Given Browser is opened to Facebook registration page
    When User enters birthdate with less than 13 years of age - in days
    Then Error creating new account

# NUMBER 8
User Leave Birthdate As Is
    Given Browser is opened to Facebook registration page
    When User did not modify the birthdate
    Then Error creating new account

# NUMBER 9
User is 13 Years Old Today
    Given Browser is opened to Facebook registration page
    When User birthdate matches current month and day
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
    Then Registration Error

Input Password with Special Lowercase Character
    Given Browser is opened to Facebook registration page
    When User adds a special lowercase character
    Then Registration Error



*** Keywords ***
Browser is opened to Facebook registration page
    Open Browser To Registration Page    

Confirm email page is displayed
    Sleep    20 seconds
    Title Should Be    Facebook
    Page Should Contain    Enter the code from your email

Unable to process registration
    Sleep    15 seconds
    Page Should Contain    Sorry, we are not able to process your registration.

Error creating new account
    Sleep    15 seconds
    Page Should Contain    We Couldn't Create Your Account

Selected date is invalid
    Sleep    15 seconds
    Page Should Contain    The selected date is not valid.

Registration Error
    Sleep    15 seconds
    Page Should Contain    There was an error with your registration. Please try registering again.