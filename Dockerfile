FROM payara/server-full:latest

LABEL maintainer="mphslaats"

ENV MYSQL_VERSION=8.0.16

RUN ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} start-domain ${DOMAIN_NAME} \
   # Download and install database connector
   && curl -s "http://central.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar" -o "/tmp/mysql-connector-java-$MYSQL_VERSION.jar" \
   && ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} add-library "/tmp/mysql-connector-java-$MYSQL_VERSION.jar" \
   && rm -f "/tmp/mysql-connector-java-$MYSQL_VERSION.jar" \
   # Prevent Payara from scanning for database configuration since the connector is declared in glassfish-resources.xml
   && ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddeployment.resource.validation=false" \
   # Prevent known bug: https://github.com/payara/Payara/issues/3495
   && ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-payara-executor-service-configuration --threadpoolexecutorqueuesize 1000 \
   && ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} stop-domain ${DOMAIN_NAME}
