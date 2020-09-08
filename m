Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF94EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C2E206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgIHKhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:37:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56324 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbgIHK0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05E632011C1;
        Tue,  8 Sep 2020 12:26:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDEF7201198;
        Tue,  8 Sep 2020 12:26:10 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EB4420327;
        Tue,  8 Sep 2020 12:26:10 +0200 (CEST)
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
Subject: [PATCH v3 07/14] dt-bindings: reset: imx8mp: Add hdmi blk_ctl reset IDs
Date:   Tue,  8 Sep 2020 13:24:44 +0300
Message-Id: <1599560691-3763-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/reset/imx8mp-reset.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index ba70248..eb9ed21 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -80,4 +80,16 @@
 
 #define IMX8MP_MEDIA_BLK_CTL_RESET_NUM			25
 
+#define IMX8MP_HDMI_BLK_CTL_HDMI_TX_RESET		0
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PHY_RESET		1
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PAI_RESET		2
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PVI_RESET		3
+#define IMX8MP_HDMI_BLK_CTL_HDMI_TRNG_RESET		4
+#define IMX8MP_HDMI_BLK_CTL_IRQ_STEER_RESET		5
+#define IMX8MP_HDMI_BLK_CTL_HDMI_HDCP_RESET		6
+#define IMX8MP_HDMI_BLK_CTL_LCDIF_RESET			7
+
+#define IMX8MP_HDMI_BLK_CTL_RESET_NUM			8
+
+
 #endif
-- 
2.7.4

