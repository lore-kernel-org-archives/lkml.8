Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E5C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A243D206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIJRbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:31:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54618 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgIJR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4D59729BB13
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 04/12] soc: mediatek: pm-domains: Add bus protection protocol
Date:   Thu, 10 Sep 2020 19:28:18 +0200
Message-Id: <20200910172826.3074357-5-enric.balletbo@collabora.com>
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

Bus protection will need to update more then one register
in infracfg. Add support for several operations.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-pm-domains.c | 44 +++++++++++++++++++--------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index db631dbaf2e3..52ac41ca871f 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -53,6 +53,8 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
+#define SPM_MAX_BUS_PROT_DATA		3
+
 struct scpsys_bus_prot_data {
 	u32 bus_prot_mask;
 	bool bus_prot_reg_update;
@@ -73,7 +75,7 @@ struct scpsys_domain_data {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u8 caps;
-	const struct scpsys_bus_prot_data bp_infracfg;
+	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
 };
 
 struct scpsys_domain {
@@ -159,24 +161,40 @@ static int scpsys_sram_disable(struct scpsys_domain *pd, void __iomem *ctl_addr)
 
 static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
-	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int i, ret;
 
-	if (!bp_data->bus_prot_mask)
-		return 0;
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask)
+			break;
 
-	return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
-					       bp_data->bus_prot_reg_update);
+		ret = mtk_infracfg_set_bus_protection(pd->infracfg,
+						      bpd[i].bus_prot_mask,
+						      bpd[i].bus_prot_reg_update);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
-	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int i, ret;
+
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask)
+			return 0;
 
-	if (!bp_data->bus_prot_mask)
-		return 0;
+		ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
+							bpd[i].bus_prot_mask,
+							bpd[i].bus_prot_reg_update);
+		if (ret)
+			return ret;
+	}
 
-	return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
-						 bp_data->bus_prot_reg_update);
+	return 0;
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
@@ -482,7 +500,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
+		.bp_infracfg[0] = {
 			.bus_prot_reg_update = true,
 			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
 				MT8173_TOP_AXI_PROT_EN_MM_M1,
@@ -524,7 +542,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
+		.bp_infracfg[0] = {
 			.bus_prot_reg_update = true,
 			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
 				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-- 
2.28.0

