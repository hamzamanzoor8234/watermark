#!/bin/bash
echo "Starting IOPaint Docker Container..."
docker compose up --build -d

echo "Waiting for IOPaint server to start..."
sleep 5

echo "Opening browser to http://localhost:8085..."
if [ "$(uname)" == "Darwin" ]; then
    open http://localhost:8085
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    xdg-open http://localhost:8085
fi

echo ""
echo "IOPaint is running in the background!"
echo "To stop the container, run:"
echo "docker compose down"
