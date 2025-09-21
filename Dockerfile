
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -q -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app
# ajuste o padrão do JAR se necessário (ex.: *-0.0.1-SNAPSHOT.jar)
COPY --from=build /app/target/*-SNAPSHOT.jar app.jar
EXPOSE 8080
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75"
CMD ["sh","-c","java -Dserver.port=${PORT:-8080} -Dserver.address=0.0.0.0 -jar app.jar"]
