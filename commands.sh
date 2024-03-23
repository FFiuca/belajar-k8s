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


