@echo off

REM Fetching TS_ENGINE
set TS_ENGINE_PATH=TS_ENGINE
set TS_ENGINE_URL=https://github.com/Saurav280191/TS_ENGINE.git

:: Check if the submodule is already added
git submodule status %TS_ENGINE_PATH%

if %errorlevel% neq 0 (
  echo Submodule already exists
) else (
  :: Add the submodule
  git submodule add %TS_ENGINE_URL% %TS_ENGINE_PATH%
)

:: Initialize the submodule
git submodule update --init --recursive %TS_ENGINE_PATH%

echo Added and initialized TS_ENGINE

cd TS_ENGINE

::Pull latest TS_ENGINE source
git pull origin main
echo Pulled latest TS_ENGINE

REM Installing vcpkg
call Install-vcpkg.bat
REM Completed vcpkg installation

REM Installing assimp and spdlog
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

xcopy "Assets" "build\x64\debug\Assets" /E /I /Y
xcopy "Assets" "build\x64\debug\bin\Assets" /E /I /Y

PAUSE



