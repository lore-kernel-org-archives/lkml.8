Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E99206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgDCVc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:32:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:32:25 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mk1BG-1iw6SV1DdA-00kN7q for <linux-kernel@vger.kernel.org>; Fri, 03 Apr
 2020 23:32:23 +0200
Received: by mail-qk1-f171.google.com with SMTP id b62so9723758qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:32:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuZk49O+2eOgDe6wsX+sHx9NkKEFNsJJAisjm0PtCIEw8YRiFngR
        ypxUnLNawh/GmWl1NXqnhqM1kQEBCl4iyk0R4MM=
X-Google-Smtp-Source: APiQypIw1+/5MZVGthm6xQ9mSafhEM5lNhCgHclDp2ph/giU4dB5oFYo0ljpHAJ8d34mUcEBfKhTqSs0V4r85UKQHic=
X-Received: by 2002:a37:3c1:: with SMTP id 184mr9682491qkd.352.1585949542026;
 Fri, 03 Apr 2020 14:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Apr 2020 23:32:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39t9wZvLMOayx4RSGZ0N+bKjgVw=fwEB=u=UvfnnHHpQ@mail.gmail.com>
Message-ID: <CAK8P3a39t9wZvLMOayx4RSGZ0N+bKjgVw=fwEB=u=UvfnnHHpQ@mail.gmail.com>
Subject: [GIT PULL 1/4] ARM: SoC updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xauwIELELYcMeAGwgxDofcO/r7i35m+HQ/005/DTPiY1GB4skpi
 VmxUhxd5Fxsf7YYLHAKqjYuTosyNE5J0/G1vwSw9B/GL1F6eA6p3kmRaV5PuC55/yHc+2QO
 Wq/PzhovTZDuCztMFXAyXKJEn8eC29/GsC2clS4YG/mDvlx4g0T5SNo9op+ffuwpyzEyEhV
 GhVWeBT5uRv4aIFDcBxKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i4P1IkbQTTY=:ryQBdo+gXLkr64GtIrl31k
 EttusqctJZirBw55wGcY0XrxASBMsntZ1IuyRVEyGJte5Rs8+7qD+jPa/qsl42FE+9NWXOSAN
 ND9YOW0nrIFdiWyNOXiApZv7pdHwj6NUryRutAafSoJFXhbe+QIYLV0s459Sk23x0HFKkaMlr
 On4tY7eyPZkem9KaxfoJIBy53ptKhLDCDev0dqMmpJ/ZyO4WsvDku/FG5p8SMYUOvhzCGcHrU
 XLoS+6z3KFzScIiqBK4xu3BE82xCKz7IWTCC+AOM7aon6dt72ZcE/qxERqtLp/YAPAStwx88s
 VTwhe6dAQCLfDM6L8WNWZdpmiCVj3o8M5DsZ8/O1Eqjon+VreWEIT/cBo6ObxXY8bk9VlXL57
 9Bv8pufMe4a2WwF8y4Xoq1DhkkWH1gNrsFkS0NEB3C5P687mLNxUBoMVWQwXd5PlHn9Qfw9RH
 wNqzXRCCc29U44Kf1iGhp1ciRwEy+UHMAs/nQn8HgUGiNHcgXa1A+Hkz3QnlNE433/Fjd7mA2
 0BoQzetjz2EuEE2tsfTJjUe705FvDYHuWdc4/CZX8CdpqaohtNPJGtF/IfXIztuUdODMZbJwm
 1jLfNs+jHos0NiURvf60wX1fhmOBGKc5vhhTqPuyPleCbJsVws9zOElTuH/Zgx9tA2+ZRXt5a
 oIrODMwxUVWvXTd8ZApDJF2WUPbjDHc0MBX7mfOclzNeRwCsZLWJmUUVV27ktbfJmu9oLzVYG
 lJEGwLsG9vMj2i9wthERSBeMPcw24WZlI6ngLP3EPQE1PvfPN20QHrkl9zhfwOEl9z0G6Xhah
 pdLYoTvVzF+paHympoggjzUDwGu9W/mx/Ly6zzejL6Wu7eV52k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-soc-5.7

for you to fetch changes up to f125e2d4339dda6937865f975470b29c84714c9b:

  ARM: qcom: Add support for IPQ40xx (2020-03-31 21:03:27 +0200)

----------------------------------------------------------------
ARM: SoC updates

The code changes are mostly for 32-bit platforms and include:

- Lots of updates for the Nvidia Tegra platform, including
  cpuidle, pmc, and dt-binding changes

- Microchip at91 power management updates for the recently added
  sam9x60 SoC

- Treewide setup_irq deprecation by afzal mohammed

- STMicroelectronics stm32 gains earlycon support

- Renesas platforms with Cortex-A9 can now use the global timer

- Some TI OMAP2+ platforms gain cpuidle support

- Various cleanups for the i.MX6 and Orion platforms, as well as
  Kconfig files across all platforms

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (6):
      ARM: imx: Remove unused include of linux/irqchip/arm-gic.h
      ARM: imx: Remove unused includes on mach-imx6q.c
      ARM: imx: Remove unused include of linux/of.h on mach-imx6sl.c
      ARM: imx: Add missing of_node_put()
      ARM: imx: Remove unnecessary blank lines
      ARM: imx: Drop unnecessary src_base check

Argus Lin (3):
      dt-bindings: pwrap: mediatek: add pwrap support for MT6779
      soc: mediatek: pwrap: add pwrap driver for MT6779 SoCs
      soc: mediatek: pwrap: add support for MT6359 PMIC

Arnd Bergmann (16):
      Merge tag 'renesas-arm-soc-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/soc
      Merge tag 'omap-for-v5.7/soc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'omap-for-v5.7/pm33xx-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'arm-soc/for-5.7/soc' of
https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'arm-soc/for-5.7/soc-arm64' of
https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'sunxi-core-for-5.7' of
git://git.kernel.org/.../sunxi/linux into arm/soc
      Merge tag 'stm32-soc-for-v5.7-1' of
git://git.kernel.org/.../atorgue/stm32 into arm/soc
      Merge tag 'tegra-for-5.7-soc' of
git://git.kernel.org/.../tegra/linux into arm/soc
      Merge tag 'tegra-for-5.7-arm-core' of
git://git.kernel.org/.../tegra/linux into arm/soc
      Merge tag 'mvebu-arm-5.7-1' of
git://git.infradead.org/linux-mvebu into arm/soc
      Merge tag 'imx-soc-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/soc
      Merge tag 'v5.6-next-soc' of
git://git.kernel.org/.../matthias.bgg/linux into arm/soc
      Merge tag 'at91-5.7-soc' of git://git.kernel.org/.../at91/linux
into arm/soc
      Merge tag 'zynq-soc-for-v5.7' of
https://github.com/Xilinx/linux-xlnx into arm/soc
      Merge tag 'zynqmp-soc-for-v5.7' of
https://github.com/Xilinx/linux-xlnx into arm/soc
      Merge tag 'tegra-for-5.7-cpuidle' of
git://git.kernel.org/.../tegra/linux into arm/soc

Bibby Hsieh (1):
      soc: mediatek: knows_txdone needs to be set in Mediatek CMDQ helper

Christian Lamparter (1):
      ARM: qcom: Add support for IPQ40xx

Claudiu Beznea (8):
      ARM: at91: pm: use proper master clock register offset
      ARM: at91: pm: revert do not disable/enable PLLA for ULP modes
      ARM: at91: pm: add macros for plla disable/enable
      ARM: at91: pm: add pmc_version member to at91_pm_data
      ARM: at91: pm: s/sfr/sfrbu in pm_suspend.S
      clk: at91: move sam9x60's PLL register offsets to PMC header
      ARM: at91: pm: add plla disable/enable support for sam9x60
      ARM: at91: pm: add quirk for sam9x60's ulp1

Dave Gerlach (5):
      dt-bindings: arm: cpu: Add TI AM335x and AM437x enable method
      ARM: OMAP2+: pm33xx-core: Add cpuidle_ops for am335x/am437x
      ARM: OMAP2+: pm33xx-core: Extend platform_data ops for cpuidle
      soc: ti: pm33xx: Add base cpuidle support
      ARM: omap2plus_defconfig: Add CONFIG_ARM_CPUIDLE

Dmitry Osipenko (15):
      ARM: tegra: Compile sleep-tegra20/30.S unconditionally
      ARM: tegra: Add tegra_pm_park_secondary_cpu()
      ARM: tegra: Remove pen-locking from cpuidle-tegra20
      ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
      ARM: tegra: Propagate error from tegra_idle_lp2_last()
      ARM: tegra: Expose PM functions required for new cpuidle driver
      ARM: tegra: Rename some of the newly exposed PM functions
      ARM: tegra: Make outer_disable() open-coded
      ARM: tegra: cpuidle: Handle case where secondary CPU hangs on entering LP2
      ARM: tegra: cpuidle: Make abort_flag atomic
      ARM: tegra: cpuidle: Remove unnecessary memory barrier
      cpuidle: Refactor and move out NVIDIA Tegra20 driver into drivers/cpuidle
      cpuidle: tegra: Squash Tegra30 driver into the common driver
      cpuidle: tegra: Squash Tegra114 driver into the common driver
      cpuidle: tegra: Disable CC6 state if LP2 unavailable

Erwan Le Ray (4):
      ARM: debug: stm32: add UART early console configuration for STM32F4
      ARM: debug: stm32: add UART early console configuration for STM32F7
      ARM: debug: stm32: add UART early console support for STM32H7
      ARM: debug: stm32: add UART early console support for STM32MP1

Geert Uytterhoeven (8):
      ARM: shmobile: Enable ARM_GLOBAL_TIMER on Cortex-A9 MPCore SoCs
      ARM: at91: Drop unneeded select of COMMON_CLK
      ARM: sunxi: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: zynq: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: shmobile: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      ARM: orion5x: Drop unneeded select of PCI_DOMAINS_GENERIC
      arm64: bcm2835: Drop select of nonexistent HAVE_ARM_ARCH_TIMER
      ARM: bcm: Drop unneeded select of PCI_DOMAINS_GENERIC, HAVE_SMP, TIMER_OF

JC Kuo (1):
      dt-bindings: phy: tegra: Add Tegra194 support

Nagarjuna Kristam (2):
      dt-bindings: phy: tegra-xusb: Add usb-role-switch
      dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding

Sowjanya Komatineni (6):
      dt-bindings: clock: tegra: Add IDs for OSC clocks
      dt-bindings: tegra: Convert Tegra PMC bindings to YAML
      dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
      dt-bindings: soc: tegra-pmc: Add ID for Tegra PMC 32 kHz blink clock
      soc/tegra: Add Tegra PMC clocks registration into PMC driver
      soc/tegra: Add support for 32 kHz blink clock

Stefan Agner (1):
      ARM: imx: limit errata selection to Cortex-A9 based designs

Tejas Patel (2):
      include: linux: firmware: Correct config dependency of zynqmp_eemi_ops
      arm64: zynqmp: Make zynqmp_firmware driver optional

Thierry Reding (3):
      Merge branch 'for-5.7/dt-bindings' into for-5.7/soc
      soc/tegra: pmc: Cleanup whitespace usage
      Merge branch 'for-5.7/arm/core' into for-5.7/cpuidle

Tony Lindgren (2):
      ARM: OMAP2+: Improve handling of ti-sysc related sysc_fields
      Merge branch 'omap-for-v5.7/omap1' into omap-for-v5.7/soc

Venkat Reddy Talla (1):
      soc/tegra: pmc: Add pins for Tegra194

Vincenzo Frascino (1):
      arm: mach-dove: Mark dove_io_desc as __maybe_unused

Xu Wang (1):
      ARM: orion5x: ts78xx: Remove unneeded variable ret

afzal mohammed (7):
      ARM: OMAP: replace setup_irq() by request_irq()
      ARM: orion: replace setup_irq() by request_irq()
      ARM: iop32x: replace setup_irq() by request_irq()
      ARM: ep93xx: Replace setup_irq() by request_irq()
      ARM: spear: replace setup_irq() by request_irq()
      ARM: cns3xxx: replace setup_irq() by request_irq()
      ARM: mmp: replace setup_irq() by request_irq()

 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 300 ---------
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     | 354 +++++++++++
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |  24 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   1 +
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 ++++++
 arch/arm/Kconfig.debug                             |  42 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/configs/omap2plus_defconfig               |   2 +
 arch/arm/include/debug/stm32.S                     |   9 +-
 arch/arm/mach-at91/Kconfig                         |   1 -
 arch/arm/mach-at91/pm.c                            |  35 +-
 arch/arm/mach-at91/pm.h                            |   2 +
 arch/arm/mach-at91/pm_data-offsets.c               |   4 +
 arch/arm/mach-at91/pm_suspend.S                    | 189 +++++-
 arch/arm/mach-bcm/Kconfig                          |   8 -
 arch/arm/mach-cns3xxx/core.c                       |  10 +-
 arch/arm/mach-dove/common.c                        |   2 +-
 arch/arm/mach-ep93xx/timer-ep93xx.c                |  14 +-
 arch/arm/mach-imx/Kconfig                          |  10 +-
 arch/arm/mach-imx/anatop.c                         |   7 +-
 arch/arm/mach-imx/gpc.c                            |   4 +-
 arch/arm/mach-imx/mach-imx6q.c                     |  13 -
 arch/arm/mach-imx/mach-imx6sl.c                    |   1 -
 arch/arm/mach-imx/mach-imx6ul.c                    |   1 -
 arch/arm/mach-imx/platsmp.c                        |   1 +
 arch/arm/mach-imx/pm-imx6.c                        |   2 +
 arch/arm/mach-imx/pm-imx7ulp.c                     |   1 +
 arch/arm/mach-imx/src.c                            |   3 -
 arch/arm/mach-iop32x/time.c                        |  12 +-
 arch/arm/mach-mmp/time.c                           |  11 +-
 arch/arm/mach-omap1/pm.c                           |  13 +-
 arch/arm/mach-omap1/time.c                         |  10 +-
 arch/arm/mach-omap1/timer32k.c                     |  10 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  19 +-
 arch/arm/mach-omap2/pm33xx-core.c                  | 137 +++-
 arch/arm/mach-omap2/timer.c                        |  11 +-
 arch/arm/mach-orion5x/Kconfig                      |   2 -
 arch/arm/mach-orion5x/ts78xx-setup.c               |   3 +-
 arch/arm/mach-qcom/Kconfig                         |   5 +
 arch/arm/mach-shmobile/setup-r8a7779.c             |   1 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |   1 -
 arch/arm/mach-spear/time.c                         |   9 +-
 arch/arm/mach-sunxi/sunxi.c                        |   2 +-
 arch/arm/mach-tegra/Makefile                       |  19 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c             |  89 ---
 arch/arm/mach-tegra/cpuidle-tegra20.c              | 212 -------
 arch/arm/mach-tegra/cpuidle-tegra30.c              | 132 ----
 arch/arm/mach-tegra/cpuidle.c                      |  50 --
 arch/arm/mach-tegra/cpuidle.h                      |  21 -
 arch/arm/mach-tegra/irq.c                          |   3 +-
 arch/arm/mach-tegra/pm.c                           |  54 +-
 arch/arm/mach-tegra/pm.h                           |   4 -
 arch/arm/mach-tegra/reset-handler.S                |  11 -
 arch/arm/mach-tegra/reset.h                        |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S                | 170 -----
 arch/arm/mach-tegra/sleep-tegra30.S                |   6 +-
 arch/arm/mach-tegra/sleep.h                        |  15 -
 arch/arm/mach-tegra/tegra.c                        |   7 +-
 arch/arm/mach-zynq/common.c                        |   2 +-
 arch/arm/plat-orion/time.c                         |  10 +-
 arch/arm64/Kconfig.platforms                       |   2 -
 drivers/clk/at91/clk-sam9x60-pll.c                 |  91 ++-
 drivers/cpuidle/Kconfig.arm                        |   8 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-tegra.c                    | 392 ++++++++++++
 drivers/firmware/xilinx/Kconfig                    |   2 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 128 ++++
 drivers/soc/renesas/Kconfig                        |   2 +
 drivers/soc/tegra/pmc.c                            | 688 ++++++++++++++++-----
 drivers/soc/ti/pm33xx.c                            |  21 +-
 include/dt-bindings/clock/tegra114-car.h           |   4 +-
 include/dt-bindings/clock/tegra124-car-common.h    |   4 +-
 include/dt-bindings/clock/tegra210-car.h           |   4 +-
 include/dt-bindings/clock/tegra30-car.h            |   4 +-
 include/dt-bindings/soc/tegra-pmc.h                |  16 +
 include/linux/clk/at91_pmc.h                       |  23 +
 include/linux/firmware/xlnx-zynqmp.h               |   2 +-
 include/linux/platform_data/pm33xx.h               |   6 +-
 include/soc/tegra/cpuidle.h                        |   2 +-
 {arch/arm/mach-tegra => include/soc/tegra}/irq.h   |   8 +-
 include/soc/tegra/pm.h                             |  31 +
 include/soc/tegra/pmc.h                            |   3 +-
 85 files changed, 2290 insertions(+), 1448 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
 create mode 100644
Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)
