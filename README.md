# Payara
This repository contains a Dockerfile which extends [payara/server-full](https://hub.docker.com/r/payara/server-full).

## Changes
The following additions have been made to the container:
* A MySQL connector has been added from: http://central.maven.org/maven2/mysql/mysql-connector-java;
* Whenever you use a `glassfish-resources.xml` in your project to define the database connection you have to disable `resource validation`;
* Prevents a known bug: https://github.com/payara/Payara/issues/3495

## Build
If you want to build the docker image using:
```bash
docker build -t mphslaats/payara .
```
Alternatively you can use the image by pulling it from the [Docker Hub](https://hub.docker.com/r/mphslaats/payara):
```bash
docker pull mphslaats/payara
```

## Run Payara locally without docker image
If you want to run Payara locally, without the docker image, you can add the changes above by following these steps:
* Add database connector:
  * Download the database connector from: http://central.maven.org/maven2/mysql/mysql-connector-java;
  * Add the database connector using:
```bash
./asadmin add-library "<path to database connector>"
```
* Disable resource scanning:
```bash
./asadmin create-jvm-options "-Ddeployment.resource.validation=false"
```
* Prevent a known bug: https://github.com/payara/Payara/issues/3495:
```bash
./asadmin set-payara-executor-service-configuration --threadpoolexecutorqueuesize 1000
```
