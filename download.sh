#!/bin/bash

# 获取latest release tag
NVMeFix_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/NVMeFix/tags | grep 'name' | cut -d\" -f4 | head -1 )
IntelMausi_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/IntelMausi/tags | grep 'name' | cut -d\" -f4 | head -1 )
VirtualSMC_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/VirtualSMC/tags | grep 'name' | cut -d\" -f4 | head -1 )
Lilu_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/Lilu/tags | grep 'name' | cut -d\" -f4 | head -1 )
WhateverGreen_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/WhateverGreen/tags | grep 'name' | cut -d\" -f4 | head -n 2 | tail -n 1 )
OpenCorePkg_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/OpenCorePkg/tags | grep 'name' | cut -d\" -f4 | head -1 )
AppleALC_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/AppleALC/tags | grep 'name' | cut -d\" -f4 | head -1 )
RestrictEvents_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/acidanthera/RestrictEvents/tags | grep 'name' | cut -d\" -f4 | head -1 )
Hackintool_TAG=$(wget --no-check-certificate -qO- https://api.github.com/repos/headkaze/Hackintool/tags | grep 'name' | cut -d\" -f4 | head -1 )
CCG_TAG=$(curl -s "https://mackie100projects.altervista.org/download-clover-configurator/" | grep -o 'Version: [0-9.]*' | cut -d' ' -f2 | head -n 1)
OCC_TAG=$(curl -s "https://mackie100projects.altervista.org/download-opencore-configurator/" | grep -o 'OpenCore Configurator [0-9.]*' | head -n 1 | sed 's/OpenCore Configurator //')

# 输出 release tag
cat > ./ReleaseTag << EOF
${OpenCorePkg_TAG}
OpenCorePkg=${OpenCorePkg_TAG}
AppleALC=${AppleALC_TAG}
IntelMausi=${IntelMausi_TAG}
Lilu=${Lilu_TAG}
VirtualSMC=${VirtualSMC_TAG}
WhateverGreen=${WhateverGreen_TAG}
NVMeFix=${NVMeFix_TAG}
RestrictEvents=${RestrictEvents_TAG}
EOF

# 下载最新release文件
wget -q https://github.com/acidanthera/NVMeFix/releases/download/${NVMeFix_TAG}/NVMeFix-${NVMeFix_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/IntelMausi/releases/download/${IntelMausi_TAG}/IntelMausi-${IntelMausi_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/VirtualSMC/releases/download/${VirtualSMC_TAG}/VirtualSMC-${VirtualSMC_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/Lilu/releases/download/${Lilu_TAG}/Lilu-${Lilu_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/WhateverGreen/releases/download/${WhateverGreen_TAG}/WhateverGreen-${WhateverGreen_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/OpenCorePkg/releases/download/${OpenCorePkg_TAG}/OpenCore-${OpenCorePkg_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/AppleALC/releases/download/${AppleALC_TAG}/AppleALC-${AppleALC_TAG}-RELEASE.zip
wget -q https://github.com/acidanthera/AppleALC/releases/download/${RestrictEvents_TAG}/RestrictEvents-${RestrictEvents_TAG}-RELEASE.zip

# 下载最新黑苹果工具
wget -q -O ${PWD}/OCC-${OCC_TAG}.zip https://mackie100projects.altervista.org/apps/opencoreconf/download-new-build.php?version=last
wget -q -O ${PWD}/CCG-${CCG_TAG}.zip https://mackie100projects.altervista.org/apps/cloverconf/download-new-build.php?version=global
wget -q https://github.com/headkaze/Hackintool/releases/download/${Hackintool_TAG}/Hackintool.zip

# 解压
unzip -q AppleALC-${AppleALC_TAG}-RELEASE.zip -d ./AppleALC
unzip -q IntelMausi-${IntelMausi_TAG}-RELEASE.zip -d ./IntelMausi
unzip -q Lilu-${Lilu_TAG}-RELEASE.zip -d ./Lilu
unzip -q NVMeFix-${NVMeFix_TAG}-RELEASE.zip -d ./NVMeFix
unzip -q OpenCore-${OpenCorePkg_TAG}-RELEASE.zip -d ./OpenCore
unzip -q VirtualSMC-${VirtualSMC_TAG}-RELEASE.zip -d ./VirtualSMC
unzip -q WhateverGreen-${WhateverGreen_TAG}-RELEASE.zip -d ./WhateverGreen
unzip -q WhateverGreen-${RestrictEvents_TAG}-RELEASE.zip -d ./RestrictEvents

# 下载 HfsPlus.efi 到 OC Drivers
wget -q -P ./OpenCore/X64/EFI/OC/Drivers/ https://raw.githubusercontent.com/acidanthera/OcBinaryData/master/Drivers/HfsPlus.efi
zip -q -r HfsPlus.zip ./OpenCore/X64/EFI/OC/Drivers/HfsPlus.efi


# 创建 Components 文件夹
mkdir -p ./Components/OC
# 复制 kext 文件到 Components 文件夹
cp -r ./AppleALC/AppleALC.kext ./Components/
cp -r ./IntelMausi/IntelMausi.kext ./Components/
cp -r ./Lilu/Lilu.kext ./Components/
cp -r ./NVMeFix/NVMeFix.kext ./Components/
cp -r ./WhateverGreen/WhateverGreen.kext ./Components/
cp -r ./RestrictEvents/RestrictEvents.kext ./Components/

# 复制 VirtualSMC kext 到 Components
cp -r ./VirtualSMC/Kexts/VirtualSMC.kext ./Components/
cp -r ./VirtualSMC/Kexts/SMCSuperIO.kext ./Components/
cp -r ./VirtualSMC/Kexts/SMCProcessor.kext ./Components/
# 复制 OpenCore 核心组件到 Components
cp -r ./OpenCore/X64/EFI/BOOT/BOOTx64.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/OpenCore.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/OpenRuntime.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/OpenCanopy.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/HfsPlus.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/ResetNvramEntry.efi ./Components/OC/
cp -r ./OpenCore/X64/EFI/OC/Drivers/ToggleSipEntry.efi ./Components/OC/
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
cp -r ./OpenCore/X64/EFI/OC/Drivers/OpenCanopy.efi ./EFI/OC/Drivers/
cp -r ./OpenCore/X64/EFI/OC/Drivers/ResetNvramEntry.efi ./EFI/OC/Drivers/
cp -r ./OpenCore/X64/EFI/OC/Drivers/ToggleSipEntry.efi ./EFI/OC/Drivers/

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
cp -r ./VirtualSMC/Kexts/RestrictEvents.kext ./EFI/OC/Kexts/

# 生成 README.md
cat > ./README.md << EOF
# Acidanthera && Hackintosh Tools

### Core EFI download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Core-EFI.zip

### Core Components download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Core-Components.zip

### All files download link
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
| RestrictEvents| ${RestrictEvents_TAG} |

### OpenCore Configurator download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/OCC.zip

### Clover Configurator download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/CCG.zip

### Hackintool download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Hackintool.zip

| Hackintosh Tools      | Version           |
| --------------------- | ----------------- |
| OpenCore Configurator | ${OCC_TAG}        | 
| Clover Configurator   | ${CCG_TAG}         |
| Hackintool            | ${Hackintool_TAG} |

EOF

# 生成 ReleaseNote.md
cat > ./ReleaseNote.md << EOF

### Core EFI download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Core-EFI.zip

### Core Components download link
https://github.com/SuperNG6/Acidanthera-Hackintosh-Tools/releases/download/${OpenCorePkg_TAG}/Core-Components.zip

| Components    | Version               |
| ------------- | --------------------- |
| OpenCorePkg   | ${OpenCorePkg_TAG}    | 
| AppleALC      | ${AppleALC_TAG}       |
| IntelMausi    | ${IntelMausi_TAG}     |
| Lilu          | ${Lilu_TAG}           |
| VirtualSMC    | ${VirtualSMC_TAG}     |
| WhateverGreen | ${WhateverGreen_TAG}  |
| NVMeFix       | ${NVMeFix_TAG}        |

| Hackintosh Tools      | Version           |
| --------------------- | ----------------- |
| OpenCore Configurator | ${OCC_TAG}        | 
| Clover Configurator   | ${CCG_TAG}         |
| Hackintool            | ${Hackintool_TAG} |

EOF
