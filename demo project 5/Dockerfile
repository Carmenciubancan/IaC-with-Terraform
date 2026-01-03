FROM amazoncorretto:8-alpine3.17-jre

EXPOSE 8080

#copying the jar file to the container
COPY ./target/java-maven-app-*.jar /usr/app/java-maven-app-1.0-SNAPSHOT.jar 

#setting the working directory inside the container
WORKDIR /usr/app 

#command to run the jar file
ENTRYPOINT ["java", "-jar", "java-maven-app-1.0-SNAPSHOT.jar"]
