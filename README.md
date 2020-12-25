# aws lightsail cli

An image that allows you to do "aws lightsail push-container-image".
The above command probably requires docker.

ytoune/aws-lightsail-cli has awscli, lightsailctl and docker.
And have nodejs for convenience. (don't have npm or yarn)

# usage

```shell
docker --rm --entrypoint sh -v $(pwd):/app -v ~/.aws:/root/.aws:ro ytoune/aws-lightsail-cli
```

# for gitlab-ci

```yml
services:
  - docker:dind

app-deploy:
  image: ytoune/aws-lightsail-cli
  script:
    # It seems that it doesn't use $AWS_ACCESS_KEY_ID and $AWS_SECRET_ACCESS_KEY, so I'm generating ~/.aws/credentials
    - mkdir ~/.aws || echo pass
    - echo '[default]' >| ~/.aws/credentials
    - echo "aws_access_key_id=$AWS_ACCESS_KEY_ID" >> ~/.aws/credentials
    - echo "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
    - echo '[default]' >| ~/.aws/config
    - echo 'region=ap-northeast-1' >> ~/.aws/config
    - echo 'output=json' >> ~/.aws/config
    # build
    - docker build -t myapp .
    # push
    - aws lightsail push-container-image --region ap-northeast-1 --service-name ${APP_SERVICE_NAME} --label api --image myapp
  only:
    - main
```

# example of use

https://gitlab.com/yt-practice/lightsail-container-20201222


[AWS Lightsail Containers に GitLab CI でデプロイする](https://zenn.dev/rithmety/articles/20201224-lightsail-containers)