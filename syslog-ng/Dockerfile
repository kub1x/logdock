FROM balabit/syslog-ng:latest

ADD scripts/install-kafka-libs.sh /tmp/
RUN chmod +x /tmp/install-kafka-libs.sh && /tmp/install-kafka-libs.sh

# See: https://hub.docker.com/r/dockerbase/syslog-ng/~/dockerfile/
# Replace the system() source because inside Docker we can't access /proc/kmsg.
# https://groups.google.com/forum/#!topic/docker-user/446yoB0Vx6w
RUN	sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf

# See: https://hub.docker.com/r/dockerbase/syslog-ng/~/dockerfile/
# Uncomment 'SYSLOGNG_OPTS="--no-caps"' to avoid the following warning:
# syslog-ng: Error setting capabilities, capability management disabled; error='Operation not permitted'
# http://serverfault.com/questions/524518/error-setting-capabilities-capability-management-disabled#
RUN	sed -i 's/^#\(SYSLOGNG_OPTS="--no-caps"\)/\1/g' /etc/default/syslog-ng
