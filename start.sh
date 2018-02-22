#!/bin/bash

#poolproxy e stratum Rules:
screen -dmS prlp2 ~/open-pool-pirl/poolrpc ~/open-pool-pirl/prlPS.json

#api:
screen -dmS prlapi ~/open-pool-pirl/poolrpc ~/open-pool-pirl/prlapi.json

#unlocker:
screen -dmS prlunlocker ~/open-pool-pirl/poolrpc ~/open-pool-pirl/prlunlocker.json

#payout:
screen -dmS prlpayout ~/open-pool-pirl/poolrpc ~/open-pool-pirl/prlpayout.json

exit 0
