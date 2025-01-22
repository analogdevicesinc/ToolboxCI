#!/bin/bash

# Get the directory of the current script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$script_dir/env_config.sh"

BOARD=$1
MLFLAGS="-nodisplay -nodesktop -nosplash"
if [ -z "$MLRELEASE" ]
then
	MLRELEASE=$req_matlab_v
fi

MLPATH=$matlab_path_linux

cd ../..
cp hdl/vendor/AnalogDevices/hdlcoder_board_customization.m test/hdlcoder_board_customization_local.m
sed -i "s/hdlcoder_board_customization/hdlcoder_board_customization_local/g" test/hdlcoder_board_customization_local.m
source "$vivado_settings_path"
Xvfb :77 &
export DISPLAY=:77
export SWT_GTK3=0
source "$vivado_settings_path"
$MLPATH/$MLRELEASE/bin/matlab $MLFLAGS -r "addpath(genpath(pwd));cd('test');runSynthTests('$BOARD');"
pidof Xvfb
if [ $? -eq 0 ]; then
    kill -9 `pidof Xvfb`
fi
