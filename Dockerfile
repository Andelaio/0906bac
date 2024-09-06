FROM node:latest

EXPOSE 3000

WORKDIR /app

COPY . .

RUN apt update -y &&\
    chmod +x server.js &&\
    npm install 

CMD ["npm", "start"]
