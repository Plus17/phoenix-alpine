# Docker Phoenix
A docker image based on hexpm images with pre installed erlang, elixir, phoenix & nodejs.

Current versions:

**Alpine** 3.15.0

**Elixir** 1.13.4

**Erlang/OTP** 23.3.4.9

**Phoenix** 1.6.6

**Node** 16.14.2

Dockerize your phoenix project quickly with docker-compose with this image.

Example:

```yaml
version: '3.7'

volumes:
  deps:
  builds:
  node_modules:

services:
  phx:
    image: plus17/phoenix-alpine:1.13.4-1.6.6
    ports:
      - ${HTTP_PORT:-4000}:${HTTP_PORT:-4000}
    volumes:
      - ./:/app/src
      - deps:/app/src/deps
      - builds:/app/src/_build
      - node_modules:/app/src/assets/node_modules
    depends_on:
      - postgres
    environment:
      - MIX_ENV=${ENV:-dev}
      - POSTGRES_URL=ecto://postgres:postgres@postgres/your_app_name_${ENV:-dev}
      - HTTP_PORT=${HTTP_PORT:-4000}
    working_dir: /app/src

  postgres:
    image: postgres:11
    ports:
      - ${DATABASE_EXTERNAL_PORT:-5432}:5432
    environment:
      POSTGRES_HOST_AUTH_METHOD: "trust"
```

And execute with:
```bash
# Commands to set-up your app
docker-compose run --rm phx sh -c "mix ecto.create"
docker-compose run --rm phx sh -c "mix ecto.migrate"
docker-compose run --rm phx sh -c "cd assets/node_modules && npm install"

# Start your server
docker-compose run --service-ports phx iex --sname your_app -S mix phx.server

# To run tests
ENV=test docker-compose run --rm phx sh -c "mix test"
```
