FROM centos:7

ARG SSACLI_URL="https://downloads.linux.hpe.com/SDR/repo/mcp/centos/7/x86_64/current/ssacli-3.40-3.0.x86_64.rpm"
ARG PERCCLI_URL="https://downloads.dell.com/FOLDER04470715M/1/perccli_7.1-007.0127_linux.tar.gz"
ARG STORCLI_URL="http://downloads.linux.hpe.com/SDR/repo/spp-gen10/2019.03.0/packages/storcli-1.25.12-1.noarch.rpm"

RUN curl -# -o /tmp/$(basename $SSACLI_URL) $SSACLI_URL && \
    curl -# -o /tmp/$(basename $PERCCLI_URL) $PERCCLI_URL && \
    curl -# -o /tmp/$(basename $STORCLI_URL) $STORCLI_URL

RUN yum install -y /tmp/$(basename $SSACLI_URL) /tmp/$(basename $STORCLI_URL)

RUN tar -xf /tmp/$(basename $PERCCLI_URL) -C /tmp && \
    yum install -y  /tmp/Linux/perccli-*.rpm

RUN mkdir /raid-tools/ && \
    cp /opt/smartstorageadmin/ssacli/bin/ssacli /raid-tools/ && \
    cp /opt/MegaRAID/perccli/perccli64 /raid-tools/ && \
    cp /opt/MegaRAID/storcli/storcli64 /raid-tools
