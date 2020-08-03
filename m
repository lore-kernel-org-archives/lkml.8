Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC5207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgHCVoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:44:55 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHCVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:44:54 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N49Qd-1kkwxZ30zp-0103RN for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:44:37 +0200
Received: by mail-qt1-f169.google.com with SMTP id x12so20937103qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:44:36 -0700 (PDT)
X-Gm-Message-State: AOAM532oxmHjySHVatqXwzbcpuOYClKigVyNylh2YM4Mb0Ju6o+YPSc/
        LOlABO8xBHBeY0+BnRV6Gl6LA8zA8a3hatXodGo=
X-Google-Smtp-Source: ABdhPJzBqDmzvlwf55pKw4jYm/Xeaf5RyiIP1Ns7nGyw0hhGEK5GXOfcE+U3RErfxjy1Poxi+mq6Sx+XA9aXwuYjBYU=
X-Received: by 2002:ac8:4652:: with SMTP id f18mr18239802qto.142.1596491075110;
 Mon, 03 Aug 2020 14:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:44:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36swLKHA1QmtTqn6SBCfC=bXxQopt8uUbMEMbmumCVLg@mail.gmail.com>
Message-ID: <CAK8P3a36swLKHA1QmtTqn6SBCfC=bXxQopt8uUbMEMbmumCVLg@mail.gmail.com>
Subject: [GIT PULL 2/5] ARM: SoC: DT changes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2gv3NKiNMmScn7YbvMjyIlsbhv6Nhb2LjDrLB0JDADHye1jNZSa
 XmbKaH9QhyYgYZihNHUjuGZHkKFatF9uwXaFQH2FJO2x5a3skD+nNO7+aDzq0z9Ub3ODm/4
 mlJRus5jTvsD/wVYULiUTKSt11JNfMrscq8sOrQS9pf2n2yMlVi+YFcucsdjZ2osApvqBI1
 hH22r9cPkTGyRc2SaCVSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxwxuM7b7VM=:yTYtovAzNklqXZX43yciy8
 KNkke4WMb9dE7ScfgZozjfNouHgpIvjMRIYLUMwkaBbyity2bFf32XA3w9sXvyxsoP3kIJiCv
 1mSQCYQXSgNqqjUqXOA9ueyhGPbhcJGevs0ikKEIOspXQTSLdoT+owljSGB7VCkn/+1AExhuo
 Zd5a/M4Ni+N2X5cMmcCfL0nkM12iaHYyjiwrOjcwCIGv0uQcPVnkWkMuv11UaHFjSlYynw2pQ
 jhF+hpcRvAMdHGaIuWvdU5raMgGp4y+d1jFkYYDAyG/o0yrlT1jTmvnZ1Ys0TW22ekzZ/8X4V
 rocUmVsfQRclzQYUVbseV/TyNsIhFo2VMNm/vEb5adhPyciVbHfcZU4Eo4nXjM6sNki6u/957
 ZIiY50EmZvs9xuwXsDAvrbPNnJcejfon1kLXWVKWlNFFVluoTDr8mD78yURxx2QG4BaUf8M8G
 0UOtqRvDm43dpbap9U3zSGM8nlnHE/+tjbuB/xKXbUQJvNBVkSLirmZZmwFHWu58dDBE2wgXm
 HRq/2KDoGxQQFfNQHsgJ+s3AaXOh7tMk/CTkayhOsLzJoAatv48pxyKJTlNRMCVxBAbHqTO5e
 V+PTfcm68aRwfagZC7OOQwTYeeLAZTHKYx1dZYIjPzz/pFJfv43CJC63Prama7DjANblU//7u
 uxpcD2t7QvxtqTlczWkXFXebmM7UAQ3qZuCYN/KFOuK7c4rUG6htNn9p1a0pFViJj6DNNfxlo
 VO1fCxkqWbgZsEj3kXsF8lb8U2Ea4WceCa5DFGbM/doH3Gtu//cfU36A4Y7RnwizCq1MZSrgX
 4Vg9dU5DFR8S0fFZluoJMb/ylK/uafB4ydQ4KMf+JOBV8X+yb/elO60I/1ZkXST027ZQ5EDjQ
 e83iu2Aux3F9J+RKU60rZ16504fbz7WpzoEusk/5c2Ptj5CiFmK1NhNl5hKeemvOqIWTe4lbq
 OCVaQ4KCI8mDy4elQuQIiyyYXeVWwVHeErO4E5VxYgQtNnnAZguzd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-dt-5.9

for you to fetch changes up to f510ca05271b6f71bd532fe743b39f628110223f:

  Merge tag 'qcom-arm64-for-5.9-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
(2020-07-31 10:41:56 +0200)

----------------------------------------------------------------
ARM: SoC DT changes for 5.9

As usual, there are many patches addressing minor issues in existing
DTS files, such as DTC warnings, or adding support for additional
peripherals.

There are three added SoCs in existing product families:

 - Amazon:
    Alpine v3 is a 16-core Cortex-A72 SoC from Amazon's Annapurna Labs,
    otherwise known as AL73400 or first-generation Graviton, and following
    the already supported Cortex-A1`5 and Cortex-A57 based Alpine chips.
    This one is added together with the official Evaluation platform.

 - Qualcomm:
    The Snapdragon SDM630 platform is a family of mid-range mobile phone
    chips from 2017 based on Cortex-A53 or Kryo 260 CPUs.
    A total of five end-user products are added based on these, all
    Android phones from Sony: Xperia 10, 10 Plus, XA2, XA2 Plus and
    XA2 Ultra.

 - Renesas:
    RZ/G2H (r8a774e1) is currently the top model in the Renesas RZ/G
    family, and apparently closely related to the RZ/G2N and RZ/G2M
    models we already support but has a faster GPU and additional
    on-chip peripherals.
    It is added along with the HopeRun HiHope RZ/G2H development board

A small number of new boards for already supported SoCs also debut:

 - Allwinner sunxi:
    Only one new machine, revision v1.2 of the Pine64 PinePhone
    (non-Android) smartphone, containing minor changes compared to
    earlier versions.

 - Amlogic Meson:
    WeTek Core2 is an Amlogic S912 (GXM) based Set-top-box

 - Aspeed:
    EthanolX is AMD's EPYC data center rerence platform, using an
    ASpeed AST2600 baseboard management controller.

 - Mediatek:
    Lenovo IdeaPad Duet 10.1" (kukui/krane) is a new Chromebook
    based on the MT8183 (Helio P60t) SoC.

 - Nvidia Tegra:
    ASUS Google Nexus 7 and Acer Iconia Tab A500 are two Android
    tablets from around 2012 using Tegra 3 and Tegra 2, respectively.
    Thanks to PostmarketOS, these can now run mainline kernels
    and become useful again.

    The Jetson Xavier NX Developer Kit uses a SoM and carrier board
    for the Tegra194, their latest 64-bit chip based on Carmel CPU
    cores and Volta graphics.

 - NXP i.MX:
    Five new boards based on the 32-bit i.MX6 series are added:
    The MYiR MYS-6ULX single-board computer, and four different
    models of industrial computers from Protonic.

 - Qualcomm:
    MikroTik RouterBoard 3011 is a rackmounted router based on the
    32-bit IPQ8064 networking SoC
    Three older phones get added, the Snapdragon 808 (msm8992) based
    Xiaomi Libra (Mi 4C) and Microsoft Lumia 950, originally running
    Windows Phone, and the Snapdragon 810 (msm8994) based Sony
    Xperia Z5.

 - Renesas:
    In addition to the HiHope RZ/G2H board mentioned above, we gain
    support for board versions 3.0 and 4.0 of the earlier RZ/G2M and
    RZ/G2N reference boards.
    Beacon EmbeddedWorks adds another SoM+Carrier development board
    for RZ/G2M.

 - Rockchips:
    Radxa Rock Pi N8 development board and the VMARC RK3288 SoM it
    is based on, using the high-end 32-bit rk3288 SoC.

Notable updates to existing platforms are usually for added on-chip
peripherals, including:

 - ASpeed AST2xxx (various)

 - Allwinner (cpufreq, thermal, Pinephone touchscreen)

 - Amlogic Meson (audio, gpu dvdfs, board updates)

 - Arm Versatile

 - Broadcom (board updates for switch ports, Raspberry pi clock updates)

 - Hisilicon (various)

 - Intel/Altera SoCFPGA (various)

 - Marvell Armada 7xxx/8xxx (smmu)

 - Marvell MMP (GPU on mmp2/mmp3)

 - Mediatek mt8183 (USB, pericfg)

 - NXP Layerscape (VPU, thermal, DSPI)

 - NXP i.MX (VPU, bindings, board updates)

 - Nvidia Tegra194 (GPU)

 - Qualcomm (GPU, Interconnect, ...)

 - Renesas R-Car (SPI, IPMMU, board updates)

 - STMicroelectronics STM32 (various)

 - Samsung Exynos (various)

 - Socionext Uniphier (updates to serial, and pcie)

 - TI K3 (serdes, usb3, audio, sd, chipid)

 - TI OMAP (IPU/DSP remoteproc changes, dropping platform data)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
[shortlog didn't fit in 100kb, using
$ git log --oneline --first-parent v5.8-rc2..arm-dt-5.9]

6fc013ffb1b6 Merge tag 'amlogic-dt64-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into arm/dt
dae29d661d25 Merge tag 'amlogic-dt64-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into arm/dt
9141b3ca7fed ARM: dts: berlin: Align L2 cache-controller nodename with dtschema
73bf2131d057 Merge tag 'aspeed-5.9-devicetree' of
git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed into arm/dt
7fbdc6afd02b Merge tag 'at91-dt-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/dt
4a775263fcda Merge tag 'amlogic-dt64-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into arm/dt
33c56edacd9f Merge tag 'mvebu-dt64-5.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into
arm/dt
a127fdac2397 Merge tag 'mvebu-dt-5.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into
arm/dt
cf8182fc9d3d Merge tag 'ti-k3-dt-for-v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux into arm/dt
0183b9b0e9a1 arm64: dts: amazon: add Amazon's Annapurna Labs Alpine v3 support
b29dd1131306 dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
81079390fab2 dt-bindings: arm: amazon: add missing alpine-v2 DT binding
e6293d123a85 dt-bindings: arm: amazon: update maintainers of amazon,al
DT bindings
39889b8294c5 arm64: dts: amazon: rename al folder to be amazon
34d8ddb4d451 dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
3ed75c545d47 Merge tag 'v5.9-rockchip-dts32-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip
into arm/dt
571a9cf12a85 Merge tag 'v5.9-rockchip-dts64-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip
into arm/dt
67598a474fbb ARM: dts: mmp3-dell-ariel: Enable the GPU
d896b86e09a7 ARM: dts: mmp3: Add the GPU
cbcb5b33df5f ARM: dts: mmp2-olpc-xo-1-75: Enable the GPU
b4c2abb6810e ARM: dts: mmp2: Add the GPU
d1e6f7c9f0f1 ARM: dts: mmp2-olpc-xo-1-75: Enable audio support
3f2326312aec ARM: dts: mmp2: Add SSPA nodes
5fd71502e2a7 ARM: dts: mmp2: Add Audio Clock controller
f3f202bb5600 ARM: dts: mmp2: Add DMA nodes
f2023d9d1051 ARM: dts: mmp2: Add Audio SRAM
f45a04a5ec44 ARM: dts: mmp2: Extend the MPMU reg range
1267340fe51c ARM: dts: mmp2: Add #power-domain-cells to /clocks
f45200b67ea3 ARM: dts: mmp2-olpc-xo-1-75: Delete #address-cells from ssp3
9dbf272cf4f1 ARM: dts: mmp2-olpc-xo-1-75: Fix camera I2C node validation
6b848e263aaf Merge tag 'ux500-dts-for-v5.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson
into arm/dt
b61010a1ec45 Merge tag 'stm32-dt-for-v5.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into
arm/dt
bd979a33ace6 Merge tag 'samsung-dt64-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/dt
3236013b7091 Merge tag 'samsung-dt-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/dt
42f8362abd0e Merge tag 'qcom-dts-for-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
c6e2e454baef Merge tag 'qcom-arm64-for-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
01407153cfed Merge tag 'hisi-arm64-dt-for-5.9' of
git://github.com/hisilicon/linux-hisi into arm/dt
6ce448eeef44 Merge tag 'hisi-arm32-dt-for-5.9' of
git://github.com/hisilicon/linux-hisi into arm/dt
4828f4570873 Merge tag 'sunxi-dt-for-5.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/dt
262fc784d856 Merge tag 'versatile-for-v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator
into arm/dt
3b796abd3027 Merge tag 'imx-dt64-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
arm/dt
d27895a12223 Merge tag 'imx-dt-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
arm/dt
8fc5082aa470 Merge tag 'imx-bindings-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
arm/dt
36e163eda14c Merge tag 'socfpga_dts_update_for_v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into
arm/dt
fb31429fa988 Merge tag 'tegra-for-5.9-arm64-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
3502e079c6bc Merge tag 'tegra-for-5.9-arm-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
28ef26f649c6 Merge tag 'tegra-for-5.9-dt-bindings' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
981053c0b282 Merge tag 'amlogic-dt64' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into arm/dt
a0660529acf7 Merge tag 'amlogic-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic
into arm/dt
6760a29c8817 Merge tag 'renesas-dt-bindings-for-v5.9-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into
arm/dt
2c2a5564d102 Merge tag 'renesas-arm-dt-for-v5.9-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into
arm/dt
39a85f6d91a1 Merge tag 'v5.8-next-dts64' of
git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into
arm/dt
0e9aa96859ed Merge tag 'omap-for-v5.9/dt-pt2-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/dt
32ed5880aef5 Merge tag 'omap-for-v5.9/ti-sysc-drop-pdata-take2-signed'
of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap
into arm/dt
42027dfe59c0 Merge tag 'arm-soc/for-5.9/devicetree' of
https://github.com/Broadcom/stblinux into arm/dt
67b2563855ad Merge tag 'omap-for-v5.9/dt-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/dt
dfe2a4cf8e2f Merge tag 'uniphier-dt64-v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier
into arm/dt
056a7ecf4725 Merge tag 'uniphier-dt-v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier
into arm/dt
9f0d16ebe30f Merge tag 'renesas-arm-dt-for-v5.9-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into
arm/dt

 .../devicetree/bindings/arm/al,alpine.yaml         |   21 -
 .../devicetree/bindings/arm/amazon,al.yaml         |   33 +
 Documentation/devicetree/bindings/arm/amlogic.yaml |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |    5 +
 .../devicetree/bindings/arm/mediatek.yaml          |    5 +
 Documentation/devicetree/bindings/arm/renesas.yaml |   13 +
 .../devicetree/bindings/arm/rockchip.yaml          |    6 +
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   14 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |    5 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |   18 +
 .../bindings/fuse/nvidia,tegra20-fuse.txt          |    5 +-
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       |   25 +
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |   19 +-
 .../bindings/mfd/ti,j721e-system-controller.yaml   |   74 +
 .../bindings/power/renesas,rcar-sysc.yaml          |    1 +
 .../devicetree/bindings/reset/renesas,rst.yaml     |    1 +
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt |    4 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    2 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    6 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |    2 +-
 arch/arm/boot/dts/Makefile                         |   14 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |    2 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |    2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |    2 +-
 arch/arm/boot/dts/am335x-baltos-leds.dtsi          |    2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |    2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |    2 +-
 arch/arm/boot/dts/am335x-bone.dts                  |    2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi     |    2 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    |    2 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  146 +-
 arch/arm/boot/dts/am335x-boneblue.dts              |    2 +-
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi     |    2 +-
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts    |    2 +-
 arch/arm/boot/dts/am335x-bonegreen.dts             |    2 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |    2 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi             |    2 +-
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |    2 +-
 arch/arm/boot/dts/am335x-guardian.dts              |    2 +-
 arch/arm/boot/dts/am335x-icev2.dts                 |    2 +-
 arch/arm/boot/dts/am335x-lxm.dts                   |    2 +-
 arch/arm/boot/dts/am335x-netcan-plus-1xx.dts       |    2 +-
 arch/arm/boot/dts/am335x-netcom-plus-2xx.dts       |    2 +-
 arch/arm/boot/dts/am335x-netcom-plus-8xx.dts       |    2 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts        |    4 +-
 arch/arm/boot/dts/am335x-osd335x-common.dtsi       |    2 +-
 arch/arm/boot/dts/am335x-pdu001.dts                |    2 +-
 arch/arm/boot/dts/am335x-pocketbeagle.dts          |  271 ++-
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          |    2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   24 +
 arch/arm/boot/dts/am33xx.dtsi                      |    2 +-
 arch/arm/boot/dts/am3517-craneboard.dts            |    2 +-
 arch/arm/boot/dts/am3517-evm-ui.dtsi               |    2 +-
 arch/arm/boot/dts/am3517-evm.dts                   |    2 +-
 arch/arm/boot/dts/am3517.dtsi                      |    6 +-
 arch/arm/boot/dts/am3874-iceboard.dts              |    4 +-
 arch/arm/boot/dts/am4372.dtsi                      |    4 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |    2 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |    2 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |    2 +-
 arch/arm/boot/dts/am57-pruss.dtsi                  |    2 +-
 arch/arm/boot/dts/am5718.dtsi                      |    2 +-
 arch/arm/boot/dts/am571x-idk.dts                   |    2 +-
 arch/arm/boot/dts/am5728.dtsi                      |    2 +-
 arch/arm/boot/dts/am5729-beagleboneai.dts          |   73 +-
 arch/arm/boot/dts/am572x-idk-common.dtsi           |    2 +-
 arch/arm/boot/dts/am572x-idk.dts                   |    2 +-
 arch/arm/boot/dts/am5748.dtsi                      |    2 +-
 arch/arm/boot/dts/am574x-idk.dts                   |    2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |    2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |    2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts       |    2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |    2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |    2 +-
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi          |    2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pbx-a9.dts          |    2 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |    5 +-
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts      |  219 +++
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts      | 1231 +++++++++++++-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts  |   42 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  466 +++++-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        |  152 ++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |   79 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   11 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    5 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   15 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |   13 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   30 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |    2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm21664.dtsi                    |    2 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |    5 +
 arch/arm/boot/dts/bcm2711.dtsi                     |   15 +
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |   25 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |   20 +
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |   20 +
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |   40 +
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts      |   25 +
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts      |   20 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |   40 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts   |   40 +
 arch/arm/boot/dts/berlin2.dtsi                     |    2 +-
 arch/arm/boot/dts/berlin2cd.dtsi                   |    2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    |    2 +-
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi         |    2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             |    2 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    2 +-
 arch/arm/boot/dts/dra7-iva-thermal.dtsi            |    2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |    4 -
 arch/arm/boot/dts/dra7.dtsi                        |    2 +-
 arch/arm/boot/dts/dra71-evm.dts                    |    2 +-
 arch/arm/boot/dts/dra71x.dtsi                      |    2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |    2 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |    2 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          |    4 +-
 arch/arm/boot/dts/dra72-evm.dts                    |    2 +-
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi          |    2 +-
 arch/arm/boot/dts/dra72x.dtsi                      |    2 +-
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi          |    2 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   60 +-
 arch/arm/boot/dts/dra76-evm.dts                    |    2 +-
 arch/arm/boot/dts/dra76x.dtsi                      |    2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   41 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   47 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   70 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   98 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   28 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   21 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   86 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   92 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   46 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   53 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  130 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |    6 -
 arch/arm/boot/dts/exynos5800.dtsi                  |    6 +-
 arch/arm/boot/dts/hi3620.dtsi                      |    2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |    2 +-
 arch/arm/boot/dts/imx1.dtsi                        |    2 +-
 arch/arm/boot/dts/imx23.dtsi                       |    2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   14 +-
 arch/arm/boot/dts/imx27.dtsi                       |   10 +-
 arch/arm/boot/dts/imx28.dtsi                       |    2 +-
 arch/arm/boot/dts/imx31.dtsi                       |    8 +-
 arch/arm/boot/dts/imx35.dtsi                       |   10 +-
 arch/arm/boot/dts/imx50.dtsi                       |   12 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |    1 +
 arch/arm/boot/dts/imx51.dtsi                       |   14 +-
 arch/arm/boot/dts/imx53-kp.dtsi                    |    8 +
 arch/arm/boot/dts/imx53-m53evk.dts                 |    1 +
 arch/arm/boot/dts/imx53-ppd.dts                    |   51 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |    8 +
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    1 -
 arch/arm/boot/dts/imx53.dtsi                       |   14 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |    1 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |    1 +
 arch/arm/boot/dts/imx6dl-mamoj.dts                 |    1 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts                |  184 +++
 arch/arm/boot/dts/imx6dl-prtvt7.dts                |  411 +++++
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         |    1 -
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |    1 +
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts             |    1 -
 arch/arm/boot/dts/imx6q-display5.dtsi              |    1 -
 arch/arm/boot/dts/imx6q-kp.dtsi                    |    2 +
 arch/arm/boot/dts/imx6q-mccmon6.dts                |    1 -
 arch/arm/boot/dts/imx6q-novena.dts                 |    1 +
 arch/arm/boot/dts/imx6q-pistachio.dts              |    1 +
 arch/arm/boot/dts/imx6q-prti6q.dts                 |  543 +++++++
 arch/arm/boot/dts/imx6q-prtwd2.dts                 |  188 +++
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   14 +-
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     |    1 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |    1 +
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |    1 +
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |    1 +
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |    1 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               |    3 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  153 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  160 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  166 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  168 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  147 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  153 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |  141 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |  165 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi              |  141 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |  142 +-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi              |  142 +-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi              |  160 +-
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi              |  148 +-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi              |  153 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |    1 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |    2 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    3 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |    2 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    2 +
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi         |    1 +
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi              |  163 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    3 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   15 +-
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi         |    1 +
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |    2 -
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    2 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   45 +-
 arch/arm/boot/dts/imx6qp-sabreauto.dts             |    4 +
 arch/arm/boot/dts/imx6qp-sabresd.dts               |    4 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |    1 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   40 +-
 arch/arm/boot/dts/imx6sll-evk.dts                  |    1 +
 arch/arm/boot/dts/imx6sll.dtsi                     |   38 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |    1 +
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |   96 ++
 arch/arm/boot/dts/imx6sx-sdb-mqs.dts               |   48 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   31 +
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |    3 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   80 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            |    1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        |    1 +
 arch/arm/boot/dts/imx6ul-geam.dts                  |    1 +
 arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi   |    1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |    1 +
 arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts    |    1 +
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi      |    1 +
 arch/arm/boot/dts/imx6ul-pico.dtsi                 |    1 +
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |    1 -
 arch/arm/boot/dts/imx6ul.dtsi                      |   67 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi             |    4 -
 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts   |   18 +
 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi       |  238 +++
 arch/arm/boot/dts/imx7s.dtsi                       |   28 +-
 arch/arm/boot/dts/imx7ulp.dtsi                     |    2 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  |    2 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   17 +-
 arch/arm/boot/dts/meson.dtsi                       |    9 +-
 arch/arm/boot/dts/meson8.dtsi                      |   32 +
 arch/arm/boot/dts/meson8b-ec100.dts                |   25 +
 arch/arm/boot/dts/meson8b-odroidc1.dts             |   26 +
 arch/arm/boot/dts/meson8b.dtsi                     |   47 +
 arch/arm/boot/dts/meson8m2.dtsi                    |   23 +
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts            |   78 +-
 arch/arm/boot/dts/mmp2.dtsi                        |   89 +-
 arch/arm/boot/dts/mmp3-dell-ariel.dts              |    8 +
 arch/arm/boot/dts/mmp3.dtsi                        |   25 +
 arch/arm/boot/dts/omap2.dtsi                       |    2 +-
 arch/arm/boot/dts/omap2420-h4.dts                  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |    2 +-
 arch/arm/boot/dts/omap2430-sdp.dts                 |    2 +-
 arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm-ab.dts           |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |    2 +-
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |    2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |    2 +-
 arch/arm/boot/dts/omap3-evm.dts                    |    2 +-
 arch/arm/boot/dts/omap3-ha-common.dtsi             |    2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts                 |    2 +-
 arch/arm/boot/dts/omap3-ha.dts                     |    2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |    2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |    6 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |    8 +-
 arch/arm/boot/dts/omap3-thunder.dts                |    2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   59 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |    2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |    2 +-
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi           |    2 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi                |   20 +-
 arch/arm/boot/dts/omap4-l4.dtsi                    |   37 +-
 arch/arm/boot/dts/omap4-panda-a4.dts               |    2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   36 +-
 arch/arm/boot/dts/omap4-panda-es.dts               |    2 +-
 arch/arm/boot/dts/omap4-panda.dts                  |    2 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts           |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |    6 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |    2 +-
 arch/arm/boot/dts/omap4.dtsi                       |   33 +-
 arch/arm/boot/dts/omap443x.dtsi                    |    2 +-
 arch/arm/boot/dts/omap4460.dtsi                    |    2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |    2 +-
 arch/arm/boot/dts/omap5-core-thermal.dtsi          |    2 +-
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi           |    2 +-
 arch/arm/boot/dts/omap5-l4-abe.dtsi                |   20 +-
 arch/arm/boot/dts/omap5-l4.dtsi                    |   38 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |   36 +-
 arch/arm/boot/dts/omap5.dtsi                       |   27 +-
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts          |  308 ++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  115 ++
 arch/arm/boot/dts/r7s72100.dtsi                    |    4 +-
 arch/arm/boot/dts/r7s9210.dtsi                     |    4 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts    |   97 ++
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts            |  187 +++
 arch/arm/boot/dts/r8a7742.dtsi                     |  854 ++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7744.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7745.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a77470.dtsi                    |    6 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |    9 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |    8 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |    1 -
 arch/arm/boot/dts/r8a7790.dtsi                     |    8 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |    1 -
 arch/arm/boot/dts/r8a7791-porter.dts               |    1 -
 arch/arm/boot/dts/r8a7791.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |    2 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |    5 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |    1 -
 arch/arm/boot/dts/r8a7794-silk.dts                 |    1 -
 arch/arm/boot/dts/r8a7794.dtsi                     |    6 +-
 arch/arm/boot/dts/r9a06g032.dtsi                   |    2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |    1 +
 arch/arm/boot/dts/rk322x.dtsi                      |    7 +-
 arch/arm/boot/dts/rk3288-rock-pi-n8.dts            |   17 +
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            |   17 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          |    2 +-
 arch/arm/boot/dts/rk3288-veyron-mighty.dts         |    6 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         |    2 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          |    6 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |    2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         |    2 +-
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi            |  322 ++++
 arch/arm/boot/dts/rk3288-vyasa.dts                 |    3 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   20 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |    3 +
 .../boot/dts/rockchip-radxa-dalang-carrier.dtsi    |   97 +-
 arch/arm/boot/dts/rv1108.dtsi                      |   13 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               |   90 +-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |   17 +
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |    2 +
 arch/arm/boot/dts/sam9x60.dtsi                     |    7 +
 arch/arm/boot/dts/sh73a0.dtsi                      |    7 +-
 arch/arm/boot/dts/socfpga.dtsi                     |    2 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             |    2 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |    5 +
 arch/arm/boot/dts/ste-ab8500.dtsi                  |   14 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |    2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |    2 +-
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts     |   45 +
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     |    4 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |   10 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |    8 +-
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   85 +-
 arch/arm/boot/dts/stm32f429-disco.dts              |   97 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   22 +-
 arch/arm/boot/dts/stm32f469-disco.dts              |    8 +-
 arch/arm/boot/dts/stm32f746.dtsi                   |    7 +-
 arch/arm/boot/dts/stm32f769-disco.dts              |    4 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |   10 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |    7 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi           |  258 ++-
 arch/arm/boot/dts/stm32mp151.dtsi                  |    4 +-
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |    2 +
 arch/arm/boot/dts/stm32mp157c-dk2.dts              |   11 +
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |    4 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   15 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   38 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts |   38 +
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi |   18 +-
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi   |   12 +
 arch/arm/boot/dts/tegra114-dalmore.dts             |  149 +-
 arch/arm/boot/dts/tegra114-roth.dts                |  141 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |   84 +-
 arch/arm/boot/dts/tegra114.dtsi                    |   48 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |    4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts    |    4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        |    5 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |    5 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  263 ++-
 arch/arm/boot/dts/tegra124-nyan-big.dts            |    3 +-
 arch/arm/boot/dts/tegra124-nyan-blaze.dts          |    1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  283 ++--
 arch/arm/boot/dts/tegra124-venice2.dts             |  284 ++--
 arch/arm/boot/dts/tegra124.dtsi                    |   59 +-
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts    | 1438 ++++++++++++++++
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts      |    2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts         |    2 +-
 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi   |   98 +-
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi             |   98 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |  140 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |   68 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |   61 +-
 arch/arm/boot/dts/tegra20-plutux.dts               |   66 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |  152 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   39 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |   66 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |  104 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |  106 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   91 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |    4 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts     |    8 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         |    5 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi              |    5 +-
 .../boot/dts/tegra30-asus-nexus7-grouper-E1565.dts |    9 +
 .../boot/dts/tegra30-asus-nexus7-grouper-PM269.dts |    9 +
 .../dts/tegra30-asus-nexus7-grouper-common.dtsi    | 1232 ++++++++++++++
 .../tegra30-asus-nexus7-grouper-maxim-pmic.dtsi    |  185 +++
 ...tegra30-asus-nexus7-grouper-memory-timings.dtsi | 1565 ++++++++++++++++++
 .../dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi   |  149 ++
 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi |  149 ++
 .../boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts |    9 +
 ...tegra30-asus-nexus7-tilapia-memory-timings.dtsi |  325 ++++
 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi |  235 +++
 arch/arm/boot/dts/tegra30-beaver.dts               |  212 ++-
 arch/arm/boot/dts/tegra30-cardhu-a02.dts           |  128 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts           |  149 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  280 ++--
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |    2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |    5 +-
 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi   |  398 ++---
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi             |  398 ++---
 arch/arm/boot/dts/tegra30.dtsi                     |  117 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi               |    2 +-
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |    6 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |    7 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |    5 +
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |    2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |    8 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |    2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   30 +
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |    2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |    2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |    6 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |   31 +-
 arch/arm/boot/dts/vf610-zii-cfu1.dts               |    2 +
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |    2 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |    2 +
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts           |   20 +-
 arch/arm/boot/dts/vf610-zii-spb4.dts               |   21 +
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts           |    5 +
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts          |   14 +
 arch/arm/boot/dts/vf610.dtsi                       |    2 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |   22 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   61 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   59 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  193 ---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  179 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  155 +-
 arch/arm64/boot/dts/Makefile                       |    2 +-
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 .../dts/allwinner/sun50i-a64-pinephone-1.1.dts     |   19 +
 .../dts/allwinner/sun50i-a64-pinephone-1.2.dts     |   40 +
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |   54 +-
 .../allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts  |    1 +
 .../boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi      |   79 +
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |    1 +
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |   38 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |   38 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |    2 +
 arch/arm64/boot/dts/{al => amazon}/Makefile        |    1 +
 .../boot/dts/{al => amazon}/alpine-v2-evp.dts      |    0
 arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi  |    0
 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts       |   24 +
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi          |  408 +++++
 arch/arm64/boot/dts/amlogic/Makefile               |    1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |    6 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   55 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts      |  136 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi   |    6 +-
 arch/arm64/boot/dts/amlogic/meson-gx-mali450.dtsi  |   61 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   18 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   63 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi    |   46 +-
 .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts   |    2 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi   |   23 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   17 +-
 .../boot/dts/amlogic/meson-gxm-wetek-core2.dts     |   87 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   45 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |   26 +-
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |   92 ++
 .../arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts |   88 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |   53 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |    6 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  111 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   15 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts  |   85 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |   39 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |    8 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  105 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  103 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   14 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   14 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts  |   36 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   71 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   26 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts       |   96 ++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      |    6 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   10 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   24 +-
 .../arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi |    2 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   40 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   10 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   83 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   34 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  428 +++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   10 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |   79 +
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts |    8 +
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   28 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   40 +
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |   18 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |    2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    4 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |    4 +-
 .../dts/mediatek/mt8183-kukui-krane-sku176.dts     |   18 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi      |  343 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  788 +++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   68 +-
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts     |  399 +++--
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |  205 ++-
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  111 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   80 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  124 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  125 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   16 +-
 .../dts/nvidia/tegra194-p3509-0000+p3668-0000.dts  |  331 ++++
 .../arm64/boot/dts/nvidia/tegra194-p3668-0000.dtsi |  290 ++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  280 +++-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   46 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |    6 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi     |   19 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  330 ++--
 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi     |  414 +++--
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |  277 ++--
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |  171 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   72 +-
 arch/arm64/boot/dts/qcom/Makefile                  |    8 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  262 ++-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   28 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  189 +++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   42 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  861 ++++------
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  150 +-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |   20 +-
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |   20 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   31 +
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |  245 ++-
 .../boot/dts/qcom/msm8992-msft-lumia-talkman.dts   |   39 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |   90 -
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |  364 +++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  566 +++++--
 .../arm64/boot/dts/qcom/msm8994-angler-rev-101.dts |    2 +
 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |   30 -
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      |  268 ---
 .../qcom/msm8994-sony-xperia-kitakami-sumire.dts   |   13 +
 .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi     |  235 +++
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  642 +++++++-
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi    |    2 +-
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      |    5 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi                |   50 +
 arch/arm64/boot/dts/qcom/pm660l.dtsi               |   36 +
 arch/arm64/boot/dts/qcom/pm8009.dtsi               |   37 +
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |   42 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |   44 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |   44 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |   12 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   15 +
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   19 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  604 ++++++-
 .../dts/qcom/sdm630-sony-xperia-ganges-kirin.dts   |   13 +
 .../boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi   |   40 +
 .../dts/qcom/sdm630-sony-xperia-nile-discovery.dts |   13 +
 .../dts/qcom/sdm630-sony-xperia-nile-pioneer.dts   |   13 +
 .../dts/qcom/sdm630-sony-xperia-nile-voyager.dts   |   20 +
 .../boot/dts/qcom/sdm630-sony-xperia-nile.dtsi     |  136 ++
 arch/arm64/boot/dts/qcom/sdm630.dtsi               | 1174 +++++++++++++
 .../dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts |   20 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  118 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  525 +++++-
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts            |   21 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 1038 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |   30 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 1717 ++++++++++++++++++--
 arch/arm64/boot/dts/renesas/Makefile               |   56 +-
 .../boot/dts/renesas/beacon-renesom-baseboard.dtsi |  758 +++++++++
 .../arm64/boot/dts/renesas/beacon-renesom-som.dtsi |  312 ++++
 arch/arm64/boot/dts/renesas/cat875.dtsi            |    1 -
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     |   71 +-
 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi       |   86 +
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi       |  124 ++
 .../boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi      |   52 +
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |   39 +-
 .../boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts |   29 +
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts        |   43 +-
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  |    6 +-
 .../r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts   |   15 +
 .../dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dts  |   20 +
 .../dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts     |   37 +
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts     |    6 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |   10 +-
 .../r8a774b1-hihope-rzg2n-ex-idk-1110wr.dts        |   15 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts  |    5 +-
 .../r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dts   |   15 +
 .../dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dts  |   15 +
 .../dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts     |   41 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts     |    6 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |   10 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |    6 +-
 .../boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts  |   15 +
 .../boot/dts/renesas/r8a774e1-hihope-rzg2h.dts     |   26 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi          | 1664 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |    8 +-
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |    8 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |   97 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |    8 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |   67 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   67 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   17 +
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |   67 +
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |   67 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |   17 +
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |    1 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |    6 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |    3 -
 arch/arm64/boot/dts/rockchip/px30.dtsi             |    7 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |    8 +-
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts |    1 -
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |    2 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   25 +-
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts |    8 +-
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |   10 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |    8 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |    4 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |    8 +-
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |   10 +-
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |    8 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |    6 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   99 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |    6 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   10 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |   22 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts  |    8 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |   20 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   19 +-
 .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts    |    6 +-
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |  206 ++-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |    2 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |    8 +-
 .../boot/dts/socionext/uniphier-ld20-akebi96.dts   |    2 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |    2 +-
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |    8 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |    2 +
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   10 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |    2 +
 arch/arm64/boot/dts/ti/Makefile                    |    2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   38 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |    2 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |    7 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |    2 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   27 +-
 arch/arm64/boot/dts/ti/k3-am654.dtsi               |    2 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  171 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  281 +++-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |    7 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |    2 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |    2 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/bus/ti-sysc.c                              |    6 +-
 drivers/clk/imx/clk-imx8mp.c                       |    1 +
 drivers/clk/imx/clk-vf610.c                        |    1 +
 drivers/soc/amlogic/meson-gx-socinfo.c             |    8 +-
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h      |   59 +
 include/dt-bindings/clock/vf610-clock.h            |    3 +-
 include/dt-bindings/mux/mux-j721e-wiz.h            |   53 +
 include/dt-bindings/pinctrl/k3.h                   |    2 +-
 include/dt-bindings/power/qcom-rpmpd.h             |    1 +
 include/dt-bindings/power/r8a774e1-sysc.h          |   36 +
 695 files changed, 37834 insertions(+), 7849 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/amazon,al.yaml
 create mode 100644
Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-mqs.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
 create mode 100644 arch/arm/boot/dts/rk3288-rock-pi-n8.dts
 create mode 100644 arch/arm/boot/dts/rk3288-vmarc-som.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644
arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
 create mode 100644
arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts
 create mode 100644
arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-memory-timings.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
 rename arch/arm64/boot/dts/{al => amazon}/Makefile (64%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-mali450.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
 create mode 100644
arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p3668-0000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-msft-lumia-talkman.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
 create mode 100644
arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm660.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm660l.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8009.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
 create mode 100644
arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630.dtsi
 create mode 100644
arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
 create mode 100644 arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dts
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dts
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1.dtsi
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
