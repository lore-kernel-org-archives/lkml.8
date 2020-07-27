Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEDA206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="prkwOJDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgG0TqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:46:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57114 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0TqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:46:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk8SK072052;
        Mon, 27 Jul 2020 14:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595879168;
        bh=8DoqvNs5Ge9OhF8xGlBr5njg0/9YcCrLqUvyZ0Da5uk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=prkwOJDZf7c1AyAXKb9y1EvrZUHQYh+cExxLvMBdPTStIDRqQxhhuE+r1IvfujKOD
         JReEoSo+jBuC4sGvtP41AbHH6V0xEqEKra2vhYIH+7K0a9awSHJHu4FgIrai90dig7
         KYucIJtWWIL+J64qSzc8RorFblvq4Os3jqY+eMH8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk8S8006812;
        Mon, 27 Jul 2020 14:46:08 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 14:46:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 14:46:07 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk3mX036731;
        Mon, 27 Jul 2020 14:46:06 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 1/3] phy: ti: am654: simplify regfield handling
Date:   Tue, 28 Jul 2020 01:16:01 +0530
Message-ID: <20200727194603.44636-2-nsekhar@ti.com>
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

regfield handling in current driver code is made complicated
by having a separate regfield variable for each field which
is allocated individually.

This quickly gets unwieldy once number of regfields increase.
Instead, use an array of regfields which are allocated in a
loop.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 161 +++++++++++++-----------------
 1 file changed, 68 insertions(+), 93 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 0a166d5a6414..836193a71018 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -22,7 +22,7 @@
 #define CMU_R07C		0x7c
 
 #define COMLANE_R138		0xb38
-#define VERSION			0x70
+#define VERSION_VAL		0x70
 
 #define COMLANE_R190		0xb90
 
@@ -80,27 +80,52 @@ static struct regmap_config serdes_am654_regmap_config = {
 	.max_register = 0x1ffc,
 };
 
-static const struct reg_field cmu_master_cdn_o = REG_FIELD(CMU_R07C, 24, 24);
-static const struct reg_field config_version = REG_FIELD(COMLANE_R138, 16, 23);
-static const struct reg_field l1_master_cdn_o = REG_FIELD(COMLANE_R190, 9, 9);
-static const struct reg_field cmu_ok_i_0 = REG_FIELD(COMLANE_R194, 19, 19);
-static const struct reg_field por_en = REG_FIELD(SERDES_CTRL, 29, 29);
-static const struct reg_field tx0_enable = REG_FIELD(WIZ_LANEXCTL_STS, 29, 31);
-static const struct reg_field rx0_enable = REG_FIELD(WIZ_LANEXCTL_STS, 13, 15);
-static const struct reg_field pll_enable = REG_FIELD(WIZ_PLL_CTRL, 29, 31);
-static const struct reg_field pll_ok = REG_FIELD(WIZ_PLL_CTRL, 28, 28);
+enum serdes_am654_fields {
+	/* CMU Master Reset */
+	CMU_MASTER_CDN,
+	CONFIG_VERSION,
+
+	/* Lane 1 Master Reset */
+	L1_MASTER_CDN,
+
+	/* CMU OK Status */
+	CMU_OK_I_0,
+
+	/* Serdes reset */
+	POR_EN,
+
+	/* Tx Enable Value */
+	TX0_ENABLE,
+
+	/* Rx Enable Value */
+	RX0_ENABLE,
+
+	/* PLL Enable Value */
+	PLL_ENABLE,
+
+	/* PLL ready for use */
+	PLL_OK,
+
+	/* sentinel */
+	MAX_FIELDS
+
+};
+
+static const struct reg_field serdes_am654_reg_fields[] = {
+	[CMU_MASTER_CDN]		= REG_FIELD(CMU_R07C, 24, 24),
+	[CONFIG_VERSION]		= REG_FIELD(COMLANE_R138, 16, 23),
+	[L1_MASTER_CDN]			= REG_FIELD(COMLANE_R190, 9, 9),
+	[CMU_OK_I_0]			= REG_FIELD(COMLANE_R194, 19, 19),
+	[POR_EN]			= REG_FIELD(SERDES_CTRL, 29, 29),
+	[TX0_ENABLE]			= REG_FIELD(WIZ_LANEXCTL_STS, 29, 31),
+	[RX0_ENABLE]			= REG_FIELD(WIZ_LANEXCTL_STS, 13, 15),
+	[PLL_ENABLE]			= REG_FIELD(WIZ_PLL_CTRL, 29, 31),
+	[PLL_OK]			= REG_FIELD(WIZ_PLL_CTRL, 28, 28),
+};
 
 struct serdes_am654 {
 	struct regmap		*regmap;
-	struct regmap_field	*cmu_master_cdn_o;
-	struct regmap_field	*config_version;
-	struct regmap_field	*l1_master_cdn_o;
-	struct regmap_field	*cmu_ok_i_0;
-	struct regmap_field	*por_en;
-	struct regmap_field	*tx0_enable;
-	struct regmap_field	*rx0_enable;
-	struct regmap_field	*pll_enable;
-	struct regmap_field	*pll_ok;
+	struct regmap_field	*fields[MAX_FIELDS];
 
 	struct device		*dev;
 	struct mux_control	*control;
@@ -116,12 +141,12 @@ static int serdes_am654_enable_pll(struct serdes_am654 *phy)
 	int ret;
 	u32 val;
 
-	ret = regmap_field_write(phy->pll_enable, PLL_ENABLE_STATE);
+	ret = regmap_field_write(phy->fields[PLL_ENABLE], PLL_ENABLE_STATE);
 	if (ret)
 		return ret;
 
-	return regmap_field_read_poll_timeout(phy->pll_ok, val, val, 1000,
-					      PLL_LOCK_TIME);
+	return regmap_field_read_poll_timeout(phy->fields[PLL_OK], val, val,
+					      1000, PLL_LOCK_TIME);
 }
 
 static void serdes_am654_disable_pll(struct serdes_am654 *phy)
@@ -129,7 +154,7 @@ static void serdes_am654_disable_pll(struct serdes_am654 *phy)
 	struct device *dev = phy->dev;
 	int ret;
 
-	ret = regmap_field_write(phy->pll_enable, PLL_DISABLE_STATE);
+	ret = regmap_field_write(phy->fields[PLL_ENABLE], PLL_DISABLE_STATE);
 	if (ret)
 		dev_err(dev, "Failed to disable PLL\n");
 }
@@ -139,12 +164,12 @@ static int serdes_am654_enable_txrx(struct serdes_am654 *phy)
 	int ret;
 
 	/* Enable TX */
-	ret = regmap_field_write(phy->tx0_enable, TX0_ENABLE_STATE);
+	ret = regmap_field_write(phy->fields[TX0_ENABLE], TX0_ENABLE_STATE);
 	if (ret)
 		return ret;
 
 	/* Enable RX */
-	ret = regmap_field_write(phy->rx0_enable, RX0_ENABLE_STATE);
+	ret = regmap_field_write(phy->fields[RX0_ENABLE], RX0_ENABLE_STATE);
 	if (ret)
 		return ret;
 
@@ -156,12 +181,12 @@ static int serdes_am654_disable_txrx(struct serdes_am654 *phy)
 	int ret;
 
 	/* Disable TX */
-	ret = regmap_field_write(phy->tx0_enable, TX0_DISABLE_STATE);
+	ret = regmap_field_write(phy->fields[TX0_ENABLE], TX0_DISABLE_STATE);
 	if (ret)
 		return ret;
 
 	/* Disable RX */
-	ret = regmap_field_write(phy->rx0_enable, RX0_DISABLE_STATE);
+	ret = regmap_field_write(phy->fields[RX0_ENABLE], RX0_DISABLE_STATE);
 	if (ret)
 		return ret;
 
@@ -187,8 +212,8 @@ static int serdes_am654_power_on(struct phy *x)
 		return ret;
 	}
 
-	return regmap_field_read_poll_timeout(phy->cmu_ok_i_0, val, val,
-					      SLEEP_TIME, PLL_LOCK_TIME);
+	return regmap_field_read_poll_timeout(phy->fields[CMU_OK_I_0], val,
+					      val, SLEEP_TIME, PLL_LOCK_TIME);
 }
 
 static int serdes_am654_power_off(struct phy *x)
@@ -288,15 +313,15 @@ static int serdes_am654_pcie_init(struct serdes_am654 *phy)
 {
 	int ret;
 
-	ret = regmap_field_write(phy->config_version, VERSION);
+	ret = regmap_field_write(phy->fields[CONFIG_VERSION], VERSION_VAL);
 	if (ret)
 		return ret;
 
-	ret = regmap_field_write(phy->cmu_master_cdn_o, 0x1);
+	ret = regmap_field_write(phy->fields[CMU_MASTER_CDN], 0x1);
 	if (ret)
 		return ret;
 
-	ret = regmap_field_write(phy->l1_master_cdn_o, 0x1);
+	ret = regmap_field_write(phy->fields[L1_MASTER_CDN], 0x1);
 	if (ret)
 		return ret;
 
@@ -325,13 +350,13 @@ static int serdes_am654_reset(struct phy *x)
 	serdes_am654_disable_pll(phy);
 	serdes_am654_disable_txrx(phy);
 
-	ret = regmap_field_write(phy->por_en, 0x1);
+	ret = regmap_field_write(phy->fields[POR_EN], 0x1);
 	if (ret)
 		return ret;
 
 	mdelay(1);
 
-	ret = regmap_field_write(phy->por_en, 0x0);
+	ret = regmap_field_write(phy->fields[POR_EN], 0x0);
 	if (ret)
 		return ret;
 
@@ -587,66 +612,16 @@ static int serdes_am654_regfield_init(struct serdes_am654 *am654_phy)
 {
 	struct regmap *regmap = am654_phy->regmap;
 	struct device *dev = am654_phy->dev;
+	int i;
 
-	am654_phy->cmu_master_cdn_o = devm_regmap_field_alloc(dev, regmap,
-							      cmu_master_cdn_o);
-	if (IS_ERR(am654_phy->cmu_master_cdn_o)) {
-		dev_err(dev, "CMU_MASTER_CDN_O reg field init failed\n");
-		return PTR_ERR(am654_phy->cmu_master_cdn_o);
-	}
-
-	am654_phy->config_version = devm_regmap_field_alloc(dev, regmap,
-							    config_version);
-	if (IS_ERR(am654_phy->config_version)) {
-		dev_err(dev, "CONFIG_VERSION reg field init failed\n");
-		return PTR_ERR(am654_phy->config_version);
-	}
-
-	am654_phy->l1_master_cdn_o = devm_regmap_field_alloc(dev, regmap,
-							     l1_master_cdn_o);
-	if (IS_ERR(am654_phy->l1_master_cdn_o)) {
-		dev_err(dev, "L1_MASTER_CDN_O reg field init failed\n");
-		return PTR_ERR(am654_phy->l1_master_cdn_o);
-	}
-
-	am654_phy->cmu_ok_i_0 = devm_regmap_field_alloc(dev, regmap,
-							cmu_ok_i_0);
-	if (IS_ERR(am654_phy->cmu_ok_i_0)) {
-		dev_err(dev, "CMU_OK_I_0 reg field init failed\n");
-		return PTR_ERR(am654_phy->cmu_ok_i_0);
-	}
-
-	am654_phy->por_en = devm_regmap_field_alloc(dev, regmap, por_en);
-	if (IS_ERR(am654_phy->por_en)) {
-		dev_err(dev, "POR_EN reg field init failed\n");
-		return PTR_ERR(am654_phy->por_en);
-	}
-
-	am654_phy->tx0_enable = devm_regmap_field_alloc(dev, regmap,
-							tx0_enable);
-	if (IS_ERR(am654_phy->tx0_enable)) {
-		dev_err(dev, "TX0_ENABLE reg field init failed\n");
-		return PTR_ERR(am654_phy->tx0_enable);
-	}
-
-	am654_phy->rx0_enable = devm_regmap_field_alloc(dev, regmap,
-							rx0_enable);
-	if (IS_ERR(am654_phy->rx0_enable)) {
-		dev_err(dev, "RX0_ENABLE reg field init failed\n");
-		return PTR_ERR(am654_phy->rx0_enable);
-	}
-
-	am654_phy->pll_enable = devm_regmap_field_alloc(dev, regmap,
-							pll_enable);
-	if (IS_ERR(am654_phy->pll_enable)) {
-		dev_err(dev, "PLL_ENABLE reg field init failed\n");
-		return PTR_ERR(am654_phy->pll_enable);
-	}
-
-	am654_phy->pll_ok = devm_regmap_field_alloc(dev, regmap, pll_ok);
-	if (IS_ERR(am654_phy->pll_ok)) {
-		dev_err(dev, "PLL_OK reg field init failed\n");
-		return PTR_ERR(am654_phy->pll_ok);
+	for (i = 0; i < MAX_FIELDS; i++) {
+		am654_phy->fields[i] = devm_regmap_field_alloc(dev,
+							       regmap,
+							       serdes_am654_reg_fields[i]);
+		if (IS_ERR(am654_phy->fields[i])) {
+			dev_err(dev, "Unable to allocate regmap field %d\n", i);
+			return PTR_ERR(am654_phy->fields[i]);
+		}
 	}
 
 	return 0;
-- 
2.17.1

