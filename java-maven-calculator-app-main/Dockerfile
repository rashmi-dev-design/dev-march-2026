FROM tomcat:10.1-jdk17
RUN rm -rf $CATALINA_HOME/webapps/ROOT
COPY target/calculator.war $CATALINA_HOME/webapps/ROOT.war
EXPOSE 8080
