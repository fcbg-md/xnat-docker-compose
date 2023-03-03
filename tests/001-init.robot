*** Settings ***
Documentation     Example using the space separated format.
Library           SeleniumLibrary

*** Variables ***
${HOMEPAGE}    http://xnat-nginx
${BROWSER}    Firefox

# Tasks and test cases are barely the same thing so do not worry of you see test cases in exmaple
*** Tasks ***
Open xnat web application
    Open application
    Log in

List plugins installed
    Go to Plugin Page
    Count Plugins Installed

*** Keywords ***
Open application
    Open Browser    ${HOMEPAGE}    ${BROWSER}

Log in
    Input Text        username    admin
    Input Password    password    admin
    Submit Form
    Capture Page Screenshot
    Wait until page contains    XNAT currently contains
    Capture Page Screenshot

Go to Plugin Page
    Go To    http://xnat-nginx/app/template/Page.vm?view=admin#tab=plugins
    Wait Until Element Is Visible    xpath=//h3[.//text() = 'List of Installed Plugins']
    Capture Page Screenshot

Count Plugins Installed
    ${count}=    Get Element Count    xpath=//tbody[(@class='table-body')]/tr
    Log    There are ${count} plugin installed