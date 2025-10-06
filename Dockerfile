FROM jboss/wildfly:latest

# Copie ton .war dans le dossier de déploiement WildFly
COPY target/iotplatform.war /opt/jboss/wildfly/standalone/deployments/