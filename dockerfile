# copying the package.json files and installing dependencies:
COPY package*.json ./
RUN npm install

# copying the rest of application code:
COPY . .

# building the application:
RUN npm run build


# second stage base image:
FROM nginx:alpine

# removing default nginx static files:
RUN rm -rf /usr/share/nginx/html/*

# copying build files from first stage:
COPY --from=build /app/build /usr/share/nginx/html

# exposing port:
EXPOSE 80

# starting nginx:
CMD ["nginx", "-g", "daemon off;"]
