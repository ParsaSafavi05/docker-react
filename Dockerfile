FROM node:alpine as builder
WORKDIR '/app'

COPY package.json package-lock.json ./

RUN npm cache clean --force \ && npm install --verbose --fetch-timeout=60000 \
--registery=https://registery.npmmirror.com/

COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html



