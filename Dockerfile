FROM docker

RUN apk --update --no-cache add binutils curl nodejs \
 && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
 && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk \
 && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-bin-2.32-r0.apk \
 && apk add --no-cache glibc-2.32-r0.apk glibc-bin-2.32-r0.apk

RUN cd /tmp && mkdir work && cd work \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && cd .. && rm -rf work

RUN curl "https://s3.us-west-2.amazonaws.com/lightsailctl/latest/linux-amd64/lightsailctl" -o "/usr/local/bin/lightsailctl" \
  && chmod +x /usr/local/bin/lightsailctl

WORKDIR /app

ENTRYPOINT [ "/bin/sh", "-l" ]
