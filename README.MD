Static Website Example
----------------------

To be used with Cloud Academy labs.

## Quick Start

This guide explains how to run the application using Docker, but without Docker Compose.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

### 1. Build the Backend Image

```bash
docker build -t python-backend .
```

### 2. Create a Docker Network

```bash
docker network create app-network
```

### 3. Run the Backend Container

```bash
docker run -d --name backend --network app-network python-backend
```

### 4. Run the Nginx Container

```bash
docker run -d --name nginx -p 8181:80 --network app-network \
  -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
  -v $(pwd):/usr/share/nginx/html \
  nginx:latest
```

### 5. Access the Application

Open your web browser and navigate to `http://localhost:8181`.

License
----------------------

This static website is based on the Dimension template by [HTML5 UP](https://html5up.net/)

Creative Commons License
All of the site templates I create for [HTML5 UP](https://html5up.net/) are licensed under the Creative Commons Attribution 3.0 License, which means you can:
 - Use them for personal stuff
 - Use them for commercial stuff
 - Change them however you like


... all for free, yo. In exchange, just give HTML5 UP credit for the design and tell your friends about it :)

More info [here](https://html5up.net/license).
