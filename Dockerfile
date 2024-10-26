FROM gradle:8.10.2-jdk17 AS build
WORKDIR /app

COPY build.gradle settings.gradle ./
COPY src ./src

RUN gradle build --no-daemon

FROM openjdk:17
COPY --from=build /app/build/libs/demoOne-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
