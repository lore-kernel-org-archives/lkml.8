Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFBC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B20A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fsWK58n4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgGOLZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:30 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62526 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgGOLZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812327; x=1626348327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oURAU4DGWL3mFMY+Lw1NVxLEsg2r2biBRPsLMwX3NXw=;
  b=fsWK58n4YPMlwCDBQqooZrtEg9eQsTGif7I0AJuqthB/G1l9cYT0xeWU
   DAfvery6lf3RCMCrd/EtF4H9nEiutnaeVusfVKCL9WpchWYfV5XCJbiKL
   /z32guBJW83hUmLNtkERVYbp8EZtKbjdToOfRbGUh21G8EOrqBsDT4U9J
   BIeJ8C0NHMg+AmtE76jOM/6Kz4hGRpsPYtp5LOu5235EEePqsdVXNkcKO
   +Es1E7nt4ffAG6IL0S4UypbFxnMOyipNtkzJpdtwWDy5RVMiSrSQdOTvH
   PEkzKJAF+MBnHuwGQheGMwmV0QklIvuliiKRKruXh9/hCCeTxc+TiWAM+
   g==;
IronPort-SDR: 3omDv9oRlwjTkqwHEdELlwkXQEc6SBwtFhvOgUP86jV4h4AlrR73ZC2UhRDCpQgM7okeBUmIL6
 h3dad6FxvtEWMGlKT8ksTGDylWlMleg+qDcyC57AM+ZShTQr4RDT18AWWMz9R0M9ymS1MtmBPi
 EZ7iE19A4OfPBs+421y7VcA9bR5MJ32aGeAbCc+Qb3iIk2FK4ZOkfrwuLVOYegdXGcyG4psFnB
 fO1rX1GmBo98e0e9G+5bNWo97zcJEDn9xzlywr0xicndxwiKjo1GofxIozME52G8cHQIQiWp/O
 lpM=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962917"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:25:26 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 13/19] clk: at91: clk-master: add master clock support for SAMA7G5
Date:   Wed, 15 Jul 2020 14:24:21 +0300
Message-ID: <1594812267-6697-14-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add master clock support (MCK1..4) for SAMA7G5. SAMA7G5's PMC has
multiple master clocks feeding different subsystems. One of them
feeds image subsystem and is changeable based on image subsystem
needs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 310 +++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/at91/pmc.h        |   7 +
 include/linux/clk/at91_pmc.h  |   1 +
 3 files changed, 313 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 88d545b1698c..bd0d8a69a2cf 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -17,30 +17,49 @@
 #define MASTER_DIV_SHIFT	8
 #define MASTER_DIV_MASK		0x3
 
+#define PMC_MCR			0x30
+#define PMC_MCR_ID_MSK		GENMASK(3, 0)
+#define PMC_MCR_CMD		BIT(7)
+#define PMC_MCR_DIV		GENMASK(10, 8)
+#define PMC_MCR_CSS		GENMASK(20, 16)
+#define PMC_MCR_CSS_SHIFT	(16)
+#define PMC_MCR_EN		BIT(28)
+
+#define PMC_MCR_ID(x)		((x) & PMC_MCR_ID_MSK)
+
+#define MASTER_MAX_ID		4
+
 #define to_clk_master(hw) container_of(hw, struct clk_master, hw)
 
 struct clk_master {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	spinlock_t *lock;
 	const struct clk_master_layout *layout;
 	const struct clk_master_characteristics *characteristics;
+	u32 *mux_table;
 	u32 mckr;
+	int chg_pid;
+	u8 id;
+	u8 parent;
+	u8 div;
 };
 
-static inline bool clk_master_ready(struct regmap *regmap)
+static inline bool clk_master_ready(struct clk_master *master)
 {
+	unsigned int bit = master->id ? AT91_PMC_MCKXRDY : AT91_PMC_MCKRDY;
 	unsigned int status;
 
-	regmap_read(regmap, AT91_PMC_SR, &status);
+	regmap_read(master->regmap, AT91_PMC_SR, &status);
 
-	return !!(status & AT91_PMC_MCKRDY);
+	return !!(status & bit);
 }
 
 static int clk_master_prepare(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
 
-	while (!clk_master_ready(master->regmap))
+	while (!clk_master_ready(master))
 		cpu_relax();
 
 	return 0;
@@ -50,7 +69,7 @@ static int clk_master_is_prepared(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
 
-	return clk_master_ready(master->regmap);
+	return clk_master_ready(master);
 }
 
 static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
@@ -143,6 +162,287 @@ at91_clk_register_master(struct regmap *regmap,
 	return hw;
 }
 
+static unsigned long
+clk_sama7g5_master_recalc_rate(struct clk_hw *hw,
+			       unsigned long parent_rate)
+{
+	struct clk_master *master = to_clk_master(hw);
+
+	return DIV_ROUND_CLOSEST_ULL(parent_rate, (1 << master->div));
+}
+
+static void clk_sama7g5_master_best_diff(struct clk_rate_request *req,
+					 struct clk_hw *parent,
+					 unsigned long parent_rate,
+					 long *best_rate,
+					 long *best_diff,
+					 u32 div)
+{
+	unsigned long tmp_rate, tmp_diff;
+
+	if (div == MASTER_PRES_MAX)
+		tmp_rate = parent_rate / 3;
+	else
+		tmp_rate = parent_rate >> div;
+
+	tmp_diff = abs(req->rate - tmp_rate);
+
+	if (*best_diff < 0 || *best_diff >= tmp_diff) {
+		*best_rate = tmp_rate;
+		*best_diff = tmp_diff;
+		req->best_parent_rate = parent_rate;
+		req->best_parent_hw = parent;
+	}
+}
+
+static int clk_sama7g5_master_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	struct clk_master *master = to_clk_master(hw);
+	struct clk_rate_request req_parent = *req;
+	struct clk_hw *parent;
+	long best_rate = LONG_MIN, best_diff = LONG_MIN;
+	unsigned long parent_rate;
+	unsigned int div, i;
+
+	/* First: check the dividers of MCR. */
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+		if (!parent_rate)
+			continue;
+
+		for (div = 0; div < MASTER_PRES_MAX + 1; div++) {
+			clk_sama7g5_master_best_diff(req, parent, parent_rate,
+						     &best_rate, &best_diff,
+						     div);
+			if (!best_diff)
+				break;
+		}
+
+		if (!best_diff)
+			break;
+	}
+
+	/* Second: try to request rate form changeable parent. */
+	if (master->chg_pid < 0)
+		goto end;
+
+	parent = clk_hw_get_parent_by_index(hw, master->chg_pid);
+	if (!parent)
+		goto end;
+
+	for (div = 0; div < MASTER_PRES_MAX + 1; div++) {
+		if (div == MASTER_PRES_MAX)
+			req_parent.rate = req->rate * 3;
+		else
+			req_parent.rate = req->rate << div;
+
+		if (__clk_determine_rate(parent, &req_parent))
+			continue;
+
+		clk_sama7g5_master_best_diff(req, parent, req_parent.rate,
+					     &best_rate, &best_diff, div);
+
+		if (!best_diff)
+			break;
+	}
+
+end:
+	pr_debug("MCK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
+		 __func__, best_rate,
+		 __clk_get_name((req->best_parent_hw)->clk),
+		req->best_parent_rate);
+
+	if (best_rate < 0)
+		return -EINVAL;
+
+	req->rate = best_rate;
+
+	return 0;
+}
+
+static u8 clk_sama7g5_master_get_parent(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+	u8 index;
+
+	spin_lock_irqsave(master->lock, flags);
+	index = clk_mux_val_to_index(&master->hw, master->mux_table, 0,
+				     master->parent);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	return index;
+}
+
+static int clk_sama7g5_master_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+
+	if (index >= clk_hw_get_num_parents(hw))
+		return -EINVAL;
+
+	spin_lock_irqsave(master->lock, flags);
+	master->parent = clk_mux_index_to_val(master->mux_table, 0, index);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	return 0;
+}
+
+static int clk_sama7g5_master_enable(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+	unsigned int val, cparent;
+
+	spin_lock_irqsave(master->lock, flags);
+
+	regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master->id));
+	regmap_read(master->regmap, PMC_MCR, &val);
+	regmap_update_bits(master->regmap, PMC_MCR,
+			   PMC_MCR_EN | PMC_MCR_CSS | PMC_MCR_DIV |
+			   PMC_MCR_CMD | PMC_MCR_ID_MSK,
+			   PMC_MCR_EN | (master->parent << PMC_MCR_CSS_SHIFT) |
+			   (master->div << MASTER_DIV_SHIFT) |
+			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
+
+	cparent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
+
+	/* Wait here only if parent is being changed. */
+	while ((cparent != master->parent) && !clk_master_ready(master))
+		cpu_relax();
+
+	spin_unlock_irqrestore(master->lock, flags);
+
+	return 0;
+}
+
+static void clk_sama7g5_master_disable(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(master->lock, flags);
+
+	regmap_write(master->regmap, PMC_MCR, master->id);
+	regmap_update_bits(master->regmap, PMC_MCR,
+			   PMC_MCR_EN | PMC_MCR_CMD | PMC_MCR_ID_MSK,
+			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
+
+	spin_unlock_irqrestore(master->lock, flags);
+}
+
+static int clk_sama7g5_master_is_enabled(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(master->lock, flags);
+
+	regmap_write(master->regmap, PMC_MCR, master->id);
+	regmap_read(master->regmap, PMC_MCR, &val);
+
+	spin_unlock_irqrestore(master->lock, flags);
+
+	return !!(val & PMC_MCR_EN);
+}
+
+static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long div, flags;
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if ((div > (1 << (MASTER_PRES_MAX - 1))) || (div & (div - 1)))
+		return -EINVAL;
+
+	if (div == 3)
+		div = MASTER_PRES_MAX;
+	else
+		div = ffs(div) - 1;
+
+	spin_lock_irqsave(master->lock, flags);
+	master->div = div;
+	spin_unlock_irqrestore(master->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops sama7g5_master_ops = {
+	.enable = clk_sama7g5_master_enable,
+	.disable = clk_sama7g5_master_disable,
+	.is_enabled = clk_sama7g5_master_is_enabled,
+	.recalc_rate = clk_sama7g5_master_recalc_rate,
+	.determine_rate = clk_sama7g5_master_determine_rate,
+	.set_rate = clk_sama7g5_master_set_rate,
+	.get_parent = clk_sama7g5_master_get_parent,
+	.set_parent = clk_sama7g5_master_set_parent,
+};
+
+struct clk_hw * __init
+at91_clk_sama7g5_register_master(struct regmap *regmap,
+				 const char *name, int num_parents,
+				 const char **parent_names,
+				 u32 *mux_table,
+				 spinlock_t *lock, u8 id,
+				 bool critical, int chg_pid)
+{
+	struct clk_master *master;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	unsigned long flags;
+	unsigned int val;
+	int ret;
+
+	if (!name || !num_parents || !parent_names || !mux_table ||
+	    !lock || id > MASTER_MAX_ID)
+		return ERR_PTR(-EINVAL);
+
+	master = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &sama7g5_master_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+	if (chg_pid >= 0)
+		init.flags |= CLK_SET_RATE_PARENT;
+	if (critical)
+		init.flags |= CLK_IS_CRITICAL;
+
+	master->hw.init = &init;
+	master->regmap = regmap;
+	master->id = id;
+	master->chg_pid = chg_pid;
+	master->lock = lock;
+	master->mux_table = mux_table;
+
+	spin_lock_irqsave(master->lock, flags);
+	regmap_write(master->regmap, PMC_MCR, master->id);
+	regmap_read(master->regmap, PMC_MCR, &val);
+	master->parent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
+	master->div = (val & PMC_MCR_DIV) >> MASTER_DIV_SHIFT;
+	spin_unlock_irqrestore(master->lock, flags);
+
+	hw = &master->hw;
+	ret = clk_hw_register(NULL, &master->hw);
+	if (ret) {
+		kfree(master);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
 const struct clk_master_layout at91rm9200_master_layout = {
 	.mask = 0x31F,
 	.pres_shift = 2,
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 2bfe1405f9f8..29d150feaa46 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -155,6 +155,13 @@ at91_clk_register_master(struct regmap *regmap, const char *name,
 			 const struct clk_master_characteristics *characteristics);
 
 struct clk_hw * __init
+at91_clk_sama7g5_register_master(struct regmap *regmap,
+				 const char *name, int num_parents,
+				 const char **parent_names, u32 *mux_table,
+				 spinlock_t *lock, u8 id, bool critical,
+				 int chg_pid);
+
+struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 			     const char *parent_name, u32 id);
 struct clk_hw * __init
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 49a53a137610..77d6dabc4c3c 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -174,6 +174,7 @@
 #define		AT91_PMC_MOSCRCS	(1 << 17)		/* Main On-Chip RC [some SAM9] */
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
 #define		AT91_PMC_GCKRDY		(1 << 24)		/* Generated Clocks */
+#define		AT91_PMC_MCKXRDY	(1 << 26)		/* Master Clock x [x=1..4] Ready Status */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
 #define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
-- 
2.7.4

