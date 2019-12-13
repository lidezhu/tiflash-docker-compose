# TiFlash cluster Docker Compose

1. Put the following binaries into `bin/` directory

* libtiflash_proxy.so
* tiflash
* flash_cluster_manager

2. Build tiflash image

``` shell
docker build -t hub.pingcap.net/tiflash/tiflash:{your-tag} .
docker push hub.pingcap.net/tiflash/tiflash:{your-tag}
```

# TiFlash k8s cluster
1. use `tidb-operator` to deploy tidb cluster

2. kubectl apply -f tiflash.yaml -n tiflash-test

3. kubectl port-forward -n tiflash-test svc/tiflash-test-cluster-tidb 4000:4000 &  
   
4. mysql -h 127.0.0.1 -P 4000 -u root -D test

# chaos test
1. kubectl create namespace tiflash-chaos-testing

2. kubectl apply -f tikv-failure.yaml -n tiflash-chaos-testing

3. kubectl apply -f tiflash-failure.yaml -n tiflash-chaos-testing

notes:
1. check pd,tikv,tidb version
2. remember to modify pd and tikv config
