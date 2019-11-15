# TiFlash cluster Docker Compose

1. Put the following binaries into `bin/` directory

* pd-server
* tikv-server
* tidb-server
* tikv-server-rngine
* tiflash
* flash_cluster_manager

2. Run docker-compose

``` shell
docker-compose up
```

3. Connect TiDB

``` shell
mysql -h 127.0.0.1 -P 4000 -u root -D test --comments
MySQL [test]> create table cluster (id int, name varchar(10));
MySQL [test]> insert into cluster values(10, "name");
MySQL [test]> alter table test.cluster set tiflash replica 1;
MySQL [test]> select /*+ read_from_storage(tiflash[t]) */ count(*) from test.cluster t;
MySQL [test]> explain select /*+ read_from_storage(tiflash[t]) */ count(*) from test.cluster t;
```

If the plan output contains `tiflash`, then the TiFlash cluster is normal.

# TiFlash k8s cluster
1. use `kind` deploy tidb cluster(https://pingcap.com/docs-cn/stable/tidb-in-kubernetes/get-started/deploy-tidb-from-kubernetes-kind/)

2. kubectl apply -f tiflash.yaml

3. wait for tiflash and cluster-manage pod ready (`watch kubectl get pods`)

4. kubectl apply -f rngine.yaml

5. kubectl port-forward -n tiflash-test svc/tiflash-test-cluster-tidb 4000:4000 &  
   
6. mysql -h 127.0.0.1 -P 4000 -u root -D test

# chaos test
1. kubectl apply -f tikv-failure.yaml

notes:
1. check pd,tikv,tidb version
2. remember to modify pd config
