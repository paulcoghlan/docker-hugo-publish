# Stage 1: Build the Hugo site
FROM debian:bullseye-slim as builder

# Set environment variables
ENV HUGO_VERSION 0.142.0
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-amd64.deb

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
curl \
vim-tiny \
git \
ca-certificates && \
curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} -o ${HUGO_BINARY}    

RUN apt-get install -y ./${HUGO_BINARY} && \
    rm -rf /var/lib/apt/lists/* ${HUGO_BINARY}

# Add Google Cloud SDK distribution URI as a package source
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import Google Cloud public key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Install the Google Cloud SDK
RUN apt-get update && apt-get install -y google-cloud-sdk

# Set working directory
WORKDIR /site

# Copy build.sh to container and execute 
COPY build.sh ./

RUN chmod +x build.sh 

# Define build argument with a default value
ARG HUGO_ACTION=build
# Convert ARG to ENV so it's available at runtime
ENV HUGO_ACTION=${HUGO_ACTION}

# RUN build.sh 
CMD ["./build.sh"]


# # Stage 2: Serve the site
# FROM nginx:alpine

# # Copy the built site from the previous stage
# COPY --from=builder /site/public /usr/share/nginx/html

# # Expose the port used by NGINX
# EXPOSE 80

# # Start the NGINX server

