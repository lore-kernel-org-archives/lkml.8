Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9952074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596830543;
	bh=C+7asLDriCYEDRRBcKx9zx5zJb59QUfuNMAsgzrUPkU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DyVkOpouq/eiJ6TXS7oUvx9cpaqeRSFGKgC36J04QSKXVseXPsD5t1Lll74dak+Yl
	 1HeQewZBBPvzEzqm0cJmxMVjgBKAS7NZ9r6iGYAYt8AxghyhR4RJhcJtQvDW8hE3N0
	 BqO0+6GxjQA7kHJCijc3m0gsJRT6SheFP3BQCfKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHGUCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHGUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:02:21 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2FC2074D;
        Fri,  7 Aug 2020 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596830540;
        bh=C+7asLDriCYEDRRBcKx9zx5zJb59QUfuNMAsgzrUPkU=;
        h=From:To:Cc:Subject:Date:From;
        b=SWr+fJoH9tnckuS/pJIaK2jU5JnQGazVWE8BvozXV7NFW5iUfo2bM3msUeE9mgi4C
         ekgZebCOkbMlnHsoS10yMNf+u9H2TNR/u1Pk/7NMNn1SHdSQsyNz2l7QTsUvpCEwFx
         VQJU/cFqxqVB5VkcfSv0ibuJkhlwjcaJfOPWhdtg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri,  7 Aug 2020 13:02:19 -0700
Message-Id: <20200807200219.463265-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e7468bd9d30a21e059af477106dc5588ae52dff:

  clk: Specify IOMEM dependency for HSDK pll driver (2020-07-11 09:28:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 63e95849a774140ea0825f99be35765758bb7341:

  Merge branch 'clk-imx' into clk-next (2020-07-21 01:03:16 -0700)

----------------------------------------------------------------
It looks like a smaller batch of clk updates this time around. In the core
framework we just have some minor tweaks and a debugfs feature, so not much to
see there. The driver updates are fairly well split between AT91 and Qualcomm
clk support. Adding those two drivers together equals about 50% of the
diffstat. Otherwise, the big amount of work this time was on supporting
Broadcom's Raspberry Pi firmware clks. See below for some more highlights.

Core:
 - Document clk_hw_round_rate() so it gets some more use
 - Remove unused __clk_get_flags()
 - Add a prepare/enable debugfs feature similar to rate setting

New Drivers:
 - Add support for SAMA7G5 SoC clks
 - Enable CPU clks on Qualcomm IPQ6018 SoCs
 - Enable CPU clks on Qualcomm MSM8996 SoCs
 - GPU clk support for Qualcomm SM8150 and SM8250 SoCs
 - Audio clks on Qualcomm SC7180 SoCs
 - Microchip Sparx5 DPLL clk
 - Add support for the new Renesas RZ/G2H (R8A774E1) SoC

Updates:
 - Make defines for bcm63xx-gate clks to use in DT
 - Support BCM2711 SoC firmware clks
 - Add HDMI clks for BCM2711 SoCs
 - Add RTC related clks on Ingenic SoCs
 - Support USB PHY clks on Ingenic SoCs
 - Support gate clks on BCM6318 SoCs
 - RMU and DMAC/GPIO clock support for Actions Semi S500 SoCs
 - Use poll_timeout functions in Rockchip clk driver
 - Support Rockchip rk3288w SoC variant
 - Mark mac_lbtest critical on Rockchip rk3188
 - Add CAAM clock support for i.MX vf610 driver
 - Add MU root clock support for i.MX imx8mp driver
 - Amlogic g12: add neural network accelerator clock sources
 - Amlogic meson8: remove critical flag for main PLL divider
 - Amlogic meson8: add video decoder clock gates
 - Convert one more Renesas DT binding to json-schema
 - Enhance critical clock handling on Renesas platforms to only consider
   clocks that were enabled at boot time

----------------------------------------------------------------
Adam Ford (3):
      clk: vc5: Allow Versaclock driver to support multiple instances
      dt: Add additional option bindings for IDT VersaClock
      clk: vc5: Enable addition output configurations of the Versaclock

Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: Common CLK framework

Andrey Smirnov (1):
      clk: imx: vf610: add CAAM clock

Andy Shevchenko (1):
      clk: Drop duplicate selection in Kconfig

Ansuel Smith (1):
      ipq806x: gcc: add support for child probe

Dinh Nguyen (3):
      dt-bindings: agilex: add NAND_X_CLK and NAND_ECC_CLK
      clk: socfpga: agilex: add nand_x_clk and nand_ecc_clk
      clk: socfpga: agilex: mpu_l2ram_clk should be mpu_ccu_clk

Dmitry Shmidt (2):
      dt-bindings: clk: g12a-clkc: Add NNA CLK Source clock IDs
      clk: meson: g12a: Add support for NNA CLK source clocks

Florian Fainelli (1):
      dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML

Geert Uytterhoeven (2):
      dt-bindings: clock: renesas: cpg: Convert to json-schema
      Merge tag 'renesas-r8a774e1-dt-binding-defs-tag' into clk-renesas-for-v5.9

Ilia Lin (2):
      soc: qcom: Separate kryo l2 accessors from PMU driver
      dt-bindings: clk: qcom: Add bindings for CPU clock for msm8996

Konrad Dybcio (2):
      clk: qcom: smd: Add support for SDM660 rpm clocks
      clk: qcom: smd: Add support for MSM8992/4 rpm clocks

Loic Poulain (1):
      clk: qcom: Add CPU clock driver for msm8996

Marian-Cristian Rotariu (4):
      dt-bindings: power: Add r8a774e1 SYSC power domain definitions
      clk: renesas: Add r8a774e1 CPG Core Clock Definitions
      dt-bindings: clock: renesas,cpg-mssr: Document r8a774e1
      clk: renesas: cpg-mssr: Add r8a774e1 support

Martin Blumenstingl (3):
      clk: meson: meson8b: Drop CLK_IS_CRITICAL from fclk_div2
      clk: meson: meson8b: add the vclk_en gate clock
      clk: meson: meson8b: add the vclk2_en gate clock

Maxime Ripard (30):
      reset: Move reset-simple header out of drivers/reset
      reset: simple: Add reset callback
      dt-bindings: clock: Add BCM2711 DVP binding
      clk: bcm: Add BCM2711 DVP driver
      dt-bindings: clock: Add a binding for the RPi Firmware clocks
      firmware: rpi: Only create clocks device if we don't have a node for it
      clk: bcm: rpi: Allow the driver to be probed by DT
      clk: bcm: rpi: Statically init clk_init_data
      clk: bcm: rpi: Use clk_hw_register for pllb_arm
      clk: bcm: rpi: Remove global pllb_arm clock pointer
      clk: bcm: rpi: Make sure pllb_arm is removed
      clk: bcm: rpi: Remove pllb_arm_lookup global pointer
      clk: bcm: rpi: Switch to clk_hw_register_clkdev
      clk: bcm: rpi: Make sure the clkdev lookup is removed
      clk: bcm: rpi: Use CCF boundaries instead of rolling our own
      clk: bcm: rpi: Create a data structure for the clocks
      clk: bcm: rpi: Add clock id to data
      clk: bcm: rpi: Pass the clocks data to the firmware function
      clk: bcm: rpi: Rename is_prepared function
      clk: bcm: rpi: Split pllb clock hooks
      clk: bcm: rpi: Make the PLLB registration function return a clk_hw
      clk: bcm: rpi: Add DT provider for the clocks
      clk: bcm: rpi: Add an enum for the firmware clocks
      clk: bcm: rpi: Discover the firmware clocks
      clk: bcm: rpi: Give firmware clocks a name
      Revert "clk: bcm2835: remove pllb"
      clk: bcm2835: Allow custom CCF flags for the PLLs
      clk: bcm2835: Don't cache the PLLB rate
      clk: bcm: rpi: Remove the quirks for the CPU clock
      clk: bcm: dvp: Add missing module informations

Peng Fan (1):
      clk: imx8mp: add mu root clk

Randy Dunlap (1):
      clk: <linux/clk-provider.h>: drop a duplicated word

Sarang Mairal (1):
      clk: add function documentation for clk_hw_round_rate()

Sivaprakash Murugesan (7):
      dt-bindings: clock: add ipq6018 a53 pll compatible
      clk: qcom: Add ipq apss pll driver
      clk: qcom: Add DT bindings for ipq6018 apss clock controller
      clk: qcom: Add ipq6018 apss clock controller
      dt-bindings: clock: qcom: ipq8074: Add missing bindings for PCIe
      clk: qcom: ipq8074: Add missing clocks for pcie
      clk: qcom: ipq8074: Add correct index for PCIe clocks

Stephen Boyd (21):
      Merge branch 'reset/simple' of git://git.pengutronix.de/git/pza/linux into clk-bcm
      Merge branch 'clk-socfpga' into clk-next
      Merge branch 'clk-doc' into clk-next
      Merge branch 'clk-qcom' into clk-next
      Merge branch 'clk-vc5' into clk-next
      Merge branch 'clk-bcm' into clk-next
      Merge branch 'clk-qcom' into clk-next
      Merge branch 'clk-https' into clk-next
      Merge tag 'clk-renesas-for-v5.9-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge branch 'clk-renesas' into clk-next
      Merge branch 'clk-qcom' into clk-next
      Merge branch 'clk-kconfig' into clk-next
      Merge branch 'clk-fixes' into clk-next
      Merge branch 'clk-doc' into clk-next
      Merge branch 'clk-qcom' into clk-next
      Merge tag 'clk-renesas-for-v5.9-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge branch 'clk-renesas' into clk-next
      Merge tag 'clk-meson-v5.9-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge branch 'clk-amlogic' into clk-next
      Merge tag 'clk-imx-5.9' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge branch 'clk-imx' into clk-next

Taniya Das (1):
      clk: qcom: gcc: Make disp gpll0 branch aon for sc7180/sdm845

Ulrich Hecht (3):
      clk: renesas: cpg-mssr: Mark clocks as critical only if on at boot
      clk: renesas: rcar-gen3: Mark RWDT clocks as critical
      clk: renesas: rzg2: Mark RWDT clocks as critical

Vincent Knecht (2):
      dt-bindings: clock: rpmcc: Document MSM8936 compatible
      clk: qcom: smd: Add support for MSM8936 rpm clocks

Wei Yongjun (2):
      clk: qcom: Fix return value check in apss_ipq6018_probe()
      clk: qcom: msm8996: Make symbol 'cpu_msm8996_clks' static

Álvaro Fernández Rojas (11):
      clk: bcm63xx-gate: fix last clock availability
      dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
      clk: bcm63xx-gate: add BCM6318 support
      mips: bmips: add BCM3368 clock definitions
      mips: bmips: add BCM6318 clock definitions
      mips: bmips: add BCM6328 clock definitions
      mips: bmips: add BCM6358 clock definitions
      mips: bmips: add BCM6362 clock definitions
      mips: bmips: add BCM6368 clock definitions
      mips: bmips: add BCM63268 clock definitions
      clk: bcm63xx-gate: switch to dt-bindings definitions

 .../arm/bcm/raspberrypi,bcm2835-firmware.txt       |  14 -
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  59 +++
 .../bindings/clock/brcm,bcm2711-dvp.yaml           |  47 ++
 .../bindings/clock/brcm,bcm63xx-clocks.txt         |   2 +
 .../devicetree/bindings/clock/clock-bindings.txt   |   2 +-
 .../devicetree/bindings/clock/idt,versaclock5.txt  |  33 ++
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |  21 +-
 .../bindings/clock/qcom,msm8996-apcc.yaml          |  56 +++
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |   4 +
 .../bindings/clock/renesas,cpg-clocks.yaml         | 241 +++++++++
 .../bindings/clock/renesas,cpg-mssr.yaml           |   1 +
 .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |  33 --
 .../bindings/clock/renesas,r8a7740-cpg-clocks.txt  |  41 --
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  47 --
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  49 --
 .../bindings/clock/renesas,rz-cpg-clocks.txt       |  53 --
 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  35 --
 .../devicetree/bindings/clock/silabs,si514.txt     |   2 +-
 .../devicetree/bindings/clock/silabs,si5351.txt    |   2 +-
 .../devicetree/bindings/clock/silabs,si570.txt     |   4 +-
 .../devicetree/bindings/clock/ti,cdce706.txt       |   2 +-
 .../devicetree/bindings/clock/ti,cdce925.txt       |   8 +-
 drivers/clk/Kconfig                                |   2 -
 drivers/clk/bcm/Kconfig                            |  11 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-bcm2711-dvp.c                  | 124 +++++
 drivers/clk/bcm/clk-bcm2835.c                      |  34 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 | 553 +++++++++++++++++----
 drivers/clk/bcm/clk-raspberrypi.c                  | 311 +++++++-----
 drivers/clk/clk-cdce706.c                          |   2 +-
 drivers/clk/clk-gpio.c                             |   2 +-
 drivers/clk/clk-si5351.c                           |   4 +-
 drivers/clk/clk-versaclock5.c                      | 240 +++++++--
 drivers/clk/clk.c                                  |  15 +
 drivers/clk/imx/clk-imx8mp.c                       |   1 +
 drivers/clk/imx/clk-vf610.c                        |   1 +
 drivers/clk/keystone/sci-clk.c                     |   2 +-
 drivers/clk/keystone/syscon-clk.c                  |   2 +-
 drivers/clk/meson/g12a.c                           | 119 +++++
 drivers/clk/meson/g12a.h                           |   7 +-
 drivers/clk/meson/meson8b.c                        |  67 ++-
 drivers/clk/meson/meson8b.h                        |   6 +-
 drivers/clk/qcom/Kconfig                           |  28 ++
 drivers/clk/qcom/Makefile                          |   3 +
 drivers/clk/qcom/apss-ipq-pll.c                    |  95 ++++
 drivers/clk/qcom/apss-ipq6018.c                    | 106 ++++
 drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 538 ++++++++++++++++++++
 drivers/clk/qcom/clk-smd-rpm.c                     | 297 +++++++++++
 drivers/clk/qcom/gcc-ipq806x.c                     |   2 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |  60 +++
 drivers/clk/qcom/gcc-sc7180.c                      |   2 +-
 drivers/clk/qcom/gcc-sdm845.c                      |   4 +-
 drivers/clk/renesas/Kconfig                        |   5 +
 drivers/clk/renesas/Makefile                       |   1 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |   1 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |   1 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |   1 +
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            | 349 +++++++++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   2 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   2 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |   1 +
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |   2 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |   2 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |   1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |   2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |  23 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
 drivers/clk/socfpga/clk-agilex.c                   |   8 +-
 drivers/clk/versatile/icst.c                       |   2 +-
 drivers/clk/versatile/icst.h                       |   2 +-
 drivers/firmware/raspberrypi.c                     |  14 +
 drivers/perf/Kconfig                               |   1 +
 drivers/perf/qcom_l2_pmu.c                         |  90 +---
 drivers/reset/reset-simple.c                       |  23 +-
 drivers/reset/reset-socfpga.c                      |   3 +-
 drivers/reset/reset-sunxi.c                        |   3 +-
 drivers/reset/reset-uniphier-glue.c                |   3 +-
 drivers/soc/qcom/Kconfig                           |   4 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  57 +++
 include/dt-bindings/clk/versaclock.h               |  13 +
 include/dt-bindings/clock/agilex-clock.h           |   4 +-
 include/dt-bindings/clock/bcm3368-clock.h          |  24 +
 include/dt-bindings/clock/bcm6318-clock.h          |  42 ++
 include/dt-bindings/clock/bcm63268-clock.h         |  30 ++
 include/dt-bindings/clock/bcm6328-clock.h          |  19 +
 include/dt-bindings/clock/bcm6358-clock.h          |  18 +
 include/dt-bindings/clock/bcm6362-clock.h          |  26 +
 include/dt-bindings/clock/bcm6368-clock.h          |  24 +
 include/dt-bindings/clock/g12a-clkc.h              |   2 +
 include/dt-bindings/clock/qcom,apss-ipq.h          |  12 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |   4 +
 include/dt-bindings/clock/qcom,rpmcc.h             |  16 +
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h      |  59 +++
 include/dt-bindings/clock/vf610-clock.h            |   3 +-
 include/dt-bindings/power/r8a774e1-sysc.h          |  36 ++
 include/linux/clk-provider.h                       |   2 +-
 {drivers => include/linux}/reset/reset-simple.h    |   7 +
 include/soc/qcom/kryo-l2-accessors.h               |  12 +
 100 files changed, 3669 insertions(+), 690 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/bcm/clk-bcm2711-dvp.c
 create mode 100644 drivers/clk/qcom/apss-ipq-pll.c
 create mode 100644 drivers/clk/qcom/apss-ipq6018.c
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/clk/renesas/r8a774e1-cpg-mssr.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/dt-bindings/clk/versaclock.h
 create mode 100644 include/dt-bindings/clock/bcm3368-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6318-clock.h
 create mode 100644 include/dt-bindings/clock/bcm63268-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6328-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6358-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6362-clock.h
 create mode 100644 include/dt-bindings/clock/bcm6368-clock.h
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
 rename {drivers => include/linux}/reset/reset-simple.h (74%)
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
