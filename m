Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C401B206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgHNMLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:11:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55038 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNMJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:09:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CFA2B200D6B;
        Fri, 14 Aug 2020 14:09:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2E02200CEF;
        Fri, 14 Aug 2020 14:09:52 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DFDF203B5;
        Fri, 14 Aug 2020 14:09:52 +0200 (CEST)
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
Subject: [PATCH v2 05/17] dt-bindings: reset: imx8mp: Add media blk_ctrl reset IDs
Date:   Fri, 14 Aug 2020 15:09:14 +0300
Message-Id: <1597406966-13740-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mp for blk-ctrl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/reset/imx8mp-reset.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index fca0c9bff..13e56dd 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -52,4 +52,32 @@
 
 #define IMX8MP_AUDIO_BLK_CTRL_RESET_NUM		2
 
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI_PCLK	0
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI_CLKREF	1
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI_PCLK	2
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI_ACLK	3
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_PIXEL		4
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_APB		5
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISI_PROC		6
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISI_APB		7
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_BUS_BLK		8
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI2_PCLK	9
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_CSI2_ACLK	10
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_PIXEL	11
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_APB		12
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_COR		13
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_AXI		14
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP1_AHB		15
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_COR		16
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_AXI		17
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_ISP0_AHB		18
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_COR		19
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_AXI		20
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_DWE_AHB		21
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_MIPI_DSI2		22
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF_AXI		23
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_LCDIF2_AXI		24
+
+#define IMX8MP_MEDIA_BLK_CTRL_RESET_NUM			25
+
 #endif
-- 
2.7.4

