#!/bin/bash

# RUNUSER_USERNAME
if [ ! -n "${RUNUSER_USERNAME-}" ] ; then
  echo "RUNUSER_USERNAME is not set or empty"
  exit 1
fi
# RUNUSER_UID
if [ ! -n "${RUNUSER_UID-}" ] ; then
  echo "RUNUSER_UID is not set or empty"
  exit 1
fi
# RUNUSER_GID
if [ ! -n "${RUNUSER_GID-}" ] ; then
  echo "RUNUSER_GID is not set or empty"
  exit 1
fi
# RUNUSER_HOME
if [ ! -n "${RUNUSER_HOME-}" ] ; then
  echo "RUNUSER_HOME is not set or empty"
  exit 1
fi


groupmod --gid 2002 tool
usermod --uid 2002 --gid 2002 --login tool tool

#su - $RUNUSER_USERNAME -c "cd ${RUNUSER_HOME};export HOME=${RUNUSER_HOME};$*"
su - tool -c "$*"

