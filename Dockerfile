FROM nginx:1.27.2

LABEL author="nik@chankov.net"

# Create the stream conf directory
RUN mkdir /etc/nginx/stram.conf.d
# Copy the initial file in the directory
COPY ./dbtrac.conf /etc/nginx/stream.conf.d/

# Update nginx configuration file
RUN echo "stream {\n\tinclude /etc/nginx/stream.conf.d/*.conf;\n}" >> /etc/nginx/nginx.conf

# create the root directory
RUN mkdir /dbtrac

# Create RW and RO files
RUN mkdir /dbtrac/snippets
RUN touch /dbtrac/snippets/write.servers
RUN touch /dbtrac/snippets/read.servers
RUN echo "server localhost:3306;" >> /dbtrac/snippets/write.servers
RUN echo "server localhost:3306;" >> /dbtrac/snippets/read.servers
RUN chown nginx:nginx /dbtrac -Rf

# Add listener for file uploads (remote configuration)
COPY ./uploader.conf /etc/nginx/conf.d/
COPY ./35-dbtrac-monitor.sh /docker-entrypoint.d/