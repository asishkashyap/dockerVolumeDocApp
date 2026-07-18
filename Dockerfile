# Single stage docker file for Todo Application - Frontend
FROM nginx:1.29.5-alpine

#copy the html file from repo
COPY ./index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

