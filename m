Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09189206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591743245;
	bh=nVuBqbkV/uv74u3QW2uddNsqQSwQmtQDFLo+qHJ3u5Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qc5jvdogMDpr4oxWa3HQKTuiZTQdHC+7ram+bQ/YWswiVYg9GMCzRN1VohiZekzG3
	 NALE1AMP14gLnB/a4ppIucynjk1HTvQN6dh3xoGJYqdGYkOVQ41/qHFfPvADVvc23v
	 +vAbDAt9PM2Q8iZM0CXRsdKFsFsJsr+eQ0ZXX3II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgFIWyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgFIWxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:53:52 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB6E206D5;
        Tue,  9 Jun 2020 22:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591743230;
        bh=nVuBqbkV/uv74u3QW2uddNsqQSwQmtQDFLo+qHJ3u5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=dWsPem0V18bCYroX0t07DPKOT+Undy0XjdVqrpBfEhEiWehkAi/hYzM7bBDyMC5bL
         sDK91sccUoybQDHWo29JfA90WPfnW7AUxG6Z5gXyY8COb7T+sKZfttRir3pj1u0DLe
         dnCcXQhEaD5uChxigs0uPdbs9egCZoIgUnwPLFI8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Tue,  9 Jun 2020 15:53:50 -0700
Message-Id: <20200609225350.206940-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 9ac1eafa885a9b2d3becd4f2e622829b1f5b9b86:

  clk: mediatek: Remove ifr{0,1}_cfg_regs structures (2020-06-09 14:22:14 -0700)

----------------------------------------------------------------
This time around we have 4 lines of diff in the core framework, removing a
function that isn't used anymore. Otherwise the main new thing for the common
clk framework is that it is selectable in the Kconfig language now. Hopefully
this will let clk drivers and clk consumers be testable on more than the
architectures that support the clk framework. The goal is to introduce some
Kunit tests for the framework.

Outside of the core framework we have the usual set of various driver updates
and non-critical fixes. The dirstat shows that the new Baikal-T1 driver is the
largest addition this time around in terms of lines of code. After that the x86
(Intel), Qualcomm, and Mediatek drivers introduce many lines to support new or
upcoming SoCs. After that the dirstat shows the usual suspects working on their
SoC support by fixing minor bugs, correcting data and converting some of their
DT bindings to YAML.

Core:
 - Allow the COMMON_CLK config to be selectable

New Drivers:
 - Clk driver for Baikal-T1 SoCs
 - Mediatek MT6765 clock support
 - Support for Intel Agilex clks
 - Add support for X1830 and X1000 Ingenic SoC clk controllers
 - Add support for the new Renesas RZ/G1H (R8A7742) SoC
 - Add support for Qualcomm's MSM8939 Generic Clock Controller

Updates:
 - Support IDT VersaClock 5P49V5925
 - Bunch of updates for HSDK clock generation unit (CGU) driver
 - Start making audio and GPU clks work on Marvell MMP2/MMP3 SoCs
 - Add some GPU, NPU, and UFS clks to Qualcomm SM8150 driver
 - Enable supply regulators for GPU gdscs on Qualcomm SoCs
 - Add support for Si5342, Si5344 and Si5345 chips
 - Support custom flags in Xilinx zynq firmware
 - Various small fixes to the Xilinx clk driver
 - A single minor rounding fix for the legacy Allwinner clock support
 - A few patches from Abel Vesa as preparation of adding audiomix clock support
   on i.MX
 - A couple of cleanups from Anson Huang for i.MX clk-sscg-pll and clk-pllv3
   drivers
 - Drop dependency on ARM64 for i.MX8M clock driver, to support aarch32 mode on
   aarch64 hardware
 - A series from Peng Fan to improve i.MX8M clock drivers, using composite
   clock for core and bus clk slice
 - Set a better parent clock for flexcan on i.MX6UL to support CiA102 defined
   bit rates
 - A couple changes for EMC frequency scaling on Tegra210
 - Support for CPU frequency scaling on Tegra20/Tegra30
 - New clk gate for CSI test pattern generator on Tegra210
 - Regression fixes for Samsung exynos542x and exynos5433 SoCs
 - Use of fallthrough; attribute for Samsung s3c24xx
 - Updates and fixup HDMI and video clocks on Meson8b
 - Fixup reset polarity on Meson8b
 - Fix GPU glitch free mux switch on Meson gx and g12
 - A minor fix for the currently unused suspend/resume handling on Renesas RZ/A1 and RZ/A2
 - Two more conversions of Renesas DT bindings to json-schema
 - Add support for the USB 2.0 clock selector on Renesas R-Car M3-W+

----------------------------------------------------------------
Abel Vesa (4):
      clk: imx: gate2: Allow single bit gating clock
      clk: imx: pll14xx: Add the device as argument when registering
      clk: imx: Add helpers for passing the device as argument
      dt-bindings: clocks: imx8mp: Add ids for audiomix clocks

Adam Ford (2):
      clk: vc5: Add support for IDT VersaClock 5P49V6965
      dt: Add bindings for IDT VersaClock 5P49V5925

Alain Volmat (1):
      clk: clk-flexgen: fix clock-critical handling

Anson Huang (2):
      clk: imx: clk-sscg-pll: Remove unnecessary blank lines
      clk: imx: clk-pllv3: Use readl_relaxed_poll_timeout() for PLL lock wait

Bjorn Andersson (2):
      clk: qcom: gdsc: Handle GDSC regulator supplies
      clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc

Bryan O'Donoghue (3):
      clk: qcom: msm8916: Fix the address location of pll->config_reg
      clk: qcom: Add DT bindings for MSM8939 GCC
      clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock Controller

Christophe JAILLET (2):
      clk: renesas: r9a06g032: Fix some typo in comments
      clk: clk-xgene: Fix a typo in Kconfig

Chunyan Zhang (6):
      clk: sprd: mark the local clock symbols static
      clk: sprd: return correct type of value for _sprd_pll_recalc_rate
      clk: sprd: check its parent status before reading gate clock
      dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
      clk: sprd: add dt-bindings include for mipi_csi_xx clocks
      clk: sprd: add mipi_csi_xx gate clocks

Claudiu Beznea (2):
      clk: at91: pmc: do not continue if compatible not located
      clk: at91: pmc: decrement node's refcount

Codrin Ciubotariu (1):
      clk: at91: Add peripheral clock for PTC

Colin Ian King (4):
      clk: versatile: remove redundant assignment to pointer clk
      clk: intel: remove redundant initialization of variable rate64
      clk: baikal-t1: fix spelling mistake "Uncompatible" -> "Incompatible"
      clk: baikal-t1: remove redundant assignment to variable 'divider'

Dinh Nguyen (5):
      clk: socfpga: stratix10: use new parent data scheme
      clk: socfpga: remove clk_ops enable/disable methods
      clk: socfpga: add const to _ops data structures
      dt-bindings: documentation: add clock bindings information for Agilex
      clk: socfpga: agilex: add clock driver for the Agilex platform

Dmitry Osipenko (5):
      clk: tegra: Add custom CCLK implementation
      clk: tegra: pll: Add pre/post rate-change hooks
      clk: tegra: cclk: Add helpers for handling PLLX rate changes
      clk: tegra20: Use custom CCLK implementation
      clk: tegra30: Use custom CCLK implementation

Eddie James (1):
      clk: ast2600: Fix AHB clock divider for A1

Eugeniy Paltsev (3):
      CLK: HSDK: CGU: check if PLL is bypassed first
      CLK: HSDK: CGU: support PLL bypassing
      CLK: HSDK: CGU: add support for 148.5MHz clock

Geert Uytterhoeven (6):
      MAINTAINERS: Add DT Bindings for Renesas Clock Generators
      Merge tag 'renesas-r8a7742-dt-binding-defs-tag' into clk-renesas-for-v5.8
      clk: renesas: rcar-gen2: Remove superfluous CLK_RENESAS_DIV6 selects
      clk: renesas: cpg-mssr: Fix STBCR suspend/resume handling
      dt-bindings: clock: renesas: div6: Convert to json-schema
      dt-bindings: clock: renesas: mstp: Convert to json-schema

Jason Yan (1):
      clk: ti: dra7: remove two unused symbols

Jeffrey Hugo (1):
      clk: qcom: Add missing msm8998 ufs_unipro_core_clk_src

Joe Perches (1):
      ARM/SAMSUNG EXYNOS ARM ARCHITECTURES: Use fallthrough;

Joseph Lo (4):
      clk: tegra: Add PLLP_UD and PLLMB_UD for Tegra210
      clk: tegra: Export functions for EMC clock scaling
      clk: tegra: Implement Tegra210 EMC clock
      clk: tegra: Remove the old emc_mux clock for Tegra210

Lad Prabhakar (4):
      dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
      clk: renesas: Add r8a7742 CPG Core Clock Definitions
      dt-bindings: clock: renesas: cpg-mssr: Document r8a7742 binding
      clk: renesas: cpg-mssr: Add R8A7742 support

Lubomir Rintel (14):
      clk: mmp: frac: Do not lose last 4 digits of precision
      clk: mmp: frac: Allow setting bits other than the numerator/denominator
      dt-bindings: marvell,mmp2: Add clock id for the I2S clocks
      dt-bindings: marvell,mmp2: Add clock id for the Audio clock
      clk: mmp2: Move thermal register defines up a bit
      clk: mmp2: Rename mmp2_pll_init() to mmp2_main_clk_init()
      clk: mmp2: Add the I2S clocks
      clk: mmp2: Add the audio clock
      dt-bindings: clock: Make marvell,mmp2-clock a power controller
      dt-bindings: marvell,mmp2: Add ids for the power domains
      clk: mmp2: Add support for power islands
      dt-bindings: clock: Add Marvell MMP Audio Clock Controller binding
      clk: mmp2: Add audio clock controller driver
      dt-bindings: clock: Add a missing include to MMP Audio Clock binding

Macpaul Lin (3):
      dt-bindings: clock: mediatek: document clk bindings for Mediatek MT6765 SoC
      dt-bindings: clock: mediatek: document clk bindings mipi0a for Mediatek MT6765 SoC
      dt-bindings: clock: mediatek: document clk bindings vcodecsys for Mediatek MT6765 SoC

Marek Szyprowski (3):
      clk: samsung: Mark top ISP and CAM clocks on Exynos542x as critical
      clk: samsung: Fix CLK_SMMU_FIMCL3 clock name on Exynos542x
      clk: samsung: exynos5433: Add IGNORE_UNUSED flag to sclk_i2s1

Mars Cheng (1):
      clk: mediatek: add mt6765 clock IDs

Martin Blumenstingl (9):
      clk: meson8b: export the HDMI system clock
      clk: meson: meson8b: make the hdmi_sys clock tree mutable
      clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
      clk: meson: g12a: Prepare the GPU clock tree to change at runtime
      clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
      clk: meson: meson8b: Fix the polarity of the RESET_N lines
      clk: meson: meson8b: Fix the vclk_div{1, 2, 4, 6, 12}_en gate bits
      clk: meson: meson8b: Make the CCF use the glitch-free VPU mux
      clk: meson: meson8b: Don't rely on u-boot to init all GP_PLL registers

Michał Mirosław (3):
      clk: at91: optimize pmc data allocation
      clk: at91: allow setting PCKx parent via DT
      clk: at91: allow setting all PMC clock parents via DT

Mike Looijmans (1):
      clk: clk-si5341: Add support for the Si5345 series

Nathan Chancellor (2):
      clk: bcm2835: Fix return type of bcm2835_register_gate
      clk: bcm2835: Remove casting to bcm2835_clk_register

Owen Chen (1):
      clk: mediatek: Add MT6765 clock support

Peng Fan (10):
      clk: imx7ulp: make it easy to change ARM core clk
      clk: imx: drop the dependency on ARM64 for i.MX8M
      clk: imx8m: drop clk_hw_set_parent for A53
      clk: imx: imx8mp: fix pll mux bit
      clk: imx8mp: Define gates for pll1/2 fixed dividers
      clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code
      clk: imx8m: migrate A53 clk root to use composite core
      clk: imx: add mux ops for i.MX8M composite clk
      clk: imx: add imx8m_clk_hw_composite_bus
      clk: imx: use imx8m_clk_hw_composite_bus for i.MX8M bus clk slice

Quanyang Wang (1):
      clk: zynqmp: fix memory leak in zynqmp_register_clocks

Rahul Tanwar (2):
      dt-bindings: clk: intel: Add bindings document & header file for CGU
      clk: intel: Add CGU clock driver for a new SoC

Rajan Vaja (3):
      clk: zynqmp: Limit bestdiv with maxdiv
      clk: zynqmp: Fix invalid clock name queries
      clk: zynqmp: Add support for custom type flags

Rikard Falkeborn (2):
      clk: sunxi: Fix incorrect usage of round_down()
      clk: bcm2835: Constify struct debugfs_reg32

Serge Semin (4):
      dt-bindings: clk: Add Baikal-T1 CCU PLLs binding
      dt-bindings: clk: Add Baikal-T1 CCU Dividers binding
      clk: Add Baikal-T1 CCU PLLs driver
      clk: Add Baikal-T1 CCU Dividers driver

Sivaprakash Murugesan (1):
      dt-bindings: clock: Add YAML schemas for QCOM A53 PLL

Sowjanya Komatineni (2):
      dt-bindings: clock: tegra: Add clock ID for CSI TPG clock
      clk: tegra: Add Tegra210 CSI TPG clock gate

Stephen Boyd (24):
      Merge tag 'clk-renesas-for-v5.8-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      ARM: Remove redundant COMMON_CLK selects
      ARM: Remove redundant CLKDEV_LOOKUP selects
      arm64: tegra: Remove redundant CLKDEV_LOOKUP selects
      h8300: Remove redundant CLKDEV_LOOKUP selects
      MIPS: Remove redundant CLKDEV_LOOKUP selects
      mmc: meson-mx-sdio: Depend on OF_ADDRESS and not just OF
      clk: Allow the common clk framework to be selectable
      ARM: mmp: Remove legacy clk code
      MIPS: Loongson64: Drop asm/clock.h include
      clk: Move HAVE_CLK config out of architecture layer
      Merge tag 'clk-meson-v5.8-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-renesas-for-v5.8-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-v5.8-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      Merge tag 'sunxi-clk-for-5.8-1' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'for-5.8-clk' of git://git.kernel.org/.../tegra/linux into clk-tegra
      Merge tag 'clk-imx-5.8' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      clk: ingenic: Mark ingenic_tcu_of_match as __maybe_unused
      Merge branches 'clk-selectable', 'clk-amlogic', 'clk-renesas', 'clk-samsung' and 'clk-allwinner' into clk-next
      Merge branches 'clk-tegra', 'clk-imx', 'clk-zynq', 'clk-socfpga', 'clk-at91' and 'clk-ti' into clk-next
      Merge branches 'clk-unisoc', 'clk-trivial', 'clk-bcm', 'clk-st' and 'clk-ast2600' into clk-next
      Merge branches 'clk-mmp', 'clk-intel', 'clk-ingenic', 'clk-qcom' and 'clk-silabs' into clk-next
      Merge branches 'clk-vc5', 'clk-hsdk', 'clk-mediatek' and 'clk-baikal' into clk-next
      clk: mediatek: Remove ifr{0,1}_cfg_regs structures

Taniya Das (3):
      clk: qcom: gcc: Add support for a new frequency for SC7180
      dt-bindings: clock: Add gcc_sec_ctrl_clk_src clock ID
      clk: qcom: gcc: Add support for Secure control source clock

Tejas Patel (2):
      clk: zynqmp: Fix divider2 calculation
      clk: zynqmp: Update fraction clock check from custom type flags

Tero Kristo (6):
      clk: ti: composite: fix memory leak
      clk: ti: omap4: Add proper parent clocks for l4-secure clocks
      clk: ti: omap5: Add proper parent clocks for l4-secure clocks
      clk: ti: dra7xx: fix gpu clkctrl parent
      clk: ti: dra7xx: mark MCAN clock as DRA76x only
      clk: ti: dra7xx: fix RNG clock parent

Thierry Reding (2):
      Merge branch 'for-5.8/dt-bindings' into for-5.8/clk
      clk: tegra: Rename Tegra124 EMC clock source file

Vinod Koul (2):
      clk: qcom: gcc: Add GPU and NPU clocks for SM8150
      clk: qcom: gcc: Add missing UFS clocks for SM8150

Waibel Georg (1):
      clk: imx: imx6ul: change flexcan clock to support CiA bitrates

Weiyi Lu (1):
      clk: mediatek: assign the initial value to clk_init_data of mtk_mux

Yoshihiro Shimoda (1):
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Add r8a77961 support

YueHaibing (2):
      clk: Remove unused inline function clk_debug_reparent
      clk: zynqmp: Make zynqmp_clk_get_max_divisor static

周琰杰 (Zhou Yanjie) (6):
      clk: Ingenic: Remove unnecessary spinlock when reading registers.
      clk: Ingenic: Adjust cgu code to make it compatible with X1830.
      dt-bindings: clock: Add X1830 clock bindings.
      clk: Ingenic: Add CGU driver for X1830.
      dt-bindings: clock: Add and reorder ABI for X1000.
      clk: X1000: Add FIXDIV for SSI clock of X1000.

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   28 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   27 +
 .../bindings/clock/baikal,bt1-ccu-div.yaml         |  188 +
 .../bindings/clock/baikal,bt1-ccu-pll.yaml         |  131 +
 .../devicetree/bindings/clock/idt,versaclock5.txt  |    1 +
 .../devicetree/bindings/clock/intel,agilex.yaml    |   46 +
 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |   44 +
 .../bindings/clock/marvell,mmp2-audio-clock.yaml   |   75 +
 .../bindings/clock/marvell,mmp2-clock.yaml         |    5 +
 .../devicetree/bindings/clock/qcom,a53pll.txt      |   22 -
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |   40 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    3 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |    4 +
 .../bindings/clock/renesas,cpg-div6-clock.yaml     |   60 +
 .../bindings/clock/renesas,cpg-div6-clocks.txt     |   40 -
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   60 -
 .../bindings/clock/renesas,cpg-mstp-clocks.yaml    |   82 +
 .../bindings/clock/renesas,rcar-usb2-clock-sel.txt |    4 +-
 .../devicetree/bindings/clock/silabs,si5341.txt    |   11 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |    1 +
 MAINTAINERS                                        |    1 +
 arch/Kconfig                                       |    6 -
 arch/arm/Kconfig                                   |    5 +-
 arch/arm/mach-actions/Kconfig                      |    1 -
 arch/arm/mach-clps711x/Kconfig                     |    1 -
 arch/arm/mach-mmp/Kconfig                          |    3 +-
 arch/arm/mach-mmp/Makefile                         |    6 -
 arch/arm/mach-mmp/clock-mmp2.c                     |  114 -
 arch/arm/mach-mmp/clock-pxa168.c                   |   94 -
 arch/arm/mach-mmp/clock-pxa910.c                   |   70 -
 arch/arm/mach-mmp/clock.c                          |  105 -
 arch/arm/mach-mmp/clock.h                          |   65 -
 arch/arm/mach-mmp/pxa168.c                         |    1 -
 arch/arm/mach-mmp/time.c                           |    1 -
 arch/arm/mach-vt8500/Kconfig                       |    1 -
 arch/arm64/Kconfig.platforms                       |    1 -
 arch/c6x/Kconfig                                   |    1 +
 arch/h8300/Kconfig                                 |    1 -
 arch/m68k/Kconfig.cpu                              |    2 +-
 arch/mips/Kconfig                                  |    7 +-
 arch/mips/loongson2ef/Kconfig                      |    2 +-
 arch/mips/loongson64/smp.c                         |    1 -
 arch/mips/ralink/Kconfig                           |    4 +
 arch/sh/boards/Kconfig                             |    5 +
 arch/unicore32/Kconfig                             |    2 +-
 drivers/clk/Kconfig                                |   33 +-
 drivers/clk/Makefile                               |    4 +-
 drivers/clk/at91/at91rm9200.c                      |   12 +-
 drivers/clk/at91/at91sam9260.c                     |   13 +-
 drivers/clk/at91/at91sam9g45.c                     |   10 +-
 drivers/clk/at91/at91sam9n12.c                     |   12 +-
 drivers/clk/at91/at91sam9rl.c                      |   10 +-
 drivers/clk/at91/at91sam9x5.c                      |   10 +-
 drivers/clk/at91/pmc.c                             |   47 +-
 drivers/clk/at91/pmc.h                             |    8 +-
 drivers/clk/at91/sam9x60.c                         |   10 +-
 drivers/clk/at91/sama5d2.c                         |   13 +-
 drivers/clk/at91/sama5d3.c                         |   10 +-
 drivers/clk/at91/sama5d4.c                         |   10 +-
 drivers/clk/baikal-t1/Kconfig                      |   42 +
 drivers/clk/baikal-t1/Makefile                     |    3 +
 drivers/clk/baikal-t1/ccu-div.c                    |  602 +++
 drivers/clk/baikal-t1/ccu-div.h                    |  110 +
 drivers/clk/baikal-t1/ccu-pll.c                    |  558 +++
 drivers/clk/baikal-t1/ccu-pll.h                    |   64 +
 drivers/clk/baikal-t1/clk-ccu-div.c                |  485 +++
 drivers/clk/baikal-t1/clk-ccu-pll.c                |  204 +
 drivers/clk/bcm/clk-bcm2835.c                      |   80 +-
 drivers/clk/clk-ast2600.c                          |   31 +-
 drivers/clk/clk-hsdk-pll.c                         |   70 +-
 drivers/clk/clk-si5341.c                           |   69 +-
 drivers/clk/clk-versaclock5.c                      |   11 +
 drivers/clk/clk.c                                  |    4 -
 drivers/clk/imx/Kconfig                            |    8 +-
 drivers/clk/imx/clk-composite-8m.c                 |   56 +-
 drivers/clk/imx/clk-gate2.c                        |   31 +-
 drivers/clk/imx/clk-imx6ul.c                       |    2 +-
 drivers/clk/imx/clk-imx7ulp.c                      |    6 +-
 drivers/clk/imx/clk-imx8mm.c                       |   27 +-
 drivers/clk/imx/clk-imx8mn.c                       |   25 +-
 drivers/clk/imx/clk-imx8mp.c                       |  148 +-
 drivers/clk/imx/clk-imx8mq.c                       |   29 +-
 drivers/clk/imx/clk-pll14xx.c                      |    8 +-
 drivers/clk/imx/clk-pllv3.c                        |   16 +-
 drivers/clk/imx/clk-sscg-pll.c                     |   10 -
 drivers/clk/imx/clk.h                              |   62 +-
 drivers/clk/ingenic/Kconfig                        |   10 +
 drivers/clk/ingenic/Makefile                       |    1 +
 drivers/clk/ingenic/cgu.c                          |   28 +-
 drivers/clk/ingenic/cgu.h                          |    4 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |    4 +
 drivers/clk/ingenic/jz4740-cgu.c                   |    4 +
 drivers/clk/ingenic/jz4770-cgu.c                   |    8 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |    3 +
 drivers/clk/ingenic/tcu.c                          |    2 +-
 drivers/clk/ingenic/x1000-cgu.c                    |  123 +-
 drivers/clk/ingenic/x1830-cgu.c                    |  448 +++
 drivers/clk/mediatek/Kconfig                       |   86 +
 drivers/clk/mediatek/Makefile                      |    7 +
 drivers/clk/mediatek/clk-mt6765-audio.c            |  100 +
 drivers/clk/mediatek/clk-mt6765-cam.c              |   74 +
 drivers/clk/mediatek/clk-mt6765-img.c              |   70 +
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |   68 +
 drivers/clk/mediatek/clk-mt6765-mm.c               |   96 +
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |   70 +
 drivers/clk/mediatek/clk-mt6765.c                  |  922 +++++
 drivers/clk/mediatek/clk-mux.c                     |    2 +-
 drivers/clk/meson/g12a.c                           |   30 +-
 drivers/clk/meson/gxbb.c                           |   40 +-
 drivers/clk/meson/meson8b.c                        |  120 +-
 drivers/clk/meson/meson8b.h                        |    5 +-
 drivers/clk/mmp/Makefile                           |    3 +-
 drivers/clk/mmp/clk-audio.c                        |  443 +++
 drivers/clk/mmp/clk-frac.c                         |   27 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |  104 +-
 drivers/clk/mmp/clk.h                              |   11 +
 drivers/clk/mmp/pwr-island.c                       |  115 +
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-msm8916.c                     |    8 +-
 drivers/clk/qcom/gcc-msm8939.c                     | 3988 ++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8998.c                     |   27 +
 drivers/clk/qcom/gcc-sc7180.c                      |   94 +-
 drivers/clk/qcom/gcc-sm8150.c                      |  148 +
 drivers/clk/qcom/gdsc.c                            |   23 +
 drivers/clk/qcom/gdsc.h                            |    4 +
 drivers/clk/qcom/mmcc-msm8996.c                    |    2 +
 drivers/clk/renesas/Kconfig                        |    8 +-
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a7742-cpg-mssr.c             |  275 ++
 drivers/clk/renesas/r9a06g032-clocks.c             |    6 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   14 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   18 +-
 drivers/clk/samsung/clk-exynos5433.c               |    3 +-
 drivers/clk/samsung/clk-s3c2443.c                  |    2 +-
 drivers/clk/socfpga/Makefile                       |    2 +
 drivers/clk/socfpga/clk-agilex.c                   |  454 +++
 drivers/clk/socfpga/clk-gate-s10.c                 |    5 +-
 drivers/clk/socfpga/clk-periph-s10.c               |   10 +-
 drivers/clk/socfpga/clk-pll-a10.c                  |    4 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |   78 +-
 drivers/clk/socfpga/clk-pll.c                      |    4 +-
 drivers/clk/socfpga/clk-s10.c                      |  160 +-
 drivers/clk/socfpga/stratix10-clk.h                |   10 +-
 drivers/clk/sprd/gate.c                            |    7 +
 drivers/clk/sprd/gate.h                            |    9 +
 drivers/clk/sprd/pll.c                             |    2 +-
 drivers/clk/sprd/sc9863a-clk.c                     |   64 +-
 drivers/clk/st/clk-flexgen.c                       |    1 +
 drivers/clk/sunxi/clk-sunxi.c                      |    2 +-
 drivers/clk/tegra/Kconfig                          |    4 -
 drivers/clk/tegra/Makefile                         |    4 +-
 drivers/clk/tegra/clk-pll.c                        |   12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c           |  212 ++
 .../clk/tegra/{clk-emc.c => clk-tegra124-emc.c}    |    0
 drivers/clk/tegra/clk-tegra20.c                    |    7 +-
 drivers/clk/tegra/clk-tegra210-emc.c               |  369 ++
 drivers/clk/tegra/clk-tegra210.c                   |   94 +-
 drivers/clk/tegra/clk-tegra30.c                    |    6 +-
 drivers/clk/tegra/clk.h                            |   24 +-
 drivers/clk/ti/clk-44xx.c                          |   14 +-
 drivers/clk/ti/clk-54xx.c                          |   14 +-
 drivers/clk/ti/clk-7xx.c                           |   15 +-
 drivers/clk/ti/composite.c                         |    1 +
 drivers/clk/versatile/clk-versatile.c              |    2 +-
 drivers/clk/x86/Kconfig                            |    8 +
 drivers/clk/x86/Makefile                           |    1 +
 drivers/clk/x86/clk-cgu-pll.c                      |  156 +
 drivers/clk/x86/clk-cgu.c                          |  636 ++++
 drivers/clk/x86/clk-cgu.h                          |  335 ++
 drivers/clk/x86/clk-lgm.c                          |  475 +++
 drivers/clk/zynqmp/clk-zynqmp.h                    |    1 +
 drivers/clk/zynqmp/clkc.c                          |   24 +-
 drivers/clk/zynqmp/divider.c                       |   27 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |    3 +-
 drivers/mmc/host/Kconfig                           |    2 +-
 include/dt-bindings/clock/agilex-clock.h           |   70 +
 include/dt-bindings/clock/at91.h                   |    4 +
 include/dt-bindings/clock/bt1-ccu.h                |   48 +
 include/dt-bindings/clock/imx7ulp-clock.h          |    5 +-
 include/dt-bindings/clock/imx8mp-clock.h           |   90 +-
 include/dt-bindings/clock/intel,lgm-clk.h          |  165 +
 include/dt-bindings/clock/marvell,mmp2-audio.h     |   10 +
 include/dt-bindings/clock/marvell,mmp2.h           |    3 +
 include/dt-bindings/clock/meson8b-clkc.h           |    1 +
 include/dt-bindings/clock/mt6765-clk.h             |  313 ++
 include/dt-bindings/clock/qcom,gcc-msm8939.h       |  206 +
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |    1 +
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |    1 +
 include/dt-bindings/clock/r8a7742-cpg-mssr.h       |   42 +
 include/dt-bindings/clock/sprd,sc9863a-clk.h       |    5 +
 include/dt-bindings/clock/tegra210-car.h           |    6 +-
 include/dt-bindings/clock/x1000-cgu.h              |   64 +-
 include/dt-bindings/clock/x1830-cgu.h              |   55 +
 include/dt-bindings/power/marvell,mmp2.h           |   11 +
 include/dt-bindings/power/r8a7742-sysc.h           |   29 +
 include/dt-bindings/reset/bt1-ccu.h                |   25 +
 include/dt-bindings/reset/qcom,gcc-msm8939.h       |  110 +
 include/linux/clk/tegra.h                          |   27 +
 209 files changed, 15301 insertions(+), 1251 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/baikal,bt1-ccu-div.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.yaml
 delete mode 100644 arch/arm/mach-mmp/clock-mmp2.c
 delete mode 100644 arch/arm/mach-mmp/clock-pxa168.c
 delete mode 100644 arch/arm/mach-mmp/clock-pxa910.c
 delete mode 100644 arch/arm/mach-mmp/clock.c
 delete mode 100644 arch/arm/mach-mmp/clock.h
 create mode 100644 drivers/clk/baikal-t1/Kconfig
 create mode 100644 drivers/clk/baikal-t1/Makefile
 create mode 100644 drivers/clk/baikal-t1/ccu-div.c
 create mode 100644 drivers/clk/baikal-t1/ccu-div.h
 create mode 100644 drivers/clk/baikal-t1/ccu-pll.c
 create mode 100644 drivers/clk/baikal-t1/ccu-pll.h
 create mode 100644 drivers/clk/baikal-t1/clk-ccu-div.c
 create mode 100644 drivers/clk/baikal-t1/clk-ccu-pll.c
 create mode 100644 drivers/clk/ingenic/x1830-cgu.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mipi0a.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765.c
 create mode 100644 drivers/clk/mmp/clk-audio.c
 create mode 100644 drivers/clk/mmp/pwr-island.c
 create mode 100644 drivers/clk/qcom/gcc-msm8939.c
 create mode 100644 drivers/clk/renesas/r8a7742-cpg-mssr.c
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c
 rename drivers/clk/tegra/{clk-emc.c => clk-tegra124-emc.c} (100%)
 create mode 100644 drivers/clk/tegra/clk-tegra210-emc.c
 create mode 100644 drivers/clk/x86/Kconfig
 create mode 100644 drivers/clk/x86/clk-cgu-pll.c
 create mode 100644 drivers/clk/x86/clk-cgu.c
 create mode 100644 drivers/clk/x86/clk-cgu.h
 create mode 100644 drivers/clk/x86/clk-lgm.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h
 create mode 100644 include/dt-bindings/clock/bt1-ccu.h
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h
 create mode 100644 include/dt-bindings/clock/marvell,mmp2-audio.h
 create mode 100644 include/dt-bindings/clock/mt6765-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8939.h
 create mode 100644 include/dt-bindings/clock/r8a7742-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h
 create mode 100644 include/dt-bindings/power/marvell,mmp2.h
 create mode 100644 include/dt-bindings/power/r8a7742-sysc.h
 create mode 100644 include/dt-bindings/reset/bt1-ccu.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-msm8939.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
