*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Edge
${DELAY}          0.5
# ----------------------------------------
${VALID FIRST NAME}     Juan
${VALID LAST NAME}    Cruz
${VALID MONTH}    6
${VALID DAY}    1
${VALID YEAR}    1990
${VALID GENDER}    Male
# ${VALID MOBILE NUMBER}
${VALID EMAIL}    test_jc8754@gmail.com
${VALID PASSWORD}    Password123!
# ----------------------------------------
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
User enters valid credentials
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects correct month day and year
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects correct month day and year
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    ${VALID MONTH}
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${VALID DAY}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    ${VALID YEAR}

# ----------------------------------------

# NUMBER 2
User selects Month with Days not more than 30 and more than 13 years old
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects INCORRECT month day and year and more than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects INCORRECT month day and year and more than 13 years old
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
User selects FEBRUARY 29 30 or 31 on NON leap year and more than 13 years old
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects INCORRECT day and NON leap year and more than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects INCORRECT day and NON leap year and more than 13 years old
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
User selects FEBRUARY 30 or 31 on leap year and more than 13 years old
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects INCORRECT day and leap year and more than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects INCORRECT day and leap year and more than 13 years old
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
User enters birthdate with less than 13 years of age - in years
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects normal birth month and day but is less than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects normal birth month and day but is less than 13 years old
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
User enters birthdate with less than 13 years of age - in months
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects normal birth day and year but is less than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects normal birth day and year but is less than 13 years old
    ${randomDays}    Evaluate    random.choice(${DAYS 1 TO 29})    modules=random
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    5
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day    ${randomDays}
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2012

# ----------------------------------------

# NUMBER 7
User enters birthdate with less than 13 years of age - in days
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects normal birthdate but is less than 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects normal birthdate but is less than 13 years old
    Click Element    name:birthday_month
    Select From List By Value    name:birthday_month    4
    Click Element    name:birthday_day
    Select From List By Value    name:birthday_day   5
    Click Element    name:birthday_year
    Select From List By Value    name:birthday_year    2012

# ----------------------------------------

# NUMBER 8
User did not modify the birthdate
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

# ----------------------------------------

# NUMBER 9
User birthdate matches current month and day
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects birthdate and is exactly 13 years old
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    ${VALID PASSWORD}
    Click Button    name:websubmit

User selects birthdate and is exactly 13 years old
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
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects correct month day and year
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    Password123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User inputs ONLY one lowercase character
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects correct month day and year
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    pASSWORD123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User DOES NOT ADD a lowercase character
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects correct month day and year
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    PASSWORD123!
    Click Element    id:password_step_input
    Click Button    name:websubmit

User adds a special lowercase character
    Input Text    name:firstname    ${VALID FIRST NAME}
    Input Text    name:lastname    ${VALID LAST NAME}
    User selects correct month day and year
    Select Radio Button    sex    2
    Input Text    name:reg_email__    ${VALID EMAIL}
    Input Text    name:reg_passwd__    PASSWóRD123!
    Click Element    id:password_step_input
    Click Button    name:websubmit