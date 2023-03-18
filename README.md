# Ping

Ping is a small docker image intended to provide a "ping" response for a docker swarm. This is useful, for example
if the swarm is running behind something like an AWS load balancer, that expects a health check to respond.

Ping normally runs on port 8080 at the endpoint `/ping`.  This can be altered by specifying the env variables 
`PING_PORT` and `PING_PATH`, respectively.

A typical configuration in a docker swarm (for example) might look like:

```yaml
services:
  ping:
    image: cascapp/ping:latest
    restart: always
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
    environment:
      PING_PORT: 8080   # optional, defaults to 8080
      PING_PATH: /ping  # optional, defaults to /ping
    networks:
      - traefik
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```