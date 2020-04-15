Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA3C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9492720784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635610AbgDOIIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:08:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39686 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403805AbgDOID1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:03:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A0641A079A;
        Wed, 15 Apr 2020 10:03:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C4851A078C;
        Wed, 15 Apr 2020 10:03:05 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B19C5202B0;
        Wed, 15 Apr 2020 10:03:04 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 00/13] Add generic MFD i.MX mix and audiomix support
Date:   Wed, 15 Apr 2020 11:02:40 +0300
Message-Id: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
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

Changes since v2:
 * removed the runtime PM for now
 * changed the new SPDX identifiers to GPL-2.0-only
 * took care of the DT schema comment

Abel Vesa (13):
  mfd: Add i.MX generic mix support
  Documentation: mfd: Add DT bindings for i.MX Mix
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

 .../devicetree/bindings/mfd/fsl,imx-mix.yaml       |  34 ++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  41 ++++-
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-audiomix.c                     | 175 +++++++++++++++++++++
 drivers/clk/imx/clk-gate2.c                        |  31 +++-
 drivers/clk/imx/clk-pll14xx.c                      |   8 +-
 drivers/clk/imx/clk.h                              |  55 ++++++-
 drivers/mfd/Kconfig                                |  11 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/imx-mix.c                              |  48 ++++++
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-imx-audiomix.c                 | 117 ++++++++++++++
 include/dt-bindings/clock/imx8mp-clock.h           |  62 ++++++++
 include/dt-bindings/reset/imx-audiomix-reset.h     |  15 ++
 15 files changed, 590 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
 create mode 100644 drivers/clk/imx/clk-audiomix.c
 create mode 100644 drivers/mfd/imx-mix.c
 create mode 100644 drivers/reset/reset-imx-audiomix.c
 create mode 100644 include/dt-bindings/reset/imx-audiomix-reset.h

-- 
2.7.4

