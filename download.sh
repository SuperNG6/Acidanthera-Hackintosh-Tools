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

# 创建Components文件夹
mkdir ./Components
# 复制关键文件到Components文件夹
cp -r ./AppleALC/AppleALC.kext ./Components/
cp -r ./IntelMausi/IntelMausi.kext ./Components/
cp -r ./Lilu/Lilu.kext ./Components/
cp -r ./NVMeFix/NVMeFix.kext ./Components/
# cp -r ./WhateverGreen/WhateverGreen.kext ./Components/
cp -r ./WhateverGreen/WhateverGreen.kext ./Components/
cp -r ./VirtualSMC ./Components/
cp -r ./OpenCore ./Components/

cat > ./README.md << EOF
# Acidanthera Hackintosh Tools

**AppleALC-${AppleALC_TAG}-RELEASE**  
**IntelMausi-${IntelMausi_TAG}-RELEASE**  
**Lilu-${Lilu_TAG}-RELEASE**  
**NVMeFix-${NVMeFix_TAG}-RELEASE**  
**OpenCore-${OpenCorePkg_TAG}-RELEASE**  
**VirtualSMC-${VirtualSMC_TAG}-RELEASE**  
**WhateverGreen-1.4.5-RELEASE**  

EOF