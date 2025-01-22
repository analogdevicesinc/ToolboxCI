#!/bin/bash

# Set the required MATLAB version
export req_matlab_v="R2023b"

# Set the required VIVADO version
export req_vivado_v="2023.2"

# Define the full path to settings64.sh, using the Vivado version
export vivado_settings_path="/opt/Xilinx/Vivado/$req_vivado_v/settings64.sh"

# MATLAB installation paths for different operating systems
export matlab_path_linux="/usr/local/MATLAB"
export matlab_path_windows="/cygdrive/c/Program Files/MATLAB"
