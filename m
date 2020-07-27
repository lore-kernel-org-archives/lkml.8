Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8124BC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557542074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hxnJy06o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgG0TqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:46:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57120 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0TqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:46:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RJkCBB072067;
        Mon, 27 Jul 2020 14:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595879172;
        bh=4+nqjkSHy9vRMkUIj4OFrwiVh0M1uxXF6W1gEH1x978=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hxnJy06oL2yD3sEgjkBNULitBR3cR9llWhyzib3ZPB22COVUxUJzfbHvOzPuSNbM4
         gtzoPxEhWQDoP7qM87czpHWZ+uhx58eBLda57CXIDyXT0hlP/RIC+1F6FLpAKdWspX
         vBr0TE+rUcMHcuSarMzMqpO9PPg+rVyyNJSKARKk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RJkBOG009500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 14:46:11 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 14:46:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 14:46:11 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk3mZ036731;
        Mon, 27 Jul 2020 14:46:10 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 3/3] phy: ti: am654: update PCIe serdes config
Date:   Tue, 28 Jul 2020 01:16:03 +0530
Message-ID: <20200727194603.44636-4-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727194603.44636-1-nsekhar@ti.com>
References: <20200727194603.44636-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PCIe serdes config to latest suggested for
hardware. This fixes cases of failure to enumerate
in Gen2 mode with some cards.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 140 ++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index e73432a7bf0c..d249cc4dff4c 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -19,15 +19,38 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#define CMU_R004		0x4
+#define CMU_R060		0x60
 #define CMU_R07C		0x7c
-
+#define CMU_R088		0x88
+#define CMU_R0D0		0xd0
+#define CMU_R0E8		0xe8
+
+#define LANE_R048		0x248
+#define LANE_R058		0x258
+#define LANE_R06c		0x26c
+#define LANE_R070		0x270
+#define LANE_R070		0x270
+#define LANE_R19C		0x39c
+
+#define COMLANE_R004		0xa04
 #define COMLANE_R138		0xb38
 #define VERSION_VAL		0x70
 
 #define COMLANE_R190		0xb90
-
 #define COMLANE_R194		0xb94
 
+#define COMRXEQ_R004		0x1404
+#define COMRXEQ_R008		0x1408
+#define COMRXEQ_R00C		0x140c
+#define COMRXEQ_R014		0x1414
+#define COMRXEQ_R018		0x1418
+#define COMRXEQ_R01C		0x141c
+#define COMRXEQ_R04C		0x144c
+#define COMRXEQ_R088		0x1488
+#define COMRXEQ_R094		0x1494
+#define COMRXEQ_R098		0x1498
+
 #define SERDES_CTRL		0x1fd0
 
 #define WIZ_LANEXCTL_STS	0x1fe0
@@ -81,8 +104,33 @@ static struct regmap_config serdes_am654_regmap_config = {
 };
 
 enum serdes_am654_fields {
+	/* CMU PLL Control */
+	CMU_PLL_CTRL,
+
+	LANE_PLL_CTRL_RXEQ_RXIDLE,
+
+	/* CMU VCO bias current and VREG setting */
+	AHB_PMA_CM_VCO_VBIAS_VREG,
+	AHB_PMA_CM_VCO_BIAS_VREG,
+
+	AHB_PMA_CM_SR,
+	AHB_SSC_GEN_Z_O_20_13,
+
+	/* AHB PMA Lane Configuration */
+	AHB_PMA_LN_AGC_THSEL_VREGH,
+
+	/* AGC and Signal detect theshold for Gen3 */
+	AHB_PMA_LN_GEN3_AGC_SD_THSEL,
+
+	AHB_PMA_LN_RX_SELR_GEN3,
+	AHB_PMA_LN_TX_DRV,
+
 	/* CMU Master Reset */
 	CMU_MASTER_CDN,
+
+	/* P2S ring buffer initial startup pointer difference */
+	P2S_RBUF_PTR_DIFF,
+
 	CONFIG_VERSION,
 
 	/* Lane 1 Master Reset */
@@ -91,6 +139,42 @@ enum serdes_am654_fields {
 	/* CMU OK Status */
 	CMU_OK_I_0,
 
+	/* Mid-speed initial calibration control */
+	COMRXEQ_MS_INIT_CTRL_7_0,
+
+	/* High-speed initial calibration control */
+	COMRXEQ_HS_INIT_CAL_7_0,
+
+	/* Mid-speed recalibration control */
+	COMRXEQ_MS_RECAL_CTRL_7_0,
+
+	/* High-speed recalibration control */
+	COMRXEQ_HS_RECAL_CTRL_7_0,
+
+	/* ATT configuration */
+	COMRXEQ_CSR_ATT_CONFIG,
+
+	/* Edge based boost adaptation window length */
+	COMRXEQ_CSR_EBSTADAPT_WIN_LEN,
+
+	/* COMRXEQ control 3 & 4 */
+	COMRXEQ_CTRL_3_4,
+
+	/* COMRXEQ control 14, 15 and 16*/
+	COMRXEQ_CTRL_14_15_16,
+
+	/* Threshold for errors in pattern data  */
+	COMRXEQ_CSR_DLEV_ERR_THRESH,
+
+	/* COMRXEQ control 25 */
+	COMRXEQ_CTRL_25,
+
+	/* Mid-speed rate change calibration control */
+	CSR_RXEQ_RATE_CHANGE_CAL_RUN_RATE2_O,
+
+	/* High-speed rate change calibration control */
+	COMRXEQ_HS_RCHANGE_CTRL_7_0,
+
 	/* Serdes reset */
 	POR_EN,
 
@@ -112,10 +196,33 @@ enum serdes_am654_fields {
 };
 
 static const struct reg_field serdes_am654_reg_fields[] = {
-	[CMU_MASTER_CDN]		= REG_FIELD(CMU_R07C, 24, 24),
+	[CMU_PLL_CTRL]			= REG_FIELD(CMU_R004, 8, 15),
+	[AHB_PMA_CM_VCO_VBIAS_VREG]	= REG_FIELD(CMU_R060, 8, 15),
+	[CMU_MASTER_CDN]		= REG_FIELD(CMU_R07C, 24, 31),
+	[AHB_PMA_CM_VCO_BIAS_VREG]	= REG_FIELD(CMU_R088, 24, 31),
+	[AHB_PMA_CM_SR]			= REG_FIELD(CMU_R0D0, 24, 31),
+	[AHB_SSC_GEN_Z_O_20_13]		= REG_FIELD(CMU_R0E8, 8, 15),
+	[LANE_PLL_CTRL_RXEQ_RXIDLE]	= REG_FIELD(LANE_R048, 8, 15),
+	[AHB_PMA_LN_AGC_THSEL_VREGH]	= REG_FIELD(LANE_R058, 16, 23),
+	[AHB_PMA_LN_GEN3_AGC_SD_THSEL]	= REG_FIELD(LANE_R06c, 0, 7),
+	[AHB_PMA_LN_RX_SELR_GEN3]	= REG_FIELD(LANE_R070, 16, 23),
+	[AHB_PMA_LN_TX_DRV]		= REG_FIELD(LANE_R19C, 16, 23),
+	[P2S_RBUF_PTR_DIFF]		= REG_FIELD(COMLANE_R004, 0, 7),
 	[CONFIG_VERSION]		= REG_FIELD(COMLANE_R138, 16, 23),
-	[L1_MASTER_CDN]			= REG_FIELD(COMLANE_R190, 9, 9),
+	[L1_MASTER_CDN]			= REG_FIELD(COMLANE_R190, 8, 15),
 	[CMU_OK_I_0]			= REG_FIELD(COMLANE_R194, 19, 19),
+	[COMRXEQ_MS_INIT_CTRL_7_0]	= REG_FIELD(COMRXEQ_R004, 24, 31),
+	[COMRXEQ_HS_INIT_CAL_7_0]	= REG_FIELD(COMRXEQ_R008, 0, 7),
+	[COMRXEQ_MS_RECAL_CTRL_7_0]	= REG_FIELD(COMRXEQ_R00C, 8, 15),
+	[COMRXEQ_HS_RECAL_CTRL_7_0]	= REG_FIELD(COMRXEQ_R00C, 16, 23),
+	[COMRXEQ_CSR_ATT_CONFIG]	= REG_FIELD(COMRXEQ_R014, 16, 23),
+	[COMRXEQ_CSR_EBSTADAPT_WIN_LEN]	= REG_FIELD(COMRXEQ_R018, 16, 23),
+	[COMRXEQ_CTRL_3_4]		= REG_FIELD(COMRXEQ_R01C, 8, 15),
+	[COMRXEQ_CTRL_14_15_16]		= REG_FIELD(COMRXEQ_R04C, 0, 7),
+	[COMRXEQ_CSR_DLEV_ERR_THRESH]	= REG_FIELD(COMRXEQ_R088, 16, 23),
+	[COMRXEQ_CTRL_25]		= REG_FIELD(COMRXEQ_R094, 24, 31),
+	[CSR_RXEQ_RATE_CHANGE_CAL_RUN_RATE2_O] = REG_FIELD(COMRXEQ_R098, 8, 15),
+	[COMRXEQ_HS_RCHANGE_CTRL_7_0]	= REG_FIELD(COMRXEQ_R098, 16, 23),
 	[POR_EN]			= REG_FIELD(SERDES_CTRL, 29, 29),
 	[TX0_ENABLE]			= REG_FIELD(WIZ_LANEXCTL_STS, 29, 31),
 	[RX0_ENABLE]			= REG_FIELD(WIZ_LANEXCTL_STS, 13, 15),
@@ -311,9 +418,32 @@ static int serdes_am654_pcie_init(struct serdes_am654 *phy)
 {
 	int ret = 0;
 
+	ret |= regmap_field_write(phy->fields[CMU_PLL_CTRL], 0x2);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_CM_VCO_VBIAS_VREG], 0x98);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_CM_VCO_BIAS_VREG], 0x98);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_CM_SR], 0x45);
+	ret |= regmap_field_write(phy->fields[AHB_SSC_GEN_Z_O_20_13], 0xe);
+	ret |= regmap_field_write(phy->fields[LANE_PLL_CTRL_RXEQ_RXIDLE], 0x5);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_LN_AGC_THSEL_VREGH], 0x83);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_LN_GEN3_AGC_SD_THSEL], 0x83);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_LN_RX_SELR_GEN3],	0x81);
+	ret |= regmap_field_write(phy->fields[AHB_PMA_LN_TX_DRV], 0x3b);
+	ret |= regmap_field_write(phy->fields[P2S_RBUF_PTR_DIFF], 0x3);
 	ret |= regmap_field_write(phy->fields[CONFIG_VERSION], VERSION_VAL);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_MS_INIT_CTRL_7_0], 0xf);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_HS_INIT_CAL_7_0], 0x4f);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_MS_RECAL_CTRL_7_0], 0xf);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_HS_RECAL_CTRL_7_0], 0x4f);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CSR_ATT_CONFIG], 0x7);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CSR_EBSTADAPT_WIN_LEN], 0x7f);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CTRL_3_4], 0xf);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CTRL_14_15_16], 0x9a);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CSR_DLEV_ERR_THRESH], 0x32);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_CTRL_25], 0x80);
+	ret |= regmap_field_write(phy->fields[CSR_RXEQ_RATE_CHANGE_CAL_RUN_RATE2_O], 0xf);
+	ret |= regmap_field_write(phy->fields[COMRXEQ_HS_RCHANGE_CTRL_7_0], 0x4f);
 	ret |= regmap_field_write(phy->fields[CMU_MASTER_CDN], 0x1);
-	ret |= regmap_field_write(phy->fields[L1_MASTER_CDN], 0x1);
+	ret |= regmap_field_write(phy->fields[L1_MASTER_CDN], 0x2);
 
 	if (ret)
 		return -EIO;
-- 
2.17.1

