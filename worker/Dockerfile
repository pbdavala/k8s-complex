# Prod Dockerfile for worker.
FROM node:alpine
WORKDIR "/app"
COPY ./package.json ./
RUN npm install
COPY . .
# start  here is from package.json in worker folder where it is defiend as node index.js
CMD ["npm", "run", "start"]