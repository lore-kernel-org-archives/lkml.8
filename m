Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4600206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHNMLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:11:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38294 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgHNMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:09:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DB651A0B20;
        Fri, 14 Aug 2020 14:09:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DD5A1A03F1;
        Fri, 14 Aug 2020 14:09:54 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 93E29203B5;
        Fri, 14 Aug 2020 14:09:53 +0200 (CEST)
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
Subject: [PATCH v2 07/17] dt-bindings: reset: imx8mp: Add hdmi blk_ctrl reset IDs
Date:   Fri, 14 Aug 2020 15:09:16 +0300
Message-Id: <1597406966-13740-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used imx8mp for blk-ctrl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/reset/imx8mp-reset.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index 13e56dd..c1ca79c 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -80,4 +80,16 @@
 
 #define IMX8MP_MEDIA_BLK_CTRL_RESET_NUM			25
 
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_TX_RESET		0
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_PHY_RESET		1
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_PAI_RESET		2
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_PVI_RESET		3
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_TRNG_RESET		4
+#define IMX8MP_HDMI_BLK_CTRL_IRQ_STEER_RESET		5
+#define IMX8MP_HDMI_BLK_CTRL_HDMI_HDCP_RESET		6
+#define IMX8MP_HDMI_BLK_CTRL_LCDIF_RESET		7
+
+#define IMX8MP_HDMI_BLK_CTRL_RESET_NUM			8
+
+
 #endif
-- 
2.7.4

