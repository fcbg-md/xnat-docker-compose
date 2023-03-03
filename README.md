# XNAT DOCKER COMPOSE

This repo is a fork from the [Official xnat dc repo](https://github.com/NrgXnat/xnat-docker-compose), so you will find the revelant documentation here.

## Test

We use [robot framework]() to run automated test on our application,  
You can find [here](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html) the documentation of the selenium library (browser library used to write test).  

Furthermore we created a makefile to make your life easier, it permit you to start and stop the xnat with one command,  
It also permit to reload the xnat to reload the plugins (the plugins are located inside xnat/plugins).
And finally to easily run your robot tests:  
Test case are located into tests and the results inside reports.  

Run ```make``` to display the different command !