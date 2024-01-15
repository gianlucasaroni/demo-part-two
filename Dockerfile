####################
# frontend builder #
####################
FROM node:20.10.0 AS fe
WORKDIR /workspace/fe
COPY frontend .
RUN ls
RUN sed -i src/app/app.component.ts -e "s/http:\/\/localhost:3000//g" src/app/app.component.ts
RUN npm i && npm run build

##############
# main image #
##############
FROM ubuntu:22.04
WORKDIR /workspace

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install ca-certificates sudo curl nginx -y && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    sudo npm install -g npm

COPY nginx-site.conf /etc/nginx/sites-available/default

WORKDIR /workspace/be
COPY backend .
RUN npm install

WORKDIR /workspace
COPY start-all /usr/local/bin/start-all
RUN chmod +x /usr/local/bin/start-all
RUN rm -rf /var/www/html/*
COPY --from=fe /workspace/fe/dist/frontend/browser /var/www/html

CMD ["sh", "-c", "start-all"]