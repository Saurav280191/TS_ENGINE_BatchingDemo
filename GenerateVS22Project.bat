@echo off
 
echo Cloning TS_ENGINE...
git clone https://github.com/Saurav280191/TS_ENGINE.git
echo TS_ENGINE cloned complete.
timeout /t 5 >nul
PAUSE

::if not exist "TS_ENGINE"(
::echo TS_ENGINE was not cloned properly
::PAUSE
::exit 
::)


cd TS_ENGINE

REM Pulling latest TS_ENGINE source
git pull origin main
echo Pulled latest TS_ENGINE

REM Installing vcpkg
call Install-vcpkg.bat
REM Completed vcpkg installation

REM Installing assimp
cd vcpkg
vcpkg install assimp:x64-windows --recurse
::vcpkg install spdlog:x64-windows --recurse
echo Installed assimp, imgui, and spdlog. 

cd ..
cd ..
echo To generate project,
PAUSE

REM Generate Solution
cmake -G "Visual Studio 17 2022" -A=x64 -B=./build/x64/Debug -DCMAKE_ARCHITECTURE=x64 -DCMAKE_BUILD_TYPE=Debug
REM Build Binaries
cmake --build build/x64/Debug --config Debug

copy "TS_ENGINE\vcpkg\installed\x64-windows\debug\bin\assimp-vc143-mtd.dll" "build\x64\Debug\bin"
copy "TS_ENGINE\vcpkg\installed\x64-windows\debug\bin\pugixml.dll" "build\x64\Debug\bin"
copy "TS_ENGINE\vcpkg\installed\x64-windows\debug\bin\zlibd1.dll" "build\x64\Debug\bin"

xcopy "Assets" "build\x64\debug\Assets" /E /I /Y
xcopy "Assets" "build\x64\debug\bin\Assets" /E /I /Y

PAUSE



