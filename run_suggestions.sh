 #!/bin/bash 

########################################################################
#### Edit the following values ####
JMETER_BIN_PATH=~/jmeter/apache-jmeter-5.5/bin
TEST_PLAN=./test_plans/suggestions.jmx
THREAD_COUNT=2 # no.of concurrent users
HOLD_TIME=60 # run peak load for 5 min
CSV_INPUT_FILE=./cases/suggestions_input.csv
RESULTS_DIR=./results/SUGGESTIONS
## enable this to override the default behaviour
SAMPLES_PER_MIN=10
############# local ##################################################
# PROTOCOL=http
# BASE_URL=localhost
# PORT=3000
# ROUTE_PATH=/suggestions
# API_KEY=api_key
############# automation testing server ##################################################
PROTOCOL=http
BASE_URL=ec2-18-224-39-239.us-east-2.compute.amazonaws.com
PORT=3000
ROUTE_PATH=suggestions
API_KEY=dummy
########################################################################
echo "num_of_users: ${THREAD_COUNT}  HOLD_TIME: ${HOLD_TIME} SAMPLES_PER_MIN: ${SAMPLES_PER_MIN}"
echo "SAMPLES_PER_MIN: ${SAMPLES_PER_MIN}"
echo "Recreating results dir: ${RESULTS_DIR}"
rm -rf ${RESULTS_DIR} && mkdir -p ${RESULTS_DIR}
########################################################################
# #  DEV deployment
echo "Start: `date`"
${JMETER_BIN_PATH}/jmeter \
-JPROTOCOL=${PROTOCOL} \
-JBASE_URL=${BASE_URL} \
-JROUTE_PATH=${ROUTE_PATH} \
-JPORT=${PORT} \
-JAPI_KEY=${API_KEY} \
-JTHREAD_COUNT=${THREAD_COUNT} \
-JSAMPLES_PER_MIN=${SAMPLES_PER_MIN} \
-JHOLD_TIME=${HOLD_TIME} \
-JCSV_INPUT_FILE=${CSV_INPUT_FILE} \
-n -t ${TEST_PLAN} \
-l ${RESULTS_DIR}//aggregate_report.csv \
-e -o ${RESULTS_DIR}/
echo "End  : `date`"
###################################################################
