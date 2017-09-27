include:
  - pkg.pkg-init
  - pkg.pkg-yum

keepalived-install:
  file.managed:
    - name: /usr/local/src/keepalived-1.3.6.tar.gz
    - source: salt://keepalived/files/keepalived-1.3.6.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar -zxvf keepalived-1.3.6.tar.gz && cd /usr/local/src/keepalived-1.3.6 && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - pkg: pkg-init
      - pkg: pkg-yum
      - file: keepalived-install 

keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/files/keepalived
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require:
      - file: keepalived-init

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
    - mode: 755

