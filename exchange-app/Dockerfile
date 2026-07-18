FROM node:alpine AS build

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:alpine
WORKDIR /usr/src/app
RUN npm install -g serve

COPY --from=build /usr/src/app/dist/exchange-app /usr/src/app/dist/

EXPOSE 8080
CMD ["serve", "-s", "dist/browser", "-l", "8080"]
