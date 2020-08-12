Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D378A20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597253988;
	bh=Cm/kTyTPG9sDpDjUSOWah8lg+mvIs3lh9zRio7IdUBY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yQqrPW3ShJAXH2vGQi+DXQVk+BhGRkUQis5za8DYuknBxtV3zYefDj6aQ4aJFtTDu
	 Ehrt4qV9C9ZiL6hga9GADdOHWAvReQ4gh5gByQxPMaxtmXEcWFUKiaVDUt0QD/CB+g
	 I/65mYD77wlWpAhNvBYvHEGjtXtodL/qVumTGVYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLRjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHLRjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:39:44 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458C620781;
        Wed, 12 Aug 2020 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597253983;
        bh=Cm/kTyTPG9sDpDjUSOWah8lg+mvIs3lh9zRio7IdUBY=;
        h=From:To:Cc:Subject:Date:From;
        b=z2Ax6J7a0YqZdH4DWIc9gRScu3iyX1j2f9vkiUTTtrPh4zHyAzHm9dYOvnnwezZTQ
         L/nGVcKt+7lFoqUk95e2ftA/N7/IPddwFsIBMDqeD1Slr0495nYCWxh3EmZYWuu39a
         2sLXYNpXfF2JPpq9h6twYReb4CX5gtbJ0qZgbB0s=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] More clk changes for the merge window
Date:   Wed, 12 Aug 2020 10:39:42 -0700
Message-Id: <20200812173942.1753107-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 22b1408b0d282c1cd09846f8e3fe3a1e9b962eb4:

  Merge tag 'clk-imx-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into clk-imx (2020-07-21 01:02:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to dd9c697a944a02066877404b01e9fb7dcb3a2218:

  Merge branches 'clk-microchip', 'clk-mmp', 'clk-unused' and 'clk-at91' into clk-next (2020-08-03 15:07:18 -0700)

----------------------------------------------------------------
Here's some more updates that missed the last pull request because I
happened to tag the tree at an earlier point in the history of clk-next.
I must have fat fingered it and checked out an older version of clk-next
on this second computer I'm using.

This time it actually includes more code for Qualcomm SoCs, the AT91
major updates, and some Rockchip SoC clk driver updates as well. I've
corrected this flow so this shouldn't happen again.

----------------------------------------------------------------
Adam Ford (1):
      clk: vc5: Add memory check to prevent oops

Ahmad Fatoum (1):
      clk: at91: fix possible dead lock in new drivers

Alex Bee (1):
      clk: rockchip: add sclk_mac_lbtest to rk3188_critical_clocks

Arnd Bergmann (1):
      clk: mmp: avoid missing prototype warning

Claudiu Beznea (18):
      clk: at91: clk-generated: continue if __clk_determine_rate() returns error
      clk: at91: clk-generated: check best_rate against ranges
      clk: at91: clk-sam9x60-pll: fix mul mask
      clk: at91: sam9x60-pll: use logical or for range check
      clk: at91: sam9x60-pll: check fcore against ranges
      clk: at91: sam9x60-pll: use frac when setting frequency
      clk: at91: sam9x60: fix main rc oscillator frequency
      clk: at91: sckc: register slow_rc with accuracy option
      clk: at91: replace conditional operator with double logical not
      clk: at91: clk-generated: pass the id of changeable parent at registration
      clk: at91: clk-generated: add mux_table option
      clk: at91: clk-master: add master clock support for SAMA7G5
      clk: at91: clk-peripheral: add support for changeable parent rate
      clk: at91: clk-programmable: add mux_table option
      clk: at91: add macro for pll ids mask
      clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs
      clk: at91: clk-utmi: add utmi support for sama7g5
      clk: at91: sama7g5: add clock support for sama7g5

Colin Ian King (1):
      clk: vc5: fix use of memory after it has been kfree'd

Cristian Ciocaltea (6):
      clk: actions: Fix h_clk for Actions S500 SoC
      dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
      clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
      dt-bindings: reset: Add binding constants for Actions S500 RMU
      clk: actions: Add Actions S500 SoC Reset Management Unit support
      MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs

Dmitry Osipenko (1):
      clk: tegra: pll: Improve PLLM enable-state detection

Douglas Anderson (1):
      dt-bindings: clock: Fix YAML schemas for LPASS clocks on SC7180

Geert Uytterhoeven (1):
      clk: hsdk: Fix bad dependency on IOMEM

Gustavo A. R. Silva (2):
      clk: imx: Use fallthrough pseudo-keyword
      clk: davinci: Use fallthrough pseudo-keyword

Heiko Stuebner (4):
      clk: rockchip: convert rk3399 pll type to use readl_relaxed_poll_timeout
      clk: rockchip: convert basic pll lock_wait to use regmap_read_poll_timeout
      clk: rockchip: convert rk3036 pll type to use internal lock status
      clk: rockchip: use separate compatibles for rk3288w-cru

Jonathan Marek (11):
      clk: qcom: gcc: fix sm8150 GPU and NPU clocks
      clk: qcom: clk-alpha-pll: remove unused/incorrect PLL_CAL_VAL
      clk: qcom: clk-alpha-pll: same regs and ops for trion and lucid
      clk: qcom: clk-alpha-pll: use the right PCAL_DONE value for lucid pll
      clk: qcom: gcc: remove unnecessary vco_table from SM8150
      dt-bindings: clock: combine qcom,sdm845-gpucc and qcom,sc7180-gpucc
      dt-bindings: clock: add SM8150 QCOM Graphics clock bindings
      dt-bindings: clock: add SM8250 QCOM Graphics clock bindings
      clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc drivers
      clk: qcom: Add graphics clock controller driver for SM8150
      clk: qcom: Add graphics clock controller driver for SM8250

Julia Lawall (1):
      clk: drop unused function __clk_get_flags

Konrad Dybcio (2):
      clk: qcom: gcc-sdm660: Add missing modem reset
      clk: qcom: gcc-sdm660: Fix up gcc_mss_mnoc_bimc_axi_clk

Lars Povlsen (2):
      dt-bindings: clock: sparx5: Add bindings include file
      clk: sparx5: Add Sparx5 SoC DPLL clock driver

Loic Poulain (1):
      dt-bindings: clock: Fix qcom,msm8996-apcc yaml syntax

Lori Hikichi (1):
      clk: iproc: round clock rate to the closest

Luca Ceresoli (4):
      dt-bindings: clk: versaclock5: fix 'idt' prefix typos
      MAINTAINERS: take over IDT VersaClock 5 clock driver
      dt-bindings: clk: versaclock5: convert to yaml
      clk: vc5: use a dedicated struct to describe the output drivers

Maxime Ripard (1):
      dt-bindings: arm: bcm: Add a select to the RPI Firmware binding

Michael Krummsdorf (1):
      clk: qoriq: add LS1021A core pll mux options

Mike Tipton (1):
      clk: Add support for enabling/disabling clocks from debugfs

Mylène Josserand (2):
      clk: rockchip: Handle clock tree for rk3288w variant
      dt-bindings: clocks: add rk3288w variant compatible

Nicolas Saenz Julienne (1):
      clk: bcm2835: Do not use prediv with bcm2711's PLLs

Rahul Tanwar (3):
      clk: intel: Use devm_clk_hw_register() instead of clk_hw_register()
      clk: intel: Improve locking in the driver
      clk: intel: Avoid unnecessary memset by improving code

Robin Murphy (1):
      clk: rockchip: Revert "fix wrong mmc sample phase shift for rk3328"

Stephen Boyd (9):
      Merge tag 'v5.9-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: qcom: Export gdsc_gx_do_nothing_enable() to modules
      clk: Clean up kernel-doc errors
      Merge branch 'clk-fixes' into clk-kconfig
      Merge branches 'clk-socfpga', 'clk-doc', 'clk-qcom', 'clk-vc5' and 'clk-bcm' into clk-next
      Merge branches 'clk-https', 'clk-renesas', 'clk-kconfig', 'clk-amlogic' and 'clk-imx' into clk-next
      Merge branches 'clk-actions', 'clk-rockchip', 'clk-iproc', 'clk-intel' and 'clk-debugfs' into clk-next
      Merge branches 'clk-fallthru', 'clk-ingenic', 'clk-tegra', 'clk-sirf' and 'clk-qoriq' into clk-next
      Merge branches 'clk-microchip', 'clk-mmp', 'clk-unused' and 'clk-at91' into clk-next

Taniya Das (4):
      clk: qcom: gdsc: Add support to enable retention of GSDCR
      dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7180
      clk: qcom: gcc: Add support for GCC LPASS clock for SC7180
      clk: qcom: lpass: Add support for LPASS clock controller for SC7180

Xu Wang (1):
      clk: clk-atlas6: fix return value check in atlas6_clk_init()

周琰杰 (Zhou Yanjie) (6):
      dt-bindings: clock: Add RTC related clocks for Ingenic SoCs.
      dt-bindings: clock: Add tabs to align code.
      clk: Ingenic: Add RTC related clocks for Ingenic SoCs.
      clk: JZ4780: Add functions for enable and disable USB PHY.
      clk: JZ4780: Reformat the code to align it.
      clk: X1000: Add support for calculat REFCLK of USB PHY.

 .../arm/bcm/raspberrypi,bcm2835-firmware.txt       |   14 -
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   68 ++
 .../bindings/clock/brcm,bcm2711-dvp.yaml           |   47 +
 .../bindings/clock/brcm,bcm63xx-clocks.txt         |    2 +
 .../devicetree/bindings/clock/clock-bindings.txt   |    2 +-
 .../devicetree/bindings/clock/idt,versaclock5.txt  |   92 --
 .../devicetree/bindings/clock/idt,versaclock5.yaml |  154 +++
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |   21 +-
 .../{qcom,sdm845-gpucc.yaml => qcom,gpucc.yaml}    |   18 +-
 .../bindings/clock/qcom,msm8996-apcc.yaml          |   54 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    4 +
 .../bindings/clock/qcom,sc7180-gpucc.yaml          |   74 --
 .../bindings/clock/qcom,sc7180-lpasscorecc.yaml    |  108 ++
 .../bindings/clock/renesas,cpg-clocks.yaml         |  241 +++++
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |   33 -
 .../bindings/clock/renesas,r8a7740-cpg-clocks.txt  |   41 -
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |   47 -
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |   49 -
 .../bindings/clock/renesas,rz-cpg-clocks.txt       |   53 -
 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |   35 -
 .../bindings/clock/rockchip,rk3288-cru.txt         |    8 +-
 .../devicetree/bindings/clock/silabs,si514.txt     |    2 +-
 .../devicetree/bindings/clock/silabs,si5351.txt    |    2 +-
 .../devicetree/bindings/clock/silabs,si570.txt     |    4 +-
 .../devicetree/bindings/clock/ti,cdce706.txt       |    2 +-
 .../devicetree/bindings/clock/ti,cdce925.txt       |    8 +-
 MAINTAINERS                                        |    4 +-
 drivers/clk/Kconfig                                |    3 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/actions/owl-s500.c                     |   89 +-
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/at91rm9200.c                      |    3 +-
 drivers/clk/at91/at91sam9260.c                     |    3 +-
 drivers/clk/at91/at91sam9g45.c                     |    5 +-
 drivers/clk/at91/at91sam9n12.c                     |    7 +-
 drivers/clk/at91/at91sam9rl.c                      |    3 +-
 drivers/clk/at91/at91sam9x5.c                      |    7 +-
 drivers/clk/at91/clk-generated.c                   |   44 +-
 drivers/clk/at91/clk-main.c                        |    6 +-
 drivers/clk/at91/clk-master.c                      |  310 +++++-
 drivers/clk/at91/clk-peripheral.c                  |  111 +-
 drivers/clk/at91/clk-programmable.c                |   11 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |  547 +++++++---
 drivers/clk/at91/clk-system.c                      |    4 +-
 drivers/clk/at91/clk-utmi.c                        |  103 +-
 drivers/clk/at91/dt-compat.c                       |   25 +-
 drivers/clk/at91/pmc.h                             |   43 +-
 drivers/clk/at91/sam9x60.c                         |   66 +-
 drivers/clk/at91/sama5d2.c                         |   41 +-
 drivers/clk/at91/sama5d3.c                         |    8 +-
 drivers/clk/at91/sama5d4.c                         |    7 +-
 drivers/clk/at91/sama7g5.c                         | 1059 ++++++++++++++++++++
 drivers/clk/at91/sckc.c                            |    5 +-
 drivers/clk/bcm/Kconfig                            |   11 +
 drivers/clk/bcm/Makefile                           |    1 +
 drivers/clk/bcm/clk-bcm2711-dvp.c                  |  124 +++
 drivers/clk/bcm/clk-bcm2835.c                      |   59 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 |  553 ++++++++--
 drivers/clk/bcm/clk-iproc-asiu.c                   |    4 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |  311 +++---
 drivers/clk/clk-ast2600.c                          |   49 +-
 drivers/clk/clk-cdce706.c                          |    2 +-
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-qoriq.c                            |   10 +-
 drivers/clk/clk-si5351.c                           |    4 +-
 drivers/clk/clk-sparx5.c                           |  295 ++++++
 drivers/clk/clk-versaclock5.c                      |  304 ++++--
 drivers/clk/clk.c                                  |   53 +-
 drivers/clk/davinci/pll.c                          |    2 +-
 drivers/clk/imx/clk-pllv3.c                        |    4 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |  165 +--
 drivers/clk/ingenic/x1000-cgu.c                    |   97 +-
 drivers/clk/ingenic/x1830-cgu.c                    |   13 +
 drivers/clk/keystone/sci-clk.c                     |    2 +-
 drivers/clk/keystone/syscon-clk.c                  |    2 +-
 drivers/clk/meson/g12a.c                           |  119 +++
 drivers/clk/meson/g12a.h                           |    7 +-
 drivers/clk/meson/meson8b.c                        |   67 +-
 drivers/clk/meson/meson8b.h                        |    6 +-
 drivers/clk/mmp/clk-pxa168.c                       |    1 +
 drivers/clk/mmp/clk-pxa910.c                       |    1 +
 drivers/clk/mvebu/Kconfig                          |    1 +
 drivers/clk/qcom/Kconfig                           |   53 +
 drivers/clk/qcom/Makefile                          |    6 +
 drivers/clk/qcom/apss-ipq-pll.c                    |   95 ++
 drivers/clk/qcom/apss-ipq6018.c                    |  106 ++
 drivers/clk/qcom/clk-alpha-pll.c                   |   70 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |   21 +-
 drivers/clk/qcom/clk-cpu-8996.c                    |  538 ++++++++++
 drivers/clk/qcom/clk-smd-rpm.c                     |  297 ++++++
 drivers/clk/qcom/gcc-ipq806x.c                     |    2 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |   60 ++
 drivers/clk/qcom/gcc-sc7180.c                      |   16 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    4 +
 drivers/clk/qcom/gcc-sdm845.c                      |    4 +-
 drivers/clk/qcom/gcc-sm8150.c                      |   26 +-
 drivers/clk/qcom/gdsc.c                            |   39 +
 drivers/clk/qcom/gdsc.h                            |    2 +
 drivers/clk/qcom/gpucc-sc7180.c                    |   27 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |   27 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |  320 ++++++
 drivers/clk/qcom/gpucc-sm8250.c                    |  348 +++++++
 drivers/clk/qcom/lpasscorecc-sc7180.c              |  476 +++++++++
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |  349 +++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   23 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/clk/rockchip/clk-pll.c                     |   70 +-
 drivers/clk/rockchip/clk-rk3188.c                  |    1 +
 drivers/clk/rockchip/clk-rk3288.c                  |   39 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    8 +-
 drivers/clk/sirf/clk-atlas6.c                      |    2 +-
 drivers/clk/socfpga/clk-agilex.c                   |    8 +-
 drivers/clk/tegra/clk-pll.c                        |   20 +-
 drivers/clk/versatile/icst.c                       |    2 +-
 drivers/clk/versatile/icst.h                       |    2 +-
 drivers/clk/x86/clk-cgu-pll.c                      |    2 +-
 drivers/clk/x86/clk-cgu.c                          |   32 +-
 drivers/firmware/raspberrypi.c                     |   14 +
 drivers/perf/Kconfig                               |    1 +
 drivers/perf/qcom_l2_pmu.c                         |   90 +-
 drivers/reset/reset-simple.c                       |   23 +-
 drivers/reset/reset-socfpga.c                      |    3 +-
 drivers/reset/reset-sunxi.c                        |    3 +-
 drivers/reset/reset-uniphier-glue.c                |    3 +-
 drivers/soc/qcom/Kconfig                           |    4 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |   57 ++
 include/dt-bindings/clk/versaclock.h               |   13 +
 include/dt-bindings/clock/actions,s500-cmu.h       |    7 +-
 include/dt-bindings/clock/agilex-clock.h           |    4 +-
 include/dt-bindings/clock/bcm3368-clock.h          |   24 +
 include/dt-bindings/clock/bcm6318-clock.h          |   42 +
 include/dt-bindings/clock/bcm63268-clock.h         |   30 +
 include/dt-bindings/clock/bcm6328-clock.h          |   19 +
 include/dt-bindings/clock/bcm6358-clock.h          |   18 +
 include/dt-bindings/clock/bcm6362-clock.h          |   26 +
 include/dt-bindings/clock/bcm6368-clock.h          |   24 +
 include/dt-bindings/clock/g12a-clkc.h              |    2 +
 include/dt-bindings/clock/jz4780-cgu.h             |  144 +--
 include/dt-bindings/clock/microchip,sparx5.h       |   23 +
 include/dt-bindings/clock/qcom,apss-ipq.h          |   12 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |    4 +
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |    1 +
 include/dt-bindings/clock/qcom,gcc-sdm660.h        |    1 +
 include/dt-bindings/clock/qcom,gpucc-sm8150.h      |   33 +
 include/dt-bindings/clock/qcom,gpucc-sm8250.h      |   34 +
 .../dt-bindings/clock/qcom,lpasscorecc-sc7180.h    |   29 +
 include/dt-bindings/clock/qcom,rpmcc.h             |   16 +
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h      |   59 ++
 include/dt-bindings/clock/x1000-cgu.h              |    2 +
 include/dt-bindings/clock/x1830-cgu.h              |    2 +
 include/dt-bindings/power/r8a774e1-sysc.h          |   36 +
 include/dt-bindings/reset/actions,s500-reset.h     |   67 ++
 include/linux/clk-provider.h                       |    3 +-
 include/linux/clk/at91_pmc.h                       |    4 +
 {drivers => include/linux}/reset/reset-simple.h    |    7 +
 include/soc/qcom/kryo-l2-accessors.h               |   12 +
 170 files changed, 8462 insertions(+), 1521 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
 create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-gpucc.yaml => qcom,gpucc.yaml} (75%)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/at91/sama7g5.c
 create mode 100644 drivers/clk/bcm/clk-bcm2711-dvp.c
 create mode 100644 drivers/clk/clk-sparx5.c
 create mode 100644 drivers/clk/qcom/apss-ipq-pll.c
 create mode 100644 drivers/clk/qcom/apss-ipq6018.c
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8150.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8250.c
 create mode 100644 drivers/clk/qcom/lpasscorecc-sc7180.c
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
 create mode 100644 include/dt-bindings/clock/microchip,sparx5.h
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8250.h
 create mode 100644 include/dt-bindings/clock/qcom,lpasscorecc-sc7180.h
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
 create mode 100644 include/dt-bindings/reset/actions,s500-reset.h
 rename {drivers => include/linux}/reset/reset-simple.h (74%)
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
