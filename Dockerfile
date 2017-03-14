FROM fluent/fluentd:latest-onbuild

MAINTAINER Keaton Choi <keaton@dailyhotel.com>

# USER fluent
USER root
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN apk update && apk add ruby-dev build-base && \
  gem install fluent-plugin-secure-forward && \
  gem install fluent-plugin-elasticsearch --no-rdoc --no-ri && \
  gem install fluent-plugin-parser --no-rdoc --no-ri && \
  gem install fluent-parser-elasticsearch --no-rdoc --no-ri && \
  gem install fluent-plugin-concat -v 1.0.0 --no-rdoc --no-ri && \
  rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && gem sources -c && \
  apk del ruby-dev build-base && \
  rm -rf /var/cache/apk/*

EXPOSE 24284
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
