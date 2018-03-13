FROM node:8-alpine

# Update latest available packages,
# add 'app' user, and make temp directory
RUN echo "http://mirrors.aliyun.com/alpine/v3.7/main/" > /etc/apk/repositories&&\
    apk --no-cache add ffmpeg git && \
    npm install -g grunt-cli bower && \
    adduser -D app && \
    mkdir /tmp/torrent-stream && \
    chown app:app /tmp/torrent-stream

WORKDIR /home/app
COPY . .
RUN chown app:app /home/app -R

# run as user app from here on
USER app
RUN npm config set registry https://registry.npm.taobao.org&&\
    PHANTOMJS_CDNURL=https://npm.taobao.org/dist/phantomjs npm install && \
    bower install 

VOLUME [ "/tmp/torrent-stream" ]
EXPOSE 6881 9000

CMD [ "npm", "start" ]
