#!/bin/bash
set -Eeu -o pipefail

# == EDIT THESE VALUES ==
parent_dir=path/to/SIEGE/
julia=path/to/julia
project_folder_name=project_folder_name
# =======================

unset JULIA_LOAD_PATH
unset LD_LIBRARY_PATH
export JULIA_PROJECT="${parent_dir}/${project_folder_name}"
export JULIA_DEPOT_PATH=":${parent_dir}/build/depot"
export JULIA_PKG_OFFLINE=true

${julia} -J${parent_dir}/build/sysimage.so "$@"
