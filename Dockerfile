FROM ruby:2.7.0-alpine3.11

LABEL maintainer="Westwater"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache curl wget bash tzdata ruby ruby-bundler nodejs

# Needed to make native extensions
RUN apk add --no-cache ruby-dev g++ musl-dev make \
    && echo "gem: --no-document" > /etc/gemrc \
    && gem install bundler smashing

# Create dashboard and link volumes
RUN smashing new smashing

RUN rm -r /smashing/dashboards/* \
    && rm -r /smashing/jobs/*

RUN cd /smashing \
    && ln -s /smashing/dashboards /dashboards \
    && ln -s /smashing/jobs /jobs \
    && ln -s /smashing/assets /assets \
    && ln -s /smashing/lib /lib-smashing \
    && ln -s /smashing/public /public \
    && ln -s /smashing/widgets /widgets \
    && mkdir /smashing/config \
    && mv /smashing/config.ru /smashing/config/config.ru \
    && ln -s /smashing/config/config.ru /smashing/config.ru \
    && ln -s /smashing/config /config

VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE ${PORT}
WORKDIR /smashing

COPY run.sh /
CMD ["/run.sh"]