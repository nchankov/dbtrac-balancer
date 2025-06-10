FROM nginx:1.27.2

LABEL author="nik@chankov.net"

# Create the stream conf directory
RUN mkdir /etc/nginx/stram.conf.d
# Copy the initial file in the directory
COPY ./dbtrac.conf /etc/nginx/stream.conf.d/

# Update nginx configuration file
RUN echo "stream {\n\tinclude /etc/nginx/stream.conf.d/*.conf;\n}" >> /etc/nginx/nginx.conf

# Create RW and RO files
RUN mkdir /etc/nginx/snippets
RUN touch /etc/nginx/snippets/write.servers
RUN touch /etc/nginx/snippets/read.servers
RUN echo "server localhost:3306;" >> /etc/nginx/snippets/write.servers
RUN echo "server localhost:3306;" >> /etc/nginx/snippets/read.servers

# Add listener for file uploads (remote configuration)
COPY ./uploader.conf /etc/nginx/conf.d/
COPY ./35-dbtrac-monitor.sh /docker-entrypoint.d/