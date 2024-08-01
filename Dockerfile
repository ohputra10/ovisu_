FROM node:14-bullseye

RUN apt-get update && apt-get install -y dos2unix

# Change working directory
WORKDIR /usr/src/app

# Clone FUXA repository
RUN git clone https://github.com/ohputra10/ovisu.git

# Copy odbcinst.ini to /etc
RUN cp FUXA/odbc/odbcinst.ini /etc/odbcinst.ini

# Install build dependencies for node-odbc
RUN apt-get update && apt-get install -y build-essential unixodbc unixodbc-dev

# Convert the script to Unix format and make it executable
RUN dos2unix FUXA/odbc/install_odbc_drivers.sh && chmod +x FUXA/odbc/install_odbc_drivers.sh

# Execute the script
RUN FUXA/odbc/install_odbc_drivers.sh

# Clone node-odbc repository
RUN git clone https://github.com/markdirish/node-odbc.git

# Change working directory to node-odbc
WORKDIR /usr/src/app/node-odbc

# Install compatible versions of global npm packages
RUN npm install -g npm@7 && \
    npm install -g node-gyp@7 && \
    npm install -g node-addon-api@5 && \
    npm install -g @mapbox/node-pre-gyp@1

# Install dependencies and build node-odbc
RUN npm ci --production && \
    ./node_modules/.bin/node-pre-gyp rebuild --production && \
    ./node_modules/.bin/node-pre-gyp package

# Build and install node-odbc
#RUN npm install

# Change working directory
WORKDIR /usr/src/app

# Clone FUXA repository
RUN git clone -b odbc https://github.com/ohputra10/ovisu.git

# Change working directory to FUXA
WORKDIR /usr/src/app/FUXA

# Install Fuxa server
WORKDIR /usr/src/app/FUXA/server
RUN npm install

# Workaround for sqlite3 https://stackoverflow.com/questions/71894884/sqlite3-err-dlopen-failed-version-glibc-2-29-not-found
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev && \
    apt-get autoremove -yqq --purge && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*  && \
    npm install --build-from-source --sqlite=/usr/bin sqlite3

# Add project files
ADD . /usr/src/app/FUXA

# Set working directory
WORKDIR /usr/src/app/FUXA/server

# Expose port
EXPOSE 1881

# Start the server
CMD [ "npm", "start" ]
