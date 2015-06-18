#!/bin/bash

function enable() {

}

function disable() {

}

# See how we were called.
case "$1" in
  blue)
    enable "blue"
	 disable "green"
    ;;
  both)
    enable "blue"
	 enable "green"
    ;;
  green)
    disable "blue"
	 enable "green"
    ;;
  *)
    echo "Usage: $0 {blue|green|both}"
	 exit 1
esac

if [ "blue" = "$1" ]; then BLUE_ST=enable; GREEN_ST=disable; 
elif [ "green" = "$1" ]; then  BLUE_ST=disable; GREEN_ST=enable;
else BLUE_ST=enable; GREEN_ST=enable;
fi

echo ">> SWITCHING TO THE SERVER $1"
echo "blue: $(curl -sS -X POST http://localhost:8000/health/$BLUE_ST)"
echo "green: $(curl -sS -X POST http://localhost:9000/health/$GREEN_ST)"
# Print status
echo "blue: $(curl -sSi -X HEAD http://localhost:8000/health | grep HTTP)"
echo "green: $(curl -sSi -X HEAD http://localhost:9000/health | grep HTTP)"
