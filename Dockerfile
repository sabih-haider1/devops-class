FROM node:alpine AS app-build-stage
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
# RUN npx htmlhint "**/*.html"
# RUN npx stylelint "**/*.css"
RUN npx parcel build "./src/index.html" --dist-dir "./dist" --public-url "./" --no-cache

FROM nginx:alpine AS deploy-stage
COPY --from=app-build-stage /app/dist /usr/share/nginx/html