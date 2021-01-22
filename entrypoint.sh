#!/bin/bash
set -e

# update $USER_ID at runtime
usermod -u $USER_ID $USER_NAME
# if the binded volumes do not exist on the host
# they will be created at runtime with root
# therefore we need to change ownership at runtime
chown -R $USER_NAME:$USER_NAME $APP_DATA_DIR $APP_CONFIG_DIR $APP_ETC_DIR

exec gosu $USER_NAME "$@"
