FROM ubuntu:trusty

LABEL software=nmrmlconv
LABEL software.version=1.1b
LABEL version=0.1

LABEL Description="Convert NMR-RAW vendor files to nmrML."

MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>



# Update, install, clean up
RUN apt-get -y update &&  apt-get -y install --no-install-recommends build-essential software-properties-common byobu \
curl git htop man unzip vim wget openjdk-7-jdk openjdk-7-jre && \
apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /var/cache/oracle-jdk7-installer /tmp/* /var/tmp/*

# Clone nmrML github repo
WORKDIR /usr/src
RUN git clone https://github.com/nmrML/nmrML

# Install nmrML converter
WORKDIR /usr/src/nmrML/tools/Parser_and_Converters/Java/converter
RUN install -m755 bin/nmrMLcreate /usr/local/bin
RUN install -m755 bin/nmrMLproc /usr/local/bin
RUN mkdir /usr/local/share/nmrML
RUN install -m755 bin/converter.jar /usr/local/share/nmrML/

# Add startup script
#ADD nmrmlconv.sh /usr/local/bin
#RUN chmod 755 /usr/local/bin/nmrmlconv.sh

# Define data directory
RUN mkdir /data
WORKDIR /data

#ENTRYPOINT [ "/usr/local/bin/nmrmlconv.sh" ]
#ENTRYPOINT [ "java", "-jar", "/usr/local/share/nmrML/converter.jar" ]
