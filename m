Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1203AC2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53F020672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586055229;
	bh=LqgOB1inol60Yu2izpzwkBL7SF8vTtl2k8EC0qNX8ls=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RMpiDeeSfBO7oW0F2icmvfMJAYNDOZyNebPwvnkd8xnJmqKi116nY9Nau797mDxSI
	 6VeO8INY3IYEa3qDVcNvhtYmHx6QjCSNwBRxr1E/EL7pGlLgqLNavamZncDQOvpehR
	 3fvGfaB0dTW23kHtY9PpRnLqQ//YZeFAJYS374vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDECxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgDECxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:53:48 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603A420672;
        Sun,  5 Apr 2020 02:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586055226;
        bh=LqgOB1inol60Yu2izpzwkBL7SF8vTtl2k8EC0qNX8ls=;
        h=From:To:Cc:Subject:Date:From;
        b=nU8GbSFvO9kL8jV76uRsr3ATQ0zNoz/zh702+nFitZfavz4qAW+A31AoEd8Vt0iiy
         pF4XbXVCPZlxltDJB9WBqfWzac5J3QxgeCEIkJNri2hi30Aa3hHFExpdoh32GQpCyf
         1T4O5FvaB9MDDpw75CUyieVKwu8cvLViGewlBHh0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Sat,  4 Apr 2020 19:53:45 -0700
Message-Id: <20200405025345.156578-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 42be7c41a5edc990e329b991b4ad6ec172e72e18:

  dt-bindings: clk: g12a-clkc: add SPICC SCLK Source clock IDs (2020-02-19 18:40:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 28ecaf1c30fe3f616eef5ab2dd5990399957234e:

  Merge branches 'clk-unisoc', 'clk-tegra', 'clk-qcom' and 'clk-imx' into clk-next (2020-04-03 15:10:19 -0700)

----------------------------------------------------------------
There's not much to see in the core framework this time around. Instead the
majority of the diff is the normal collection of driver additions for new SoCs
and non-critical clk data fixes and updates. The framework must be middle aged.

The two biggest directories in the diffstat show that the Qualcomm and Unisoc
support added a handful of big drivers for new SoCs but that's not really the
whole story because those new drivers tend to add large numbers of lines of clk
data. There's a handful of AT91 clk drivers added this time around too and a
bunch of improvements to drivers like the i.MX driver. All around lots of
updates and fixes in various clk drivers which is good to see.

The core framework has only one real major change which has been baking in next
for the past couple months. It fixes the framework so that it stops caching a
clk's phase when the phase clk_op returns an error. Before this change we would
consider some negative errno as a phase and that just doesn't make sense.

Core:
 - Don't show clk phase when it is invalid

New Drivers:
 - Add support for Unisoc SC9863A clks
 - Qualcomm SM8250 RPMh and MSM8976 RPM clks
 - Qualcomm SM8250 Global Clock Controller (GCC) support
 - Qualcomm SC7180 Modem Clock Controller (MSS CC) support
 - EHRPWM's TimeBase clock(TBCLK) for TI AM654 SoCs
 - Support PMC clks on at91sam9n12, at91rm9200, sama5d3, and at91sam9g45 SoCs

Updates:
 - GPU GX GDSC support on Qualcomm sc7180
 - Fixes and improvements for the Marvell MMP2/MMP3 SoC clk drivers
 - A series from Anson to convert i.MX8 clock bindings to json-schema
 - Update i.MX pll14xx driver to include new frequency entries for pll1443x table,
   and return error for invalid PLL type
 - Add missing of_node_put() call for a number of i.MX clock drivers
 - Drop flag CLK_IS_CRITICAL from 'A53_CORE' mux clock, as we already
   have the flag on its child cpu clock
 - Fix a53 cpu clock for i.MX8 drivers to get it source from ARM PLL
   via CORE_SEL slice, and source from A53 CCM clk root when we need to
   change ARM PLL frequency. Thus, we can support core running above
   1GHz safely
 - Update i.MX pfdv2 driver to check zero rate and use determine_rate for
   getting the best rate
 - Add CLKO2 for imx8mm, SNVS clock for imx8mn, and PXP clock for imx7d
 - Remove PMC clks from Tegra clk driver
 - Improved clock/reset handling for the Renesas R-Car USB2 Clock Selector
 - Conversion to json-schema of the Renesas CPG/MSSR DT bindings
 - Add Crypto clocks on Renesas R-Car M3-W/W+, M3-N, E3, and D3
 - Add RPC (QSPI/HyperFLASH) clocks on Renesas R-Car H3, M3-W/W+, and M3-N
 - Update Amlogic audio clock gate hierarchy for meson8 and gxbb
 - Update Amlogic g12a spicc clock sources
 - Support for Ingenic X1000 TCU clks

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: clk-gate2: Pass the device to the register function

Abhishek Sahu (1):
      ipq806x: gcc: Added the enable regs and mask for PRNG

Aditya Pakki (1):
      clk: samsung: Remove redundant check in samsung_cmu_register_one

Alexandre Belloni (4):
      clk: at91: add at91sam9g45 pmc driver
      clk: at91: add sama5d3 pmc driver
      clk: at91: add at91sam9n12 pmc driver
      clk: at91: add at91rm9200 pmc driver

Andy Shevchenko (1):
      clk: Fix trivia typo in comment exlusive => exclusive

AngeloGioacchino Del Regno (2):
      clk: qcom: smd: Add support for MSM8976 rpm clocks
      dt-bindings: clock: rpmcc: Document msm8976 compatible

Anson Huang (23):
      dt-bindings: clock: Convert i.MX8MQ to json-schema
      dt-bindings: clock: Convert i.MX8MM to json-schema
      dt-bindings: clock: Refine i.MX8MN clock binding
      clk: imx: pll14xx: Add new frequency entries for pll1443x table
      clk: imx: Include clk-provider.h instead of clk.h for i.MX8M SoCs clock driver
      clk: imx: drop redundant initialization
      clk: imx7ulp: Include clk-provider.h instead of clk.h
      clk: imx6sl: Add missing of_node_put()
      clk: imx8mq: Add missing of_node_put()
      clk: imx8mm: Add missing of_node_put()
      clk: imx8mn: Add missing of_node_put()
      clk: imx8mp: Add missing of_node_put()
      clk: imx8mp: Include slab.h instead of clkdev.h
      clk: imx8mm: Remove unused includes
      clk: imx8mn: Remove unused includes
      clk: imx8mp: Rename the IMX8MP_CLK_HDMI_27M clock
      clk: imx: pll14xx: Return error if pll type is invalid
      clk: imx: clk-sscg-pll: Drop unnecessary initialization
      clk: imx: Fix division by zero warning on pfdv2
      clk: imx8mn: A53 core clock no need to be critical
      clk: imx8mm: A53 core clock no need to be critical
      clk: imx8mp: A53 core clock no need to be critical
      clk: imx8mq: A53 core clock no need to be critical

Ansuel Smith (1):
      clk: qcom: clk-rpm: add missing rpm clk for ipq806x

Chunyan Zhang (7):
      dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
      dt-bindings: clk: sprd: add bindings for sc9863a clock controller
      clk: sprd: Add dt-bindings include file for SC9863A
      clk: sprd: Add macros for referencing parents without strings
      clk: sprd: support to get regmap from parent node
      clk: sprd: add clocks support for SC9863A
      clk: sprd: fix to get a correct ibias of pll

Claudiu Beznea (4):
      clk: at91: usb: continue if clk_hw_round_rate() return zero
      clk: at91: sam9x60: fix usb clock parents
      clk: at91: usb: use proper usbs_mask
      clk: at91: usb: introduce num_parents in driver's structure

Codrin Ciubotariu (1):
      clk: at91: sam9x60: Don't use audio PLL

Dinh Nguyen (2):
      clk: stratix10: use do_div() for 64-bit calculation
      clk: socfpga: stratix10: simplify parameter passing

Dirk Behme (3):
      clk: renesas: r8a7795: Add RPC clocks
      clk: renesas: r8a7796: Add RPC clocks
      clk: renesas: r8a77965: Add RPC clocks

Fabio Estevam (4):
      clk: imx8mm: Fix the CLKO1 source select list
      clk: imx8mm: Add CLKO2 support
      dt-bindings: imx8mq-clock: Fix the file path
      dt-bindings: imx8mm-clock: Fix the file path

Geert Uytterhoeven (4):
      clk: renesas: rcar-gen3: Add CCREE clocks
      clk: Fix continuation of of_clk_detect_critical()
      clk: renesas: Remove use of ARCH_R8A7795
      dt-bindings: clock: renesas: cpg-mssr: Convert to json-schema

Jernej Skrabec (8):
      clk: sunxi-ng: a64: Export MBUS clock
      clk: sunxi-ng: sun8i-de2: Split out H5 definitions
      clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A64
      clk: sunxi-ng: sun8i-de2: H6 doesn't have rotate core
      clk: sunxi-ng: sun8i-de2: Don't reuse A83T resets
      clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A83T
      clk: sunxi-ng: sun8i-de2: Add R40 specific quirks
      clk: sunxi-ng: sun8i-de2: Sort structures

Jerome Brunet (4):
      clk: meson: gxbb: add the gxl internal dac gate
      clk: meson: gxbb: set audio output clock hierarchy
      Merge branch 'v5.7/dt' into v5.7/drivers
      clk: rockchip: fix mmc get phase

Laurent Pinchart (1):
      clk: imx7d: Add PXP clock

Linus Walleij (3):
      dt-bindings: clock: Create YAML schema for ICST clocks
      clk: versatile: Export icst_clk_setup()
      clk: versatile: Add device tree probing for IM-PD1 clocks

Lubomir Rintel (16):
      clk: mmp2: Remove a unused prototype
      clk: mmp2: Constify some strings
      dt-bindings: clock: Convert marvell,mmp2-clock to json-schema
      clk: mmp2: Add support for PLL clock sources
      clk: mmp2: Stop pretending PLL outputs are constant
      dt-bindings: clock: Add MMP3 compatible string
      clk: mmp2: Check for MMP3
      dt-bindings: marvell,mmp2: Add clock ids for MMP3 PLLs
      clk: mmp2: Add PLLs that are available on MMP3
      dt-bindings: marvell,mmp2: Add clock ids for the GPU clocks
      clk: mmp2: add the GPU clocks
      dt-bindings: marvell,mmp2: Add clock ids for the thermal sensors
      clk: mmp2: Add clocks for the thermal sensors
      dt-bindings: marvell,mmp2: Add clock id for the fifth SD HCI on MMP3
      clk: mmp2: Add clock for fifth SD HCI on MMP3
      clk: mmp2: Fix bit masks for LCDC I/O and pixel clocks

Martin Blumenstingl (1):
      clk: meson: meson8b: set audio output clock hierarchy

Mauro Carvalho Chehab (1):
      MAINTAINERS: dt: update reference for arm-integrator.txt

Maxime Ripard (1):
      clk: Fix phase init check

Mike Looijmans (1):
      clk, clk-si5341: Support multiple input ports

Mike Tipton (1):
      clk: qcom: clk-rpmh: Wait for completion when enabling clocks

Neil Armstrong (1):
      clk: meson: g12a: add support for the SPICC SCLK Source clocks

Paul Cercueil (2):
      clk: ingenic/jz4770: Exit with error if CGU init failed
      clk: ingenic/TCU: Fix round_rate returning error

Peng Fan (12):
      clk: imx: imx8mp: add ocotp root clk
      clk: imx: composite-8m: add imx8m_clk_hw_composite_core
      clk: imx: imx8mq: use imx8m_clk_hw_composite_core
      clk: imx: imx8mm: use imx8m_clk_hw_composite_core
      clk: imx: imx8mn: use imx8m_clk_hw_composite_core
      clk: imx: imx8mq: fix a53 cpu clock
      clk: imx: imx8mm: fix a53 cpu clock
      clk: imx: imx8mn: fix a53 cpu clock
      clk: imx: imx8mp: fix a53 cpu clock
      clk: imx: pfdv2: switch to use determine_rate
      clk: imx: pfdv2: determine best parent rate
      clk: imx: pllv4: use prepare/unprepare

Sowjanya Komatineni (6):
      clk: tegra: Add support for OSC_DIV fixed clocks
      clk: tegra: Add Tegra OSC to clock lookup
      clk: tegra: Fix Tegra PMC clock out parents
      clk: tegra: Remove CLK_M_DIV fixed clocks
      clk: tegra: Remove tegra_pmc_clk_init along with clk ids
      clk: tegra: Remove audio clocks configuration from clock driver

Stephen Boyd (18):
      clk: qcom: alpha-pll: Make error prints more informative
      clk: Don't cache errors from clk_ops::get_phase()
      clk: Use 'parent' to shorten lines in __clk_core_init()
      clk: Move rate and accuracy recalc to mostly consumer APIs
      clk: Bail out when calculating phase fails during clk registration
      Merge tag 'clk-renesas-for-v5.7-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v5.7-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-renesas-for-v5.7-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-5.7' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'for-5.7-clk' of git://git.kernel.org/.../tegra/linux into clk-tegra
      clk: tegra: Use NULL for pointer initialization
      Merge tag 'clk-imx-5.7' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()
      clk: qcom: rpmh: Drop unnecessary semicolons
      Merge branches 'clk-samsung', 'clk-formatting', 'clk-si5341' and 'clk-socfpga' into clk-next
      Merge branches 'clk-phase-errors', 'clk-amlogic', 'clk-renesas' and 'clk-allwinner' into clk-next
      Merge branches 'clk-ti', 'clk-ingenic', 'clk-typo', 'clk-at91', 'clk-mmp2' and 'clk-arm-icst' into clk-next
      Merge branches 'clk-unisoc', 'clk-tegra', 'clk-qcom' and 'clk-imx' into clk-next

Taniya Das (12):
      dt-bindings: clk: qcom: Add support for GPU GX GDSCR
      clk: qcom: gpucc: Add support for GX GDSC for SC7180
      dt-bindings: clock: Add RPMHCC bindings for SM8250
      clk: qcom: rpmh: Add support for RPMH clocks on SM8250
      clk: qcom: clk-alpha-pll: Use common names for defines
      clk: qcom: clk-alpha-pll: Refactor trion PLL
      clk: qcom: clk-alpha-pll: Add support for controlling Lucid PLLs
      dt-bindings: clock: Add SM8250 GCC clock bindings
      clk: qcom: gcc: Add global clock controller driver for SM8250
      dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
      clk: qcom: gcc: Add support for modem clocks in GCC
      clk: qcom: Add modem clock controller driver for SC7180

Thierry Reding (1):
      Merge branch 'for-5.7/dt-bindings' into for-5.7/clk

Vignesh Raghavendra (2):
      dt-bindings: clock: Add binding documentation for TI EHRPWM TBCLK
      clk: keystone: Add new driver to handle syscon based clocks

Wesley Cheng (1):
      clk: qcom: gcc: Add USB3 PIPE clock and GDSC for SM8150

Xiaolong Zhang (1):
      clk: sprd: add gate for pll clocks

Yoshihiro Shimoda (4):
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Fix clock[-name]s properties
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Add power-domains and resets properties
      clk: renesas: rcar-usb2-clock-sel: Add multiple clocks management
      clk: renesas: rcar-usb2-clock-sel: Add reset_control

周琰杰 (Zhou Yanjie) (2):
      clk: Ingenic: Add support for TCU of X1000.
      clk: JZ4780: Add function for enable the second core.

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  300 --
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |  354 ++
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |  103 +
 .../devicetree/bindings/clock/arm-integrator.txt   |   34 -
 .../devicetree/bindings/clock/arm-syscon-icst.txt  |   70 -
 .../devicetree/bindings/clock/imx8mm-clock.txt     |   29 -
 .../devicetree/bindings/clock/imx8mm-clock.yaml    |   68 +
 .../devicetree/bindings/clock/imx8mn-clock.yaml    |   48 +-
 .../devicetree/bindings/clock/imx8mq-clock.txt     |   20 -
 .../devicetree/bindings/clock/imx8mq-clock.yaml    |   72 +
 .../bindings/clock/marvell,mmp2-clock.yaml         |   64 +
 .../devicetree/bindings/clock/marvell,mmp2.txt     |   21 -
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |   72 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    2 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |   62 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |  100 -
 .../bindings/clock/renesas,cpg-mssr.yaml           |  119 +
 .../bindings/clock/renesas,rcar-usb2-clock-sel.txt |   17 +-
 .../clock/{sprd.txt => sprd,sc9860-clk.txt}        |    2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |  105 +
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml      |   35 +
 MAINTAINERS                                        |    2 +-
 drivers/clk/at91/Makefile                          |    4 +
 drivers/clk/at91/at91rm9200.c                      |  199 ++
 drivers/clk/at91/at91sam9g45.c                     |  220 ++
 drivers/clk/at91/at91sam9n12.c                     |  238 ++
 drivers/clk/at91/clk-usb.c                         |    9 +-
 drivers/clk/at91/sam9x60.c                         |   14 +-
 drivers/clk/at91/sama5d3.c                         |  240 ++
 drivers/clk/clk-si5341.c                           |  212 +-
 drivers/clk/clk.c                                  |  127 +-
 drivers/clk/imx/clk-composite-8m.c                 |   20 +-
 drivers/clk/imx/clk-fixup-div.c                    |    2 +-
 drivers/clk/imx/clk-fixup-mux.c                    |    2 +-
 drivers/clk/imx/clk-gate2.c                        |    8 +-
 drivers/clk/imx/clk-imx6sl.c                       |    1 +
 drivers/clk/imx/clk-imx7d.c                        |    1 +
 drivers/clk/imx/clk-imx7ulp.c                      |    2 +-
 drivers/clk/imx/clk-imx8mm.c                       |   63 +-
 drivers/clk/imx/clk-imx8mn.c                       |   41 +-
 drivers/clk/imx/clk-imx8mp.c                       |   24 +-
 drivers/clk/imx/clk-imx8mq.c                       |   53 +-
 drivers/clk/imx/clk-pfdv2.c                        |   61 +-
 drivers/clk/imx/clk-pll14xx.c                      |    4 +
 drivers/clk/imx/clk-pllv4.c                        |   12 +-
 drivers/clk/imx/clk-sscg-pll.c                     |   14 +-
 drivers/clk/imx/clk.h                              |   13 +-
 drivers/clk/ingenic/jz4770-cgu.c                   |    4 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   55 +-
 drivers/clk/ingenic/tcu.c                          |   10 +-
 drivers/clk/keystone/Kconfig                       |    8 +
 drivers/clk/keystone/Makefile                      |    1 +
 drivers/clk/keystone/syscon-clk.c                  |  172 +
 drivers/clk/meson/g12a.c                           |  129 +
 drivers/clk/meson/g12a.h                           |    6 +-
 drivers/clk/meson/gxbb.c                           |   21 +-
 drivers/clk/meson/gxbb.h                           |    2 +-
 drivers/clk/meson/meson8b.c                        |   21 +-
 drivers/clk/mmp/Makefile                           |    2 +-
 drivers/clk/mmp/clk-mix.c                          |    2 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |  146 +-
 drivers/clk/mmp/clk-pll.c                          |  139 +
 drivers/clk/mmp/clk.c                              |   31 +
 drivers/clk/mmp/clk.h                              |   31 +-
 drivers/clk/qcom/Kconfig                           |   16 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  277 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |   12 +
 drivers/clk/qcom/clk-rpm.c                         |   35 +
 drivers/clk/qcom/clk-rpmh.c                        |   79 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |   50 +
 drivers/clk/qcom/gcc-ipq806x.c                     |    2 +
 drivers/clk/qcom/gcc-sc7180.c                      |   72 +-
 drivers/clk/qcom/gcc-sm8150.c                      |   52 +
 drivers/clk/qcom/gcc-sm8250.c                      | 3690 ++++++++++++++++++++
 drivers/clk/qcom/gpucc-sc7180.c                    |   37 +
 drivers/clk/qcom/mss-sc7180.c                      |  143 +
 drivers/clk/renesas/Kconfig                        |    3 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    8 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   10 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |   12 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    2 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    2 +
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |   40 +-
 drivers/clk/rockchip/clk-mmc-phase.c               |    4 +-
 drivers/clk/samsung/clk.c                          |    4 -
 drivers/clk/socfpga/clk-gate-s10.c                 |   40 +-
 drivers/clk/socfpga/clk-periph-s10.c               |   42 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |   17 +-
 drivers/clk/socfpga/clk-s10.c                      |   29 +-
 drivers/clk/socfpga/stratix10-clk.h                |   25 +-
 drivers/clk/sprd/Kconfig                           |    8 +
 drivers/clk/sprd/Makefile                          |    1 +
 drivers/clk/sprd/common.c                          |   10 +-
 drivers/clk/sprd/composite.h                       |   39 +-
 drivers/clk/sprd/div.h                             |   20 +-
 drivers/clk/sprd/gate.c                            |   17 +
 drivers/clk/sprd/gate.h                            |  120 +-
 drivers/clk/sprd/mux.h                             |   28 +-
 drivers/clk/sprd/pll.c                             |    7 +-
 drivers/clk/sprd/pll.h                             |   55 +-
 drivers/clk/sprd/sc9863a-clk.c                     | 1772 ++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |    4 -
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |  115 +-
 drivers/clk/tegra/Makefile                         |    1 -
 drivers/clk/tegra/clk-id.h                         |   12 +-
 drivers/clk/tegra/clk-tegra-fixed.c                |   37 +-
 drivers/clk/tegra/clk-tegra-pmc.c                  |  122 -
 drivers/clk/tegra/clk-tegra114.c                   |   43 +-
 drivers/clk/tegra/clk-tegra124.c                   |   48 +-
 drivers/clk/tegra/clk-tegra20.c                    |    9 +-
 drivers/clk/tegra/clk-tegra210.c                   |   34 +-
 drivers/clk/tegra/clk-tegra30.c                    |   33 +-
 drivers/clk/tegra/clk.h                            |    1 -
 drivers/clk/versatile/clk-icst.c                   |   25 +-
 drivers/clk/versatile/clk-icst.h                   |   22 +
 drivers/clk/versatile/clk-impd1.c                  |   79 +
 include/dt-bindings/clock/imx7d-clock.h            |    3 +-
 include/dt-bindings/clock/imx8mm-clock.h           |   11 +-
 include/dt-bindings/clock/imx8mn-clock.h           |    8 +-
 include/dt-bindings/clock/imx8mp-clock.h           |    5 +-
 include/dt-bindings/clock/imx8mq-clock.h           |    9 +-
 include/dt-bindings/clock/marvell,mmp2.h           |   13 +
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |    7 +-
 include/dt-bindings/clock/qcom,gcc-sm8150.h        |    4 +
 include/dt-bindings/clock/qcom,gcc-sm8250.h        |  271 ++
 include/dt-bindings/clock/qcom,gpucc-sc7180.h      |    3 +-
 include/dt-bindings/clock/qcom,mss-sc7180.h        |   12 +
 include/dt-bindings/clock/qcom,rpmcc.h             |    4 +
 include/dt-bindings/clock/qcom,rpmh.h              |    4 +-
 include/dt-bindings/clock/sprd,sc9863a-clk.h       |  334 ++
 include/dt-bindings/clock/sun50i-a64-ccu.h         |    2 +-
 include/dt-bindings/clock/tegra114-car.h           |    4 +-
 include/dt-bindings/clock/tegra124-car-common.h    |    4 +-
 include/dt-bindings/clock/tegra210-car.h           |    4 +-
 include/dt-bindings/clock/tegra30-car.h            |    4 +-
 include/dt-bindings/soc/tegra-pmc.h                |   16 +
 138 files changed, 10718 insertions(+), 1435 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/arm-integrator.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
 create mode 100644 drivers/clk/at91/at91rm9200.c
 create mode 100644 drivers/clk/at91/at91sam9g45.c
 create mode 100644 drivers/clk/at91/at91sam9n12.c
 create mode 100644 drivers/clk/at91/sama5d3.c
 create mode 100644 drivers/clk/keystone/syscon-clk.c
 create mode 100644 drivers/clk/mmp/clk-pll.c
 create mode 100644 drivers/clk/qcom/gcc-sm8250.c
 create mode 100644 drivers/clk/qcom/mss-sc7180.c
 create mode 100644 drivers/clk/sprd/sc9863a-clk.c
 delete mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8250.h
 create mode 100644 include/dt-bindings/clock/qcom,mss-sc7180.h
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h

-- 
Sent by a computer, using git, on the internet
