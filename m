Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98627206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgIHKfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:35:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44830 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgIHK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCEFD1A0335;
        Tue,  8 Sep 2020 12:26:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABEB91A032F;
        Tue,  8 Sep 2020 12:26:08 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 078FE2036D;
        Tue,  8 Sep 2020 12:26:07 +0200 (CEST)
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
Subject: [PATCH v3 04/14] dt-bindings: clock: imx8mp: Add media blk_ctl clock IDs
Date:   Tue,  8 Sep 2020 13:24:41 +0300
Message-Id: <1599560691-3763-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/clock/imx8mp-clock.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 5fc2c40..12632fa 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -396,4 +396,32 @@
 
 #define IMX8MP_CLK_AUDIO_BLK_CTL_END			59
 
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_PCLK		0
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_CLKREF	1
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_PCLK		2
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_ACLK		3
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_PIXEL		4
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_APB		5
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISI_PROC		6
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISI_APB		7
+#define IMX8MP_CLK_MEDIA_BLK_CTL_BUS_BLK		8
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_PCLK		9
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_ACLK		10
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_PIXEL		11
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_APB		12
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_COR		13
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AXI		14
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AHB		15
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_COR		16
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AXI		17
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AHB		18
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_COR		19
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AXI		20
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AHB		21
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI2		22
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_AXI		23
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_AXI		24
+
+#define IMX8MP_CLK_MEDIA_BLK_CTL_END			25
+
 #endif
-- 
2.7.4

