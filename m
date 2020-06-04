Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B459DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF28207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgFDU4o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:56:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFDU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:56:44 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N5W0q-1isybk2rc2-0170N7 for <linux-kernel@vger.kernel.org>; Thu, 04 Jun
 2020 22:56:31 +0200
Received: by mail-qv1-f52.google.com with SMTP id f89so3671038qva.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:56:30 -0700 (PDT)
X-Gm-Message-State: AOAM532/RkeTc2jGJVxvnnqiSvb4quMsjrMPCbuGDBZGJxTt54EJjgz4
        A4N3rQ5mRSyMtxjNq6+G2vVI/AF1vFSAMycQpZ0=
X-Google-Smtp-Source: ABdhPJwR3pr0sPlxLzQ36KdQDqPXgqRxZssChY1wnsAz9xOoYvJyy/jF7rfKyUHjNcGFruuY2ox1nYv0OyQqHCorU/s=
X-Received: by 2002:a0c:c1c3:: with SMTP id v3mr6691746qvh.222.1591304189044;
 Thu, 04 Jun 2020 13:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
 <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com>
 <CAK8P3a3w4euZfDQPt7wqWg9w4uf7SM4NLeA2CyOMmgNGPAdQaQ@mail.gmail.com> <CAK8P3a2fCyYgoexi6NiAY2cch5C-7EEkNGy6PJGxjJ-2yMndLA@mail.gmail.com>
In-Reply-To: <CAK8P3a2fCyYgoexi6NiAY2cch5C-7EEkNGy6PJGxjJ-2yMndLA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jun 2020 22:56:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WM_iT+zPZjDeoih-qZwSJbjZfVMvqpG3Sa1aDqgHwPA@mail.gmail.com>
Message-ID: <CAK8P3a2WM_iT+zPZjDeoih-qZwSJbjZfVMvqpG3Sa1aDqgHwPA@mail.gmail.com>
Subject: [GIT PULL 4/4] ARM: DT changes for v5.8
List-Id: <soc.lore.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Sdb4cgES8+jG3bbTxBSNJNHDgWN/3EHQo8phAkEdVeMTHjQzcd6
 A9GT0MnKGJE7VUeh+Ss5GhU9vKRm+QU3qwZ3dRqU8xplgnN101qfLF8ePCgdpyqCzV7BED3
 bo7K+IufAYz3h9ZVaU+/6oTAdzzZSLwc1zi0dWyLknkVdPGvHJ3ZaYEqkdIwQdlYFi0OAhv
 8rhFfUo+zG36jvucBAfPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQQpTSuEeHs=:OfznxH6I2Hjpe5JaKCNkrs
 n+N54pyni6EOitj4K/bcM93CsP8iKtzx+TOjqAe7TLn7quM4ccPfXHpbksT8jbKkOaTfraSxR
 uQZiiRAhNNlh+thJQ21jyEYTBaq/Ke7b1bz13INad+73dKmuCGpC6bgohc5I8M2vkXFEIuPwU
 qytS3EA/bAe5pFwntdhcx1a/oScJMshFKWARhrnkoKZGk1Gq1znPeQm5Of6vJb662QWvY8g/a
 p/0vEQSy4bD3tLP9rRE8N4/BFRZPlTbOyiEZMt431ZwkU2lIxkzluBy5+FFaBaio8V5V1Z2bs
 SkOVtlS5lRPf1IOKjKZ/0NHB0LUbY8ux0iCGGpAxwFvZMVj/dkMzz3C3g6396kXaKvNVG/wXE
 NbshltKIb3FVNGR4SV1GLndlxizbQ6fuHLG5+KG9KQvCljAtaIfTUD0H5YSMPOM8gVg9+Wuv/
 KLt+MO4iZIaoxaFXX82NyGBpNXB7M9TuXfpzXeQABEjnGDRawx5cfa8DD0UA95fJtje/Yl0PN
 dS/oZvrFdsfitzMCA8wflzXaq9Gw7PUAEq4kKbqGMm/U8QgTPPX80fHhdKLpRLXWUohToRSBf
 7YvY+Vw8CAkLwvSmB/dvpN6wScUBFu0psQy3qrTBGZp7U4dirjI2gjdpDNHJJc1RugtqJBtEF
 RXKkVIq0smISMi5at/IFhS5lBJ1n6f2XN4VZtxaWPininBMEM9sjnld3tS9t0SzMnMnN9amS3
 bsJm0MzsR11biXg2Ckj6Dth8+Tt3uOQ5IScnvEecy2zxIEmqeNemSVO/t4UePKhE0r91P2rhA
 v3rm2rk3EObnFna8MJQhOUcXpiCJnH7wT1nPlvhrJDmMYJvL3M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-dt-5.8

for you to fetch changes up to 9ad249abe7b8f6f0d2d876bde860b1c511d71d7b:

  Merge tag 'zynqmp-dt-for-v5.8' of
https://github.com/Xilinx/linux-xlnx into arm/dt (2020-06-02 20:45:53
+0200)

----------------------------------------------------------------
ARM: DT changes for v5.8

This is the set of device tree changes, mostly covering new
hardware support, with 577 patches touching a little over 500
files.

There are five new Arm SoCs supported in this release, all of
them for existing SoC families:

 - Realtek RTD1195, RTD1395 and RTD1619 -- three SoCs used in
   both NAS devices and Android Set-top-box designs, along
   with the "Horseradish", "Lion Skin" and "Mjolnir" reference
   platforms; the Mele X1000 and Xnano X5 set-top-boxes and
   the Banana Pi BPi-M4 single-board computer.

 - Renesas RZ/G1H (r8a7742) -- a high-end 32-bit industrial SoC
   and the iW-RainboW-G21D-Qseven-RZG1H board/SoM

 - Rockchips RK3326 -- low-end 64-bit SoC along with the
   Odroid-GO Advance game console

Newly added machines on already supported SoCs are:

 - AMLogic S905D based Smartlabs SML-5442TW TV box

 - AMLogic S905X3 based ODROID-C4 SBC

 - AMLogic S922XH based Beelink GT-King Pro TV box

 - Allwinner A20 based Olimex A20-OLinuXino-LIME-eMMC SBC

 - Aspeed ast2500 based BMCs in Facebook x86 "Yosemite V2"
   and YADRO OpenPower P9 "Nicole"

 - Marvell Kirkwood based Check Point L-50 router

 - Mediatek MT8173 based Elm/Hana Chromebook laptops

 - Microchip SAMA5D2 "Industrial Connectivity Platform"
   reference board

 - NXP i.MX8m based Beacon i.MX8m-Mini SoM development kit

 - Octavo OSDMP15x based Linux Automation MC-1 development board

 - Qualcomm SDM630 based Xiaomi Redmi Note 7 phone

 - Realtek RTD1295 based Xnano X5 TV Box

 - STMicroelectronics STM32MP1 based Stinger96 single-board
   computer and IoT Box

 - Samsung Exynos4210 based based Samsung Galaxy S2 phone

 - Socionext Uniphier based Akebi96 SBC

 - TI Keystone based K2G Evaluation board

 - TI am5729 based Beaglebone-AI development board

Include device descriptions for additional hardware support in existing
SoCs and machines based on all major SoC platforms:

 - AMlogic Meson

 - Allwinner sunxi

 - Arm Juno/VFP/Vexpress/Integrator

 - Broadcom bcm283x/bcm2711

 - Hisilicon hi6220

 - Marvell EBU

 - Mediatek MT27xx, MT76xx, MT81xx and MT67xx

 - Microchip SAMA5D2

 - NXP i.MX6/i.MX7/i.MX8 and Layerscape

 - Nvidia Tegra

 - Qualcomm Snapdragon

 - Renesas r8a77961, r8a7791

 - Rockchips RK32xx/RK33xx

 - ST-Ericsson ux500

 - STMicroelectronics SMT32

 - Samsung Exynos and S5PV210

 - Socionext Uniphier

 - TI OMAP5/DRA7 and Keystone

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Abhishek Sahu (1):
      ARM: dts: qcom: ipq4019: fix high resolution timer

Adam Ford (1):
      arm64: dts: imx: Add Beacon i.MX8m-Mini development kit

Ahmad Fatoum (8):
      ARM: dts: stm32: enable stm32mp157's &gpu by default
      ARM: dts: stm32: preset stm32mp15x video #address- and #size-cells
      ARM: dts: stm32: remove now redundant STM32MP15x video cell sizes
      ARM: dts: stm32: use uniform label names for sleep pinctrl phandles
      ARM: dts: stm32: use uniform node names for sleep pinctrl groups
      dt-bindings: add vendor prefix for Linux Automation GmbH
      ARM: dts: stm32: add STM32MP1-based Linux Automation MC-1 board
      dt-bindings: arm: stm32: document lxa,stm32mp157c-mc1 compatible

Alain Volmat (4):
      dts: arm: stih418: Fix complain about IRQ_TYPE_NONE usage
      dts: arm: stih407-family: remove duplicated rng nodes
      ARM: dts: stm32: use st,stm32mp15-i2c compatible for stm32mp151
      ARM: dts: stm32: add Fast Mode Plus info in I2C nodes of stm32mp151

Alex Elder (2):
      arm64: dts: sdm845: add IPA iommus property
      arm64: dts: qcom: sc7180: add IPA information

Alexander Filippov (2):
      ARM: dts: aspeed: ast2400: Add video engine support
      ARM: dts: aspeed: Add YADRO Nicole BMC

Alexandre Belloni (4):
      ARM: dts: at91: sama5d3: switch to new clock bindings
      ARM: dts: at91: at91sam9n12: switch to new clock bindings
      ARM: dts: at91: at91sam9g45: switch to new clock bindings
      ARM: dts: at91: rm9200: switch to new clock bindings

Alexey Minnekhanov (2):
      dt-bindings: arm: qcom: Add sdm630 and sdm660 SoCs
      arm64: dts: qcom: Add Xiaomi Redmi Note 7 (lavender)

Amit Kucheria (5):
      dt-bindings: arm: cpus: Add kryo468 compatible
      arm64: dts: qcom: sc7180: Fix cpu compatible
      arm64: dts: qcom: msm8916: remove unit name for thermal trip points
      arm64: dts: qcom: msm8996: remove unit name for thermal trip points
      arm64: dts: qcom: msm8998: remove unit name for thermal trip points

Andre Przywara (17):
      arm64: dts: fvp/juno: Fix node address fields
      arm64: dts: fvp: Move fixed devices out of bus node
      arm64: dts: vexpress: Move fixed devices out of bus node
      arm64: dts: fvp: Move fixed clocks out of bus node
      arm64: dts: juno: Move fixed devices out of bus node
      arm64: dts: juno: Fix mem-timer
      arm64: dts: fvp: Fix GIC compatible names
      arm64: dts: juno: Fix GIC child nodes
      arm64: dts: fvp: Fix GIC child nodes
      arm64: dts: fvp: Fix ITS node names and #msi-cells
      arm64: dts: juno: Use proper DT node name for USB
      arm64: dts: fvp/juno: Fix serial node names
      arm64: dts: fvp: Fix SMMU DT node
      arm64: dts: fvp/juno: Fix bus node names
      arm64: dts: juno: Fix GPU interrupt order
      arm64: dts: vexpress: Fix VExpress LED names
      arm64: dts: juno: Fix SCPI shared mem node name

Andreas Färber (33):
      dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
      ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
      ARM: dts: rtd1195: Exclude boot ROM from memory ranges
      ARM: dts: rtd1195: Introduce r-bus
      dt-bindings: arm: realtek: Add Realtek Horseradish EVB
      ARM: dts: rtd1195: Add Realtek Horseradish EVB
      arm64: dts: realtek: rtd129x: Fix GIC CPU masks for RTD1293
      arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
      arm64: dts: realtek: rtd129x: Introduce r-bus
      arm64: dts: realtek: rtd129x: Carve out boot ROM from memory
      dt-bindings: arm: realtek: Add RTD1395 and Banana Pi BPI-M4
      arm64: dts: realtek: Add RTD1395 and BPi-M4
      dt-bindings: arm: realtek: Add Realtek Lion Skin EVB
      arm64: dts: realtek: rtd1395: Add Realtek Lion Skin EVB
      arm64: dts: realtek: rtd16xx: Carve out boot ROM from memory
      arm64: dts: realtek: rtd16xx: Add memory reservations
      dt-bindings: vendor-prefixes: Add Xnano
      dt-bindings: arm: realtek: Add Xnano X5
      arm64: dts: realtek: rtd1295: Add Xnano X5
      ARM: dts: rtd1195: Introduce iso and misc syscon
      arm64: dts: realtek: rtd129x: Introduce CRT, iso and misc syscon
      arm64: dts: realtek: rtd139x: Introduce CRT, iso and misc syscon
      arm64: dts: realtek: rtd16xx: Introduce iso and misc syscon
      ARM: dts: rtd1195: Add CRT syscon node
      dt-bindings: reset: Add Realtek RTD1195
      ARM: dts: rtd1195: Add reset nodes
      ARM: dts: rtd1195: Add UART resets
      arm64: dts: realtek: rtd16xx: Add CRT syscon node
      ARM: dts: rtd1195: Add SB2 and SCPU Wrapper syscon nodes
      arm64: dts: realtek: rtd129x: Add SB2 and SCPU Wrapper syscon nodes
      arm64: dts: realtek: rtd139x: Add SB2 and SCPU Wrapper syscon nodes
      arm64: dts: realtek: rtd16xx: Add SB2 and SCPU Wrapper syscon nodes
      dt-bindings: reset: rtd1295: Add SB2 reset

Andreas Kemnade (1):
      ARM: dts: e60k02: add interrupt for PMIC

Andrew Geissler (4):
      ARM: dts: aspeed: witherspoon: Add gpio line names
      ARM: dts: aspeed: romulus: Add gpio line names
      ARM: dts: aspeed: zaius: Add gpio line names
      ARM: dts: aspeed: rainier: Add gpio line names

Andrew Jeffery (3):
      ARM: dts: aspeed: rainier: Enable VUART2
      ARM: dts: aspeed: tacoma: Enable the second VUART
      ARM: dts: aspeed: Change KCS nodes to v2 binding

Anson Huang (17):
      arm64: dts: imx8mm-evk: Add secondary cpus supply
      arm64: dts: imx8mn-ddr4-evk: Add secondary cpus supply
      ARM: dts: imx7: Correct CPU supply name
      ARM: dts: imx7d: Add cpu1 supply
      arm64: dts: imx8mp: Add thermal zones support
      arm64: dts: imx8qxp-mek: Sort labels alphabetically
      arm64: dts: imx8qxp-mek: Add PMIC thermal zone support
      arm64: dts: imx8mn: Update VDD_ARM 1.2GHz setpoint voltage
      arm64: dts: imx8mq: Add src node interrupts
      arm64: dts: imx8mp: Add src node interrupts
      ARM: dts: imx51: Add src node interrupt
      ARM: dts: imx53: Add src node interrupt
      ARM: dts: imx6qdl: Use nvmem interface to get fuse data
      ARM: dts: imx6sl: Use nvmem interface to get fuse data
      ARM: dts: imx: make src node name generic
      ARM: dts: imx50: Add src node interrupt
      ARM: dts: imx5: make src node name generic

Ansuel Smith (1):
      ARM: dts: qcom: add scm definition to ipq806x

Arnaud Pouliquen (1):
      ARM: dts: stm32: add cortex-M4 pdds management in Cortex-M4 node

Arnd Bergmann (42):
      Merge tag 'sti-dt-for-v5.8-round1' of
git://git.kernel.org/.../pchotard/sti into arm/dt
      Merge tag 'versatile-dts-v5.8-1' of
git://git.kernel.org/.../linusw/linux-integrator into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.8-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.8-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'omap-for-v5.8/dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'aspeed-5.8-devicetree' of
git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'realtek-dt-for-5.8' of
git://git.kernel.org/.../afaerber/linux-realtek into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.8' of
git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'arm-soc/for-5.8/devicetree' of
https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'samsung-dt-5.8' of
git://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'stm32-dt-for-v5.8-1' of
git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.8-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.8-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'ti-k3-dt-for-v5.8' of
git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'tegra-for-5.8-dt-bindings' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.8-arm-dt' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.8-1' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'socfpga_dts_update_for_v5.8' of
git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'v5.7-next-dts32' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'ux500-dts-v5.8' of
git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'v5.7-next-dts64' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'uniphier-dt-v5.8' of
git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'uniphier-dt64-v5.8' of
git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'at91-5.8-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.8' of
git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.8' of
git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'juno-updates-5.8' of
git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'mvebu-dt-5.8-1' of
git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt64-5.8-1' of
git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'v5.8-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.8-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge branch 'mmp/fixes' into arm/dt
      Merge tag 'amlogic-dt' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt64' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'tegra-for-5.8-arm64-dt-v2' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'imx-bindings-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'v5.7-next-dts64.2' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'keystone_dts_for_5.8' of
git://git.kernel.org/.../ssantosh/linux-keystone into arm/dt
      Merge tag 'keystone_dts_for_5.7' of
git://git.kernel.org/.../ssantosh/linux-keystone into arm/dt
      Merge tag 'zynqmp-dt-for-v5.8' of
https://github.com/Xilinx/linux-xlnx into arm/dt

Baruch Siach (2):
      arm64: dts: marvell: drop i2c timeout-ms property
      ARM: dts: marvell: drop i2c timeout-ms property

Ben Pai (2):
      ARM: dts: aspeed: mihawk: Change the name of leds
      ARM: dts: aspeed: mihawk: add aliases for i2c

Biao Huang (1):
      arm64: dts: mt2712: add ethernet device node

Bjorn Andersson (9):
      arm64: dts: qcom: qcs404: Add USB devices and PHYs
      arm64: dts: qcom: sm8250: Add rpmhpd node
      arm64: dts: qcom: sm8250: Fix PDC compatible and reg
      arm64: dts: qcom: db820c: Add pmi8994 RPM regulators
      arm64: dts: qcom: db820c: Fix invalid pm8994 supplies
      arm64: dts: qcom: c630: Add WiFi node
      arm64: dts: qcom: c630: Specify UFS device reset
      arm64: dts: qcom: msm8996: Make GPU node control GPU_GX GDSC
      arm64: dts: qcom: sc7180: Fix ETMv4 power management patch

Boris Brezillon (1):
      arm64: dts: rockchip: Define the rockchip Video Decoder node on rk3399

Brian J. Tarricone (1):
      ARM: dts: kirkwood: ReadyNAS NV+v2: Add LCD panel

Bryan O'Donoghue (7):
      arm64: dts: qcom: qcs404-evb: Define VBUS pins
      arm64: dts: qcom: qcs404-evb: Define USB ID pin
      arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
      arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
      arm64: dts: qcom: qcs404-evb: Enable USB controllers
      arm64: dts: qcom: sm8250-mtp: Add pm8150, pm8150l and pm8009
      arm64: dts: qcom: sm8250: Add UFS controller and PHY

Christian Hewitt (9):
      dt-bindings: add vendor prefix for Smartlabs LLC
      dt-bindings: arm: amlogic: add support for the Smartlabs SML-5442TW
      arm64: dts: meson: add support for the Smartlabs SML-5442TW
      arm64: dts: meson: add ethernet interrupt to wetek dtsi
      arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
      dt-bindings: arm: amlogic: add support for the Beelink GT-King
      arm64: dts: meson-g12b-gtking: add initial device-tree
      dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
      arm64: dts: meson-g12b-gtking-pro: add initial device-tree

Chunfeng Yun (1):
      arm64: dts: mt2712: use non-empty ranges for usb-phy

Chunyan Zhang (2):
      arm64: dts: Add SC9863A clock nodes
      arm64: dts: Add SC9863A emmc and sd card nodes

Claudiu Beznea (1):
      ARM: dts: at91: sama5d27_som1: Add SPI NOR flash mapping

Clément Péron (6):
      arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
      arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
      arm64: dts: allwinner: Sort Pine H64 device-tree nodes
      arm64: dts: allwinner: h6: Enable CPU opp tables for Pine H64
      arm64: dts: allwinner: h6: add voltage range to OPP table
      arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6

Codrin Ciubotariu (2):
      dt-bindings: ARM: Document SAMA5D2-ICP
      ARM: dts: at91: Configure I2C SCL gpio as open drain

Craig Tatlor (1):
      arm64: dts: qcom: Add SDM660 SoC support

Cristian Birsan (1):
      ARM: dts: at91: sama5d2-icp: add SAMA5D2-ICP

Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2_xplained: Add QSPI0 + SPI NOR memory nodes

Daniele Debernardi (5):
      ARM: dts: qcom: msm8974-klte: Add pma8084 regulator nodes
      ARM: dts: qcom: msm8974-klte: Remove inherited vreg_boost node
      ARM: dts: qcom: msm8974-klte: Add gpio-keys nodes
      ARM: dts: qcom: msm8974-klte: Add sdhci1 node
      ARM: dts: qcom: msm8974-klte: Add USB node

Dmitry Osipenko (3):
      ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
      ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
      dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30

Dongjin Kim (1):
      arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4

Douglas Anderson (3):
      arm64: dts: qcom: sc7180: Swap order of gpucc and sdhc_2
      arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza
      arm64: dts: qcom: sc7180: Add "no-map" to cmd_db reserved area

Eddie James (9):
      ARM: dts: aspeed: ast2500: Add SCU interrupt controller
      ARM: dts: aspeed: ast2600: Add SCU interrupt controllers
      ARM: dts: aspeed: tacoma: Add gpio-key definitions
      ARM: dts: aspeed: ast2600: Set arch timer always-on
      ARM: dts: aspeed: tacoma: Add iio-hwmon nodes for IIO devices
      ARM: dts: aspeed: tacoma: Add TPM
      ARM: dts: aspeed: ast2500: Add XDMA Engine
      ARM: dts: aspeed: ast2600: Add XDMA Engine
      ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control reset

Enric Balletbo i Serra (1):
      arm64: dts: mt8173: Fix mmsys node name

Etienne Carriere (1):
      ARM: dts: stm32: bump PSCI to version 1.0 on stm32mp15x

Evan Green (1):
      arm64: dts: qcom: sc7180: Include interconnect definitions

Fabio Estevam (2):
      arm64: dts: imx8qxp-mek: Do not use underscore in node name
      ARM: dts: imx50: Remove unused iomuxc-gpr node

Fabrice Gasnier (3):
      ARM: dts: stm32: fix a typo for DAC io-channel-cells on stm32f429
      ARM: dts: stm32: fix a typo for DAC io-channel-cells on stm32h743
      ARM: dts: stm32: fix a typo for DAC io-channel-cells on stm32mp15

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-next-2020-03-27' into devicetree/next

Fugang Duan (1):
      arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible string

Geert Uytterhoeven (5):
      arm64: dts: renesas: r8a77961: Add SCIF and HSCIF nodes
      ARM: dts: r8a7791: Add TPU device node
      ARM: dts: r8a7791: Add PWM device nodes
      ARM: dts: shmobile: Update CMT1 compatible values
      Merge tag 'renesas-r8a7742-dt-binding-defs-tag' into
renesas-arm-dt-for-v5.8

Guenter Roeck (1):
      ARM: dts: aspeed: tacoma: Enable eMMC controller

Guido Günther (2):
      arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
      arm64: dts: imx8mq-librem5-devkit: Don't use underscore in node name

Heiko Stuebner (3):
      arm64: dts: rockchip: add core devicetree for rk3326
      dt-bindings: Add binding for Hardkernel Odroid Go Advance
      arm64: dts: rockchip: add Odroid Advance Go

Hsin-Hsiung Wang (1):
      arm64: dts: mt6358: add PMIC MT6358 related nodes

Hsin-Yi Wang (6):
      arm64: dts: mt8173: Add gce setting in mmsys and display node
      dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
      arm64: dts: mt8173: add uart aliases
      arm64: dts: mt8173: fix unit name warnings
      arm64: dts: mediatek: add mt8173 elm and hana board
      arm64: dts: mt8173: fix mdp aliases property name

Igor Opaniuk (2):
      dt-bindings: arm: fsl: add nxp based toradex colibri bindings
      ARM: dts: colibri: introduce device trees with UHS-I support

Ikjoon Jang (1):
      arm64: dts: mt8183: adjust cpuidle target residency

Iskren Chernev (1):
      ARM: dts: qcom: msm8974-klte: Add max77826 pmic node

Jae Hyun Yoo (1):
      ARM: dts: aspeed: ast2600: Add Video Engine node

James Tai (2):
      dt-bindings: arm: realtek: Document RTD1619 and Realtek Mjolnir EVB
      arm64: dts: realtek: Add RTD1619 SoC and Realtek Mjolnir EVB

Jason Kridner (1):
      ARM: dts: am5729: beaglebone-ai: adding device tree

Jernej Skrabec (2):
      arm64: dts: allwinner: h6: orangepi: Add gpio power supply
      arm64: dts: allwinner: h6: orangepi: Disable OTG mode

Jerome Brunet (14):
      arm64: dts: meson: kvim3: move hdmi to tdm a
      dt-bindings: reset: meson: add gxl internal dac reset
      arm64: dts: meson-gx: add aiu support
      arm64: dts: meson: p230-q200: add initial audio playback support
      arm64: dts: meson: libretech-cc: add initial audio playback support
      arm64: dts: meson: libretech-ac: add initial audio playback support
      arm64: dts: meson: libretech-pc: add initial audio playback support
      arm64: dts: meson: gxl: add acodec support
      arm64: dts: meson: p230-q200: add internal DAC support
      arm64: dts: meson: libretech-cc: add internal DAC support
      arm64: dts: meson: libretech-ac: add internal DAC support
      arm64: dts: meson: libretech-pc: add internal DAC support
      arm64: dts: meson: g12: add internal DAC
      arm64: dts: meson: g12: add internal DAC glue

Joel Stanley (5):
      ARM: dts: aspeed: ast2600evb: Enable FSI master
      ARM: dts: aspeed: rainier: Add host FSI description
      ARM: dts: aspeed: tacoma: Add GPIOs for FSI
      ARM: dts: aspeed: tacoma: Add gpio line names
      ARM: dts: aspeed: rainier: Add VGA reserved memory region

Johan Jonker (19):
      arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308-roc-cc
      arm64: dts: rockchip: remove #sound-dai-cells from &i2s1 node of
rk3399-pinebook-pro.dts
      arm64: dts: rockchip: remove #sound-dai-cells from &spdif node
of rk3399-hugsun-x99.dts
      arm64: dts: rockchip: replace RK_FUNC defines in rk3326-odroid-go2
      include: dt-bindings: rockchip: remove unused defines
      arm64: dts: rockchip: fix phy nodename for rk3328
      arm64: dts: rockchip: fix rtl8211f nodename for rk3328 Beelink A1
      arm64: dts: rockchip: fix rtl8211e nodename for rk3399-nanopi4
      arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-nanopi4
      arm64: dts: rockchip: fix rtl8211e nodename for rk3399-orangepi
      arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-orangepi
      arm64: dts: rockchip: fix defines in pd_vio node for rk3399
      arm64: dts: rockchip: rename and label gpio-led subnodes
      arm64: dts: rockchip: remove disable-wp from rk3308-roc-cc emmc node
      ARM: dts: rockchip: rename and label gpio-led subnodes
      ARM: dts: rockchip: remove identical #include from rk3288.dtsi
      arm64: dts: rockchip: add bus-width properties to mmc nodes for px30
      arm64: dts: rockchip: fix pd_tcpc0 and pd_tcpc1 node position on rk3399
      arm64: dts: rockchip: fix pinctrl-names for gpio-leds node on
rk3326-odroid-go2

Jon Hunter (3):
      arm64: tegra: Fix ethernet phy-mode for Jetson Xavier
      arm64: tegra: Allow the PMIC RTC to wakeup Jetson Xavier
      arm64: tegra: Make the RTC a wakeup source on Jetson Nano and TX1

Jonathan Bakker (17):
      ARM: dts: s5pv210: Add helper define for sleep gpio config
      ARM: dts: s5pv210: Add sleep GPIO configuration for Fascinate4G
      ARM: dts: s5pv210: Add sleep GPIO configuration for Galaxy S
      ARM: dts: s5pv210: Correct gpi pinctrl node name
      ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on Aries
      ARM: dts: s5pv210: Disable pulls on GPIO I2C adapters for Aries
      ARM: dts: s5pv210: Add WM8994 support to Aries boards
      ARM: dts: s5pv210: Add FSA9480 support to Aries boards
      ARM: dts: s5pv210: Add touchkey support to Aries boards
      ARM: dts: s5pv210: Add panel support to Aries boards
      ARM: dts: s5pv210: Add remaining i2c-gpio adapters to Aries boards
      ARM: dts: s5pv210: Disable pull for vibrator enable GPIO on Aries boards
      ARM: dts: s5pv210: Add an ADC node
      ARM: dts: s5pv210: Enable ADC on Aries boards
      ARM: dts: s5pv210: Assign clocks to MMC devices on Aries boards
      ARM: dts: s5pv210: Correct FIMC definitions
      ARM: dts: s5pv210: Set MAX8998 GPIO pulls on Aries boards

Jonathan Marek (1):
      arm64: dts: qcom: fix pm8150 gpio interrupts

Joseph Lo (2):
      dt-bindings: memory: tegra: Add external memory controller
binding for Tegra210
      arm64: tegra: Add external memory controller node for Tegra210

Justin Swartz (3):
      ARM: dts: enable WLAN for Mecer Xtreme Mini S6
      ARM: dts: remove disable-wp from rk3229-xms6 emmc
      ARM: dts: rockchip: add rga node for rk322x

Jyri Sarha (3):
      ARM: dts: keystone-k2g: Add DSS node
      ARM: dts: keystone-k2g-evm: add HDMI video support
      arm64: dts: ti: am654: Add DSS node

Kalyani Akula (1):
      arm64: zynqmp: Add Xilinx AES node

Keerthy (2):
      arm64: dts: ti: am65-wakeup: Add VTM node
      arm64: dts: ti: am654: Add thermal zones

Kevin Hilman (1):
      Merge branch 'reset/meson-gxl-dac' of
git://git.pengutronix.de/pza/linux into HEAD

Krishna Manikandan (1):
      arm64: dts: qcom: sc7180: modify assigned clocks for sc7180 target

Krzysztof Kozlowski (1):
      ARM: dts: keystone: Rename "msmram" node to "sram"

Kuldeep Singh (2):
      arm64: dts: ls1012a: Add QSPI node properties
      arm: dts: ls1021atwr: Add QSPI node properties

Kunihiko Hayashi (5):
      ARM: dts: uniphier: Add XDMAC node
      arm64: dts: uniphier: Add XDMAC node
      ARM: dts: uniphier: Add ethernet aliases
      arm64: dts: uniphier: Add ethernet aliases
      arm64: dts: uniphier: Stabilize Ethernet RGMII mode of PXs3 ref board

Lad Prabhakar (13):
      dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
      clk: renesas: Add r8a7742 CPG Core Clock Definitions
      dt-bindings: power: rcar-sysc: Document r8a7742 SYSC binding
      dt-bindings: reset: rcar-rst: Document r8a7742 reset module
      ARM: dts: r8a7742: Initial SoC device tree
      ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H Qseven SOM
      ARM: dts: r8a7742-iwg21d-q7: Add iWave G21D-Q7 board based on RZ/G1H
      ARM: dts: r8a7742: Add IRQC support
      ARM: dts: r8a7742: Add [H]SCIF{A|B} support
      ARM: dts: r8a7742: Add GPIO nodes
      arm64: dts: renesas: r8a774c0-cat874: Add support for
AISTARVISION MIPI Adapter V2.1
      dt-bindings: arm: renesas: Document iW-RainboW-G21M-Qseven-RZG1H SoM
      dt-bindings: arm: renesas: Document iW-RainboW-G21D-Qseven-RZG1H board

Linus Walleij (3):
      ARM: dts: Add devicetree for Integrator/AP with IM-PD1
      ARM: dts: ux500: samsung-skomer: Add magnetometer
      ARM: dts: ux500: Add touchscreen to the Skomer

Loic Poulain (5):
      arm64: dts: qcom: msm8916: Add i2c-qcom-cci node
      arm64: dts: qcom: apq8016-sbc: Add CCI/Sensor nodes
      arm64: dts: hikey960: pinctrl: Fix spi2/spi3 pinconf
      arm64: dts: msm8996: Fix CSI IRQ types
      arch: arm64: dts: msm8996: Add CCI node

Lokesh Vutla (1):
      ARM: dts: Add 32KHz clock as default clock source

Long Cheng (1):
      arm: dts: mt2712: add uart APDMA to device tree

Lubomir Rintel (15):
      ARM: dts: kirkwood: Fix interrupt controller node name
      ARM: dts: dove: Fix interrupt controller node name
      ARM: dts: pxa168: Add missing address/size cells to i2c nodes
      ARM: dts: pxa168: Fix the gpio interrupt cell number
      ARM: dts: pxa3xx: Fix up encoding of the /gpio interrupts property
      ARM: dts: pxa910: Fix the gpio interrupt cell number
      ARM: dts: pxa*: Fix up encoding of the /rtc interrupts property
      ARM: dts: mmp*: Fix up encoding of the /rtc interrupts property
      ARM: dts: mmp3: Fix L2 cache controller node name
      ARM: dts: mmp3: Fix USB & USB PHY node names
      ARM: dts: berlin*: Fix up the SDHCI node names
      ARM: dts: mmp3: Add the fifth SD HCI
      ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
      ARM: dts: mmp3-dell-ariel: Fix the SPI devices
      ARM: dts: mmp3: Drop usb-nop-xceiv from HSIC phy

Ludovic Desroches (6):
      ARM: dts: at91: sama5d2_ptc_ek: fix sdmmc0 node description
      ARM: dts: at91: sama5d2_ptc_ek: fix vbus pin
      ARM: dts: at91: sama5d2_ptc_ek: add PB_USER as wakeup source
      ARM: dts: at91: sama5d27_som1_ek: enable i2c0
      ARM: dts: at91: sama5d27_som1_ek: add an alias for i2c0
      ARM: dts: at91: at91-sama5d27_som1: Enable eeprom device

Manikandan Elumalai (1):
      ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC

Manivannan Sadhasivam (10):
      dt-bindings: Add vendor prefix for Shiratech Solutions
      ARM: dts: stm32: Add missing pinctrl entries for STM32MP15
      dt-bindings: arm: stm32: Document Stinger96 compatible
      ARM: dts: stm32: Add Stinger96 board support
      dt-bindings: arm: stm32: Document IoT Box compatible
      ARM: dts: stm32: Add IoT Box board support
      dt-bindings: i2c: Document I2C controller binding for MT6797 SoC
      arm64: dts: mediatek: Add I2C support for MT6797 SoC
      arm64: dts: mediatek: Enable I2C support for 96Boards X20
Development board
      arm64: dts: mediatek: Switch to SPDX license identifier for MT6797 SoC

Marco Felsch (1):
      dt-bindings: arm: imx: add kontron smarc to schema

Marek Behún (4):
      arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
      arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
      arm64: dts: armada-3720-turris-mox: forbid SDR104 on SDIO for FCC purposes
      arm64: dts: armada-3720-turris-mox: fix SFP binding

Marek Szyprowski (9):
      ARM: dts: exynos: Enable Bluetooth support for Rinato board
      ARM: dts: exynos: Enable WLAN support for the Trats board
      ARM: dts: exynos: Fix GPIO polarity for thr GalaxyS3 CM36651 sensor's bus
      ARM: dts: exynos: Convert to new i2c-gpio bindings
      ARM: dts: exynos: Correct regulator names
      ARM: dts: exynos: Correct the MAX8997 interrupts on the Trats board
      ARM: dts: exynos: Remove useless address/size cells for mshc_0 on Rinato
      ARM: dts: exynos: Enable WLAN support for the Rinato board
      ARM: dts: exynos: Enable WLAN support for the UniversalC210 board

Marek Vasut (36):
      ARM: dts: imx6q-dhcom: Add DH 560-200 display unit support
      ARM: dts: stm32: Enable I2C2 on DHCOM PDK2 carrier board
      ARM: dts: stm32: Repair PMIC configuration on AV96
      ARM: dts: stm32: Repair PMIC interrupt on AV96
      ARM: dts: stm32: Add alternate pinmux for ethernet RGMII on stm32mp15
      ARM: dts: stm32: Repair ethernet operation on AV96
      ARM: dts: stm32: Add missing ethernet PHY reset on AV96
      ARM: dts: stm32: Add missing ethernet PHY skews on AV96
      ARM: dts: stm32: Add alternate pinmux for SDMMC pins on stm32mp15
      ARM: dts: stm32: Repair SDMMC1 operation on AV96
      ARM: dts: stm32: Add eMMC attached to SDMMC2 on AV96
      ARM: dts: stm32: Add QSPI NOR on AV96
      ARM: dts: stm32: Add configuration EEPROM on AV96
      ARM: dts: stm32: Enable WiFi on AV96
      ARM: dts: stm32: Add alternate pinmux for USART2 pins on stm32mp15
      ARM: dts: stm32: Enable Bluetooth on AV96
      ARM: dts: stm32: Add alternate pinmux for LTDC pins on stm32mp15
      ARM: dts: stm32: Add bindings for HDMI video on AV96
      ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15
      ARM: dts: stm32: Add bindings for audio on AV96
      ARM: dts: stm32: Add bindings for USB on AV96
      ARM: dts: stm32: Rename LEDs to match silkscreen on AV96
      ARM: dts: stm32: Add alternate pinmux for I2C2 pins
      ARM: dts: stm32: Repair I2C2 operation on AV96
      ARM: dts: stm32: Add alternate pinmux for FDCAN1 pins
      ARM: dts: stm32: Add bindings for FDCAN1 on AV96
      ARM: dts: stm32: Add alternate pinmux for FDCAN2 pins
      ARM: dts: stm32: Add bindings for FDCAN2 on AV96
      ARM: dts: stm32: Add alternate pinmux for ADC pins
      ARM: dts: stm32: Add bindings for ADC on AV96
      ARM: dts: stm32: Add alternate pinmux for SPI2 pins
      ARM: dts: stm32: Add bindings for SPI2 on AV96
      ARM: dts: stm32: Add GPIO keys for STM32MP1 DHCOM PDK2
      ARM: dts: stm32: Add GPIO LEDs for STM32MP1 DHCOM PDK2
      ARM: dts: stm32: Split SoC-independent parts of DHCOM SOM and PDK2
      ARM: dts: stm32: Split Avenger96 into DHCOR SoM and Avenger96 board

Martin Blumenstingl (5):
      arm64: dts: amlogic: use the new USB control driver for GXL and GXM
      ARM: dts: meson: add the gadget mode properties to the USB0 controller
      ARM: dts: meson8m2: Use the Meson8m2 specific USB2 PHY compatible
      ARM: dts: meson: Add the Ethernet "timing-adjustment" clock
      ARM: dts: meson: Switch existing boards with RGMII PHY to "rgmii-id"

Masahiro Yamada (2):
      ARM: dts: uniphier: add #address-cells and #size-cells to SPI nodes
      arm64: dts: uniphier: add #address-cells and #size-cells to SPI nodes

Masami Hiramatsu (2):
      dt-bindings: arm: Add Akebi96 board support
      arm64: dts: uniphier: Add support for Akebi96

Matt Porter (1):
      arm64: dts: imx8mm: specify #sound-dai-cells for SAI nodes

Matthew Barth (2):
      ARM: dts: aspeed: rainier: Set PCA9552 pin types
      ARM: dts: aspeed: rainier: Remove regulators

Matthias Brugger (1):
      arm64: dts: mt6797: Fix mmsys node name

Matthias Kaehlcke (1):
      arm64: dts: qcom: sc7180: Add interconnect paths for the video codec

Maulik Shah (2):
      arm64: dts: qcom: sc7180: Add cpuidle low power states
      arm64: dts: qcom: sc7180: Correct the pdc interrupt ranges

Maxime Ripard (1):
      arm64: dts: allwinner: h6: Add IOMMU

Michael Kao (1):
      arm64: dts: mt8173: fix cooling device range

Michael Srba (2):
      arm64: dts: qcom: msm8916: Disable coresight by default
      arm64: dts: qcom: msm8916-samsung-a3u: add nodes for display panel

Michael Walle (2):
      arm64: dts: freescale: sl28: enable LPUART1
      arm64: dts: ls1028a: sl28: keep switch port names consistent

Michal Simek (1):
      arm64: zynqmp: Fix GIC compatible property

Mike Leach (2):
      arm64: dts: qcom: msm8916: Add CTI options
      arm64: dts: hi6220: Add CTI options

Min Guo (1):
      arm: dts: mt2701: Add usb2 device nodes

Nagarjuna Kristam (1):
      arm64: tegra: Add XUDC node on Tegra194

Neil Armstrong (7):
      arm64: dts: meson: fixup SCP sram nodes
      arm64: dts: meson-g12b-ugoos-am6: fix board compatible
      arm64: dts: meson-gxbb-kii-pro: fix board compatible
      arm64: dts: meson: fix leds subnodes name
      arm64: dts: meson-g12b: move G12B thermal nodes to meson-g12b.dtsi
      arm64: dts: meson-sm1: add cpu thermal nodes
      dt-bindings: arm: amlogic: add odroid-c4 bindings

Nick Reitemeyer (1):
      ARM: dts: ux500: samsung-golden: Add magnetometer

Nicolas Saenz Julienne (3):
      ARM: dts: bcm2711: Update expgpio's GPIO labels
      ARM: dts: bcm2711: Add vmmc regulator in emmc2
      ARM: dts: bcm283x: Use firmware PM driver for V3D

Ondrej Jirman (3):
      arm64: dts: allwinner: h6: Add thermal trip points/cooling map
      arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
      arm64: dts: allwinner: sun50i-a64: Add missing address/size-cells

Pali Rohár (1):
      arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property

Pascal Paillet (1):
      ARM: dts: stm32: Enable thermal sensor support on stm32mp15xx-dkx

Paul Cercueil (1):
      dt-bindings: arm: samsung: Add compatible string for the Galaxy S2

Pawel Dembicki (1):
      ARM: dts: kirkwood: Add Check Point L-50 board

Paweł Chmiel (1):
      ARM: dts: s5pv210: Add si470x FM radio to Galaxy S

Peng Fan (2):
      arm64: dts: imx8qxp: support scu mailbox channel
      arm64: dts: imx8m: assign clocks for A53

Petr Štetiar (1):
      arm64: dts: allwinner: a64: olinuxino: add user red LED

Qiang Yu (1):
      ARM: dts: sun8i-h3: add opp table for mali gpu

Rajendra Nayak (1):
      arm64: dts: qcom: db820c: Add vdd_gfx and tie it into mmcc

Rajeshwari (1):
      arm64: dts: qcom: sc7180: Changed polling mode in Thermal-zones node

Ricardo Cañuelo (1):
      ARM: dts: imx53-cx9020: Group port definitions for the dvi-converter

Rob Herring (2):
      ARM: tegra: Kill off "simple-panel" compatibles
      arm64: tegra: Kill off "simple-panel" compatibles

Robert Foss (3):
      arm64: dts: qcom: sdm845: Add i2c-qcom-cci node
      arm64: dts: qcom: sdm845-db845c: Add pm_8998 gpio names
      arm64: dts: qcom: sdm845-db845c: Add ov8856 & ov7251 camera nodes

Russell King (3):
      ARM: dts: imx6-sr-som: add ethernet PHY configuration
      arm64: dts: update SolidRun Armada 8040 phy interface types
      arm64: dts: add uDPU i2c bus recovery

Ryder Lee (2):
      arm64: dts: mt7622: add built-in Wi-Fi device nodes
      arm: dts: mt7623: add Mali-450 device node

Sai Prakash Ranjan (2):
      arm64: dts: qcom: sc7180: Add Coresight support
      arm64: dts: qcom: sc7180: Support ETMv4 power management

Samuel Holland (4):
      ARM: dts: sunxi: a83t: Add msgbox node
      ARM: dts: sunxi: h3/h5: Add msgbox node
      arm64: dts: allwinner: a64: Add msgbox node
      arm64: dts: allwinner: h6: Add msgbox node

Sandeep Maheswaram (3):
      arm64: dts: qcom: sdm845: Add generic QUSB2 V2 Phy compatible
      arm64: dts: qcom: sc7180: Add generic QUSB2 V2 Phy compatible
      arm64: dts: qcom: sc7180: Update QUSB2 V2 Phy params for SC7180 IDP device

Sean Wang (2):
      arm: dts: mt7623: add phy-mode property for gmac2
      dt-bindings: gpu: mali-utgard: add mediatek, mt7623-mali compatible

Sebastian Meyer (1):
      arm64: allwinner: h6: orangepi-lite2: Support BT+WIFI combo module

Sharat Masetty (2):
      dt-bindings: arm-smmu: Add sc7180 compatible string
      arm64: dts: qcom: sc7180: Add A618 gpu dt blob

Sibi Sankar (4):
      arm64: dts: qcom: sdm845: Add SoC compatible to MTP
      arm64: dts: qcom: sc7180: Update reserved memory map
      arm64: dts: qcom: sc7180: Add Q6V5 MSS node
      arm64: dts: qcom: sc7180: Update Q6V5 MSS node

Sivaprakash Murugesan (1):
      arm64: dts: ipq8074: qcom: Re-arrange dts nodes based on address

Sowjanya Komatineni (6):
      dt-bindings: clock: tegra: Remove PMC clock IDs
      dt-bindings: clock: tegra: Add clock ID for CSI TPG clock
      dt-bindings: tegra: Add VI and CSI bindings
      arm64: tegra: Fix SOR powergate clocks and reset
      arm64: tegra: Add reset-cells to memory controller
      arm64: tegra: Add Tegra VI CSI support in device tree

Stefan Mavrodiev (2):
      dt-bindings: arm: sunxi: Add compatible for A20-OLinuXino-LIME-eMMC
      ARM: dts: sun7i: Add A20-OLinuXino-LIME-eMMC

Steffen Trumtrar (3):
      ARM: dts: socfgpa: set bridges status to disabled
      ARM: dts: socfpga: Add fpga2hps and fpga2sdram bridges
      ARM: dts: imx7d-pinfunc: add input mux for ENET2 mdio

Stenkin Evgeniy (1):
      ARM: dts: exynos: Add devicetree file for the Galaxy S2

Stephan Gerhold (8):
      ARM: dts: ux500: samsung-golden: Add proximity sensor
      arm64: dts: qcom: msm8916: Add blsp_i2c1
      arm64: dts: qcom: msm8916: Add blsp_i2c5
      arm64: dts: qcom: msm8916-samsung-a2015: Add touchscreen regulator
      arm64: dts: qcom: msm8916-samsung-a5u: Add touchscreen
      arm64: dts: qcom: msm8916: avoid using _ in node names
      arm64: dts: qcom: msm8916: move gpu opp table to gpu node
      arm64: dts: qcom: apq8016-sbc: merge -pins.dtsi into main .dtsi

Suman Anna (16):
      ARM: dts: DRA7: Add common IPU and DSP nodes
      ARM: dts: DRA74x: Add DSP2 processor device node
      ARM: dts: DRA74x: Add aliases for rproc nodes
      ARM: dts: DRA72x: Add aliases for rproc nodes
      ARM: dts: dra7-ipu-dsp-common: Move mailboxes into common files
      ARM: dts: dra7-ipu-dsp-common: Add mailboxes to IPU and DSP nodes
      ARM: dts: dra7-ipu-dsp-common: Add timers to IPU and DSP nodes
      ARM: dts: dra7-evm: Add CMA pools and enable IPU & DSP rprocs
      ARM: dts: dra72-evm: Add CMA pools and enable IPUs & DSP1 rprocs
      ARM: dts: dra72-evm-revc: Add CMA pools and enable IPUs & DSP1 rprocs
      ARM: dts: dra71-evm: Add CMA pools and enable IPUs & DSP1 rprocs
      ARM: dts: dra76-evm: Add CMA pools and enable IPU & DSP rprocs
      ARM: dts: beagle-x15-common: Add CMA pools and enable IPU & DSP rprocs
      ARM: dts: am572x-idk-common: Add CMA pools and enable IPU & DSP rprocs
      ARM: dts: am571x-idk: Add CMA pools and enable IPUs & DSP1 rprocs
      ARM: dts: dra7-ipu-dsp-common: Add watchdog timers to IPU and DSP nodes

Tero Kristo (8):
      arm64: dts: ti: k3-j721e-main: Add main domain watchdog entries
      ARM: dts: dra7: add timer_sys_ck entries for IPU/DSP timers
      ARM: dts: omap5: add aes1 entry
      ARM: dts: omap5: add aes2 entry
      ARM: dts: omap5: add SHA crypto accelerator node
      ARM: dts: omap5: add DES crypto accelerator node
      ARM: OMAP4: Make L4SEC clock domain SWSUP only
      ARM: OMAP5: Make L4SEC clock domain SWSUP only

Thierry Reding (5):
      dt-bindings: i2c: tegra: Document Tegra210 VI I2C
      Merge branch 'for-5.8/dt-bindings' into for-5.8/arm64/dt
      arm64: tegra: Hook up EMC cooling device
      arm64: tegra: Enable VI I2C on Jetson Nano
      arm64: tegra: Make the RTC a wakeup source on Jetson TX2

Tim Harvey (5):
      ARM: dts: imx6qdl-gw552x: add USB OTG support
      ARM: dts: imx6qdl-gw560x: add lsm9ds1 iio imu/magn support
      ARM: dts: imx6qdl-gw5904: add lsm9ds1 iio imu/magn support
      ARM: dts: imx6qdl-gw5910: add support for bcm4330-bt
      ARM: dts: imx6qdl-gw5910: fix wlan regulator

Tim Lewis (1):
      arm64: dts: meson: S922X: extend cpu opp-points

Tobias Schramm (1):
      arm64: dts: rockchip: add micro SD card regulator to rockpro64

Tomi Valkeinen (3):
      ARM: dts: am57xx-idk-common: add tc358778 bridge
      arm64: dts: ti: k3-j721e-main: Add DSS node
      arm64: dts: ti: k3-j721e-common-proc-board: add assigned clks for DSS

Tony Lindgren (1):
      Merge branch 'omap-for-v5.8/dt-timer' into omap-for-v5.8/dt

Tudor Ambarus (20):
      ARM: dts: at91: sam9x60ek: Use quad mode in the spi-nor flash
      ARM: dts: at91: sam9x60ek: Add sdmmc1 node
      ARM: dts: at91: sama5d27_wlsom1: Add alias for i2c0
      ARM: dts: at91: sama5d2: Fix the label numbering for flexcom functions
      ARM: dts: at91: sama5d2: Move flx4 definitions in the SoC dtsi
      ARM: dts: at91: sama5d2: Move flx3 definitions in the SoC dtsi
      ARM: dts: at91: sama5d2: Move flx2 definitions in the SoC dtsi
      ARM: dts: at91: sama5d2: Move flx1 definitions in the SoC dtsi
      ARM: dts: at91: sama5d2: Move flx0 definitions in the SoC dtsi
      ARM: dts: at91: sama5d2: Specify the FIFO size for the Flexcom UART
      ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and UART
flx4 functions
      ARM: dts: at91: sama5d2: Add DMA bindings for the flx3 SPI function
      ARM: dts: at91: sama5d2: Add DMA bindings for the flx1 I2C function
      ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and I2C
flx0 functions
      ARM: dts: at91: sama5d2: Remove i2s and tcb aliases from SoC dtsi
      ARM: dts: at91: sama5d2: Add missing flexcom definitions
      ARM: dts: at91: sama5d2_xplained: Add alias for DBGU
      ARM: dts: at91: sama5d2_ptc_ek: Add comments to describe the aliases
      ARM: dts: at91: sama5d2_xplained: Describe the flx0 I2C function
      ARM: dts: at91: sama5d2_xplained: Add aliases for the dedicated I2C IPs

Ulf Hansson (2):
      arm64: dts: qcom: msm8916: Conform to the domain-idle-state binding
      arm64: dts: qcom: msm8916: Conform to the nodename pattern PSCI subnodes

Ulrich Hecht (1):
      arm64: dts: mt8173: Add capacity-dmips-mhz attributes

Vidya Sagar (1):
      arm64: tegra: Fix flag for 64-bit resources in 'ranges' property

Vignesh Raghavendra (1):
      arm64: dts: ti: k3-am65-main: Add ehrpwm nodes

Vijay Khemka (2):
      ARM: dts: aspeed: tiogapass: Add IPMB device
      ARM: dts: aspeed: tiogapass: Add gpio line names

Vincent Stehlé (1):
      ARM: dts: sun8i-h2-plus-bananapi-m2-zero: Fix led polarity

Vladimir Oltean (1):
      arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers

Yangbo Lu (2):
      arm64: dts: fsl: add fsl,extts-fifo property for fman ptp
      arm64: dts: ls1043a-rdb: add compatible for board

Yangtao Li (1):
      arm64: dts: allwinner: h6: Add clock to CPU cores

Yann Gautier (1):
      ARM: dts: stm32: add sd-uhs properties in SD-card node for stm32mp157c-ed1

Yoshihiro Shimoda (6):
      arm64: dts: renesas: r8a77961: Add USB2.0 device nodes
      arm64: dts: renesas: r8a77961: Add USB3.0 device nodes
      arm64: dts: renesas: r8a77961: Add PWM device nodes
      arm64: dts: renesas: r8a77961: Add PCIe device nodes
      ARM: dts: renesas: Fix IOMMU device node names
      arm64: dts: renesas: Fix IOMMU device node names

Yuantian Tang (1):
      arm64: dts: lx2160a: add more thermal zone support

Zhao Qiang (2):
      arm64: dts: add qe node to ls1043ardb
      arm64: dts: Add ds26522 node to dts to ls1043ardb

jjian zhou (1):
      arm64: dts: mt8183: add mmc node

 Documentation/devicetree/bindings/arm/amlogic.yaml |    4 +
 .../devicetree/bindings/arm/atmel-at91.yaml        |    7 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |    4 +
 .../devicetree/bindings/arm/mediatek.yaml          |   22 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |    7 +
 Documentation/devicetree/bindings/arm/realtek.yaml |   21 +
 Documentation/devicetree/bindings/arm/renesas.yaml |   10 +
 .../devicetree/bindings/arm/rockchip.yaml          |    5 +
 .../bindings/arm/samsung/samsung-boards.yaml       |    1 +
 .../bindings/arm/socionext/uniphier.yaml           |    1 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |    3 +
 Documentation/devicetree/bindings/arm/sunxi.yaml   |    5 +
 .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   56 +
 .../display/tegra/nvidia,tegra20-host1x.txt        |   73 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |    2 +
 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |    1 +
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |    6 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    1 +
 .../memory-controllers/nvidia,tegra210-emc.yaml    |   82 ++
 .../bindings/power/renesas,rcar-sysc.yaml          |    1 +
 .../devicetree/bindings/reset/renesas,rst.yaml     |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    8 +
 arch/arm/boot/dts/Makefile                         |   19 +-
 arch/arm/boot/dts/am335x-guardian.dts              |    1 +
 arch/arm/boot/dts/am3517-evm.dts                   |    1 +
 arch/arm/boot/dts/am571x-idk.dts                   |   48 +-
 arch/arm/boot/dts/am5729-beagleboneai.dts          |  731 ++++++++++++
 arch/arm/boot/dts/am572x-idk-common.dtsi           |   63 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   63 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   58 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    2 -
 arch/arm/boot/dts/armada-375.dtsi                  |    2 -
 arch/arm/boot/dts/armada-38x.dtsi                  |    2 -
 arch/arm/boot/dts/armada-39x.dtsi                  |    4 -
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |    4 +
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |   78 +-
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    |  231 ++++
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  202 +++-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        |  310 +++++-
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts        |  326 ++++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |   35 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |  112 ++
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   34 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |   37 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   10 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   43 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   64 +-
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          |    2 +-
 arch/arm/boot/dts/at91-kizbox3-hs.dts              |    4 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi         |   48 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |   23 +
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi          |   54 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   64 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        |   16 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts      |   12 -
 arch/arm/boot/dts/at91-sama5d2_icp.dts             |  767 +++++++++++++
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |   25 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  118 +-
 arch/arm/boot/dts/at91-wb50n.dtsi                  |    4 -
 arch/arm/boot/dts/at91rm9200.dtsi                  |  296 +----
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  338 +-----
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  324 +-----
 arch/arm/boot/dts/at91sam9n12ek.dts                |    2 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |   13 +-
 arch/arm/boot/dts/bcm2835-common.dtsi              |    1 -
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi          |   12 +
 arch/arm/boot/dts/bcm2835.dtsi                     |    1 +
 arch/arm/boot/dts/bcm2836.dtsi                     |    1 +
 arch/arm/boot/dts/bcm2837.dtsi                     |    1 +
 arch/arm/boot/dts/berlin2.dtsi                     |    6 +-
 arch/arm/boot/dts/berlin2cd.dtsi                   |    2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    |    6 +-
 arch/arm/boot/dts/dove.dtsi                        |    3 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             |    1 +
 arch/arm/boot/dts/dra7-evm.dts                     |   54 +
 arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi         |   39 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |   50 +-
 arch/arm/boot/dts/dra7.dtsi                        |   36 +
 arch/arm/boot/dts/dra71-evm.dts                    |   42 +
 arch/arm/boot/dts/dra72-evm-common.dtsi            |   18 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |   42 +
 arch/arm/boot/dts/dra72-evm.dts                    |   42 +
 arch/arm/boot/dts/dra72x.dtsi                      |    6 +
 arch/arm/boot/dts/dra74-ipu-dsp-common.dtsi        |   18 +
 arch/arm/boot/dts/dra74x.dtsi                      |   21 +
 arch/arm/boot/dts/dra76-evm.dts                    |   54 +
 arch/arm/boot/dts/e60k02.dtsi                      |    2 +
 arch/arm/boot/dts/exynos3250-monk.dts              |    3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   48 +-
 arch/arm/boot/dts/exynos4210-i9100.dts             |  768 +++++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts            |    7 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   41 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   33 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |    6 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |   17 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    8 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   14 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   13 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    2 +-
 arch/arm/boot/dts/imx50.dtsi                       |    8 +-
 arch/arm/boot/dts/imx51.dtsi                       |    3 +-
 arch/arm/boot/dts/imx53-cx9020.dts                 |   25 +-
 arch/arm/boot/dts/imx53.dtsi                       |    3 +-
 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  |   31 +
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts             |  115 +-
 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi    |   44 +
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   11 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   14 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |   31 +
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |   31 +
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi              |   35 +-
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi              |   11 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   13 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   13 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |    2 +-
 arch/arm/boot/dts/imx7-tqma7.dtsi                  |    2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |    4 +
 arch/arm/boot/dts/imx7d-colibri.dtsi               |    4 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |    4 +
 arch/arm/boot/dts/imx7d-pinfunc.h                  |    2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |    4 +
 arch/arm/boot/dts/imx7d-tqma7.dtsi                 |    4 +
 arch/arm/boot/dts/imx7d-zii-rmu2.dts               |    2 +-
 arch/arm/boot/dts/imx7d-zii-rpu2.dts               |    2 +-
 arch/arm/boot/dts/imx7s.dtsi                       |    2 +-
 arch/arm/boot/dts/integratorap-im-pd1.dts          |  270 +++++
 arch/arm/boot/dts/integratorap.dts                 |   53 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |    4 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |  101 ++
 arch/arm/boot/dts/keystone-k2g.dtsi                |   26 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi               |    4 +-
 arch/arm/boot/dts/keystone-k2l.dtsi                |    4 +-
 arch/arm/boot/dts/kirkwood-l-50.dts                |  438 ++++++++
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |   14 +
 arch/arm/boot/dts/kirkwood.dtsi                    |    2 +-
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |    1 +
 arch/arm/boot/dts/ls1021a-twr.dts                  |   14 +
 arch/arm/boot/dts/meson.dtsi                       |    3 +
 arch/arm/boot/dts/meson8b-odroidc1.dts             |    3 +-
 arch/arm/boot/dts/meson8b.dtsi                     |    5 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts          |    4 +-
 arch/arm/boot/dts/meson8m2.dtsi                    |   13 +-
 arch/arm/boot/dts/mmp2.dtsi                        |    2 +-
 arch/arm/boot/dts/mmp3-dell-ariel.dts              |   12 +-
 arch/arm/boot/dts/mmp3.dtsi                        |   34 +-
 arch/arm/boot/dts/mt2701-evb.dts                   |   21 +
 arch/arm/boot/dts/mt2701.dtsi                      |   33 +
 arch/arm/boot/dts/mt7623.dtsi                      |   25 +
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts             |    1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |    1 +
 arch/arm/boot/dts/omap5-l4.dtsi                    |   31 +
 arch/arm/boot/dts/omap5.dtsi                       |   86 ++
 arch/arm/boot/dts/pxa168.dtsi                      |    8 +-
 arch/arm/boot/dts/pxa3xx.dtsi                      |    2 +-
 arch/arm/boot/dts/pxa910.dtsi                      |    4 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |    1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |    6 +
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts    |  405 ++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   11 +
 arch/arm/boot/dts/r8a7740.dtsi                     |    2 +-
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts            |   37 +
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi              |   53 +
 arch/arm/boot/dts/r8a7742.dtsi                     |  648 +++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7744.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7745.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   95 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |   14 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |   12 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 |    2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                |    2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |    6 +-
 arch/arm/boot/dts/rk3229-xms6.dts                  |   19 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   10 +
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |   12 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   12 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |    2 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |    6 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |    4 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi               |    6 +-
 arch/arm/boot/dts/rk3288.dtsi                      |    1 -
 arch/arm/boot/dts/rtd1195-horseradish.dts          |   32 +
 arch/arm/boot/dts/rtd1195-mele-x1000.dts           |   32 +
 arch/arm/boot/dts/rtd1195.dtsi                     |  217 ++++
 arch/arm/boot/dts/s5pv210-aries.dtsi               |  359 +++++-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  249 +++++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  292 +++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |    9 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   23 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  295 ++++-
 arch/arm/boot/dts/sama5d3.dtsi                     |  430 +------
 arch/arm/boot/dts/sama5d3_can.dtsi                 |   20 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi                |    8 +-
 arch/arm/boot/dts/sama5d3_gmac.dtsi                |   11 +-
 arch/arm/boot/dts/sama5d3_lcd.dtsi                 |   19 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi                |   11 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   12 +-
 arch/arm/boot/dts/sama5d3_uart.dtsi                |   20 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |    6 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              |    6 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |    6 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |    2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   16 +
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts     |   65 ++
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     |   39 +-
 arch/arm/boot/dts/stih407-family.dtsi              |   14 -
 arch/arm/boot/dts/stih418.dtsi                     |    8 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |    4 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |    4 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi           |  666 ++++++++++-
 arch/arm/boot/dts/stm32mp151.dtsi                  |   37 +-
 arch/arm/boot/dts/stm32mp157.dtsi                  |    8 +-
 arch/arm/boot/dts/stm32mp157a-avenger96.dts        |  314 +-----
 arch/arm/boot/dts/stm32mp157a-dhcor-avenger96.dts  |   38 +
 arch/arm/boot/dts/stm32mp157a-iot-box.dts          |   68 ++
 arch/arm/boot/dts/stm32mp157a-stinger96.dts        |   12 +
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi       |  342 ++++++
 arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts       |  265 +----
 arch/arm/boot/dts/stm32mp157c-dk2.dts              |    8 -
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |    7 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   14 +-
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts          |  252 +++++
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |  337 ++++++
 ...c-dhcom-som.dtsi => stm32mp15xx-dhcom-som.dtsi} |    9 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  401 +++++++
 arch/arm/boot/dts/stm32mp15xx-dhcor-io1v8.dtsi     |   23 +
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |  209 ++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   20 +-
 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi           |  230 ++++
 .../arm/boot/dts/sun7i-a20-olinuxino-lime-emmc.dts |   32 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   10 +
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    |    2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   24 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   10 +
 arch/arm/boot/dts/tegra114-dalmore.dts             |    3 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |    2 +-
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts      |    2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts         |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |    2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |    2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |    2 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts     |    2 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |   40 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |    2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |    2 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |    2 +
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |    1 +
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |    1 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |    1 +
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |    1 +
 arch/arm/boot/dts/uniphier-pro4.dtsi               |   10 +
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   12 +
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |    1 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |    1 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   12 +
 arch/arm/boot/dts/uniphier-sld8.dtsi               |    2 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  328 +++---
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    2 +-
 arch/arm/mach-omap2/clockdomains54xx_data.c        |    2 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |    9 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   12 +
 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts   |    9 +-
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi      |  117 ++
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts    |    3 +
 .../dts/allwinner/sun50i-h6-orangepi-lite2.dts     |   65 ++
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi     |   17 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |   43 +-
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts     |   13 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   60 +
 arch/arm64/boot/dts/amlogic/Makefile               |    4 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |    6 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   11 +
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi         |   32 +-
 .../boot/dts/amlogic/meson-g12b-gtking-pro.dts     |  125 +++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts  |  145 +++
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |   18 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi  |   15 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      |  377 +------
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi   |  423 +++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi        |   22 +
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi    |   78 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   98 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   23 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts |    2 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |    2 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |    2 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    2 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |    6 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   23 +
 .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts   |   73 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |    3 +-
 .../dts/amlogic/meson-gxl-s905d-phicomm-n1.dts     |    4 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts |   80 ++
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts      |    4 +
 .../boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |    4 +
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |    4 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   77 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |    3 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   79 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |    3 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |    7 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |    4 +-
 .../arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts |  402 +++++++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |    2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |   24 +
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi   |    4 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi   |   11 +-
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  142 +--
 arch/arm64/boot/dts/arm/fvp-base-revc.dts          |   10 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   82 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi      |  166 +--
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |    2 +-
 .../boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi      |    4 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   |  152 +--
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |   15 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts |   15 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |   15 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |   15 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   13 +
 .../freescale/fsl-ls1028a-kontron-sl28-var2.dts    |    4 +-
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts     |    5 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |    6 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |   33 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   65 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  130 ++-
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi     |  285 +++++
 .../arm64/boot/dts/freescale/imx8mm-beacon-kit.dts |   19 +
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi      |  410 +++++++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts       |   12 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   14 +-
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts  |   12 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   12 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   88 +-
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |    4 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   10 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |   95 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   18 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |    1 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |    4 +-
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi |  130 ++-
 .../arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi |    6 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    3 +
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |    2 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |   10 +-
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts   |   22 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |    4 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |    2 +-
 .../dts/marvell/armada-8040-mcbin-singleshot.dts   |    4 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |    4 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |    1 -
 arch/arm64/boot/dts/mediatek/Makefile              |    3 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   74 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  158 ++-
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |  358 ++++++
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts    |   49 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi           |  231 +++-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    4 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |    4 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   11 +
 .../boot/dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts   |   14 +
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi  |   70 ++
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts        |   14 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       | 1173 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   80 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  147 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   50 +-
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    3 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    5 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   30 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |    3 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   10 +
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |    7 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   89 +-
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   74 --
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |   89 --
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  257 ++++-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   53 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  112 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  474 ++++----
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   25 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  221 ++--
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |   98 +-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |   54 +
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |   35 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  228 +++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   87 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   38 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |   14 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |   14 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |   14 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |    6 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi           |   85 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  100 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   66 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  955 ++++++++++++++--
 .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts |   46 +
 arch/arm64/boot/dts/qcom/sdm660.dtsi               |  372 +++++++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |    2 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  210 ++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |    2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   98 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |   13 +
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |  351 ++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  126 ++-
 arch/arm64/boot/dts/realtek/Makefile               |    6 +
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts     |    6 +-
 arch/arm64/boot/dts/realtek/rtd1293.dtsi           |   12 +-
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts    |    6 +-
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts |    6 +-
 arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts   |   30 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |    4 +-
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   21 +-
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts      |    4 +-
 arch/arm64/boot/dts/realtek/rtd1296.dtsi           |    8 +-
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |  221 ++--
 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts     |   30 +
 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts   |   36 +
 arch/arm64/boot/dts/realtek/rtd1395.dtsi           |   65 ++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           |  193 ++++
 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts    |   44 +
 arch/arm64/boot/dts/realtek/rtd1619.dtsi           |   12 +
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi           |  229 ++++
 arch/arm64/boot/dts/renesas/Makefile               |    3 +-
 .../dts/renesas/aistarvision-mipi-adapter-2.1.dtsi |   94 ++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |   18 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |   18 +-
 .../boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts   |   72 ++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   18 +-
 arch/arm64/boot/dts/renesas/r8a77950.dtsi          |   14 +-
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |   34 +-
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |   22 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |  403 ++++++-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   20 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   10 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |   16 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   20 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   20 +-
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |    3 +
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |    7 +-
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts |  557 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3326.dtsi           |   15 +
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         |    2 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    2 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |    4 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |    4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |   29 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   10 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |    7 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |    4 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   11 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |   29 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |   27 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   34 +-
 arch/arm64/boot/dts/socionext/Makefile             |    1 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    |    1 +
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |    1 +
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   12 +
 .../boot/dts/socionext/uniphier-ld20-akebi96.dts   |  189 ++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    |    1 +
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |    1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   16 +
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   18 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |   12 +
 arch/arm64/boot/dts/sprd/sc9863a.dtsi              |   66 ++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi              |  164 +++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  104 ++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   11 +
 .../boot/dts/ti/k3-am654-industrial-thermal.dtsi   |   45 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |   20 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   75 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    6 +-
 include/dt-bindings/clock/r8a7742-cpg-mssr.h       |   42 +
 include/dt-bindings/clock/tegra114-car.h           |   14 +-
 include/dt-bindings/clock/tegra124-car-common.h    |   14 +-
 include/dt-bindings/clock/tegra20-car.h            |    2 +-
 include/dt-bindings/clock/tegra210-car.h           |   16 +-
 include/dt-bindings/clock/tegra30-car.h            |   14 +-
 include/dt-bindings/pinctrl/rockchip.h             |   11 -
 include/dt-bindings/power/r8a7742-sysc.h           |   29 +
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |    2 +-
 include/dt-bindings/reset/realtek,rtd1195.h        |   74 ++
 include/dt-bindings/reset/realtek,rtd1295.h        |    3 +
 503 files changed, 25420 insertions(+), 4950 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644
Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
 create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_icp.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra74-ipu-dsp-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4210-i9100.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi
 create mode 100644 arch/arm/boot/dts/integratorap-im-pd1.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-l-50.dts
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi
 create mode 100644 arch/arm/boot/dts/rtd1195-horseradish.dts
 create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
 create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157a-dhcor-avenger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-iot-box.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
 rename arch/arm/boot/dts/{stm32mp157c-dhcom-som.dtsi =>
stm32mp15xx-dhcom-som.dtsi} (98%)
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcor-io1v8.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime-emmc.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6358.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm660.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-xnano-x5.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd139x.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi
 create mode 100644
arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326.dtsi
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7742-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a7742-sysc.h
 create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h
