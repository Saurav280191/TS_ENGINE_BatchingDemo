@echo off

REM Build Clone and build TS_ENGINE
cd ..
echo Cloning TS_ENGINE...
git clone https://github.com/Saurav280191/TS_ENGINE.git
timeout /t 5 >nul
echo TS_ENGINE cloned complete.
cd TS_ENGINE
git pull
git checkout tags/v1.1
call GenerateVS22Project.bat

REM Build BatchingDemo
cd ..
cd TS_ENGINE_BatchingDemo
REM Generate Solution
cmake -G "Visual Studio 16 2019" -A=x64 -B=./build/x64/Debug -DCMAKE_ARCHITECTURE=x64 -DCMAKE_BUILD_TYPE=Debug
REM Build Binaries
cmake --build build/x64/Debug --config Debug

REM Post build commands
copy "..\TS_ENGINE\Dependencies\include\assimp\build\x64\bin\Debug\assimp-vc143-mtd.dll" "build\x64\Debug\bin"

xcopy "Assets" "build\x64\debug\Assets" /E /I /Y
xcopy "Assets" "build\x64\debug\bin\Assets" /E /I /Y

PAUSE