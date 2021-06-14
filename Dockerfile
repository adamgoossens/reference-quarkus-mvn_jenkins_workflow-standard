#NOTE: maybe replace this image with a TSSC openjdk image if such a thing ever needs to exist
#FROM registry.redhat.io/ubi8/openjdk-8
FROM registry.redhat.io/ubi8/ubi-minimal
USER 0

RUN microdnf install java-1.8.0-openjdk-headless

# NOTE / WARNING / IMPORTANT:
#   work around for https://bugzilla.redhat.com/show_bug.cgi?id=1798685
RUN rm -f /var/log/lastlog

###############
# install app #
###############
RUN mkdir /app
ADD target/*.jar /app/app.jar
RUN chown -R 1001:0 /app && chmod -R 774 /app
EXPOSE 8080

###########
# run app #
###########
USER 1001
ENTRYPOINT ["java", "-jar"]
CMD ["/app/app.jar"]
