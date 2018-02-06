FROM  cyberdojofoundation/bash:4.4.12
LABEL maintainer=jon@jaggersoft.com

RUN apk add git
RUN git clone https://github.com/sstephenson/bats.git
WORKDIR bats
RUN ./install.sh /usr/local

COPY red_amber_green.rb /usr/local/bin
