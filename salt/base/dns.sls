/etc/resolv.conf:
  file.managed:
    - source: salt://files/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        DNS_Server: 202.96.209.133
