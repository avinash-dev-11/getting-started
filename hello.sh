#!/bin/bash  
echo "This is a shell script"
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud auth application-default login --no-launch-browser
echo "Authentication Successfull"