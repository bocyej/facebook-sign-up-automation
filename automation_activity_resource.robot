*** Settings ***
Library           SeleniumLibrary
Library    String
Library    DateTime

*** Variables ***
${BROWSER}        Edge
${DELAY}          0.5
# ----------------------------------------
@{VOWELS}    a    e    i    o    u
@{MONTHS WITH 30 DAYS}    4    6    9    11
@{MONTHS WITH 31 DAYS}    1    3    5    7    8    10    12
@{DAYS 1 TO 29}    1    2    3    4    5    6    7    8    9    10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25    26    27    28    29
@{DAYS 29 30 31}    29    30    31
@{DAYS 30 31}    30    31
${FEBRUARY}    2
@{NORMAL YEARS}     1985    1990    1995    2001    2002    2003    2005    2010
@{LEAP YEARS}     1904    1908    1912    1916    1920    1924    1928    1932    1936    1940    1944    1948    1952    1956    1960    1964    1968    1972    1976    1980    1984    1988    1992    1996    2000    2004    2008    2012    2016    2020    2024
# ----------------------------------------
${FACEBOOK REGISTER URL}    https://www.facebook.com/r.php?locale=en_US&display=page

*** Keywords ***
Open Browser To Registration Page
    Open Browser    ${FACEBOOK REGISTER URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Registration Page Should Be Open

Registration Page Should Be Open
    Title Should Be    Sign Up for Facebook

Error icon is displayed
    ${display}    Get Element Attribute    css:._5dbb ,._5634, ._5dbc    display
    Log    Display is: ${display}
    Should Be Equal    ${display}    none    Error icon should be visible

Input border shows error color
    ${borderColor}    Get Element Attribute    css:._58mf, div._5634, ._5dba    border
    Log    Border color is: #{borderColor}
    Should Be Equal    ${borderColor}    red    Border should be color red

Selected date is not Valid
    ${errorMessage}    Get Element Attribute    css:#reg_error    opacity
    Should Be Equal    ${errorMessage}    1    The error: "The selected date is not valid" is shown

# NUMBER 1
Enter Valid Account Details
    Input Valid Credentials
    Select Valid Birthdate
    Click Submit Button

Select Valid Birthdate
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    12
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    4
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2000

# ----------------------------------------

# NUMBER 2
Fill Birthdate with Day 31 in a 30-Day Month
    Input Valid Credentials
    Select 31st on a 30-day Month
    Click Submit Button

Select 31st on a 30-day Month
    ${randomMonthsWith30Days}    Evaluate    random.choice(${MONTHS WITH 30 DAYS})    modules=random
    ${randomNormalYear}    Evaluate    random.choice(${NORMAL YEARS})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${randomMonthsWith30Days}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    31
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${randomNormalYear}

# ----------------------------------------

# NUMBER 3
Fill Birthdate with Invalid Day on February of Non-Leap Year
    Input Valid Credentials
    Select 29-31 of February on Non-Leap Year
    Click Submit Button

Select 29-31 of February on Non-Leap Year
    ${randomNormalYear}    Evaluate    random.choice(${NORMAL YEARS})    modules=random
    ${random293031Day}    Evaluate    random.choice(${DAYS 29 30 31})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${FEBRUARY}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${random293031Day}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${randomNormalYear}

# ----------------------------------------

# NUMBER 4
Fill Birthdate with Invalid Day on February of Leap Year
    Input Valid Credentials
    Select 30-31 of February on Leap Year
    Click Submit Button

Select 30-31 of February on Leap Year
    ${randomLeapYear}    Evaluate    random.choice(${LEAP YEARS})    modules=random
    ${random3031Day}    Evaluate    random.choice(${DAYS 30 31})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${FEBRUARY}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${random3031Day}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${randomLeapYear}

# ----------------------------------------

# NUMBER 5
Fill Birth Year indicating Age Under 13 years old
    Input Valid Credentials
    Select Birth Year indicating Age under 13 years old
    Click Submit Button

Select Birth Year indicating Age under 13 years old
    ${randomMonthsWith30Days}    Evaluate    random.choice(${MONTHS WITH 30 DAYS})    modules=random
    ${randomDays}    Evaluate    random.choice(${DAYS 1 TO 29})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${randomMonthsWith30Days}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${randomDays}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2015

# ----------------------------------------

# NUMBER 6
Fill Birth Month indicating Age Under 13 years old
    Input Valid Credentials
    Select Birth Month indicating Age under 13 years old
    Click Submit Button

Select Birth Month indicating Age under 13 years old
    ${randomDays}    Evaluate    random.choice(${DAYS 1 TO 29})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    5
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${randomDays}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2012

# ----------------------------------------

# NUMBER 7
Fill Birth Day indicating Age Under 13 years old
    Input Valid Credentials
    Select Birth Day indicating Age under 13 years old
    Click Submit Button

Select Birth Day indicating Age under 13 years old
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    4
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day   5
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2012

# ----------------------------------------

# NUMBER 8
Default Birthdate
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    ${password}=    Generate Random Password
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    ${password}
    Click Button    name:websubmit

# ----------------------------------------

# NUMBER 9
Fill Birthdate indicating 13 years old Today
    Input Valid Credentials
    Select birthdate for Age Exactly 13 years old Today
    Click Submit Button

Select birthdate for Age Exactly 13 years old Today
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    4
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day   3
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2012

# ----------------------------------------
# ----------------------------------------
# ----------------------------------------

# PASSWORD LOWERCASE
User inputs more than one lowercase character
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Valid Date in UTC
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    Password123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User inputs ONLY one lowercase character
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Valid Date in UTC
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    pASSWORD123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User DOES NOT ADD a lowercase character
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Valid Date in UTC
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    PASSWORD123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User adds a special lowercase character
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Valid Date in UTC
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    PASSWóRD123!
    Click Element    id:password_step_input
    Click Submit Button

# ----------------------------------------
### ------- REUSABLE COMPONENTS ------- ###
# ----------------------------------------

Input Valid Credentials
    ${firstName}=    Generate Random Text
    ${lastName}=    Generate Random Text
    ${email}=    Generate Random Email
    ${password}=    Generate Random Password
    Input Text    name:firstname    ${firstName}
    Input Text    name:lastname    ${lastName}
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${email}
    Input Text    name:reg_passwd__    ${password}

Click Submit Button
    Click Button    name:websubmit

Get Current Date in UTC
    ${currentMonth}=    Select Current Month in UTC
    ${currentDay}=    Select Current Day in UTC
    ${currentYear}=    Select Current Year in UTC
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${currentMonth}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${currentDay}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${currentYear}

Select Current Month in UTC
    ${currentMonth}=    Get Current Date    result_format=%m
    ${currentMonth}=    Evaluate    int("${currentMonth}")
    RETURN    ${currentMonth}

Select Current Day in UTC
    ${currentDay}    Get Current Date    result_format=%d
    ${currentDay}=    Evaluate    int("${currentDay}")
    RETURN    ${currentDay}

Select Current Year in UTC
    ${currentYear}    Get Current Date    result_format=%Y
    ${currentYear}=    Evaluate    int("${currentYear}")
    RETURN    ${currentYear}

Select Valid Date in UTC
    ${year}    ${month}    ${day}=    Generate Random Valid Birthdate

    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${month}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${day}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${year}

Generate Random Valid Birthdate
    ${currentYear}    Get Current Date    result_format=%Y
    ${currentYear}=    Evaluate    int("${currentYear}")
    ${validYear}    Evaluate    ${currentYear}-13

    ${randomYear}    Evaluate    random.randint(1900, ${validYear})    modules=random
    ${randomMonth}    Evaluate    random.randint(1, 12)    modules=random
    
    ${maxDay}    Run Keyword If    ${randomMonth} == ${FEBRUARY}
    ...    ${maxDay}=    Run Keyword    Get Maximum Day in February    ${randomYear}
    ...  ELSE IF    ${randomMonth} in @{MONTHS WITH 30 DAYS}    Set Variable    30
    ...  ELSE    Set Variable    31    

    ${randomDay}    Evaluate    random.randint(1, ${maxDay})    modules=random

    RETURN    ${randomYear}    ${randomMonth}    ${randomDay}

Get Maximum Day in February
    [Arguments]    ${year}
    ${isLeapYear}=    Evaluate    ${year} in @{LEAP YEARS}
    ${maxDay}=    Run Keyword If    ${isLeapYear}    Set Variable    29    ELSE    Set Variable    28

    RETURN    ${maxDay}


Generate Random Text
     ${randomVowel}    Evaluate    random.choice(${VOWELS})    modules=random
    ${randomUppercase}    Generate Random String    1    [UPPER]
    ${randomLowercase}    Generate Random String    4    [LOWER]
    RETURN    ${randomUppercase}${randomVowel}${randomLowercase}

Generate Random Password
    ${randomText}    Generate Random String    8    [LETTERS]
    ${randomNumbers}    Generate Random String    4    [NUMBERS]
    ${specialCharacters}=    Evaluate    ''.join(random.choices(string.punctuation, k=2))    modules=random
    RETURN    ${randomText}${randomNumbers}${specialCharacters}

Generate Random Email
    ${randomText}    Generate Random String    5    [LETTERS]
    ${randomNumbers}    Generate Random String    4    [NUMBERS]
    RETURN    ${randomText}${randomNumbers}@gmail.com