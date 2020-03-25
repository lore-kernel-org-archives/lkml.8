Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A5C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCYPj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:39:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53318 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCYPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61699200558;
        Wed, 25 Mar 2020 16:39:23 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52D672000D4;
        Wed, 25 Mar 2020 16:39:23 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A1DFD203CE;
        Wed, 25 Mar 2020 16:39:22 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 00/13] Add generic MFD i.MX mix and audiomix support
Date:   Wed, 25 Mar 2020 17:38:38 +0200
Message-Id: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP has some new IPs called mixes. They are formed usually by some
GPRs that can be split into different functionalities. The first example
here is the audiomix which has dedicated registers that can be registered
as a clock controller and some other registers that can be registered as
a reset controller, plus some dedicated ones that will be registered as
syscon and used by each dedicated audio IP.

More mixes to be following the same structure are to come, like hdmimix,
dispmix and mediamix. They will all be populated and registered by the MFD
imx-mix generic driver.

Changes since RFC:
 * changed the gate2 to work as shared with single bit,
   therefor avoiding to add the new clk-gate-shared clock type.
 * implemented all Stephen's comments
 * implemented all Peng's comments
 * documented the DT bindings 

Abel Vesa (13):
  mfd: Add i.MX generic mix support
  Documentation: mfd: Add DT bindings for i.MX Audiomix
  arm64: dts: imx8mp: Add AIPS 4 and 5
  arm64: dts: imx8mp: Add audiomix node
  clk: imx: gate2: Allow single bit gating clock
  clk: imx: pll14xx: Add the device as argument when registering
  clk: imx: Add helpers for passing the device as argument
  dt-bindings: clocks: imx8mp: Add ids for audiomix clocks
  clk: imx: Add audiomix clock controller support
  arm64: dts: imx8mp: Add audiomix clock controller node
  dt-bindings: reset: imx8mp: Add ids for audiomix reset
  reset: imx: Add audiomix reset controller support
  arm64: dts: imx8mp: Add audiomix reset controller node

 .../devicetree/bindings/mfd/fsl,imx-audiomix.txt   |  34 +++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  41 +++-
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-audiomix.c                     | 228 +++++++++++++++++++++
 drivers/clk/imx/clk-gate2.c                        |  31 ++-
 drivers/clk/imx/clk-pll14xx.c                      |   8 +-
 drivers/clk/imx/clk.h                              |  55 ++++-
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/imx-mix.c                              |  48 +++++
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-imx-audiomix.c                 | 122 +++++++++++
 include/dt-bindings/clock/imx8mp-clock.h           |  62 ++++++
 include/dt-bindings/reset/imx-audiomix-reset.h     |  15 ++
 15 files changed, 648 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt
 create mode 100644 drivers/clk/imx/clk-audiomix.c
 create mode 100644 drivers/mfd/imx-mix.c
 create mode 100644 drivers/reset/reset-imx-audiomix.c
 create mode 100644 include/dt-bindings/reset/imx-audiomix-reset.h

-- 
2.7.4

