Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48868C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AE5208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgHNMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:09:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54902 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:09:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 10C0B20024A;
        Fri, 14 Aug 2020 14:09:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03D3C2001AE;
        Fri, 14 Aug 2020 14:09:49 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 51E2B2030E;
        Fri, 14 Aug 2020 14:09:48 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 00/17] Add BLK_CTRL support for i.MX8MP
Date:   Fri, 14 Aug 2020 15:09:09 +0300
Message-Id: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BLK_CTRL according to HW design is basically the wrapper of the entire
function specific group of IPs and holds GPRs that usually cannot be placed
into one specific IP from that group. Some of these GPRs are used to control
some clocks, other some resets, others some very specific function that does
not fit into clocks or resets. Since the clocks are registered using the i.MX
clock subsystem API, the driver is placed into the clock subsystem, but it
also registers the resets. For the other functionalities that other GPRs might
have, the syscon is used.

Changes since v1:
 * implemented the runtime pm in blk_ctrl as discussed with Philipp Zabel on
v1 thread
 * changed the blk-ctl to clock-controller in the dts and doc
 * fixed the yaml doc
 * removed the power-domains properties since the power-domains driver
is not yet upstream for i.MX8MP.

Abel Vesa (17):
  dt-bindings: clocks: imx8mp: Rename audiomix ids clocks to
    audio_blk_ctrl
  dt-bindings: reset: imx8mp: Add audio blk_ctrl reset IDs
  dt-bindings: clock: imx8mp: Add ids for the audio shared gate
  dt-bindings: clock: imx8mp: Add media blk_ctrl clock IDs
  dt-bindings: reset: imx8mp: Add media blk_ctrl reset IDs
  dt-bindings: clock: imx8mp: Add hdmi blk_ctrl clock IDs
  dt-bindings: reset: imx8mp: Add hdmi blk_ctrl reset IDs
  clk: imx8mp: Add audio shared gate
  arm64: dts: Remove imx-hdmimix-reset header file
  Documentation: bindings: clk: Add bindings for i.MX BLK_CTRL
  clk: imx: Add blk_ctrl combo driver
  clk: imx8mp: Add audio blk_ctrl clocks and resets
  clk: imx8mp: Add hdmi blk_ctrl clocks and resets
  clk: imx8mp: Add media blk_ctrl clocks and resets
  arm64: dts: imx8mp: Add audio_blk_ctrl node
  arm64: dts: imx8mp: Add media_blk_ctrl node
  arm64: dts: imx8mp: Add hdmi_blk_ctrl node

 .../bindings/clock/fsl,imx-blk-ctrl.yaml           |  60 ++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  41 +++
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-blk-ctrl.c                     | 339 +++++++++++++++++++++
 drivers/clk/imx/clk-blk-ctrl.h                     |  81 +++++
 drivers/clk/imx/clk-imx8mp.c                       | 281 ++++++++++++++++-
 include/dt-bindings/clock/imx8mp-clock.h           | 200 ++++++++----
 include/dt-bindings/reset/imx8mp-reset.h           |  45 +++
 8 files changed, 986 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
 create mode 100644 drivers/clk/imx/clk-blk-ctrl.c
 create mode 100644 drivers/clk/imx/clk-blk-ctrl.h

-- 
2.7.4

