FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8080
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /home/k8s-pipeline/app.jar
ENTRYPOINT ["java","-jar","/home/k8s-pipeline/app.jar"]
