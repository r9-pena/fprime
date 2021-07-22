#!/bin/bash
####
# Ref.bash:
#
# Run the tests on the software through fp-util.
####
export SCRIPT_DIR="$(dirname ${BASH_SOURCE})/.."
. "${SCRIPT_DIR}/helpers.bash"

. ${SCRIPT_DIR}/tests/fputil.bash

export CMAKE_EXTRA_SETTINGS=""
# For Ref deployment to disable FRAMEWORK UTS
export CMAKE_EXTRA_SETTINGS="${CMAKE_EXTRA_SETTINGS} -DFPRIME_ENABLE_FRAMEWORK_UTS=OFF"
 
echo -e "${BLUE}Testing ${FPUTIL_DEPLOYS} against fprime-util targets: ${FPUTIL_TARGETS[@]}${NOCOLOR}"
export CHECK_TARGET_PLATFORM="native"
for target in "${FPUTIL_TARGETS[@]}"
do
    START="$(date +%s)"
    if [[ "${target}" == "generate" ]]
    then
        rm -rf "${FPUTIL_DEPLOYS}/build-fprime-automatic-"*
    fi
    fputil_action "${FPUTIL_DEPLOYS}" "${target}"
    END="$(date +%s)"
    echo "$[${END} - ${START}]"
done

echo -e "${BLUE}Testing ${INT_DEPLOYS} against integration tests${NOCOLOR}"
integration_test "${INT_DEPLOYS}"