# Payara
This repository contains a Dockerfile which extends [payara/server-full](https://hub.docker.com/r/payara/server-full).
  
The following additions have been made to the container:
* A MySQL connector has been added from: http://central.maven.org/maven2/mysql/mysql-connector-java;
* Whenever you use a `glassfish-resources.xml` in your project to define the database connection you have to disable `resource validation`;
* Prevents a known bug: https://github.com/payara/Payara/issues/3495
  
If you want to run Payara locally without this docker image you can add the changes above yourself by following these steps:
* Add database connector:
  * Download the database connector from: http://central.maven.org/maven2/mysql/mysql-connector-java;
  * Add the database connector using: `./asadmin add-library "<path to database connector>"`;
* Disable resource scanning:
```bash
./asadmin create-jvm-options "-Ddeployment.resource.validation=false"
```
* Prevent a known bug: https://github.com/payara/Payara/issues/3495:
```bash set-payara-executor-service-configuration --threadpoolexecutorqueuesize 1000
./asadmin
```
