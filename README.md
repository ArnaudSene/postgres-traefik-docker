# Deploy Traefik, Portainer, Postgres & pgadmin with Docker using LetsEncrypt to manage certificates.

In this guide we will 

- deploy [Traefik](https://traefik.io/traefik/) as a reverse proxy for Docker
- deploy [Postgres](https://github.com/docker-library/docs/blob/master/postgres/README.md) & pgadmin for Docker
- deploy [portainer](https://docs.portainer.io/) for Docker (manage containers in Docker)
- run all containers on a Linux Ubuntu 20.xx
- use [LetsEncrypt](https://letsencrypt.org/) for certification

> **Required**: 
> 
> You have 3 domain names configured, e.g:
>
> - traefik.domain-name.com
> - pgadmin.domain-name.com
> - portainer.domain-name.com


## Quick Install

### 1. Connect to your server and clone the repo

```shell
git clone https://gitlab.com/ArnaudSene/postgres-traefik-docker.git
cd postgres-traefik-docker
```

### 2. Postgres & pgadmin configuration
go to `./postgres-traefik-docker/apps/postgres`

```shell
cp env-custom .env
vi .env
```

Replace values between <> with your data. 

```dotenv
POSTGRES_USER=postgres
POSTGRES_PASSWORD=<password>
POSTGRES_DB=<db_name>
PGADMIN_DEFAULT_EMAIL=<email>
PGADMIN_DEFAULT_PASSWORD=<pg_password>
PGADMIN_HOST=pgadmin.<domain_name>
```

### 3. Traefik configuration
go to `./postgres-traefik-docker/traefik`

```shell
cp env-custom .env
vi .env
```

Replace values between <> with your data.

```dotenv
CERT_EMAIL=<email@domain_name>
TRAEFIK_HOST=traefik.<domain_name>
PORTAINER_HOST=portainer.<domain_name>
```

### 4. Create an encrypted password (Traefik dashboard) 
go to `./postgres-traefik-docker/traefik`

- Install htpasswd tool
 
```shell
sudo apt-get update
sudo apt-get install apache2-utils
```

- Save the encrypted password into `traefik/users_file` (htpasswd)
```shell
htpasswd -nb admin your_password > users_file
```

- set 600 permission on file `traefik/users_file`
```shell
sudo chmod 600 users_file
```

### 5. set 600 permission on file `traefik/data/acme.json`
go to `./postgres-traefik-docker/traefik/data`

```shell
sudo chmod 600 acme.json
```

### 6. Start containers

Start Traefik reverse proxy

go to `./postgres-traefik-docker/traefik`

```shell
chmod u+x start.sh
chmod u+x stop.sh
./start.sh
```

Start Postgres & pgadmin

go to `./postgres-traefik-docker/apps/postgres`

```shell
chmod u+x start.sh
chmod u+x stop.sh
./start.sh
```

### 7. Stop containers

Stop Traefik reverse proxy

go to `./postgres-traefik-docker/traefik`

```shell
./stop.sh
```

Start Postgres & pgadmin

go to `./postgres-traefik-docker/apps/postgres`

```shell
./stop.sh
```

---

## Access web apps

### 1. Traefik dashboard
Protected with `basicAuth`. Use your encrypted password to log in.

https://traefik.your-domain-name.com

### 2. Portainer apps
Create a user and password first then log in.

https://portainer.your-domain-name.com

### 3. pgadmin portal
Credentials defined in .env file

https://pgadmin.your-domain-name.com
