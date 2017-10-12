#!/bin/bash
host = $1
yum install vim wget tar net-tools -y
ssh-keygen -t dsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 644 -R ~/.ssh
chmod 600 ~/.ssh/id_rsa
setenforce 0
iptables -F
iptables -X
echo "SELINUX=disabled" > /etc/selinux/config
tar -zxvf ./jdk-8u141-linux-x64.tar.gz -C /usr/local/src/
mv /usr/local/src/jdk1.8.0_141 /usr/local/src/jdk1.8
echo "export JAVA_HOME=/usr/local/src/jdk1.8" > /etc/profile.d/java.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/java.sh
echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile.d/java.sh
source /etc/profile
mkdir /bigdata
tar -zxvf ./hadoop-3.0.0-beta1.tar.gz -C /bigdata/
\cp -R ./hadoop-env.sh /bigdata/hadoop-3.0.0-beta1/etc/hadoop/hadoop-env.sh
\cp -R ./core-site.xml /bigdata/hadoop-3.0.0-beta1/etc/hadoop/core-site.xml
\cp -R ./hdfs-site.xml /bigdata/hadoop-3.0.0-beta1/etc/hadoop/hdfs-site.xml
\cp -R ./mapred-site.xml /bigdata/hadoop-3.0.0-beta1/etc/hadoop/mapred-site.xml
\cp -R ./yarn-site.xml /bigdata/hadoop-3.0.0-beta1/etc/hadoop/yarn-site.xml
\cp -R ./start-dfs.sh /bigdata/hadoop-3.0.0-beta1/sbin/start-dfs.sh
\cp -R ./stop-dfs.sh /bigdata/hadoop-3.0.0-beta1/sbin/stop-dfs.sh
\cp -R ./start-yarn.sh /bigdata/hadoop-3.0.0-beta1/sbin/start-yarn.sh
\cp -R ./stop-yarn.sh /bigdata/hadoop-3.0.0-beta1/sbin/stop-yarn.sh
chown root:root -Rf /bigdata/hadoop-3.0.0-beta1/
/bigdata/hadoop-3.0.0-beta1/bin/hdfs namenode -format
/bigdata/hadoop-3.0.0-beta1/sbin/start-all.sh
echo "export HADOOP_HOME=/bigdata/hadoop-3.0.0-beta1" > /etc/profile.d/hadoop.sh
echo "export PATH=\$HADOOP_HOME/bin:\$PATH" >> /etc/profile.d/hadoop.sh
source /etc/profile