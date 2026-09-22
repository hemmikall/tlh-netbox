FROM docker.io/netboxcommunity/netbox:v4.7-5.1.1

COPY plugin_requirements.txt /opt/netbox/
RUN /opt/netbox/venv/bin/pip install --no-cache-dir -r /opt/netbox/plugin_requirements.txt \
    && mkdir -p /opt/netbox/netbox/static/netbox_topology_views/img