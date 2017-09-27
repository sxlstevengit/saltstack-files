zabbix-agent-install:
  pkg.installed:
    - name: zabbix-agent

zabbix-agent-service:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://init/files/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
        Server: {{ pillar['zabbix-agent']['Zabbix_Server'] }}
    - require:
      - pkg: zabbix-agent-install 

  service.running:
    - name: zabbix-agent
    - enable: True
    - watch:
      - pkg: zabbix-agent-install
      - file: zabbix-agent-service
