FROM tomcat:9.0-jdk17
COPY target/simple-app.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080