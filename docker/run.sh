#!/bin/sh
environment=${environment:=default}
JAVA_OPTS=${JAVA_OPTS:="-Dspring.backgroundpreinitializer.ignore=true \
-Dspring.profiles.active=${environment}"}
EXEC_CMD="java ${JAVA_OPTS} -jar *.jar"
echo $EXEC_CMD
exec $EXEC_CMD