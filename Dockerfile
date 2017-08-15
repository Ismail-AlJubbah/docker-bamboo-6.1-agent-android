#
# Oracle Java 8 Dockerfile
#
# https://github.com/cogniteev/docker-oracle-java
# https://github.com/cogniteev/docker-oracle-java/tree/master/oracle-java8
#

# Pull base image.
FROM ubuntu:16.04

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
####################################################
# Copying Docker Agent

COPY atlassian-bamboo-agent-installer-6.1.0.jar /data/
###################################################
# Install Android SDK

USER root
RUN apt-get update && apt-get install -y wget zip
RUN mkdir -p /opt/android-sdk-linux && cd /opt/android-sdk-linux &&  wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip
RUN cd /opt/android-sdk-linux && ls -la && unzip tools_r25.2.3-linux.zip
RUN mkdir -p "/opt/android-sdk-linux/licenses"
RUN echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "/opt/android-sdk-linux/licenses/android-sdk-license"
RUN echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "/opt/android-sdk-linux/licenses/android-sdk-preview-license"
RUN (while sleep 3; do echo "y"; done) | /opt/android-sdk-linux/tools/android update sdk -u --filter platform-tools,android-25
RUN chmod -R 755 /opt/android-sdk-linux

# Set PATH
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
###################################################

RUN mkdir -p /root/bamboo-agent-home/bin/
COPY bamboo-capabilities.properties /root/bamboo-agent-home/bin 

RUN mkdir -p /root/.gradle/
COPY grade.properties /root/.gradle/
###################################################

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Define working directory.
WORKDIR /root/bamboo-agent-home

# Define default command.
CMD ["bamboo-agent-android"]
