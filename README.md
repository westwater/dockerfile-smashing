# Smashing
Run [smashing](https://github.com/Smashing/smashing) in a Docker container running alpine linux

[![Docker build](https://img.shields.io/docker/automated/westwater/smashing.svg)](https://hub.docker.com/r/westwater/smashing/)
[![Image size](https://img.shields.io/docker/image-size/westwater/smashing?sort=semver)](https://hub.docker.com/r/westwater/smashing/)

## Run
```docker run -d -p 3030:3030 -v /my/dashboards:/dashboards -v /my/jobs:/jobs westwater/smashing```

Then go to [http://localhost:3030/](http://localhost:3030/).

Note: This docker image does not come with dashboards or jobs so you must provide your own using container volumes

## Configuration
### Custom smashing port
The default port is 3030 but if you want smashing to use a custom port inside the container, e.g. 8080, use the environment variable `$PORT`:

```docker run -d -e PORT=8080 -p 80:8080 westwater/smashing```

### Widgets
The standard widgets that come with `smashing new` are available but if you want to supply custom widgets you need to provide them with a container volume

```docker run -d -v=/my/widgets:/widgets -p 3030:3030 westwater/smashing```

### Gems
To install gems, supply the gem name as an environment variable:

```docker run -d -e GEMS=parallel -p 3030:3030 westwater/smashing```

Multiple gems can be also be supplied but must be in double quotes

```docker run -d -e GEMS="mysql parallel" -p 3030:3030 westwater/smashing```

## Todos

- supplying widgets volume overwrites the standard widgets, come up with merge strategy
- add way to supply Gem versions / Gemfile

## License
Distributed under the MIT license
