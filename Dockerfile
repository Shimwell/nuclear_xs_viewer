# base image
FROM node:12.2.0-alpine as build

# sudo docker build -t shimwell:nuclear_xs_viewer .

# docker run -v ${PWD}:/app -v /app/node_modules -p 3001:3000 --rm shimwell:nuclear_xs_viewer
# sudo docker run -it -p 80:80 -rm shimwell:nuclear_xs_viewer

# set working directory
WORKDIR /app


# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV NODE_OPTIONS="–max-old-space-size=2048"

# install and cache app dependencies
COPY package.json /app/package.json

RUN npm version patch

RUN npm install
RUN npm install react-scripts@3.0.1 -g 
RUN npm install jquery --save
RUN npm install popper.js --save
RUN npm install bootstrap --save
RUN npm install reactstrap react react-dom --save
RUN npm install react-table --save
RUN npm install react-select --save
RUN npm install reactstrap --save
RUN npm install react-plotly.js --save
RUN npm install plotly.js --save
RUN npm install rc-slider --save 
RUN npm install dotenv --save

RUN echo updating app code
COPY . /app

RUN npm update
# RUN npm ls
# ENV HOST_IP = 34.68.223.199

# RUN npm run build
RUN REACT_APP_HOST_IP=http://34.68.223.199 npm run build

# start app
# CMD ["npm", "start"]

FROM nginx:1.16.0-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
