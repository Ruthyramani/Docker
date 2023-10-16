#buildphase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN echo "process.setMaxListeners(20);" >> /app/entrypoint.js
COPY . .
RUN  npm run build


#runphase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html


