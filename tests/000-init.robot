*** Settings ***
Documentation                  Init xnat
Library                        SeleniumLibrary

*** Variables ***
${HOMEPAGE}                    %{HOMEPAGE}
${BROWSER}                     Firefox

# Tasks and test cases are barely the same thing so do not worry of you see test cases in exmaple
*** Test Cases ***
Open xnat web application
    Open application
    Log in

Init Xnat
    Setup site parameters

Wait for xnat homepage
    Get homepage

*** Keywords ***
Open application
    Open Browser                ${HOMEPAGE}    ${BROWSER}

Log in
    Input Text                  username    admin
    Input Password              password    admin
    Submit Form

Setup site parameters
    Wait until page contains    Save All    01:05

    Submit Form
    Wait until page contains    Initial site configuration has been completed!

Get homepage
    Go To                       ${HOMEPAGE}
    Wait until page contains    XNAT currently contains
    Capture Page Screenshot
