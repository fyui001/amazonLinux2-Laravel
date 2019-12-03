FROM amazonlinux:2

ARG SRC_FILES_PATH=files
ARG DST_FILES_PATH=/root/files

COPY $SRC_FILES_PATH $DST_FILES_PATH
RUN sh ${DST_FILES_PATH}/install.sh ${DST_FILES_PATH}

# 作業ディレクトリの指定
ADD ./ /var/www/html
WORKDIR /var/www/html

CMD sh /root/startup.sh
