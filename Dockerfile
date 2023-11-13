FROM maven:3.6.0-jdk-8-alpine AS build
WORKDIR /app
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn package -DskipTests
FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/antiquebookstore.jar
CMD ["java", "-jar", "/app/antiquebookstore.jar"]