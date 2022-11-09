FROM node:alpine
COPY . .
RUN npm install
RUN npm fund
RUN CI=true
CMD ["npm","start"]











