# ss-gluster-apb


Set Up Multinode openshift cluster on AWS


##Running Manually
docker run --rm --net=host \
-v $HOME/.kube:/opt/apb/.kube:z \
-u $UID \
docker.io/zherman/ss-gluster-apb \
provision --extra-vars 'namespace=default'

##Taking it down
docker run --rm --net=host \
-v $HOME/.kube:/opt/apb/.kube:z \
-u $UID \
docker.io/zherman/ss-gluster-apb \
deprovision --extra-vars 'namespace=default'
