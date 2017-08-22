
# Open ports 80, 5601, 9200, and 9300 on your security setting for your AMI. #
##############################################################################


## Download Java8 for 64-bit as root. Instructions from https://tecadmin.net/install-java-8-on-centos-rhel-and-fedora/
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"
tar xzf jdk-8u141-linux-x64.tar.gz

## Load elastic search onto AMI instance as root. Instructions from https://www.elastic.co/blog/running-elasticsearch-on-aws
sudo rpm -i https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.3/elasticsearch-2.3.3.rpm
sudo chkconfig --add elasticsearch

# install aws plugin
cd /usr/share/elasticsearch/
sudo bin/plugin install cloud-aws

## Configure elastic search if desired, but defaults are fine for our AMI instance
# vi /etc/sysconfig/elasticsearch
# vi /etc/elasticsearch/elasticsearch.yml

## Start elastic search
sudo service elasticsearch start

## Test Connectivity
curl localhost:9200/_cluster/health?pretty

########################################
# Output should loook like this sample #
########################################
#{
#  "cluster_name" : "elasticsearch",
#  "status" : "green",
#  "timed_out" : false,
#  "number_of_nodes" : 1,
#  "number_of_data_nodes" : 1,
#  "active_primary_shards" : 0,
#  "active_shards" : 0,
#  "relocating_shards" : 0,
#  "initializing_shards" : 0,
#  "unassigned_shards" : 0,
#  "delayed_unassigned_shards" : 0,
#  "number_of_pending_tasks" : 0,
#  "number_of_in_flight_fetch" : 0,
#  "task_max_waiting_in_queue_millis" : 0,
#  "active_shards_percent_as_number" : 100.0
#}
##############################################

##################
# Install Kibana #
##################

wget https://artifacts.elastic.co/downloads/kibana/kibana-5.5.2-x86_64.rpm
#check sha1 sum
sha1sum kibana-5.5.2-x86_64.rpm

sudo rmp --install kibana-5.5.2-x86_64.rpm

#Start Service
sudo chkconfig --add kibana
sudo -i service kibana start
#To stop use the following code
#sudo -i service kibana stop
