FROM node:26.12.1-alpine
RUN apk --update add git
RUN npm install gulp-cli -g
RUN mkdir /workspace && \
    cd /workspace && \
    npm install jsonnet-exec
RUN apk --update add jsonnet && \
    cp /usr/bin/jsonnet /workspace/node_modules/jsonnet-exec/bin/jsonnet
ENTRYPOINT ["/bin/sh"]