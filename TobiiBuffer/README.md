setup:
clone https://github.com/Microsoft/vcpkg
git clone https://github.com/Microsoft/vcpkg.git

cd vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg integrate install

for Tobii SDK, you need to manually put the right files in the right place of the vcpkg directory:
Tobii_C_SDK\64\lib\tobii_research.dll -> vcpkg\installed\x64-windows\bin
Tobii_C_SDK\64\lib\tobii_research.dll -> vcpkg\installed\x64-windows\debug\bin
Tobii_C_SDK\64\lib\tobii_research.lib -> vcpkg\installed\x64-windows\lib
Tobii_C_SDK\64\lib\tobii_research.lib -> vcpkg\installed\x64-windows\debug\lib
Tobii_C_SDK\64\include\*              -> vcpkg\installed\x64-windows\include

Tobii_C_SDK\32\lib\tobii_research.dll -> vcpkg\installed\x86-windows\bin
Tobii_C_SDK\32\lib\tobii_research.dll -> vcpkg\installed\x86-windows\debug\bin
Tobii_C_SDK\32\lib\tobii_research.lib -> vcpkg\installed\x86-windows\lib
Tobii_C_SDK\32\lib\tobii_research.lib -> vcpkg\installed\x86-windows\debug\lib
Tobii_C_SDK\32\include\*              -> vcpkg\installed\x86-windows\include

if you wish to compile the websocket server, further run:
vcpkg install uwebsockets uwebsockets:x64-windows nlohmann-json nlohmann-json:x64-windows