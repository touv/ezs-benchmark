#!/bin/bash

SIZE="${1:-10}"
ROUND="${2:-1}"
SCRIPT="${3:-en}"
INPUT="./input/data-${SIZE}.json"
OUTPUT=""
HOST="http://localhost:31976"
ENTRYPOINT="/${SCRIPT}"
NODE_VERSION=`node -v`
MAIN_STATEMENT="${4:-delegate}"
HORODATAGE=`date "+%F | %T"`

if [ ! -f "${INPUT}" ]; then
	echo "The file does not exists."
	exit 1
fi

EZS_MAIN_STATEMENT="${MAIN_STATEMENT}" ezs -d ./scripts/ &
SERVER_PID="$!"
sleep 2


echo -n -e "| ${HORODATAGE} | ${SIZE} \t| ${ROUND} \t| ${SCRIPT} \t| ${MAIN_STATEMENT} \t| ${NODE_VERSION}\t|"
TIMEFORMAT=$' %R \t| %U \t| %S \t|'
# --write-out "\nquery #{}:\t %{time_total} secs\n" \
time (seq 1 ${ROUND} | xargs -n1 -P4 -I{} curl --request "POST" \
	--url "${HOST}${ENTRYPOINT}" \
	--header "Content-Type: application/json"  \
	--silent \
	--data "@${INPUT}"  \
	--output "./output/out-${SIZE}-${SCRIPT}-{}.json";)

kill -s TERM ${SERVER_PID}
sleep 1

