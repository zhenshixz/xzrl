@echo off
title Warm Elder Calendar - Local Server Launcher

echo ==============================================================
echo          Starting [Warm Elder Calendar] Local Server...
echo ==============================================================
echo.

:: Detect the active local network IP address using primary gateway routing
set "LOCAL_IP=127.0.0.1"
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "try { Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex (Get-NetRoute -DestinationPrefix '0.0.0.0/0')[0].InterfaceIndex | Select-Object -ExpandProperty IPAddress } catch { '127.0.0.1' }"`) do set "LOCAL_IP=%%i"

echo.  * To view on this computer:
echo     Address: http://localhost:8080
echo.
echo.  * To view on mobile or tablet in the same Wi-Fi network:
echo     Address: http://%LOCAL_IP%:8080
echo.
echo.  * To stop the server, simply close this terminal window.
echo ==============================================================
echo.

python -m http.server 8080
if %errorlevel% neq 0 (
    echo.
    echo [WARNING] Python environment was not found.
    echo Attempting to open the webpage directly in your default browser...
    echo.
    start "" index.html
)
pause
