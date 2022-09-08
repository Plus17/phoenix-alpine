FROM hexpm/elixir:1.14.0-erlang-24.0.2-alpine-3.15.0

ENV PHOENIX_VERSION=1.6.12

RUN \
    apk add --no-cache --update \
      bash make gcc libc-dev npm

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
