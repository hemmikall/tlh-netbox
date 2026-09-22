FROM docker.io/netboxcommunity/netbox:v4.7-5.1.1

COPY plugin_requirements.txt /opt/netbox/
COPY configuration/plugins.py /etc/netbox/config/plugins.py
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt \
    && mkdir -p /opt/netbox/netbox/static/netbox_topology_views/img