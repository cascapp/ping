# Ping

Ping is a small docker image intended to provide a "ping" response for a docker swarm. This is useful, for example
if the swarm is running behind something like an AWS load balancer, that expects a health check to respond.

Ping normally runs on port 8080 at the endpoint `/ping`.  This can be altered by specifying the env variables 
`PING_PORT` and `PING_PATH`, respectively.

Note that the image does not expose a port.  This should be done via the `docker run --expose <port>` flag, where 
`<port>` is 8080 or is the port you specified in `PING_PORT`

A typical configuration in a docker swarm with Traefik, (for example) might look like:

```yaml
services:
  ping:
  image: cascapp/ping:latest
  restart: always
  deploy:
    replicas: 2
    restart_policy:
      condition: on-failure
    labels:
      - traefik.http.services.ping.loadbalancer.server.port=8080
      - traefik.http.routers.ping.rule=PathPrefix(`/ping`)
  #    environment:
  #      PING_PORT: 3000   # optional, defaults to 8080
  #      PING_PATH: /ping  # optional, defaults to /ping
  networks:
    - traefik
  logging:
    driver: "json-file"
    options:
      max-size: "10m"
      max-file: "3"
```