#!/bin/bash

MLFLAGS="-nodisplay -nodesktop -nosplash"

# Get the directory of the current script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$script_dir/env_config.sh"

if [ -z "$MLRELEASE" ]
then
	MLRELEASE=$req_matlab_v
fi
if [ -z "$DEMO" ]
then
	DEMO=""
fi
echo "Testing demo: $DEMO"

MLPATH=$matlab_path_linux

cd ../..
source "$vivado_settings_path"
Xvfb :77 &
export DISPLAY=:77
export SWT_GTK3=0
source "$vivado_settings_path"
$MLPATH/$MLRELEASE/bin/matlab $MLFLAGS -r "addpath(genpath('test'));addpath(genpath('deps'));runDemoTests('$DEMO');"
kill -9 `pidof Xvfb`
