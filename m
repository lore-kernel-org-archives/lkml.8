Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F0721582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIJRh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgIJR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57EC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:28:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0ECF829BB18
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/12] soc: mediatek: pm-domains: Add SMI block as bus protection block
Date:   Thu, 10 Sep 2020 19:28:20 +0200
Message-Id: <20200910172826.3074357-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Apart from the infracfg block, the SMI block is used to enable the bus
protection for some power domains. Add support for this block.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-pm-domains.c | 64 ++++++++++++++++++++-------
 include/linux/soc/mediatek/infracfg.h |  6 +++
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index f609c2d454fa..3aa430a60602 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -56,8 +56,25 @@
 
 #define SPM_MAX_BUS_PROT_DATA		3
 
+#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
+		.bus_prot_mask = (_mask),		\
+		.bus_prot_set = _set,			\
+		.bus_prot_clr = _clr,			\
+		.bus_prot_sta = _sta,			\
+		.bus_prot_reg_update = _update,		\
+	}
+
+#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, false)
+
+#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, true)
+
 struct scpsys_bus_prot_data {
 	u32 bus_prot_mask;
+	u32 bus_prot_set;
+	u32 bus_prot_clr;
+	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 };
 
@@ -69,6 +86,7 @@ struct scpsys_bus_prot_data {
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
  * @caps: The flag for active wake-up action.
  * @bp_infracfg: bus protection for infracfg subsystem
+ * @bp_smi: bus protection for smi subsystem
  */
 struct scpsys_domain_data {
 	u32 sta_mask;
@@ -77,6 +95,7 @@ struct scpsys_domain_data {
 	u32 sram_pdn_ack_bits;
 	u8 caps;
 	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
+	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
 };
 
 struct scpsys_domain {
@@ -86,6 +105,7 @@ struct scpsys_domain {
 	int num_clks;
 	struct clk_bulk_data *clks;
 	struct regmap *infracfg;
+	struct regmap *smi;
 };
 
 struct scpsys_soc_data {
@@ -173,9 +193,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 		if (bpd[i].bus_prot_reg_update)
 			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
 		else
-			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
+			regmap_write(regmap, bpd[i].bus_prot_set, mask);
 
-		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, (val & mask) == mask,
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
@@ -191,7 +211,11 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	int ret;
 
 	ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
-	return ret;
+	if (ret)
+		return ret;
+
+	bpd = pd->data->bp_smi;
+	return _scpsys_bus_protect_enable(bpd, pd->smi);
 }
 
 static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
@@ -206,11 +230,11 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 			return 0;
 
 		if (bpd[i].bus_prot_reg_update)
-			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
+			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, 0);
 		else
-			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
+			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
-		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, !(val & mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
@@ -226,7 +250,11 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	int ret;
 
 	ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
-	return ret;
+	if (ret)
+		return ret;
+
+	bpd = pd->data->bp_smi;
+	return _scpsys_bus_protect_disable(bpd, pd->smi);
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
@@ -360,6 +388,10 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
 	if (IS_ERR(pd->infracfg))
 		pd->infracfg = NULL;
 
+	pd->smi = syscon_regmap_lookup_by_phandle(node, "mediatek,smi");
+	if (IS_ERR(pd->smi))
+		pd->smi = NULL;
+
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
 		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
@@ -532,10 +564,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg[0] = {
-			.bus_prot_reg_update = true,
-			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
-				MT8173_TOP_AXI_PROT_EN_MM_M1,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT8173_POWER_DOMAIN_VENC_LT] = {
@@ -574,12 +605,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg[0] = {
-			.bus_prot_reg_update = true,
-			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
-				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_MT8173(MT8173_TOP_AXI_PROT_EN_MFG_S |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index f967d02cc2ff..3f18cddffb44 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -37,6 +37,12 @@
 #define INFRA_TOPAXI_PROTECTEN_SET	0x0260
 #define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
 
+#define BUS_PROT_UPDATE_MT8173(_mask)			\
+	BUS_PROT_UPDATE(_mask,				\
+			INFRA_TOPAXI_PROTECTEN,		\
+			INFRA_TOPAXI_PROTECTEN_CLR,	\
+			INFRA_TOPAXI_PROTECTSTA1)
+
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update);
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
-- 
2.28.0

