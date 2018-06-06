# ss-gluster-apb

## Setup
- See the example myhost.example file for inventory
- Set Up Multinode openshift cluster on AWS
- Use the install instructions from __[stateful-gluster](https://github.com/screeley44/stateful-gluster/tree/master/projects/gluster-statefulset-cloud-aws/examples/kicking-the-tires)__

## Ways to run
- Make sure the service catalog and ansible service broker running
- Add ansible-service-broker using the script add-asb.sh
- See the attached notes (setup-notes.txt) on how to push your apb to the catalog
   
## Running Manually
docker run --rm --net=host \
-v $HOME/.kube:/opt/apb/.kube:z \
-u $UID \
docker.io/zherman/ss-gluster-apb \
provision --extra-vars 'namespace=glusterfs'

## Taking it down
docker run --rm --net=host \
-v $HOME/.kube:/opt/apb/.kube:z \
-u $UID \
docker.io/zherman/ss-gluster-apb \
deprovision --extra-vars 'namespace=glusterfs'
