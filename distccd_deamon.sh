#!/bin/bash

PARAM="--daemon -p 56789 \
       --user hf10 \
      "

if [[ $1 = "-v" ]]; then
	PARAM+="--verbose "
else
	PARAM+="--log-level error "
fi
PARAM+="--log-file $PWD/log "

CLIENT="10.125.4.66 "
ALLOW="--allow $CLIENT "
PARAM+=$ALLOW

echo $PARAM
~/bin/distcc/bin/distccd $PARAM

