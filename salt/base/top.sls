base:
  '*':
    - init.env_init


prod:
  'master.saltstack.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'minion.saltstack.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
