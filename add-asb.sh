#!/usr/bin/env bash

APB_NAME=${APB_NAME:-"automation-broker-apb"}
APB_IMAGE=${APB_IMAGE:-"docker.io/automationbroker/automation-broker-apb:latest"}
BROKER_NAME=${BROKER_NAME:-"ansible-service-broker"}
BROKER_NAMESPACE=${BROKER_NAMESPACE:-"ansible-service-broker"}
HELM=${HELM:-"false"}

#
# Logging in as system:admin so we can create a clusterrolebinding and
# creating ansible-service-broker project
#
echo 'Logging in as "system:admin" to create broker resources...'
oc login -u system:admin
oc new-project $BROKER_NAMESPACE

#
# Use the automation-broker-apb to deploy the broker
oc create serviceaccount $APB_NAME --namespace $BROKER_NAMESPACE
oc create clusterrolebinding $APB_NAME --clusterrole=cluster-admin --serviceaccount=$BROKER_NAMESPACE:$APB_NAME
oc run $APB_NAME \
    --namespace=$BROKER_NAMESPACE \
    --image=$APB_IMAGE \
    --restart=Never \
    --attach=true \
    --serviceaccount=$APB_NAME \
    -- provision -e broker_name=$BROKER_NAME -e broker_helm_enabled=$HELM
if [ "$?" -ne 0 ]; then
  echo "Error deploying broker"
  exit
fi
oc delete pod $APB_NAME --namespace $BROKER_NAMESPACE
oc delete serviceaccount $APB_NAME --namespace $BROKER_NAMESPACE
oc delete clusterrolebinding $APB_NAME

#
# Then login as 'developer'/'developer' to WebUI
# Create a project
# Deploy mediawiki to new project (use a password other than
#   admin since mediawiki forbids admin as password)
# Deploy PostgreSQL(ABP) to new project
# After they are up
# Click 'Create Binding' on the kebab menu for Mediawiki,
#   select postgres
# Click deploy on mediawiki, after it's redeployed access webui
#

echo 'NOTE: You are currently logged in as "system:admin", if you intend to use the apb tool, it is required you log in as a user with a token. "developer" is recommended.'
echo '    oc adm policy add-cluster-role-to-user cluster-admin developer'
echo '    oc login -u developer'
