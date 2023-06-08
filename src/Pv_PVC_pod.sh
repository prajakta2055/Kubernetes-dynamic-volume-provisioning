#!/bin/bash

# Define variables
PVC_NAME="proj-pvc"
PV_NAME="proj-pv"
STORAGE_CLASS="manual"
STORAGE_SIZE="32Gi"
POD_NAME="pod-proj"

# Create persistent volume
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $PV_NAME
spec:
  storageClassName: $STORAGE_CLASS
  capacity:
    storage: $STORAGE_SIZE
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
EOF

# Create persistent volume claim
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $PVC_NAME
spec:
  storageClassName: $STORAGE_CLASS
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: $STORAGE_SIZE
EOF

# Create pod
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: $POD_NAME
spec:
  volumes:
    - name: $PV_NAME
      persistentVolumeClaim:
        claimName: $PVC_NAME
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: $PV_NAME
EOF
