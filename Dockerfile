FROM gcr.io/cloud-builders/npm

RUN npm install gulp-cli -g

ENTRYPOINT ["gulp"]