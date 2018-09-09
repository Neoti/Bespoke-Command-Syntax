#!/bin/bash
if /usr/bin/diff -q /opt/state.txt /opt/state1.txt ; then
    echo "Files are the same"
else
    echo "Files are differant"
fi
