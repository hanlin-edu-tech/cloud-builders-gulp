FROM alpine:latest AS jsonnet-builder
ADD .ssh /root/.ssh
RUN apk --update add git openssh build-base
WORKDIR /opt
RUN ssh -o StrictHostKeyChecking=no git@github.com; exit 0
RUN git clone git@github.com:google/jsonnet.git jsonnet
RUN cd jsonnet && \
    make

FROM node:8-alpine
RUN apk --update add git
RUN npm install gulp-cli -g
RUN mkdir /workspace && \
    cd /workspace && \
    npm install jsonnet-exec
COPY --from=jsonnet-builder /opt/jsonnet/jsonnet /workspace/node_modules/jsonnet-exec/bin/jsonnet
ENTRYPOINT ["/bin/sh"]