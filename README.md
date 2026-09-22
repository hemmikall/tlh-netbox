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
	it to every service. The Compose file sets the internal database and Valkey
	hostnames itself, so the stack works whether it is uploaded or deployed from
	a Git repository.
5. Open `http://<server>:6789` and sign in with `SUPERUSER_NAME` and
	`SUPERUSER_PASSWORD` from `.env`.

`stack.env` is the bridge used by local Docker Compose. On a Portainer Docker
Standalone deployment, Portainer creates its own `stack.env` from the uploaded
`.env` variables. The generated `.env` contains secrets and is excluded from
Git.

The stack attaches all services to the dedicated `${NETBOX_NETWORK_NAME}`
bridge network. PostgreSQL and Valkey have no host port mappings, so they are
reachable only by the NetBox services on that network. The only published port
is NetBox on `NETBOX_PORT`.

## Local validation

Validate the rendered configuration without starting containers:

```sh
docker compose --env-file .env config
```

For a local Docker Compose deployment, run:

```sh
docker compose up -d
```

## Docker Host Prerequisite

Valkey requires Linux memory overcommit to be enabled so background persistence
does not fail. Run this once on the Docker/Portainer host, not in a container:

```sh
sudo sysctl -w vm.overcommit_memory=1
echo 'vm.overcommit_memory = 1' | sudo tee /etc/sysctl.d/99-netbox-valkey.conf
sudo sysctl --system
```

Verify the setting with `sysctl vm.overcommit_memory`; it must report `1`.

## Upgrades

Keep `NETBOX_IMAGE` pinned. NetBox Docker requires its image support-files
version to match the deployment version. Review the
[netbox-docker release notes](https://github.com/netbox-community/netbox-docker/releases)
before changing the `NETBOX_IMAGE` tag or updating the stack in Portainer.