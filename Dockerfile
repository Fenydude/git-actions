FROM openjdk:17-jdk-alpine as build
WORKDIR /workspace/app

RUN apk add maven
COPY pom.xml .
COPY src src
COPY docker docker

RUN mvn clean install -DskipTests

FROM openjdk:8-jre-alpine
USER root
ARG DEPENDENCY=/workspace/app
RUN mkdir /spring-app
COPY --from=build ${DEPENDENCY}/target /spring-app
COPY --from=build ${DEPENDENCY}/docker /spring-app
WORKDIR "/spring-app"
ENTRYPOINT ["sh", "./run.sh"]