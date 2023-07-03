FROM tomcat:9-jdk8-openjdk-buster

ARG XNAT_VERSION=1.8.6.1
ARG XNAT_ROOT=/data/xnat
ARG XNAT_HOME=/data/xnat/home
ARG XNAT_DATASOURCE_DRIVER=org.postgresql.Driver
ARG XNAT_DATASOURCE_URL=jdbc:postgresql://test2-xnat-postgresql/xnatdb
ARG XNAT_DATASOURCE_HOST=test2-xnat-postgresql
ARG XNAT_DATASOURCE_DATABASE=xnatdb
ARG XNAT_DATASOURCE_USERNAME=xnatuser
ARG XNAT_DATASOURCE_PASSWORD=xnatpwd
ARG XNAT_EMAIL=none@none.com
ARG XNAT_SMTP_ENABLED=fake
ARG XNAT_SMTP_HOSTNAME=fake.fake
ARG XNAT_SMTP_PORT=${XNAT_SMTP_PORT}
ARG XNAT_SMTP_AUTH=${XNAT_SMTP_AUTH}
ARG XNAT_SMTP_USERNAME=${XNAT_SMTP_USERNAME}
ARG XNAT_SMTP_PASSWORD=${XNAT_SMTP_PASSWORD}

ARG TOMCAT_XNAT_FOLDER=ROOT
ARG TOMCAT_XNAT_FOLDER_PATH=${CATALINA_HOME}/webapps/${TOMCAT_XNAT_FOLDER}


RUN apt-get update && apt-get install -y postgresql-client wget 

RUN rm -rf ${CATALINA_HOME}/webapps/*
RUN mkdir -p \
        ${TOMCAT_XNAT_FOLDER_PATH} \
        ${XNAT_HOME}/config \
        ${XNAT_HOME}/logs \
        ${XNAT_HOME}/plugins \
        ${XNAT_HOME}/work \
        ${XNAT_ROOT}/archive \
        ${XNAT_ROOT}/build \
        ${XNAT_ROOT}/cache \
        ${XNAT_ROOT}/ftp \
        ${XNAT_ROOT}/pipeline \
        ${XNAT_ROOT}/prearchive

RUN wget --no-verbose --output-document=/tmp/xnat-web-${XNAT_VERSION}.war https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-${XNAT_VERSION}.war
RUN unzip -o -d ${TOMCAT_XNAT_FOLDER_PATH} /tmp/xnat-web-${XNAT_VERSION}.war
RUN rm -f /tmp/xnat-web-${XNAT_VERSION}.war


ADD make-xnat-config.sh /usr/local/bin/make-xnat-config.sh
RUN /usr/local/bin/make-xnat-config.sh
RUN rm /usr/local/bin/make-xnat-config.sh

ADD wait-for-postgres.sh /usr/local/bin/wait-for-postgres.sh

EXPOSE 8080

ENV XNAT_HOME=${XNAT_HOME} XNAT_DATASOURCE_USERNAME=${XNAT_DATASOURCE_USERNAME} PGPASSWORD=${XNAT_DATASOURCE_PASSWORD}

CMD ["wait-for-postgres.sh", "/usr/local/tomcat/bin/catalina.sh", "run"]

