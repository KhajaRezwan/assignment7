# Start from an Ubuntu base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    passwd \
    && rm -rf /var/lib/apt/lists/*

# Create users and groups only if they do not exist
RUN groupadd -g 5000 collin || true && \
    id -u sync &>/dev/null || useradd -m sync && \
    id -u nobody &>/dev/null || useradd -m nobody && \
    groupadd sync || true && \
    # Create the /structure directory and subdirectories
    mkdir -p /structure/sync-work /structure/nobody-work && \
    # Change ownership of directories
    chown sync:sync /structure/sync-work && \
    chown nobody:nogroup /structure/nobody-work

# Create the user 'collin' with UID 5000 only if it does not exist
RUN id -u collin &>/dev/null || useradd -u 5000 collin

# The command to keep the container running
CMD ["while", "true", "do", "echo", "users", ";", "done"]
