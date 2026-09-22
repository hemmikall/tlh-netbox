# tlh-netbox

Portainer-ready deployment for the community-maintained
[NetBox Docker image](https://github.com/netbox-community/netbox-docker).

## Deploy with Portainer

This stack is for a **Docker Standalone** environment. It uses the upstream
prebuilt `netboxcommunity/netbox:v4.7-5.1.1` image plus PostgreSQL and Valkey.

1. Edit `.env` before deployment. Set `ALLOWED_HOSTS` to the hostname(s) and/or
	IP address used to reach NetBox. Replace the initial administrator email and
	credentials if this instance will be exposed outside a trusted network.
2. In Portainer, select **Stacks** then **Add stack**, choose **Upload**, and
	upload `docker-compose.yml`.
3. Under **Environment variables**, choose **Load variables from .env file**
	and upload this repository's `.env` file.
4. Deploy the stack. Portainer creates `stack.env` from those values and passes
	it to every service.
5. Open `http://<server>:8000` and sign in with `SUPERUSER_NAME` and
	`SUPERUSER_PASSWORD` from `.env`.

`stack.env` is the bridge expected by Portainer's Docker Standalone stack
environment. It is safe to commit because it contains variable references only.
The generated `.env` contains secrets and is excluded from Git.

## Local validation

Validate the rendered configuration without starting containers:

```sh
docker compose --env-file .env config
```

For a local Docker Compose deployment, run:

```sh
docker compose up -d
```

## Upgrades

Keep `NETBOX_IMAGE` pinned. NetBox Docker requires its image support-files
version to match the deployment version. Review the
[netbox-docker release notes](https://github.com/netbox-community/netbox-docker/releases)
before changing the `NETBOX_IMAGE` tag or updating the stack in Portainer.