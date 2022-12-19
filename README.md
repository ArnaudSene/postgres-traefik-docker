# Deploy Traefik, Portainer, Postgres & pgadmin with Docker using LetsEncrypt fo manage certificates.

[Postgres for Docker](https://github.com/docker-library/docs/blob/master/postgres/README.md)


In this guide we will 

- deploy Traefik as a reverse proxy for Docker
- deploy Postgres & pgadmin for Docker
- deploy portainer for Docker
- run all containers on a Linux Ubuntu 20.xx hosted on Digital Ocean
- use LetsEncrypt for certification

> **Required**: 
> 
> You have 3 domain names configured, e.g:
>
> - traefik.halila.ca
> - pgadmin.halia.ca
> - portainer.halia.ca
    {.is-warning}


## Quick Install

### 1. Connect to your server and clone the repo

```shell
git clone https://gitlab.com/ArnaudSene/postgres-traefik-docker.git
cd postgres-traefik-docker
```

### 2. Edit the Postgres required file: `.env`:

```shell
cp env-custom apps/postgres/.env
vi apps/postgres/.env
```

```dotenv
POSTGRES_USER=postgres
POSTGRES_PASSWORD="pg password"
POSTGRES_DB="database name"
PGADMIN_DEFAULT_EMAIL="a valid email"
PGADMIN_DEFAULT_PASSWORD="pgadmin password"
```

### 3. Traefik configuration

1. set 600 permission on file `traefik/data/acme.json`
2. update `traefik/docker-compose.yml` file
   - replace `traefik.domain-nane.com` with your domain name
   - replace `portainer.domain-nane.com` with your domain name
3. update `traefik/data/traefik.yml` file
   - replace `email@domain-nane.com` with your email address
4. update `traefik/data/configs/traefik-dynamic.yml` file
   - create an encrypted password (e.g: use *htpassword*)
   - replace `"encrypted password with htpasswd for example"` with your encrypted password

### 4. Start containers

Start Traefik reverse proxy

```shell
cd traefik
docker compose up -d
```

Start Postgres & pgadmin

```shell
cd apps/postgres
bash start.sh
```

---

## Access web apps

### 1. Traefik dashboard
Protect with `basicAuth`. Use your encrypted password to sign in.

https://traefik.your-domain-name.com

### 2. Portainer apps
Create a user and password

https://portainer.your-domain-name.com

### 3. pgadmin portal
Credentials defined in .env file

https://pgadmin.your-domain-name.com