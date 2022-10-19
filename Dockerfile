FROM openjdk:17-jdk-alpine as build
WORKDIR /workspace/app

RUN apk add maven
COPY pom.xml .
COPY src src
COPY docker docker

RUN mvn clean install -DskipTests

FROM ubuntu
USER root
ARG DEPENDENCY=/workspace/app
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean;
RUN mkdir /spring-app
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring
COPY --from=build ${DEPENDENCY}/target /spring-app
COPY --from=build ${DEPENDENCY}/docker /spring-app
WORKDIR "/spring-app"
ENTRYPOINT ["sh", "./run.sh"]