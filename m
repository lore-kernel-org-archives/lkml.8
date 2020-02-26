Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E382C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2AF21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBZJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:19:47 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52854 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgBZJTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:19:47 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 81E501A713E;
        Wed, 26 Feb 2020 10:19:44 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 880D11A70CB;
        Wed, 26 Feb 2020 10:19:38 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CA9640246;
        Wed, 26 Feb 2020 17:19:31 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] dt-bindings: reset: imx7: Add support for i.MX8MN
Date:   Wed, 26 Feb 2020 17:13:48 +0800
Message-Id: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MN can reuse i.MX8MQ's reset driver, update the compatible
property and related info to support i.MX8MN.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |  4 +-
 include/dt-bindings/reset/imx8mq-reset.h           | 56 +++++++++++-----------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index c2489e4..38ac251 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -9,6 +9,7 @@ Required properties:
 	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
 	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
 	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
+	- For i.MX8MN SoCs should be "fsl,imx8mn-src", "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -49,4 +50,5 @@ Example:
 For list of all valid reset indices see
 <dt-bindings/reset/imx7-reset.h> for i.MX7,
 <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN
diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
index 9a30108..a5b5707 100644
--- a/include/dt-bindings/reset/imx8mq-reset.h
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -28,36 +28,36 @@
 #define IMX8MQ_RESET_A53_L2RESET		17
 #define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST	18
 #define IMX8MQ_RESET_OTG1_PHY_RESET		19
-#define IMX8MQ_RESET_OTG2_PHY_RESET		20
-#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
-#define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
-#define IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N	23
-#define IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N	24
-#define IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N	25
-#define IMX8MQ_RESET_PCIEPHY			26
-#define IMX8MQ_RESET_PCIEPHY_PERST		27
-#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
-#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29
-#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_OTG2_PHY_RESET		20	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_DSI_RESET_N		22	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N	23	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N	24	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N	25	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIEPHY			26	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIEPHY_PERST		27	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30	/* i.MX8MM/i.MX8MN does NOT support */
 #define IMX8MQ_RESET_DISP_RESET			31
 #define IMX8MQ_RESET_GPU_RESET			32
-#define IMX8MQ_RESET_VPU_RESET			33
-#define IMX8MQ_RESET_PCIEPHY2			34	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_PCIEPHY2_PERST		35	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_DDRC1_PRST			44
-#define IMX8MQ_RESET_DDRC1_CORE_RESET		45
-#define IMX8MQ_RESET_DDRC1_PHY_RESET		46
-#define IMX8MQ_RESET_DDRC2_PRST			47	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_DDRC2_CORE_RESET		48	/* i.MX8MM does NOT support */
-#define IMX8MQ_RESET_DDRC2_PHY_RESET		49	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_VPU_RESET			33	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIEPHY2			34	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIEPHY2_PERST		35	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC1_PRST			44	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC1_CORE_RESET		45	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC1_PHY_RESET		46	/* i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC2_PRST			47	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC2_CORE_RESET		48	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_DDRC2_PHY_RESET		49	/* i.MX8MM/i.MX8MN does NOT support */
 
 #define IMX8MQ_RESET_NUM			50
 
-- 
2.7.4

