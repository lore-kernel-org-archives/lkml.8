Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F72120809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2MIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:08:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37722 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2MIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:08:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A9FF200FEA;
        Wed, 29 Jul 2020 14:08:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A99A200FAB;
        Wed, 29 Jul 2020 14:08:18 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D268D2032B;
        Wed, 29 Jul 2020 14:08:17 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 00/17] Add BLK_CTRL support for i.MX8MP
Date:   Wed, 29 Jul 2020 15:07:46 +0300
Message-Id: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
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

 .../bindings/clock/fsl,imx-blk-ctrl.yaml           |  55 ++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  44 +++
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-blk-ctrl.c                     | 330 +++++++++++++++++++++
 drivers/clk/imx/clk-blk-ctrl.h                     |  81 +++++
 drivers/clk/imx/clk-imx8mp.c                       | 281 +++++++++++++++++-
 include/dt-bindings/clock/imx8mp-clock.h           | 200 +++++++++----
 include/dt-bindings/reset/imx8mp-reset.h           |  45 +++
 8 files changed, 975 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
 create mode 100644 drivers/clk/imx/clk-blk-ctrl.c
 create mode 100644 drivers/clk/imx/clk-blk-ctrl.h

-- 
2.7.4

