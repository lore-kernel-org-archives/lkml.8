Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDFC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A42051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580758737;
	bh=kNdwMN4tsh9aXMFtvosTypp3m+k8nqSMrPgDwk3xx2U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ztjo+JhAEB2KpCh9qUiauo/HfdO6lyYrdCN2jXh+eLy0rfb7yh/W4RZL1njoUqJm3
	 1rKzs24EYNYcV5O4+IzckQNdINNKcsRR8ofVRCYtUJX7DL3h87BZ9uvXJ64T48h8+y
	 Kq64ijh76hZEzqoESniOFo0uE0zsox9ZyMkJn+eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBCTi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgBCTi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:38:56 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B142051A;
        Mon,  3 Feb 2020 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580758735;
        bh=kNdwMN4tsh9aXMFtvosTypp3m+k8nqSMrPgDwk3xx2U=;
        h=From:To:Cc:Subject:Date:From;
        b=St3iACaC1mLUjp1LTcDbJhn6779X7OcJAomWn8/zY/RrFWMqPTW4703bN9CPTMS2z
         7vF6oJqMqNo9lVpk9DtUjOEWIWpDyBc9FaGcBCGSB75GOBEF7W5pWLHmDtpvfHS91v
         2b6PMWenCkKpiyePKLAhNK2xgm1smv6bknBGApk4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Mon,  3 Feb 2020 11:38:54 -0800
Message-Id: <20200203193854.123503-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 12ead77432f2ce32dea797742316d15c5800cb32:

  clk: Don't try to enable critical clocks if prepare failed (2019-12-26 13:59:34 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to fc6a15c853085f04c30e08bbba7d49cb611f7773:

  dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id (2020-02-03 10:33:34 -0800)

----------------------------------------------------------------
There are a few changes to the core framework this time around, in addition to
the normal collection of driver updates to support new SoCs, fix incorrect
data, and convert various drivers to clk_hw based APIs.

In the core, we allow clk_ops::init() to return an error code now so that we
can fail clk registration if the callback does something like fail to allocate
memory. We also add a new "terminate" clk_op so that things done in
clk_ops::init() can be undone, e.g. free memory. We also spit out a warning now
when critical clks fail to enable and we support changing clk rates and
enable/disable state through debugfs when developers compile the kernel
themselves.

On the driver front, we get support for what seems like a lot of Qualcomm and
NXP SoCs given that those vendors dominate the diffstat. There are a couple new
drivers for Xilinx and Amlogic SoCs too. The updates are all small things like
fixing the way glitch free muxes switch parents, avoiding div-by-zero problems,
or fixing data like parent names. See the updates section below for more
details.

Finally, the "basic" clk types have been converted to support specifying
parents with clk_hw pointers. This work includes an overhaul of the fixed-rate
clk type to be more modern by using clk_hw APIs.

Core:
 - Let clk_ops::init() return an error code
 - Add a clk_ops::terminate() callback to undo clk_ops::init()
 - Warn about critical clks that fail to enable or prepare
 - Support dangerous debugfs actions on clks with dead code

New Drivers:
 - Support for Xilinx Versal platform clks
 - Display clk controller on qcom sc7180
 - Video clk controller on qcom sc7180
 - Graphics clk controller on qcom sc7180
 - CPU PLLs for qcom msm8916
 - Move qcom msm8974 gfx3d clk to RPM control
 - Display port clk support on qcom sdm845 SoCs
 - Global clk controller on qcom ipq6018
 - Add a driver for BCLK of Freescale SAI cores
 - Add cam, vpe and sgx clock support for TI dra7
 - Add aess clock support for TI omap5
 - Enable clks for CPUfreq on Allwinner A64 SoCs
 - Add Amlogic meson8b DDR clock controller
 - Add input clocks to Amlogic meson8b controllers
 - Add SPIBSC (SPI FLASH) clock on Renesas RZ/A2
 - i.MX8MP clk driver support

Updates:
 - Convert gpio, fixed-factor, mux, gate, divider basic clks to hw based APIs
 - Detect more PRMCU variants in ux500 driver
 - Adjust the composite clk type to new way of describing clk parents
 - Fixes for clk controllers on qcom msm8998 SoCs
 - Fix gmac main clock for TI dra7
 - Move TI dra7-atl clock header to correct location
 - Fix hidden node name dependency on TI clkctrl clocks
 - Fix Amlogic meson8b mali clock update using the glitch free mux
 - Fix Amlogic pll driver division by zero at init
 - Prepare for split of Renesas R-Car H3 ES1.x and ES2.0+ config symbols
 - Switch more i.MX clk drivers to clk_hw based APIs
 - Disable non-functional divider between pll4_audio_div and
   pll4_post_div on imx6q
 - Fix watchdog2 clock name typo in imx7ulp clock driver
 - Set CLK_GET_RATE_NOCACHE flag for DRAM related clocks on i.MX8M SoCs
 - Suppress bind attrs for i.MX8M clock driver
 - Add a big comment in imx8qxp-lpcg driver to tell why
   devm_platform_ioremap_resource() shouldn't be used for the driver
 - A correction on i.MX8MN usb1_ctrl parent clock setting

----------------------------------------------------------------
Abel Vesa (11):
      clk: imx: Add correct failure handling for clk based helpers
      clk: imx: Rename the SCCG to SSCG
      clk: imx: Replace all the clk based helpers with macros
      clk: imx: pllv1: Switch to clk_hw based API
      clk: imx: pllv2: Switch to clk_hw based API
      clk: imx: imx7ulp composite: Rename to show is clk_hw based
      clk: imx: Rename sccg and frac pll register to suggest clk_hw
      clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
      clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
      clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
      clk: imx7up: Rename the clks to hws

Anson Huang (3):
      clk: imx: gate4: Switch imx_clk_gate4_flags() to clk_hw based API
      dt-bindings: imx: Add clock binding doc for i.MX8MP
      clk: imx: Add support for i.MX8MP clock driver

Benoit Parrot (2):
      clk: ti: dra7: add cam clkctrl data
      clk: ti: dra7: add vpe clkctrl data

Biju Das (1):
      dt-bindings: clock: renesas: cpg-mssr: Fix r8a774b1 typo

Bjorn Andersson (2):
      clk: qcom: gcc-msm8996: Fix parent for CLKREF clocks
      clk: qcom: rpmh: Sort OF match table

Brian Masney (1):
      clk: qcom: mmcc8974: move gfx3d_clk_src from the mmcc to rpm

Chen-Yu Tsai (1):
      clk: sunxi-ng: r40: Export MBUS clock

Chris Brandt (1):
      clk: renesas: r7s9210: Add SPIBSC clock

Corentin Labbe (1):
      clk: sunxi: use of_device_get_match_data

Dafna Hirschfeld (2):
      dt-binding: fix compilation error of the example in qcom,gcc.yaml
      dt-bindings: fix warnings in validation of qcom,gcc.yaml

Dmitry Osipenko (3):
      clk: tegra: divider: Check UART's divider enable-bit state on rate's recalculation
      clk: tegra20/30: Don't pre-initialize displays parent clock
      clk: tegra20/30: Explicitly set parent clock for Video Decoder

Eugen Hristev (2):
      clk: at91: sam9x60-pll: adapt PMC_PLL_ACR default value
      clk: at91: sam9x60: fix programmable clock prescaler

Fabio Estevam (1):
      clk: imx7ulp: Fix watchdog2 clock name typo

Geert Uytterhoeven (4):
      clk: renesas: rcar-gen2: Change multipliers and dividers to u8
      clk: renesas: Remove use of ARCH_R8A7796
      clk: Add support for setting clk_rate via debugfs
      clk: renesas: Prepare for split of R-Car H3 config symbol

Grygorii Strashko (1):
      clk: ti: dra7: fix parent for gmac_clkctrl

Icenowy Zheng (1):
      clk: sunxi-ng: add mux and pll notifiers for A64 CPU clock

Jan Remmet (1):
      clk: imx6q: disable non functional divider

Jeffrey Hugo (6):
      dt-bindings: clock: Document external clocks for MSM8998 gcc
      dt-bindings: clock: Convert qcom,mmcc to DT schema
      dt-bindings: clock: Add support for the MSM8998 mmcc
      clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
      clk: qcom: smd: Add missing bimc clock
      clk: qcom: Add missing msm8998 gcc_bimc_gfx_clk

Jerome Brunet (5):
      clk: meson: g12a: fix missing uart2 in regmap table
      Merge branch 'v5.5/fixes' into v5.6/drivers
      clk: actually call the clock init before any other callback of the clock
      clk: let init callback return an error code
      clk: add terminate callback to clk_ops

Jorge Ramirez-Ortiz (6):
      dt-bindings: mailbox: qcom: Add clock-name optional property
      clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
      clk: qcom: hfpll: register as clock provider
      clk: qcom: hfpll: CLK_IGNORE_UNUSED
      clk: qcom: hfpll: use clk_parent_data to specify the parent
      clk: qcom: apcs-msm8916: silently error out on EPROBE_DEFER

Krzysztof Kozlowski (1):
      clk: Fix Kconfig indentation

Kunihiko Hayashi (1):
      clk: uniphier: Add SCSSI clock gate for each channel

Leonard Crestez (4):
      clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
      clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
      clk: imx8m: Suppress bind attrs
      clk: imx8qxp-lpcg: Warn against devm_platform_ioremap_resource

Li Jun (1):
      clk: imx8mn: correct the usb1_ctrl parent to be usb_bus

Linus Walleij (1):
      clk: ux500: Fix up the SGA clock for some variants

Martin Blumenstingl (9):
      dt-bindings: clock: add the Amlogic Meson8 DDR clock controller binding
      dt-bindings: clock: meson8b: add the clock inputs
      clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
      clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
      clk: meson: meson8b: change references to the XTAL clock to use [fw_]name
      clk: meson: meson8b: don't register the XTAL clock when provided via OF
      clk: meson: meson8b: use of_clk_hw_register to register the clocks
      clk: meson: meson8b: make the CCF use the glitch-free mali mux
      clk: clarify that clk_set_rate() does updates from top to bottom

Maxime Ripard (2):
      clk: sunxi: a31: Export the MIPI PLL
      clk: sunxi: a23/a33: Export the MIPI PLL

Michael Walle (3):
      clk: composite: add _register_composite_pdata() variants
      dt-bindings: clock: document the fsl-sai driver
      clk: fsl-sai: new driver

Niklas Cassel (1):
      clk: qcom: apcs-msm8916: use clk_parent_data to specify the parent

Peng Fan (11):
      clk: imx: clk-divider-gate: fix a typo in comment
      clk: imx: clk-divider-gate: drop redundant initialization
      clk: imx: clk-pll14xx: Switch to clk_hw based API
      clk: imx: clk-composite-8m: Switch to clk_hw based API
      clk: imx: add imx_unregister_hw_clocks
      clk: imx: add hw API imx_clk_hw_mux2_flags
      clk: imx: gate3: Switch to clk_hw based API
      clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
      clk: imx: imx8mn: Switch to clk_hw based API
      clk: imx: imx8mm: Switch to clk_hw based API
      clk: imx: imx8mq: Switch to clk_hw based API

Peter Ujfalusi (1):
      dt-bindings: clock: Move ti-dra7-atl.h to dt-bindings/clock

Rajan Vaja (5):
      dt-bindings: clock: Add bindings for versal clock driver
      clk: zynqmp: Extend driver for versal
      clk: zynqmp: Warn user if clock user are more than allowed
      clk: zynqmp: Add support for get max divider
      clk: zynqmp: Fix divider calculation

Remi Pommarel (1):
      clk: meson: pll: Fix by 0 division in __pll_params_to_rate()

Sergei Shtylyov (1):
      clk: renesas: rcar-gen3: Allow changing the RPC[D2] clocks

Sowjanya Komatineni (1):
      clk: tegra: clk-dfll: Remove call to pm_runtime_irq_safe()

Sricharan R (2):
      clk: qcom: Add DT bindings for ipq6018 gcc clock controller
      clk: qcom: Add ipq6018 Global Clock Controller support

Stephen Boyd (27):
      clk: Use parent node pointer during registration if necessary
      Merge branch 'clk-register-dt-node-better' into clk-qcom
      clk: Warn about critical clks that fail to enable
      clk: gpio: Use DT way of specifying parents
      clk: fixed-rate: Convert to clk_hw based APIs
      clk: fixed-rate: Remove clk_register_fixed_rate_with_accuracy()
      clk: fixed-rate: Move to_clk_fixed_rate() to C file
      clk: fixed-rate: Document accuracy member
      clk: fixed-rate: Add support for specifying parents via DT/pointers
      clk: fixed-rate: Add clk flags for parent accuracy
      clk: fixed-rate: Document that accuracy isn't a rate
      clk: asm9260: Use parent accuracy in fixed rate clk
      clk: mux: Add support for specifying parents via DT/pointers
      clk: gate: Add support for specifying parents via DT/pointers
      clk: divider: Add support for specifying parents via DT/pointers
      Merge tag 'clk-renesas-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v5.6-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-5.6' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'imx-clk-5.6' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'ti-clk-for-5.6' of git://git.kernel.org/.../kristo/linux into clk-ti
      Merge tag 'for-5.6-clk' of git://git.kernel.org/.../tegra/linux into clk-nvidia
      Merge branches 'clk-init-allocation', 'clk-unused' and 'clk-register-dt-node-better' into clk-next
      Merge branches 'clk-uniphier', 'clk-warn-critical', 'clk-ux500', 'clk-kconfig' and 'clk-at91' into clk-next
      Merge branches 'clk-debugfs-danger', 'clk-basic-hw', 'clk-renesas', 'clk-amlogic' and 'clk-allwinner' into clk-next
      Merge branches 'clk-imx', 'clk-ti', 'clk-xilinx', 'clk-nvidia', 'clk-qcom', 'clk-freescale' and 'clk-qoriq' into clk-next
      clk: ls1028a: Fix warning on clamp() usage
      dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id

Stephen Warren (1):
      clk: tegra: Mark fuse clock as critical

Taniya Das (15):
      clk: qcom: rcg2: Add support for display port clock ops
      clk: qcom: dispcc: Add support for display port clocks
      clk: qcom: alpha-pll: Remove useless read from set rate
      clk: qcom: clk-alpha-pll: Add support for Fabia PLL calibration
      dt-bindings: clock: Add YAML schemas for the QCOM DISPCC clock bindings
      dt-bindings: clock: Introduce QCOM sc7180 display clock bindings
      clk: qcom: Add display clock controller driver for SC7180
      dt-bindings: clock: Add YAML schemas for the QCOM GPUCC clock bindings
      dt-bindings: clock: Introduce SC7180 QCOM Graphics clock bindings
      clk: qcom: Add graphics clock controller driver for SC7180
      dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings
      dt-bindings: clock: Introduce SC7180 QCOM Video clock bindings
      clk: qcom: Add video clock controller driver for SC7180
      clk: qcom: rpmh: skip undefined clocks when registering
      clk: qcom: rpmh: Add IPA clock for SC7180

Tejas Patel (1):
      clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag

Tony Lindgren (3):
      clk: ti: omap5: Add missing AESS clock
      clk: ti: add clkctrl data dra7 sgx
      clk: ti: clkctrl: Fix hidden dependency to node name

Vasily Khoruzhick (1):
      clk: sunxi-ng: a64: export CLK_CPUX clock for DVFS

Wen He (2):
      dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
      clk: ls1028a: Add clock driver for Display output interface

Yangbo Lu (1):
      clk: qoriq: add ls1088a hwaccel clocks support

YueHaibing (1):
      clk: bm1800: Remove set but not used variable 'fref'

 .../bindings/clock/amlogic,meson8-ddr-clkc.yaml    |   50 +
 .../bindings/clock/amlogic,meson8b-clkc.txt        |    5 +
 .../devicetree/bindings/clock/fsl,plldig.yaml      |   54 +
 .../devicetree/bindings/clock/fsl,sai-clock.yaml   |   55 +
 .../devicetree/bindings/clock/imx8mp-clock.yaml    |   68 +
 .../devicetree/bindings/clock/qcom,dispcc.txt      |   19 -
 .../devicetree/bindings/clock/qcom,dispcc.yaml     |   67 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |   87 +-
 .../devicetree/bindings/clock/qcom,gpucc.txt       |   24 -
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |   72 +
 .../devicetree/bindings/clock/qcom,mmcc.txt        |   28 -
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   98 +
 .../devicetree/bindings/clock/qcom,videocc.txt     |   18 -
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   62 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |    2 +-
 .../devicetree/bindings/clock/ti-clkctrl.txt       |   11 +-
 .../devicetree/bindings/clock/ti/dra7-atl.txt      |    4 +-
 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   64 +
 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   24 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             |    2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |    2 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   14 +
 drivers/clk/Kconfig                                |   24 +-
 drivers/clk/Makefile                               |    2 +
 drivers/clk/at91/clk-sam9x60-pll.c                 |    8 +-
 drivers/clk/at91/sam9x60.c                         |    1 +
 drivers/clk/clk-asm9260.c                          |    8 +-
 drivers/clk/clk-bm1880.c                           |    3 +-
 drivers/clk/clk-composite.c                        |   56 +-
 drivers/clk/clk-divider.c                          |   91 +-
 drivers/clk/clk-fixed-rate.c                       |  113 +-
 drivers/clk/clk-fsl-sai.c                          |   92 +
 drivers/clk/clk-gate.c                             |   35 +-
 drivers/clk/clk-gpio.c                             |  172 +-
 drivers/clk/clk-mux.c                              |   58 +-
 drivers/clk/clk-plldig.c                           |  286 ++
 drivers/clk/clk-qoriq.c                            |   29 +
 drivers/clk/clk.c                                  |  110 +-
 drivers/clk/imx/Kconfig                            |    6 +
 drivers/clk/imx/Makefile                           |    3 +-
 drivers/clk/imx/clk-composite-7ulp.c               |    2 +-
 drivers/clk/imx/clk-composite-8m.c                 |    4 +-
 drivers/clk/imx/clk-divider-gate.c                 |   12 +-
 drivers/clk/imx/clk-frac-pll.c                     |    7 +-
 drivers/clk/imx/clk-imx6q.c                        |    5 +-
 drivers/clk/imx/clk-imx7ulp.c                      |  182 +-
 drivers/clk/imx/clk-imx8mm.c                       |  565 +--
 drivers/clk/imx/clk-imx8mn.c                       |  498 ++-
 drivers/clk/imx/clk-imx8mp.c                       |  764 ++++
 drivers/clk/imx/clk-imx8mq.c                       |  584 +--
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |   11 +
 drivers/clk/imx/clk-pfdv2.c                        |    2 +-
 drivers/clk/imx/clk-pll14xx.c                      |   29 +-
 drivers/clk/imx/clk-pllv1.c                        |   14 +-
 drivers/clk/imx/clk-pllv2.c                        |   14 +-
 drivers/clk/imx/clk-pllv4.c                        |    2 +-
 drivers/clk/imx/{clk-sccg-pll.c => clk-sscg-pll.c} |  152 +-
 drivers/clk/imx/clk.c                              |   12 +-
 drivers/clk/imx/clk.h                              |  162 +-
 drivers/clk/mediatek/Kconfig                       |   44 +-
 drivers/clk/meson/Makefile                         |    2 +-
 drivers/clk/meson/clk-mpll.c                       |    4 +-
 drivers/clk/meson/clk-phase.c                      |    4 +-
 drivers/clk/meson/clk-pll.c                        |   13 +-
 drivers/clk/meson/g12a.c                           |    1 +
 drivers/clk/meson/meson8-ddr.c                     |  149 +
 drivers/clk/meson/meson8b.c                        |  124 +-
 drivers/clk/meson/sclk-div.c                       |    4 +-
 drivers/clk/microchip/clk-core.c                   |    8 +-
 drivers/clk/mmp/clk-frac.c                         |    4 +-
 drivers/clk/mmp/clk-mix.c                          |    4 +-
 drivers/clk/mvebu/Kconfig                          |    2 +-
 drivers/clk/qcom/Kconfig                           |   47 +-
 drivers/clk/qcom/Makefile                          |    5 +
 drivers/clk/qcom/apcs-msm8916.c                    |   13 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   91 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    5 +
 drivers/clk/qcom/clk-hfpll.c                       |    6 +-
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   77 +
 drivers/clk/qcom/clk-rpmh.c                        |   10 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |    5 +
 drivers/clk/qcom/dispcc-sc7180.c                   |  776 ++++
 drivers/clk/qcom/dispcc-sdm845.c                   |  214 +-
 drivers/clk/qcom/gcc-ipq6018.c                     | 4635 ++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8996.c                     |   35 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   14 +
 drivers/clk/qcom/gcc-qcs404.c                      |    2 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |  266 ++
 drivers/clk/qcom/hfpll.c                           |   21 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |   13 -
 drivers/clk/qcom/mmcc-msm8998.c                    | 2913 ++++++++++++
 drivers/clk/qcom/videocc-sc7180.c                  |  259 ++
 drivers/clk/renesas/Kconfig                        |    4 +-
 drivers/clk/renesas/r7s9210-cpg-mssr.c             |    1 +
 drivers/clk/renesas/rcar-gen2-cpg.h                |    8 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |    6 +-
 drivers/clk/rockchip/clk-pll.c                     |   28 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   28 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |    1 -
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h           |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |    4 -
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |    6 +-
 drivers/clk/tegra/clk-dfll.c                       |    3 +-
 drivers/clk/tegra/clk-divider.c                    |    9 +-
 drivers/clk/tegra/clk-tegra-periph.c               |    6 +-
 drivers/clk/tegra/clk-tegra20.c                    |    4 +-
 drivers/clk/tegra/clk-tegra30.c                    |    4 +-
 drivers/clk/ti/clk-54xx.c                          |   15 +
 drivers/clk/ti/clk-7xx.c                           |   62 +-
 drivers/clk/ti/clk.c                               |    4 +-
 drivers/clk/ti/clkctrl.c                           |   96 +-
 drivers/clk/ti/clock.h                             |    2 +-
 drivers/clk/ti/clockdomain.c                       |    8 +-
 drivers/clk/uniphier/clk-uniphier-peri.c           |   13 +-
 drivers/clk/ux500/u8500_of_clk.c                   |    2 +
 drivers/clk/versatile/Kconfig                      |    2 +-
 drivers/clk/zynqmp/clkc.c                          |    3 +-
 drivers/clk/zynqmp/divider.c                       |  118 +-
 drivers/clk/zynqmp/pll.c                           |    6 +-
 drivers/firmware/xilinx/zynqmp.c                   |    2 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |    4 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c         |    4 +-
 drivers/net/phy/mdio-mux-meson-g12a.c              |    4 +-
 include/dt-bindings/clock/dra7.h                   |   23 +
 include/dt-bindings/clock/imx8mp-clock.h           |  300 ++
 include/dt-bindings/clock/meson8-ddr-clkc.h        |    4 +
 include/dt-bindings/clock/omap5.h                  |    1 +
 include/dt-bindings/clock/qcom,dispcc-sc7180.h     |   46 +
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   13 +-
 include/dt-bindings/clock/qcom,gcc-ipq6018.h       |  262 ++
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |    1 +
 include/dt-bindings/clock/qcom,gpucc-sc7180.h      |   21 +
 include/dt-bindings/clock/qcom,mmcc-msm8998.h      |  210 +
 include/dt-bindings/clock/qcom,videocc-sc7180.h    |   23 +
 include/dt-bindings/clock/sun50i-a64-ccu.h         |    1 +
 include/dt-bindings/clock/sun6i-a31-ccu.h          |    2 +
 include/dt-bindings/clock/sun8i-a23-a33-ccu.h      |    2 +
 include/dt-bindings/clock/sun8i-r40-ccu.h          |    2 +-
 include/dt-bindings/{clk => clock}/ti-dra7-atl.h   |    0
 include/dt-bindings/clock/xlnx-versal-clk.h        |  123 +
 include/dt-bindings/reset/qcom,gcc-ipq6018.h       |  157 +
 include/linux/clk-provider.h                       |  444 +-
 include/linux/clk.h                                |    3 +
 include/linux/firmware/xlnx-zynqmp.h               |    2 +
 146 files changed, 15018 insertions(+), 1806 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
 create mode 100644 drivers/clk/clk-fsl-sai.c
 create mode 100644 drivers/clk/clk-plldig.c
 create mode 100644 drivers/clk/imx/clk-imx8mp.c
 rename drivers/clk/imx/{clk-sccg-pll.c => clk-sscg-pll.c} (70%)
 create mode 100644 drivers/clk/meson/meson8-ddr.c
 create mode 100644 drivers/clk/qcom/dispcc-sc7180.c
 create mode 100644 drivers/clk/qcom/gcc-ipq6018.c
 create mode 100644 drivers/clk/qcom/gpucc-sc7180.c
 create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
 create mode 100644 drivers/clk/qcom/videocc-sc7180.c
 create mode 100644 include/dt-bindings/clock/imx8mp-clock.h
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc7180.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq6018.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc7180.h
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sc7180.h
 rename include/dt-bindings/{clk => clock}/ti-dra7-atl.h (100%)
 create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq6018.h

-- 
Sent by a computer, using git, on the internet
