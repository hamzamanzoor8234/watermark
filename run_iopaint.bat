@echo off
echo Starting IOPaint Docker Container...
docker compose up --build -d

echo Waiting for IOPaint server to start...
timeout /t 5 /nobreak > nul

echo Opening browser to http://localhost:8085...
start http://localhost:8085

echo.
echo IOPaint is running in the background!
echo Press any key to stop the container and exit.
echo.
pause

echo Stopping IOPaint container...
docker compose down
