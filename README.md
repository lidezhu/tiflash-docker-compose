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
MySQL [test]> alter table test.cluster set tiflash replica 1;
MySQL [test]> select /*+ read_from_storage(tiflash[t]) */ count(*) from test.cluster t;
MySQL [test]> explain select /*+ read_from_storage(tiflash[t]) */ count(*) from test.cluster t;
```

If the plan output contains `tiflash`, then the TiFlash cluster is normal.
