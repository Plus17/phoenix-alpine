FROM hexpm/elixir:1.13.4-erlang-23.3.4.9-alpine-3.15.0

ENV PHOENIX_VERSION=1.6.6

RUN \
    apk add --no-cache --update \
      bash

RUN \
    apk add --no-cache \
      git python3 curl nodejs inotify-tools

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN touch ~/.bashrc
RUN /bin/bash -c "mix local.hex --force"
RUN /bin/bash -c "mix local.rebar --force"
RUN /bin/bash -c "mix archive.install --force hex phx_new $PHOENIX_VERSION"
