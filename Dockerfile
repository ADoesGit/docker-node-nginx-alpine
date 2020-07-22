# We're mixing Node and Nginx Alpine images, to allow custom configuration through environment
# variables (at runtime) - like API_URL!
# ---

# since nginx image is bigger (143 lines), we're starting with it and adding node to it.
# Use an official nginx image
#  from https://github.com/nginxinc/docker-nginx/blob/ddbbbdf9c410d105f82aa1b4dbf05c0021c84fd6/mainline/alpine/Dockerfile
FROM nginx:alpine


# --
# [start] node:10.9-alpine
#   from https://github.com/nodejs/docker-node/blob/72dd945d29dee5afa73956ebc971bf3a472442f7/10/alpine/Dockerfile
# instead of using "FROM", we're copying the Dockerfile source here.
# "FROM node:10.9-alpine"
# --


RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --update npm 


# We're not using it's command.
# CMD [ "node" ]

# --
# [end] node:10.9-alpine
# --


# From now on we have both nginx and node (+ yarn) available

# And we end our Dockerfile with nginx Dockerfile last instructions

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
