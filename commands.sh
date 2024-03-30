## PODS
# the smallest unit of kubernetes. includes proxy, cluster and ... inside.
# contains containers and manage them.
# nginx:stable-alpine3.17-slim


kubectl create -f ./pod/pod.yaml
kubectl get pod -o wide # using namespace 'default' in basically
kubectl describe pod namePod

kubectl port-forward namePod portHost:portPod

## LABEL
# can apply in many kubernetes features
kubectl create -f ./label/label.yaml
kubectl get pod --show-labels
kubectl label pod nginx-label env=prod # to add when pod already created
kubectl get pod -l key
kubectl get pod -l key=val,key2=val2 # operand &
# OPTIONS
# key
# key=value
# '!key'
# key!=value1
# 'key in (val1,val2)'
# 'key not in (val1, val2)'
###
kubectl delete pod podName1 podName2
kubectl delete pod -l key=value

## ANNOTATION
# can achieve information till 256kB
# white space allowed
kubectl create -f annotaion/annotation.yaml
kubectl describe pod nginx-annotaion
kubectl annotate pod namaPod key=value --overwrite

## Namespace
# categorizing
# same pod can create twice or more when in different namespace
kubectl get ns
kubectl get pods -n kube-system
#create namespace rsc first
kubectl create -f .\namespace\namespace.yaml
#when create pod/resources
kubectl create -f .\namespace\finance-namespace.yaml -n finance
kubectl delete ns namespaceName # when delete namespace, all resources regarding namespace will be delete
#deleting all resource ragarding namespace except namespace itself
kubectl delete pod --all -n finance

## Probe
# check healtness pod
# liveness, readness, startup
kubectl create -f .\probe\probe.yaml

## ReplicationController
kubectl get rc
kubectl create -f .\replication-controller\rc.yaml
kubectl describe rc nginx-rc
kubectl delete rc nginx-rc --cascade=false # option cascade will only delete rc, not include related pods

## ReplicaSet
# same with RC, have adjustment in selector
kubectl create -f .\replica-set\rs-expression.yaml
kubectl get rs
kubectl describe rs nginx-rs-expression

## DaemonSet
# not sure what it is.  It ensures that a copy of a pod runs on either all or some specified nodes within the cluster. This makes DaemonSet ideal for tasks like monitoring, logging, or running a network proxy on every node
# Jika kita ingin menjalankan Pod di setiap Node yang ada di Kubernetes, dan tiap Pod hanya boleh jalan 1 di Node, kita bisa menggunakan Daemon Set
# auto create when pod deleted
kubectl get ds
kubectl describe ds daemon-set
kubectl delete ds daemon-set

## Jobs
# it only run one time and after finish will be stop.
kubectl create -f .\job\job.yaml
kubectl get job
kubectl describe job jobName
kubectl delete job jobName

## CronJob
# will be create job at configured schedule
kubectl get cronjob
kubectl create -f .\cron-job\cron-job.yaml

## Log
kubectl log podName

## NodeSelector
# to specify where node to create pod based on label
# every source can be use nodeselector
kubectl get node --show-labels
# test case only create in node which have label gpu=true
kubectl label node docker-desktop gpu=true


## ALL
kubectl get all -n namespace
kubectl delete all -n namespace

## Service
# like gateway in docker. connect between network and pod
kubectl create -f .\service\service.yaml
kubectl create -f .\service\rs-service.yaml
kubectl create -f .\service\accessor-service.yaml
kubectl exec -it nginx-accessor-service /bin/sh
curl http://10.97.181.186:8080
# Access via dns : nama-service.nama-ns.svc.cluster.local:port
curl http://nginx-service.default.svc.cluster.local:8080
env | grep NGINX_SERVICE # cek env
kubectl get endpoints # cek endpoint service

## External service
# is gate to access ip/domain in external kubernetes environment
kubectl create -f .\external-service\domain.yaml
kubectl exec nginx-accessor-service -it /bin/sh
curl http://example-service.default.svc.cluster.local # it should access example.com via curl. but no result get, need check again next


## Expose Service
kubectl create -f .\expose-service\node-port\node-port.yaml
curl http://localhost:30001

# LoadBalancer
# only can run in cloud

# Ingress
# simplify expose multiple service using url domain
# actually avaible to test in local. but error when install ingress add-on
# the concept is ingress will map all services by url and ingress will forward request to related service. Service will handle which node and pod will be receive.
# need setting domain to hit ingress domain.

## VOLUME
kubectl create -f .\volume\rs-volume.yaml
kubectl exec -it rs-volume-8gbf7 /bin/sh
cat app/html/index.html

## SharingVolume
kubectl create -f .\volume\rs-sharing-volume.yaml
localhost:30003
