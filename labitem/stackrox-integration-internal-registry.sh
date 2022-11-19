export NSINTEGRATION="integration-internal-registry"

oc new-project $NSINTEGRATION

SECRET_TOKEN_NAME=$(oc get sa -n $NSINTEGRATION default -o jsonpath='{.secrets[*]}' | jq -r .name | grep token)

PIPELINE_TOKEN=$(oc get secret -n $NSINTEGRATION $SECRET_TOKEN_NAME -o jsonpath='{.data.token}' | base64 -d)
echo $PIPELINE_TOKEN

oc policy add-role-to-user admin system:serviceaccount:$NSINTEGRATION:pipeline -n $NSINTEGRATION