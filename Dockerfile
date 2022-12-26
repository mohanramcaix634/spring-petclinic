FROM maven:3.8.3-openjdk-17 as build
WORKDIR /opt/demo
COPY pom.xml .
COPY ./src ./src
RUN mvn clean install -Dmaven.test.skip=true
#RUN mvn deploy -Dmaven.test.skip=true

FROM openjdk:17-alpine
WORKDIR /opt/demo
COPY --from=build /opt/demo/target/*.jar /opt/demo/app.jar
ENTRYPOINT ["java", "-jar", "/opt/demo/app.jar"]
