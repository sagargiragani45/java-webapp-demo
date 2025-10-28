FROM tomcat:9.0
LABEL maintainer="sagargiragani"
COPY target/java-webapp-demo-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/java-webapp-demo.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

