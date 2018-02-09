FROM  cyberdojofoundation/bash
LABEL maintainer=jon@jaggersoft.com

ADD install.sh /

RUN /install.sh && \
    rm -f /install.sh

COPY red_amber_green.rb /usr/local/bin
