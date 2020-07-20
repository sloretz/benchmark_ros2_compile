#!/bin/bash

time eval "$@"
status=$?

if [ $status -ne 0 ]; then
  echo "==========================================="
  echo "Unexpected build failure; output is invalid"
  echo "==========================================="
fi

exit $status
