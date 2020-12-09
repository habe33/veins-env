#!/bin/bash

# Sets script to fail if any command fails.
set -e

# Add useful commands
print_usage() {
    echo 
    "
    Usage:	$0 COMMAND
    Options:
    help		Print help
    omnet		Run OMNeT++ IDE

    "
}

case "$1" in
    help)
        print_usage
        ;;
    omnet)
	omnetpp
        ;;
    *)
        exec "$@"
esac
