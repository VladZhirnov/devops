FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY static-website-example/ .

COPY devops/nginx-docker.conf /etc/nginx/conf.d/default.conf

EXPOSE 8282

CMD ["nginx", "-g", "daemon off;"]
