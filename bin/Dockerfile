FROM debian:11

RUN apt-get update && \
    apt-get install -y build-essential curl debhelper && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get -y install nodejs && \
    apt-get clean

WORKDIR /opt/jitsi-meet

CMD ["bash", "-c", "dpkg-buildpackage -A -rfakeroot -us -uc -tc -d && rm -rf ./bin/deb && mkdir ./bin/deb && mv ../jitsi-meet-* ./bin/deb/"]
#CMD ["tail", "-f", "/var/log/dpkg.log"]
