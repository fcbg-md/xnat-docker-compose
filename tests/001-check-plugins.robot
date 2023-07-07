*** Settings ***
Documentation                         Check installed plugins
Library                               SeleniumLibrary

*** Variables ***
${HOMEPAGE}                           %{HOMEPAGE}

*** Test Cases ***
List plugins installed
    Go to Plugin Page
    Count Plugins Installed

*** Keywords ***
Go to Plugin Page
    Go To                            ${HOMEPAGE}/app/template/Page.vm?view=admin#tab=plugins
    Wait Until Element Is Visible    xpath=//h3[.//text() = 'List of Installed Plugins']
    Capture Page Screenshot

Count Plugins Installed
    ${count}=                        Get Element Count    xpath=//tbody[(@class='table-body')]/tr
    Log                              There are ${count} plugin installed