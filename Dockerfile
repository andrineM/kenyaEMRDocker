FROM debian:jessie
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get install -y openjdk-7-jre
RUN apt-get install -y tomcat7
ADD openmrs.war /var/lib/tomcat7/webapps/openmrs.war
ADD openmrs-runtime.properties /var/lib/tomcat7/openmrs-runtime.properties
ADD kenyaemr_concepts_dump-2019-09-20.sql /home/kenyaemr_concepts_dump-2019-09-20.sql
ENV MYSQL_PWD test
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get -y install mysql-server
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
EXPOSE 8080
CMD ["/root/run.sh"]


