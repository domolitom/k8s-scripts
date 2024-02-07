#!/bin/bash

#This script returns all the lines that contains "chart:" but not pointing to an oci registry. Currently we check if the oci protocol is specified explicitly ("oci://") or if we use the OCI_REPO env variable.
#Usage ./oci_chart_checks.sh  <yaml_file1> [<yaml_file2> ...]
if [ $# -eq 0 ]; then
    echo "Usage: $0 <yaml_file1> [<yaml_file2> ...]"
    exit 1
fi

for yaml_file in "$@"; do
    # Check if YAML file exists
    if [ ! -f "$yaml_file" ]; then
        echo "Error: YAML file '$yaml_file' not found."
        continue
    fi

    # Use grep to find lines containing "chart:" and then filter those lines with awk
    lines_without_oci=$(grep -n "chart:" "$yaml_file" | grep -viE 'oci://|OCI_REPO')
    if [ -n "$lines_without_oci" ]; then
    echo "Lines without oci in $yaml_file:"
        echo "$lines_without_oci"
    fi
done
