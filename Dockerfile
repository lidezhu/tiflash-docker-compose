FROM centos:7.5.1804

ADD bin/tikv-server /tikv-server
ADD bin/pd-server /pd-server
ADD bin/tidb-server /tidb-server
ADD bin/tiflash /tiflash
ADD bin/tikv-server-rngine /tikv-server-rngine
ADD bin/flash_cluster_manager /flash-cluster-manager
