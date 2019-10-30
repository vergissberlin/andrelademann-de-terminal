FROM node:11-alpine

# myself
RUN apk add bash bash-completion vim
RUN adduser -D -s /bin/bash andre.lademann
RUN chmod go= /home/*

# terminal
RUN npm i -g node-gyp pm2
USER andre.lademann
COPY --chown=andre.lademann:andre.lademann ./home/ /home/andre.lademann
WORKDIR /home/andre.lademann/app
RUN npm ci
ENV TERM=xterm

# go
WORKDIR /home/andre.lademann
RUN chmod -R 500 ./app *.txt
RUN ls -lisah /home/andre.lademann/
CMD ["/bin/bash/", "pm2-runtime", "app/index.js"]
