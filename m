Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A4C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B522467C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBZJTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:19:48 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52890 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgBZJTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:19:47 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 840891A7184;
        Wed, 26 Feb 2020 10:19:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80C9B1A711B;
        Wed, 26 Feb 2020 10:19:39 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 65683402AD;
        Wed, 26 Feb 2020 17:19:32 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/4] dt-bindings: reset: imx7: Document usage on i.MX8MP SoC
Date:   Wed, 26 Feb 2020 17:13:49 +0800
Message-Id: <1582708431-14161-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now supports i.MX8MP, so update bindings accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |  4 +-
 include/dt-bindings/reset/imx8mp-reset.h           | 50 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/imx8mp-reset.h

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 38ac251..e10502d 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -10,6 +10,7 @@ Required properties:
 	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
 	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
 	- For i.MX8MN SoCs should be "fsl,imx8mn-src", "fsl,imx8mq-src", "syscon"
+	- For i.MX8MP SoCs should be "fsl,imx8mp-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -51,4 +52,5 @@ For list of all valid reset indices see
 <dt-bindings/reset/imx7-reset.h> for i.MX7,
 <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
 <dt-bindings/reset/imx8mq-reset.h> for i.MX8MM and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN and
+<dt-bindings/reset/imx8mp-reset.h> for i.MX8MP
diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
new file mode 100644
index 0000000..ee37769
--- /dev/null
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 NXP
+ */
+
+#ifndef DT_BINDING_RESET_IMX8MP_H
+#define DT_BINDING_RESET_IMX8MP_H
+
+#define IMX8MP_RESET_A53_CORE_POR_RESET0	0
+#define IMX8MP_RESET_A53_CORE_POR_RESET1	1
+#define IMX8MP_RESET_A53_CORE_POR_RESET2	2
+#define IMX8MP_RESET_A53_CORE_POR_RESET3	3
+#define IMX8MP_RESET_A53_CORE_RESET0		4
+#define IMX8MP_RESET_A53_CORE_RESET1		5
+#define IMX8MP_RESET_A53_CORE_RESET2		6
+#define IMX8MP_RESET_A53_CORE_RESET3		7
+#define IMX8MP_RESET_A53_DBG_RESET0		8
+#define IMX8MP_RESET_A53_DBG_RESET1		9
+#define IMX8MP_RESET_A53_DBG_RESET2		10
+#define IMX8MP_RESET_A53_DBG_RESET3		11
+#define IMX8MP_RESET_A53_ETM_RESET0		12
+#define IMX8MP_RESET_A53_ETM_RESET1		13
+#define IMX8MP_RESET_A53_ETM_RESET2		14
+#define IMX8MP_RESET_A53_ETM_RESET3		15
+#define IMX8MP_RESET_A53_SOC_DBG_RESET		16
+#define IMX8MP_RESET_A53_L2RESET		17
+#define IMX8MP_RESET_SW_NON_SCLR_M7C_RST	18
+#define IMX8MP_RESET_OTG1_PHY_RESET		19
+#define IMX8MP_RESET_OTG2_PHY_RESET		20
+#define IMX8MP_RESET_SUPERMIX_RESET		21
+#define IMX8MP_RESET_AUDIOMIX_RESET		22
+#define IMX8MP_RESET_MLMIX_RESET		23
+#define IMX8MP_RESET_PCIEPHY			24
+#define IMX8MP_RESET_PCIEPHY_PERST		25
+#define IMX8MP_RESET_PCIE_CTRL_APPS_EN		26
+#define IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF	27
+#define IMX8MP_RESET_HDMI_PHY_APB_RESET		28
+#define IMX8MP_RESET_MEDIA_RESET		29
+#define IMX8MP_RESET_GPU2D_RESET		30
+#define IMX8MP_RESET_GPU3D_RESET		31
+#define IMX8MP_RESET_GPU_RESET			32
+#define IMX8MP_RESET_VPU_RESET			33
+#define IMX8MP_RESET_VPU_G1_RESET		34
+#define IMX8MP_RESET_VPU_G2_RESET		35
+#define IMX8MP_RESET_VPUVC8KE_RESET		36
+#define IMX8MP_RESET_NOC_RESET			37
+
+#define IMX8MP_RESET_NUM			38
+
+#endif
-- 
2.7.4

