#!/bin/bash

colcon build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=ON --no-warn-unused-cli -DINSTALL_EXAMPLES=OFF -DSECURITY=ON 
