FROM debian:stretch-slim

RUN apt update -y && \
    apt-get install -y netcat jq bash uuid-runtime

ADD --chown=nobody:users docker-entrypoint.sh /docker-entrypoint.sh
ADD --chown=nobody:users files/wait-service.sh /files/wait-service.sh
RUN chmod u+x /docker-entrypoint.sh

USER nobody
ENTRYPOINT [ "/docker-entrypoint.sh" ]