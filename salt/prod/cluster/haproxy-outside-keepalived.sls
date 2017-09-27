include:
  - keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/haproxy-outside-keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
     {% if grains['id'] == 'master.saltstack.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - ETHID: eth0
    - PRIORITYID: 150
     {% elif grains['id'] == 'minion.saltstack.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - ETHID: eth1
    - PRIORITYID: 100
     {% endif %}

  service.running:
    - name: keepalived
    - enable: True
    - watch:
       - file: keepalived-service
