Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0554C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCA20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJRbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:31:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgIJR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 26B6929BB15
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 05/12] soc: mediatek: pm_domains: Make bus protection generic
Date:   Thu, 10 Sep 2020 19:28:19 +0200
Message-Id: <20200910172826.3074357-6-enric.balletbo@collabora.com>
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

Bus protection is not exclusively done by calling the infracfg misc driver.
Make the calls for setting and clearing the bus protection generic so
that we can use other blocks for it as well.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-infracfg.c   |  5 ---
 drivers/soc/mediatek/mtk-pm-domains.c | 54 +++++++++++++++++++++------
 include/linux/soc/mediatek/infracfg.h |  5 +++
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 341c7ac250e3..8871a524e023 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -12,11 +12,6 @@
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
-#define INFRA_TOPAXI_PROTECTEN		0x0220
-#define INFRA_TOPAXI_PROTECTSTA1	0x0228
-#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
-#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
-
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
  * @regmap: The infracfg regmap
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 52ac41ca871f..f609c2d454fa 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
 
 #include <dt-bindings/power/mt8173-power.h>
@@ -159,18 +160,24 @@ static int scpsys_sram_disable(struct scpsys_domain *pd, void __iomem *ctl_addr)
 				  MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
 {
-	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_mask)
+		u32 val, mask = bpd[i].bus_prot_mask;
+
+		if (!mask)
 			break;
 
-		ret = mtk_infracfg_set_bus_protection(pd->infracfg,
-						      bpd[i].bus_prot_mask,
-						      bpd[i].bus_prot_reg_update);
+		if (bpd[i].bus_prot_reg_update)
+			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, (val & mask) == mask,
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -178,18 +185,34 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
 	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int ret;
+
+	ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
+	return ret;
+}
+
+static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
+				       struct regmap *regmap)
+{
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_mask)
+		u32 val, mask = bpd[i].bus_prot_mask;
+
+		if (!mask)
 			return 0;
 
-		ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
-							bpd[i].bus_prot_mask,
-							bpd[i].bus_prot_reg_update);
+		if (bpd[i].bus_prot_reg_update)
+			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, !(val & mask),
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -197,6 +220,15 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	return 0;
 }
 
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int ret;
+
+	ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
+	return ret;
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index fd25f0148566..f967d02cc2ff 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -32,6 +32,11 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
+#define INFRA_TOPAXI_PROTECTEN		0x0220
+#define INFRA_TOPAXI_PROTECTSTA1	0x0228
+#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
+#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
+
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update);
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
-- 
2.28.0

