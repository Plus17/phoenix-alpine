# Docker Phoenix
A docker image based on hexpm images with pre installed erlang, elixir, phoenix & nodejs.

Current versions:

**Alpine** 3.15.0

**Elixir** 1.14.0

**Erlang/OTP** 24.0.2

**Phoenix** 1.6.12

**Node** 16.14.2

Dockerize your phoenix project quickly with docker-compose with this image.

For a complete example see [Phoenix Boilerplate](https://github.com/Plus17/phoenix-boilerplate).

Example:

```yaml
version: '3.7'

volumes:
  deps:
  builds:
  node_modules:

services:
  phx:
    image: plus17/phoenix-alpine:1.14.0-1.6.12
    ports:
      - ${HTTP_PORT:-4000}:${HTTP_PORT:-4000}
    volumes:
      - ./:/app/src
      - deps:/app/src/deps
      - builds:/app/src/_build
      - node_modules:/app/src/assets/node_modules
    depends_on:
      - postgres
    env_file:
      - .env
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
