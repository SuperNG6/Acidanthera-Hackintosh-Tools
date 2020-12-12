#!/bin/bash

# 获取latest release tag
NVMeFix_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/NVMeFix/tags | grep 'name' | cut -d\" -f4 | head -1 )
IntelMausi_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/IntelMausi/tags | grep 'name' | cut -d\" -f4 | head -1 )
VirtualSMC_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/VirtualSMC/tags | grep 'name' | cut -d\" -f4 | head -1 )
Lilu_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/Lilu/tags | grep 'name' | cut -d\" -f4 | head -1 )
WhateverGreen_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/WhateverGreen/tags | grep 'name' | cut -d\" -f4 | head -1 )
OpenCorePkg_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/OpenCorePkg/tags | grep 'name' | cut -d\" -f4 | head -1 )
AppleALC_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/AppleALC/tags | grep 'name' | cut -d\" -f4 | head -1 )

# 下载最新release文件
wget -q https://github.com/acidanthera/NVMeFix/releases/download/${NVMeFix_TAG}/NVMeFix-${NVMeFix_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/IntelMausi/releases/download/${IntelMausi_TAG}/IntelMausi-${IntelMausi_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/VirtualSMC/releases/download/${VirtualSMC_TAG}/VirtualSMC-${VirtualSMC_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/Lilu/releases/download/${Lilu_TAG}/Lilu-${Lilu_TAG}-RELEASE.zip
# wget -q https://github.com/acidanthera/WhateverGreen/releases/download/${WhateverGreen_TAG}/WhateverGreen_${WhateverGreen-TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/WhateverGreen/releases/download/1.4.5/WhateverGreen-1.4.5-RELEASE.zip
wget -q https://github.com/acidanthera/OpenCorePkg/releases/download/${OpenCorePkg_TAG}/OpenCore-${OpenCorePkg_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/AppleALC/releases/download/${AppleALC_TAG}/AppleALC-${AppleALC_TAG}-RELEASE.zip

# 解压
unzip -q AppleALC-${AppleALC_TAG}-RELEASE.zip -d ./AppleALC
unzip -q IntelMausi-${IntelMausi_TAG}-RELEASE.zip -d ./IntelMausi
unzip -q Lilu-${Lilu_TAG}-RELEASE.zip -d ./Lilu
unzip -q NVMeFix-${NVMeFix_TAG}-RELEASE.zip -d ./NVMeFix
unzip -q OpenCore-${OpenCorePkg_TAG}-RELEASE.zip -d ./OpenCore
unzip -q VirtualSMC-${VirtualSMC_TAG}-RELEASE.zip -d ./VirtualSMC
# unzip -q WhateverGreen-${WhateverGreen_TAG}-RELEASE.zip -d ./WhateverGreen
unzip -q WhateverGreen-1.4.5-RELEASE.zip -d ./WhateverGreen
# 下载HfsPlus.efi到OC Drivers
wget -q -P ./OpenCore/X64/EFI/OC/Drivers/ https://github.com/acidanthera/OcBinaryData/blob/master/Drivers/HfsPlus.efi

# 创建 Components 文件夹
mkdir ./Components
# 复制关键文件到 Components 文件夹
cp -r ./AppleALC/AppleALC.kext ./Components/kext/AppleALC.kext
cp -r ./IntelMausi/IntelMausi.kext ./Components/kext/
cp -r ./Lilu/Lilu.kext ./Components/kext/
cp -r ./NVMeFix/NVMeFix.kext ./Components/kext/
# cp -r ./WhateverGreen/WhateverGreen.kext ./Components/kext/
cp -r ./WhateverGreen/WhateverGreen.kext ./Components/kext/

# 复制 VirtualSMC kext 到 Components
cp -r ./VirtualSMC/Kexts/VirtualSMC.kext ./Components/kext/
cp -r ./VirtualSMC/Kexts/SMCSuperIO.kext ./Components/kext/
cp -r ./VirtualSMC/Kexts/SMCProcessor.kext ./Components/kext/
# 复制 OpenCore 核心组件到 Components
cp -r ./OpenCore/X64/EFI/BOOT/BOOTx64.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/OpenCore.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/OpenRuntime.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/HfsPlus.efi ./Components/OC/
# 复制 VirtualSMC 和 OpenCore 文件夹到 Components
cp -r ./VirtualSMC ./Components/
cp -r ./OpenCore ./Components/
# 复制VirtualSMC和OpenCore文件夹到Components
cp -r ./VirtualSMC ./Components/
cp -r ./OpenCore ./Components/


# 创建 OpenCore 模板
cp -r ./OpenCore/X64/EFI ./EFI
# 删除非必要文件
rm -rf ./EFI/OC/Bootstrap
rm -rf ./EFI/OC/Tools/*
rm -rf ./EFI/OC/Drivers/*

# 复制 OC Drivers
cp -r ./OpenCore/X64/EFI/OC/Drivers/OpenRuntime.efi ./EFI/OC/Drivers/
cp -r ./OpenCore/X64/EFI/OC/Drivers/HfsPlus.efi ./EFI/OC/Drivers/

# 复制 VirtualSMC Kexts
cp -r ./VirtualSMC/Kexts/VirtualSMC.kext ./EFI/OC/Kexts/
cp -r ./VirtualSMC/Kexts/SMCSuperIO.kext ./EFI/OC/Kexts/
cp -r ./VirtualSMC/Kexts/SMCProcessor.kext ./EFI/OC/Kexts/

# 复制 Kexts
cp -r ./AppleALC/AppleALC.kext ./EFI/OC/Kexts/
cp -r ./IntelMausi/IntelMausi.kext ./EFI/OC/Kexts/
cp -r ./Lilu/Lilu.kext ./EFI/OC/Kexts/
cp -r ./WhateverGreen/WhateverGreen.kext ./EFI/OC/Kexts/
cp -r ./NVMeFix/NVMeFix.kext ./EFI/OC/Kexts/
cp -r ./VirtualSMC/Kexts/SMCProcessor.kext ./EFI/OC/Kexts/

# 生成 README.md
cat > ./README.md << EOF
# Acidanthera Hackintosh Tools

## All Components download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Components.zip

## All files download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/all-files.zip


| Components    | Version               |
| ------------- | --------------------- |
| OpenCorePkg   | ${OpenCorePkg_TAG}    | 
| AppleALC      | ${AppleALC_TAG}       |
| IntelMausi    | ${IntelMausi_TAG}     |
| Lilu          | ${Lilu_TAG}           |
| VirtualSMC    | ${VirtualSMC_TAG}     |
| WhateverGreen | ${WhateverGreen_TAG}  |
| NVMeFix       | ${NVMeFix_TAG}        |

EOF