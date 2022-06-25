FROM golang:1.9.1
RUN apt-get update && apt-get install -y git
RUN curl -fsSL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y --force-yes nodejs build-essential
RUN git clone https://github.com/mintme-com/pool.git /app
WORKDIR /app/www
RUN npm install -g ember-cli@2.4.3 && \
    npm install -g bower && \
    npm install && \
    bower install
WORKDIR /app
RUN apt update && apt install ca-certificates libgnutls30 -y
RUN git config --global http.postBuffer 524288000
RUN make
COPY ./conf/pool/run.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/run.sh && \
    ln -s /usr/local/bin/run.sh
CMD sh /usr/local/bin/run.sh
EXPOSE 8080
EXPOSE 8888
EXPOSE 3333
