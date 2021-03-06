#!/usr/bin/env bash

# set cloudformation command parameters 
stack_name=$1
template=$2
parameters=$3
capabilities=CAPABILITY_NAMED_IAM
region=us-west-2


##### validate the parameters
if [ -z $stack_name ] || [ -z $template ] || [ -z $parameters ]
then
    echo 'Error - Invalid parameters'
    echo
    echo 'Usage - update-stack <stack-name> <template file> <param file>'
    exit 1
fi


##### validate the template and parameters
aws cloudformation validate-template --template-body file://$template > /dev/null 2>&1

if [ $? -gt 0 ]
then
    # show the error (which means running the validate again)
    aws cloudformation validate-template --template-body file://$template
    exit 1
else
    echo
    echo "Template $template is valid"
fi


##### check if stack exists
aws cloudformation describe-stacks --stack-name $stack_name > /dev/null 2>&1
response=$?
if [ $response -eq 255 ]
then
    echo
    echo 'Creating stack...'
    cfn_cmd='create-stack'
elif [ $response -eq 0 ]
then
    echo
    echo 'Updating stack...'
    cfn_cmd='update-stack'
else
    echo 'Unknown error!'
    exit 1
fi


##### execute aws cloudformation command
aws cloudformation $cfn_cmd \
--stack-name $stack_name \
--template-body file://$template \
--parameters file://$parameters \
--region=$region \
--capabilities=$capabilities

if [ $? -eq 0 ]
then
    echo 'Succesful'
fi
echo
echo 'Done.'
echo
