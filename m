Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED7C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F56C222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBZJTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:19:51 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52986 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbgBZJTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:19:50 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7523D1A7072;
        Wed, 26 Feb 2020 10:19:47 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B7101A711F;
        Wed, 26 Feb 2020 10:19:41 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5EBC1402D8;
        Wed, 26 Feb 2020 17:19:34 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/4] reset: imx7: Add support for i.MX8MP SoC
Date:   Wed, 26 Feb 2020 17:13:51 +0800
Message-Id: <1582708431-14161-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MP is a new SoC of i.MX8M family, it has same src IP
inside but with different module layout, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/reset/reset-imx7.c | 101 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 1443a55..d170fe6 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
 #include <dt-bindings/reset/imx8mq-reset.h>
+#include <dt-bindings/reset/imx8mp-reset.h>
 
 struct imx7_src_signal {
 	unsigned int offset, bit;
@@ -145,6 +146,18 @@ enum imx8mq_src_registers {
 	SRC_DDRC2_RCR		= 0x1004,
 };
 
+enum imx8mp_src_registers {
+	SRC_SUPERMIX_RCR	= 0x0018,
+	SRC_AUDIOMIX_RCR	= 0x001c,
+	SRC_MLMIX_RCR		= 0x0028,
+	SRC_GPU2D_RCR		= 0x0038,
+	SRC_GPU3D_RCR		= 0x003c,
+	SRC_VPU_G1_RCR		= 0x0048,
+	SRC_VPU_G2_RCR		= 0x004c,
+	SRC_VPUVC8KE_RCR	= 0x0050,
+	SRC_NOC_RCR		= 0x0054,
+};
+
 static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
 	[IMX8MQ_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
@@ -253,6 +266,93 @@ static const struct imx7_src_variant variant_imx8mq = {
 	},
 };
 
+static const struct imx7_src_signal imx8mp_src_signals[IMX8MP_RESET_NUM] = {
+	[IMX8MP_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET2]	= { SRC_A53RCR0, BIT(2) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET3]	= { SRC_A53RCR0, BIT(3) },
+	[IMX8MP_RESET_A53_CORE_RESET0]		= { SRC_A53RCR0, BIT(4) },
+	[IMX8MP_RESET_A53_CORE_RESET1]		= { SRC_A53RCR0, BIT(5) },
+	[IMX8MP_RESET_A53_CORE_RESET2]		= { SRC_A53RCR0, BIT(6) },
+	[IMX8MP_RESET_A53_CORE_RESET3]		= { SRC_A53RCR0, BIT(7) },
+	[IMX8MP_RESET_A53_DBG_RESET0]		= { SRC_A53RCR0, BIT(8) },
+	[IMX8MP_RESET_A53_DBG_RESET1]		= { SRC_A53RCR0, BIT(9) },
+	[IMX8MP_RESET_A53_DBG_RESET2]		= { SRC_A53RCR0, BIT(10) },
+	[IMX8MP_RESET_A53_DBG_RESET3]		= { SRC_A53RCR0, BIT(11) },
+	[IMX8MP_RESET_A53_ETM_RESET0]		= { SRC_A53RCR0, BIT(12) },
+	[IMX8MP_RESET_A53_ETM_RESET1]		= { SRC_A53RCR0, BIT(13) },
+	[IMX8MP_RESET_A53_ETM_RESET2]		= { SRC_A53RCR0, BIT(14) },
+	[IMX8MP_RESET_A53_ETM_RESET3]		= { SRC_A53RCR0, BIT(15) },
+	[IMX8MP_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
+	[IMX8MP_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
+	[IMX8MP_RESET_SW_NON_SCLR_M7C_RST]	= { SRC_M4RCR, BIT(0) },
+	[IMX8MP_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
+	[IMX8MP_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
+	[IMX8MP_RESET_SUPERMIX_RESET]		= { SRC_SUPERMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_AUDIOMIX_RESET]		= { SRC_AUDIOMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_MLMIX_RESET]		= { SRC_MLMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR, BIT(2) },
+	[IMX8MP_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
+	[IMX8MP_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
+	[IMX8MP_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
+	[IMX8MP_RESET_MEDIA_RESET]		= { SRC_DISP_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU2D_RESET]		= { SRC_GPU2D_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU3D_RESET]		= { SRC_GPU3D_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU_RESET]		= { SRC_GPU_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_RESET]		= { SRC_VPU_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_G1_RESET]		= { SRC_VPU_G1_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_G2_RESET]		= { SRC_VPU_G2_RCR, BIT(0) },
+	[IMX8MP_RESET_VPUVC8KE_RESET]		= { SRC_VPUVC8KE_RCR, BIT(0) },
+	[IMX8MP_RESET_NOC_RESET]		= { SRC_NOC_RCR, BIT(0) },
+};
+
+static int imx8mp_reset_set(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct imx7_src *imx7src = to_imx7_src(rcdev);
+	const unsigned int bit = imx7src->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
+
+	switch (id) {
+	case IMX8MP_RESET_PCIEPHY:
+		/*
+		 * wait for more than 10us to release phy g_rst and
+		 * btnrst
+		 */
+		if (!assert)
+			udelay(10);
+		break;
+
+	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
+		value = assert ? 0 : bit;
+		break;
+	}
+
+	return imx7_reset_update(imx7src, id, value);
+}
+
+static int imx8mp_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return imx8mp_reset_set(rcdev, id, true);
+}
+
+static int imx8mp_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return imx8mp_reset_set(rcdev, id, false);
+}
+
+static const struct imx7_src_variant variant_imx8mp = {
+	.signals = imx8mp_src_signals,
+	.signals_num = ARRAY_SIZE(imx8mp_src_signals),
+	.ops = {
+		.assert   = imx8mp_reset_assert,
+		.deassert = imx8mp_reset_deassert,
+	},
+};
+
 static int imx7_reset_probe(struct platform_device *pdev)
 {
 	struct imx7_src *imx7src;
@@ -283,6 +383,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 static const struct of_device_id imx7_reset_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ .compatible = "fsl,imx8mq-src", .data = &variant_imx8mq },
+	{ .compatible = "fsl,imx8mp-src", .data = &variant_imx8mp },
 	{ /* sentinel */ },
 };
 
-- 
2.7.4

