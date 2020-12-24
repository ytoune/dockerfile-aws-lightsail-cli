FROM amazon/aws-cli

RUN amazon-linux-extras install docker

RUN curl "https://s3.us-west-2.amazonaws.com/lightsailctl/latest/linux-amd64/lightsailctl" -o "/usr/local/bin/lightsailctl" \
  && chmod +x /usr/local/bin/lightsailctl

ENTRYPOINT [ "sh" ]