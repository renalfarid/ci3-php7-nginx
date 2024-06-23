# CI PHP 7 Nginx Container 

This project sets up a Docker container running Alpine Linux with Nginx, PHP 7.4, PHP-FPM, and Composer. The container is configured to serve a PHP application located in the `/var/www/html` directory.

## Prerequisites

- Docker installed on your machine.

## Getting Started

### Clone the Repository

First, clone the repository to your local machine:

```sh
git clone https://github.com/renalfarid/ci3-php7-nginx.git
cd ci3-php7-nginx
docker build -t <image_name> . --no-cache
docker run -d -p 80:80 <image_name>
```
Open browser : http://localhost


