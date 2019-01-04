# Hugo dev & deploy

Docker container for writing my blog with Hugo locally as well as for deploying through CircleCI.

## Using for development

The easiest way to use this container for dev inside an existing Hugo setup is to create a `docker-compose.yml` file at the root of the repo:

```
version: '3'

services:
  hugo:
    image: juristr/hugo-docker:latest
    working_dir: /srv/hugo
    volumes:
      - .:/srv/hugo
    command: "hugo server --bind 0.0.0.0 --templateMetrics"
    ports:
      - 1313:1313
```

Then simply run `docker-compose up` and you should be able to access your Hugo blog at `localhost:1313`.

## Using on CI build

Here's an example configuration for CircleCI

```
version: 2
jobs:
  build:
    docker:
      - image: juristr/hugo-docker
    steps:
      - checkout
      - run:
          name: Avoid hosts unknown for github
          command: mkdir ~/.ssh/ && echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config
      - run:
          name: "Install container dependencies for deploy"
          command: apk --no-cache add git openssh
      - run:
          name: "Build and deploy to GitHub"
          command: ./scripts/deploy.sh
```

> **Note -** the above is my setup that uses a `deploy.sh` script that internally calls `hugo` to build the site and then push it up to GitHub. You obviously need to modify it to your needs.

## Check out my site

Go over to [https://juristr.com](https://juristr.com) or follow me [on Twitter (@juristr)](https://twitter.com/juristr).
