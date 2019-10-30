FROM node:11-alpine

# myself
RUN apk add bash bash-completion vim mc
RUN adduser -D -s /bin/bash andre.lademann
RUN chmod go= /home/*

# terminal
RUN npm i -g node-gyp pm2
USER andre.lademann
COPY --chown=andre.lademann:andre.lademann ./home/ /home/andre.lademann
WORKDIR /home/andre.lademann/app
RUN npm ci
ENV TERM=xterm \
    WEB_SHELL=/bin/bash
EXPOSE 1337

# go
WORKDIR /home/andre.lademann
RUN chmod -R 500 ./app *.txt
CMD ["pm2-runtime", "app/index.js"]
