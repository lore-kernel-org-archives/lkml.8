Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07DB206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgFDUu6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:50:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgFDUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:50:57 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGi6k-1jludF2idW-00DosL for <linux-kernel@vger.kernel.org>; Thu, 04 Jun
 2020 22:50:51 +0200
Received: by mail-qk1-f173.google.com with SMTP id n141so7649398qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:50:51 -0700 (PDT)
X-Gm-Message-State: AOAM5323Uhp1sJsbrSrKy9J6IOq+wjGMGAcC2vkOP1fvOOlHNzFY53Sj
        Cj+6GmMomcuZlGZzcWru2PaIqoEnVy0VwNpL3iM=
X-Google-Smtp-Source: ABdhPJwTYTlTgDge1atInPyOPB1ylGjtlgLyl4tSDoj0LlDsMmnQEu/mp+CAw3L576tPlm07WFt4KcVlxyweiwaQcRs=
X-Received: by 2002:a37:9401:: with SMTP id w1mr6630360qkd.286.1591303850419;
 Thu, 04 Jun 2020 13:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
In-Reply-To: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jun 2020 22:50:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com>
Message-ID: <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com>
Subject: [GIT PULL 1/4] ARM: SoC changes for v5.8
List-Id: <soc.lore.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:3R9Arimg2uSaELaGIvw8Urc4Obe12eoSinFc4rsUpE8wM6kCoLu
 ZCQWUGX0UEDjI0F3i15Tl1ptDBK6vt0PbEXj7iFR6F3odF5W8uozOXtN324IX4wNqkcuVwR
 tjCXjW7v4WWMwC8anvQWC3RF663Ai8nDgPOfrd2+bBr20BQrRsU5jIC15Y/odJKD2xt86pW
 xCchzot/FviuHacPOAALw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IYsOg0pumY0=:LwvzCO4hASF42jMqcMfMw8
 uXacvaC6nQ3NMVWn/mNoW6WA8XbxMn3jvff7zc6sC5cEBDMIEI+FY+vMJFViKCxEfj+UIBQ7t
 bTI26ualu/M2mMVCkWg/rHufdJAe6Ukov6gsgw/14l4bN+wxhRRTOlGo8J/cvk0e3h/z+cTMj
 gkSZX0NqcJwzNlidJsuxoWhTOt8r29+nZeYZbwcD1r0fQ/FmwDsEHL4jcR5ff7/GcLnk5KeAB
 EBfS/of6yqtYs0i/sEMLsuxWV4jDrZ8zhJqd4A+Ad/7h4mcWBb+5fem8S5xcWo6PBxU2QFarc
 yUgEuwd0+G9mZKG9b6jBwDX5A5f+KEUOtRR7ob3Z3xr7/WAR6ihgxX1dHeAYcgP1ElGSsbGTo
 aPiKMag1J8sfcF5QSukvZMZdptN8vCi9pdwtPFbRN2AqJ2roH8rDcppj/YlV1ZGRzdRAAOfOs
 ib9YBFW0vqXMgrJ17TJ18wXede2id630I8cXVh4Ab5RhO+ZdtaSUS+Aevpimbrvn97q4PmRTn
 L3aXrkQHsqYSjj//VLPegaZBbVNLRLcd4x573e9OsaS0aPgGMhtIJcBftIazs85atCYDDhXsp
 H10XiBrXrUpE7YhmDsRMwGF8s/IUgYRqXv/I8JnJ15H87JZJ4XKVxE+lj2YTDHkqLJAJmbxUh
 YZxl977cMTzxbf9VEKZQsVm9qVVxMolOrKgxc8SxcJdZ3Er5SWePQ4rHVgDaryEAK0d44ecEn
 Cpc5ixsIYgwPHodpYD8/C6AXKoUhMEYXKBaGSFlSJ8Dua2FGqt8PLgE5LyQOiTMRvXzxq9yXR
 ZXfMTo4Wk1XLPbvpdrNTEYD2kcoRyfVTWyhCiqIZwoWBAj0mZY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-soc-5.8

for you to fetch changes up to d2353bad2c1eef7a1228645fbb21e7887c633d12:

  ARM: omap2: fix omap5_realtime_timer_init definition (2020-06-02
19:14:21 +0200)

----------------------------------------------------------------
ARM: SoC changes for v5.8

One new platform gets added, the Realtek RTD1195, which is an older
Cortex-a7 based relative of the RTD12xx chips that are already supported
in arch/arm64. The platform may also be extended to support running
32-bit kernels on those 64-bit chips for memory-constrained machines.

In the Renesas shmobile platform, we gain support for "RZ/G1H" or R8A7742,
an eight-core chip based on Cortex-A15 and Cortex-A7 cores, originally
released in 2016 as one of the last high-end 32-bit designs.

There is ongoing cleanup for the integrator, tegra, imx, and omap2
platforms, with integrator getting very close to the goal of having
zero code in arch/arm/, and omap2 moving more of the chip specifics
from old board code into device tree files.

The Versatile Express platform is made more modular, with built-in
drivers now becoming loadable modules. This is part of a greater effort
for the Android OS to have a common kernel binary for all platforms and
any platform specific code in loadable modules.

The PXA platform drops support for Compulab's pxa2xx boards that had
rather unusual flash and PCI drivers but no known users remaining.
All device drivers specific to those boards can now get removed as
well.

Across platforms, there is ongoing cleanup, with Geert and Rob
revisiting some a lot of Kconfig options.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anders Roxell (4):
      Revert "ARM: vexpress: Don't select VEXPRESS_CONFIG"
      power: vexpress: add suppress_bind_attrs to true
      power: vexpress: cleanup: use builtin_platform_driver
      power: reset: vexpress: fix build issue

Andreas Färber (2):
      ARM: Prepare Realtek RTD1195
      MAINTAINERS: Add Realtek arm DT files

Andrey Smirnov (1):
      ARM: vf610: report soc info via soc device

Arnd Bergmann (16):
      Merge tag 'versatile-v5.8-1' of
git://git.kernel.org/.../linusw/linux-integrator into arm/soc
      Merge tag 'renesas-arm-soc-for-v5.8-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/soc
      Merge tag 'realtek-soc-for-5.8' of
git://git.kernel.org/.../afaerber/linux-realtek into arm/soc
      Merge tag 'arm-soc/for-5.8/maintainers' of
https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'arm-soc/for-5.8/soc' of
https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'samsung-soc-5.8' of
git://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'omap-for-v5.8/soc-signed-take2' of
git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'vexpress-modules-for-soc-v2' of
git://git.kernel.org/.../robh/linux into arm/soc
      Merge tag 'renesas-arm-soc-for-v5.8-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/soc
      Merge tag 'tegra-for-5.8-arm-core' of
git://git.kernel.org/.../tegra/linux into arm/soc
      Merge tag 'imx-soc-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/soc
      Merge tag 'omap-for-v5.8/timer-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'mvebu-arm-5.8-1' of
git://git.infradead.org/linux-mvebu into arm/soc
      Merge tag 'v5.8-rockchip-soc32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/soc
      ARM: davinci: fix build failure without I2C
      ARM: omap2: fix omap5_realtime_timer_init definition

Colin Ian King (1):
      ARM: rockchip: fix spelling mistake "to" -> "too"

Dmitry Osipenko (7):
      firmware: tf: Different way of L2 cache enabling after LP2 suspend
      ARM: tegra: Initialize r0 register for firmware wake-up
      ARM: tegra: Do not fully reinitialize L2 on resume
      ARM: tegra: Correct PL310 Auxiliary Control Register initialization
      ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
      ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
      ARM: tegra: Create tegra20-cpufreq platform device on Tegra30

Florian Fainelli (1):
      ARM: mm: Remove virtual address print from B15 RAC driver

Geert Uytterhoeven (19):
      ARM: rockchip: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: integrator: Drop unneeded select of SPARSE_IRQ
      ARM: realview: Drop unneeded select of multi-platform features
      ARM: omap2plus: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
      ARM/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: mediatek: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: mmp: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: arch timer: Drop unneeded select GENERIC_CLOCKEVENTS
      ARM: actions: Drop unneeded select of COMMON_CLK
      ARM: alpine: Drop unneeded select of HAVE_SMP
      ARM: asm9260: Drop unneeded select of GENERIC_CLOCKEVENTS
      ARM: aspeed: Drop unneeded select of HAVE_SMP
      ARM: berlin: Drop unneeded select of HAVE_SMP
      ARM: clps711x: Drop unneeded select of multi-platform selected options
      ARM: davinci: Drop unneeded select of TIMER_OF
      ARM: mmp: Drop unneeded select of COMMON_CLK
      ARM: mvebu: Drop unneeded select of HAVE_SMP
      ARM: prima2: Drop unneeded select of HAVE_SMP
      ARM: socfpga: Drop unneeded select of PCI_DOMAINS_GENERIC

Lad Prabhakar (2):
      ARM: shmobile: r8a7742: Basic SoC support
      ARM: debug-ll: Add support for r8a7742

Linus Walleij (4):
      bus: Add DT bindings for Integrator/AP logic modules
      bus: Add driver for Integrator/AP logic modules
      ARM: integrator: Retire LM and IM-PD1 boardfile code
      ARM: integrator: Add some Kconfig selections

Lukas Bulwahn (2):
      MAINTAINERS: adjust to renaming physmap_of_versatile.c
      MAINTAINERS: clarify maintenance of ARM Dove drivers

Ma Feng (2):
      ARM: omap2: make omap5_erratum_workaround_801819 static
      ARM: imx: pcm037: make pcm970_sja1000_platform_data static

Nicolas Saenz Julienne (1):
      MAINTAINERS: Update Raspberry Pi development repository

Peng Fan (3):
      ARM: imx: use device_initcall for imx_soc_device_init
      ARM: imx: move cpu definitions into a header
      soc: imx: move cpu code to drivers/soc/imx

Rob Herring (21):
      ARM: versatile: Remove dead sched_clock code
      ARM: versatile: Drop mapping IB2 module registers
      ARM: vexpress: Move vexpress_flags_set() into arch code
      arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
      amba: Retry adding deferred devices at late_initcall
      clk: versatile: Rework kconfig structure
      clk: versatile: Only enable SP810 on 32-bit by default
      clk: vexpress-osc: Use the devres clock API variants
      clk: vexpress-osc: Support building as a module
      mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
      mfd: vexpress-sysreg: Drop unused syscon child devices
      mfd: vexpress-sysreg: Use devres API variants
      mfd: vexpress-sysreg: Support building as a module
      bus: vexpress-config: Merge vexpress-syscfg into vexpress-config
      bus: vexpress-config: simplify config bus probing
      vexpress: Move setting master site to vexpress-config bus
      bus: vexpress-config: Support building as module
      ARM: vexpress: Don't select VEXPRESS_CONFIG
      clk: versatile: Drop the legacy IM-PD1 clock code
      clk: versatile: Fix kconfig dependency on COMMON_CLK_VERSATILE
      ARM: zynq: Don't select CONFIG_ICST

Robert Jarzmik (2):
      ARM: pxa: remove Compulab pxa2xx boards
      MAINTAINERS: pxa: remove Compulab arm/pxa support

Samuel Zou (1):
      ARM: OMAP2+: pm33xx-core: Make am43xx_get_rtc_base_addr static

Stefan Agner (1):
      ARM: OMAP2+: drop unnecessary adrl

Tang Bin (2):
      ARM: samsung: Omit superfluous error message in s3c_adc_probe()
      ARM: samsung: Use devm_platform_ioremap_resource() to simplify code

Thierry Reding (2):
      firmware: tegra: Make BPMP a regular driver
      Merge branch 'for-5.8/firmware' into for-5.8/arm/core

Tony Lindgren (16):
      clocksource/drivers/timer-ti-32k: Add support for initializing directly
      clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
      clocksource/drivers/timer-ti-dm: Fix warning for set but not used
      clk: ti: dm816: enable sysclk6_ck on init
      bus: ti-sysc: Ignore timer12 on secure omap3
      ARM: OMAP2+: Add omap_init_time_of()
      ARM: dts: Configure system timers for am335x
      ARM: dts: Configure system timers for am437x
      ARM: dts: Configure system timers for omap4
      ARM: dts: Configure system timers for omap5 and dra7
      ARM: dts: Configure system timers for omap3
      ARM: dts: Configure system timers for ti81xx
      ARM: dts: Configure system timers for omap2
      ARM: OMAP2+: Drop old timer code for dmtimer and 32k counter
      bus: ti-sysc: Timers no longer need legacy quirk handling
      ARM: OMAP2+: Fix regression for using local timer on non-SMP SoCs

Wei Yongjun (1):
      bus: arm-integrator-lm: Fix return value check in integrator_ap_lm_probe()

Wolfram Sang (1):
      ARM: s3c64xx: convert to use i2c_new_client_device()

 .../bindings/bus/arm,integrator-ap-lm.yaml         |   83 ++
 MAINTAINERS                                        |   13 +-
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/Kconfig.debug                             |   10 +
 arch/arm/Makefile                                  |    3 +
 arch/arm/boot/dts/am33xx-l4.dtsi                   |    6 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   20 +
 arch/arm/boot/dts/am3517.dtsi                      |   24 +-
 arch/arm/boot/dts/am4372.dtsi                      |   20 +
 arch/arm/boot/dts/am437x-l4.dtsi                   |    7 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   74 +-
 arch/arm/boot/dts/dm816x.dtsi                      |   78 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |    7 +-
 arch/arm/boot/dts/dra7.dtsi                        |   10 +
 arch/arm/boot/dts/omap2.dtsi                       |   31 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   68 +-
 arch/arm/boot/dts/omap2430.dtsi                    |   68 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   33 +
 arch/arm/boot/dts/omap3-devkit8000.dts             |   33 +
 arch/arm/boot/dts/omap3.dtsi                       |  134 +-
 arch/arm/boot/dts/omap4-l4.dtsi                    |    4 +-
 arch/arm/boot/dts/omap4.dtsi                       |   10 +
 arch/arm/boot/dts/omap5-l4.dtsi                    |    4 +-
 arch/arm/boot/dts/omap5.dtsi                       |   10 +
 arch/arm/configs/cm_x2xx_defconfig                 |  173 ---
 arch/arm/configs/em_x270_defconfig                 |  178 ---
 arch/arm/configs/pxa_defconfig                     |    2 -
 arch/arm/kernel/time.c                             |    2 +-
 arch/arm/mach-actions/Kconfig                      |    1 -
 arch/arm/mach-alpine/Kconfig                       |    1 -
 arch/arm/mach-asm9260/Kconfig                      |    1 -
 arch/arm/mach-aspeed/Kconfig                       |    1 -
 arch/arm/mach-berlin/Kconfig                       |    1 -
 arch/arm/mach-clps711x/Kconfig                     |    5 -
 arch/arm/mach-davinci/Kconfig                      |    1 -
 arch/arm/mach-davinci/board-dm644x-evm.c           |   26 +-
 arch/arm/mach-imx/common.h                         |    1 -
 arch/arm/mach-imx/cpu.c                            |  159 ---
 arch/arm/mach-imx/mach-imx6q.c                     |    8 +-
 arch/arm/mach-imx/mach-imx6sl.c                    |    8 +-
 arch/arm/mach-imx/mach-imx6sx.c                    |    8 +-
 arch/arm/mach-imx/mach-imx6ul.c                    |    8 +-
 arch/arm/mach-imx/mach-imx7d.c                     |    6 -
 arch/arm/mach-imx/mach-imx7ulp.c                   |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                    |    2 +-
 arch/arm/mach-imx/mach-vf610.c                     |   47 +
 arch/arm/mach-imx/mxc.h                            |   22 +-
 arch/arm/mach-integrator/Kconfig                   |    9 +-
 arch/arm/mach-integrator/Makefile                  |    3 +-
 arch/arm/mach-integrator/impd1.c                   |  475 --------
 arch/arm/mach-integrator/impd1.h                   |   15 -
 arch/arm/mach-integrator/integrator_ap.c           |   31 -
 arch/arm/mach-integrator/lm.c                      |   96 --
 arch/arm/mach-integrator/lm.h                      |   24 -
 arch/arm/mach-mediatek/mediatek.c                  |    2 +-
 arch/arm/mach-mmp/Kconfig                          |    1 -
 arch/arm/mach-mmp/mmp-dt.c                         |    2 +-
 arch/arm/mach-mmp/mmp2-dt.c                        |    2 +-
 arch/arm/mach-mvebu/Kconfig                        |    3 -
 arch/arm/mach-omap2/Kconfig                        |    1 -
 arch/arm/mach-omap2/Makefile                       |    6 +-
 arch/arm/mach-omap2/board-generic.c                |   39 +-
 arch/arm/mach-omap2/common.h                       |    7 +
 arch/arm/mach-omap2/omap-smp.c                     |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   20 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 -
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    8 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   47 -
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |    2 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |    8 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   62 -
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   10 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  146 +--
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   45 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   90 --
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   89 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  176 ---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   74 --
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    3 -
 arch/arm/mach-omap2/pm33xx-core.c                  |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
 arch/arm/mach-omap2/timer.c                        |  577 +--------
 arch/arm/mach-prima2/Kconfig                       |    1 -
 arch/arm/mach-pxa/Kconfig                          |   17 -
 arch/arm/mach-pxa/Makefile                         |    5 -
 arch/arm/mach-pxa/cm-x255.c                        |  240 ----
 arch/arm/mach-pxa/cm-x270.c                        |  419 -------
 arch/arm/mach-pxa/cm-x2xx-pci.c                    |  196 ---
 arch/arm/mach-pxa/cm-x2xx-pci.h                    |   14 -
 arch/arm/mach-pxa/cm-x2xx.c                        |  538 --------
 arch/arm/mach-pxa/em-x270.c                        | 1286 --------------------
 arch/arm/mach-pxa/include/mach/io.h                |   18 -
 arch/arm/mach-realtek/Kconfig                      |   11 +
 arch/arm/mach-realtek/Makefile                     |    2 +
 arch/arm/mach-realtek/rtd1195.c                    |   40 +
 arch/arm/mach-realview/Kconfig                     |   10 -
 arch/arm/mach-rockchip/platsmp.c                   |    2 +-
 arch/arm/mach-rockchip/rockchip.c                  |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |    7 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    2 +
 arch/arm/mach-socfpga/Kconfig                      |    1 -
 arch/arm/mach-tegra/pm.c                           |    4 +
 arch/arm/mach-tegra/reset-handler.S                |    7 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |   16 +-
 arch/arm/mach-tegra/tegra.c                        |    8 +-
 arch/arm/mach-versatile/Kconfig                    |    1 -
 arch/arm/mach-versatile/versatile_dt.c             |    5 -
 arch/arm/mach-vexpress/Kconfig                     |    3 -
 arch/arm/mach-vexpress/core.h                      |    1 +
 arch/arm/mach-vexpress/dcscb.c                     |    1 +
 arch/arm/mach-vexpress/v2m.c                       |   23 +
 arch/arm/mach-zynq/Kconfig                         |    1 -
 arch/arm/mm/cache-b15-rac.c                        |    3 +-
 arch/arm/plat-samsung/adc.c                        |    8 +-
 arch/arm/plat-versatile/Kconfig                    |    7 -
 arch/arm/plat-versatile/Makefile                   |    1 -
 arch/arm/plat-versatile/include/plat/sched_clock.h |    7 -
 arch/arm/plat-versatile/sched-clock.c              |   28 -
 arch/arm64/Kconfig.platforms                       |    3 -
 drivers/amba/bus.c                                 |   14 +-
 drivers/bus/Kconfig                                |   11 +-
 drivers/bus/Makefile                               |    2 +-
 drivers/bus/arm-integrator-lm.c                    |  128 ++
 drivers/bus/ti-sysc.c                              |   25 +-
 drivers/bus/vexpress-config.c                      |  354 ++++--
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/ti/clk-816x.c                          |    1 +
 drivers/clk/versatile/Kconfig                      |   21 +-
 drivers/clk/versatile/clk-impd1.c                  |  121 --
 drivers/clk/versatile/clk-vexpress-osc.c           |   20 +-
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-ti-32k.c                 |   48 +-
 drivers/clocksource/timer-ti-dm-systimer.c         |  727 +++++++++++
 drivers/firmware/tegra/bpmp.c                      |    9 +-
 drivers/firmware/trusted_foundations.c             |   21 +-
 drivers/mfd/Kconfig                                |    5 +-
 drivers/mfd/vexpress-sysreg.c                      |   99 +-
 drivers/misc/Kconfig                               |    9 -
 drivers/misc/Makefile                              |    1 -
 drivers/misc/vexpress-syscfg.c                     |  280 -----
 drivers/power/reset/Kconfig                        |    2 +-
 drivers/power/reset/vexpress-poweroff.c            |    8 +-
 drivers/soc/imx/Makefile                           |    3 +
 drivers/soc/imx/soc-imx.c                          |  192 +++
 include/linux/firmware/trusted_foundations.h       |    1 +
 include/linux/platform_data/clk-integrator.h       |    2 -
 include/linux/vexpress.h                           |   30 -
 include/soc/imx/cpu.h                              |   36 +
 148 files changed, 2394 insertions(+), 6232 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.yaml
 delete mode 100644 arch/arm/configs/cm_x2xx_defconfig
 delete mode 100644 arch/arm/configs/em_x270_defconfig
 delete mode 100644 arch/arm/mach-integrator/impd1.c
 delete mode 100644 arch/arm/mach-integrator/impd1.h
 delete mode 100644 arch/arm/mach-integrator/lm.c
 delete mode 100644 arch/arm/mach-integrator/lm.h
 delete mode 100644 arch/arm/mach-pxa/cm-x255.c
 delete mode 100644 arch/arm/mach-pxa/cm-x270.c
 delete mode 100644 arch/arm/mach-pxa/cm-x2xx-pci.c
 delete mode 100644 arch/arm/mach-pxa/cm-x2xx-pci.h
 delete mode 100644 arch/arm/mach-pxa/cm-x2xx.c
 delete mode 100644 arch/arm/mach-pxa/em-x270.c
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/rtd1195.c
 delete mode 100644 arch/arm/plat-versatile/Kconfig
 delete mode 100644 arch/arm/plat-versatile/include/plat/sched_clock.h
 delete mode 100644 arch/arm/plat-versatile/sched-clock.c
 create mode 100644 drivers/bus/arm-integrator-lm.c
 create mode 100644 drivers/clocksource/timer-ti-dm-systimer.c
 delete mode 100644 drivers/misc/vexpress-syscfg.c
 create mode 100644 drivers/soc/imx/soc-imx.c
 delete mode 100644 include/linux/platform_data/clk-integrator.h
 create mode 100644 include/soc/imx/cpu.h
