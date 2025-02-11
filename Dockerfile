# 1. Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim as build

# 2. Set the working directory
WORKDIR /app

# 3. Copy the Gradle wrapper and build scripts
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# 4. Download dependencies and build the application
RUN ./gradlew clean build -x test

# 5. Copy the generated JAR file into the container
COPY build/libs/*.jar app.jar

# 6. Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# 7. Expose the default port
EXPOSE 8080
