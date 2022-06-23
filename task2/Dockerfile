FROM golang:1.8
RUN apt-get update && apt-get install -y git
RUN curl -fsSL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs build-essential
RUN git clone https://github.com/mintme-com/pool.git /app
WORKDIR /app/www
RUN npm install -g ember-cli@2.4.3 && \
    npm install -g bower && \
    npm install && \
    bower install --allow-root
WORKDIR /app
RUN go mod init main
RUN make
COPY ./conf/pool/run.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/run.sh && \
    ln -s /usr/local/bin/run.sh
CMD sh /usr/local/bin/run.sh
EXPOSE 8080
EXPOSE 8888
EXPOSE 3333
