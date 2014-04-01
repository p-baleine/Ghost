#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
# https://github.com/dockerfile/ghost/blob/master/Dockerfile
#

# Pull base image.
FROM dockerfile/nodejs

ADD . /ghost

ENV NODE_ENV development

RUN npm install -g grunt-cli
RUN cd /ghost && npm install
RUN cd /ghost && grunt init

RUN sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js

# Mount volumes.
VOLUME /ghost-override

# Define working directory.
WORKDIR /ghost

# Add files.
ADD start.bash /ghost-start

# Expose ports.
EXPOSE 2368

# Define an entry point.
CMD ["bash", "/ghost-start"]