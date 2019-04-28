FROM node:latest

WORKDIR /

RUN git clone  https://github.com/sathyarajagopal/node-export-server.git && \
    chown -R node /node-export-server

WORKDIR /node-export-server

USER node 

ENV ACCEPT_HIGHCHARTS_LICENSE="YES"

RUN rm package-lock.json && \
    npm install

USER root	 
RUN npm link --unsafe-perm

USER node

WORKDIR /node-export-server

CMD highcharts-export-server --enableServer 1 --port 7801

EXPOSE 7801
# ENTRYPOINT ["/usr/local/bin/npm", "run", "start"]