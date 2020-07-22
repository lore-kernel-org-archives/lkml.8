Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C3C433FB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7798E20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lSMFvOC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgGVHjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:13 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23413 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgGVHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403551; x=1626939551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BGrluRL9eVSzvJorGbmFTVBhikAio3RdBUKVk7O0GUI=;
  b=lSMFvOC1pcl0lZP/bGMr8JvOiiKuwI5jjUfYN1cnIoN75ENX8aHsCoeO
   QFrM7K5IW6C5QlMVKp0o08zGy+gUvEjOBSi6efZzFxJhJzzElJpbNgu7+
   eDw4cjGhw9+7IpWXPxWBvok3tXqAPXuuELvM+0EmSAZE7IwjT7wgD1meB
   ujzwPdkTaJFsIOSn13lLjgUH6B41wPTi5BzCDWWpWyIrrg3lrjBTbEyNp
   6HOlMN8X0v+Sfuu8AGIoi4zDIbQU+nQEpxUt0v/Wjeq6v4UFFGkn2Nwib
   VPzmTdg8Ex6AuEEojgxzroJO+Jqj+RDUcsYsO7Y07/5ddTB7zsRuxwEyP
   A==;
IronPort-SDR: JEEpu2yIBD9dnHpIWK+2g6Efe+7oATch6Rsq+F54Bqugwzd/g7m+bSGw+EfdhTnTkE6Awe1luH
 dJ6EfBxWYx1VadnTd3bS8Wxc9G3Kmi/hxw1J68IS0hS/44j0DJ7e8vZWCAM5YvHwI4139HaK00
 uo0EeAlCXyetEa6Eaq6K25m+a/UOWUYW0CB7JsF9pUD0pyD+e0nBfpvU7eJzxcHwEnoBx9XPPx
 LvE+GjrXMU1WMUNl8tzcLS7vzVoIsBpmLhOaXGnDIBupV0E/37DOPoKdtFlksLCAwjpGjYhIwZ
 4z8=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="82772089"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:39:07 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 10/18] clk: at91: clk-generated: pass the id of changeable parent at registration
Date:   Wed, 22 Jul 2020 10:38:18 +0300
Message-ID: <1595403506-8209-11-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the ID of changeable parent at registration. This will allow
the scalability of this clock driver with regards to the changeable
parent ID for versions of this IP where changeable parent is not the
last one in the parents list (e.g. SAMA7G5). With this the clock flags
are set to zero in case we have no changeable parent. Also in
clk_generated_best_diff() the *best_diff variable is check against
tmp_diff variable using ">=" operator instead of ">" so that in case
the requested frequency could be obtained using fix parents + gck
dividers but the clock also supports changeable parent to be able
to force the usage of the changeable parent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 26 ++++++++++++++------------
 drivers/clk/at91/dt-compat.c     |  8 +++++---
 drivers/clk/at91/pmc.h           |  4 ++--
 drivers/clk/at91/sam9x60.c       |  3 +--
 drivers/clk/at91/sama5d2.c       | 31 +++++++++++++++----------------
 5 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 2448bdc63425..f9ca04c97128 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -18,8 +18,6 @@
 
 #define GENERATED_MAX_DIV	255
 
-#define GCK_INDEX_DT_AUDIO_PLL	5
-
 struct clk_generated {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -29,7 +27,7 @@ struct clk_generated {
 	u32 gckdiv;
 	const struct clk_pcr_layout *layout;
 	u8 parent_id;
-	bool audio_pll_allowed;
+	int chg_pid;
 };
 
 #define to_clk_generated(hw) \
@@ -109,7 +107,7 @@ static void clk_generated_best_diff(struct clk_rate_request *req,
 		tmp_rate = parent_rate / div;
 	tmp_diff = abs(req->rate - tmp_rate);
 
-	if (*best_diff < 0 || *best_diff > tmp_diff) {
+	if (*best_diff < 0 || *best_diff >= tmp_diff) {
 		*best_rate = tmp_rate;
 		*best_diff = tmp_diff;
 		req->best_parent_rate = parent_rate;
@@ -129,7 +127,10 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 	int i;
 	u32 div;
 
-	for (i = 0; i < clk_hw_get_num_parents(hw) - 1; i++) {
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		if (gck->chg_pid == i)
+			continue;
+
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
@@ -161,10 +162,10 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 	 * that the only clks able to modify gck rate are those of audio IPs.
 	 */
 
-	if (!gck->audio_pll_allowed)
+	if (gck->chg_pid < 0)
 		goto end;
 
-	parent = clk_hw_get_parent_by_index(hw, GCK_INDEX_DT_AUDIO_PLL);
+	parent = clk_hw_get_parent_by_index(hw, gck->chg_pid);
 	if (!parent)
 		goto end;
 
@@ -272,8 +273,8 @@ struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id, bool pll_audio,
-			    const struct clk_range *range)
+			    u8 num_parents, u8 id,
+			    const struct clk_range *range, int chg_pid)
 {
 	struct clk_generated *gck;
 	struct clk_init_data init;
@@ -288,15 +289,16 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	init.ops = &generated_ops;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
-	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+	if (chg_pid >= 0)
+		init.flags |= CLK_SET_RATE_PARENT;
 
 	gck->id = id;
 	gck->hw.init = &init;
 	gck->regmap = regmap;
 	gck->lock = lock;
 	gck->range = *range;
-	gck->audio_pll_allowed = pll_audio;
+	gck->chg_pid = chg_pid;
 	gck->layout = layout;
 
 	clk_generated_startup(gck);
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index aa1754eac59f..8a652c44c25a 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -22,6 +22,8 @@
 
 #define SYSTEM_MAX_ID		31
 
+#define GCK_INDEX_DT_AUDIO_PLL	5
+
 #ifdef CONFIG_HAVE_AT91_AUDIO_PLL
 static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 {
@@ -135,7 +137,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		return;
 
 	for_each_child_of_node(np, gcknp) {
-		bool pll_audio = false;
+		int chg_pid = INT_MIN;
 
 		if (of_property_read_u32(gcknp, "reg", &id))
 			continue;
@@ -152,12 +154,12 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 		if (of_device_is_compatible(np, "atmel,sama5d2-clk-generated") &&
 		    (id == GCK_ID_I2S0 || id == GCK_ID_I2S1 ||
 		     id == GCK_ID_CLASSD))
-			pll_audio = true;
+			chg_pid = GCK_INDEX_DT_AUDIO_PLL;
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &dt_pcr_layout, name,
 						 parent_names, num_parents,
-						 id, pll_audio, &range);
+						 id, &range, chg_pid);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index df616f2937e7..949b1a7b91e5 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -122,8 +122,8 @@ struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id, bool pll_audio,
-			    const struct clk_range *range);
+			    u8 num_parents, u8 id,
+			    const struct clk_range *range, int chg_pid);
 
 struct clk_hw * __init
 at91_clk_register_h32mx(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index c8703d2a0886..c4e34c0909e3 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -290,8 +290,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 						 sam9x60_gck[i].n,
 						 parent_names, 6,
 						 sam9x60_gck[i].id,
-						 false,
-						 &sam9x60_gck[i].r);
+						 &sam9x60_gck[i].r, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index d69421d71daf..42637d9531d3 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -116,21 +116,20 @@ static const struct {
 	char *n;
 	u8 id;
 	struct clk_range r;
-	bool pll;
+	int chg_pid;
 } sama5d2_gck[] = {
-	{ .n = "sdmmc0_gclk", .id = 31, },
-	{ .n = "sdmmc1_gclk", .id = 32, },
-	{ .n = "tcb0_gclk",   .id = 35, .r = { .min = 0, .max = 83000000 }, },
-	{ .n = "tcb1_gclk",   .id = 36, .r = { .min = 0, .max = 83000000 }, },
-	{ .n = "pwm_gclk",    .id = 38, .r = { .min = 0, .max = 83000000 }, },
-	{ .n = "isc_gclk",    .id = 46, },
-	{ .n = "pdmic_gclk",  .id = 48, },
-	{ .n = "i2s0_gclk",   .id = 54, .pll = true },
-	{ .n = "i2s1_gclk",   .id = 55, .pll = true },
-	{ .n = "can0_gclk",   .id = 56, .r = { .min = 0, .max = 80000000 }, },
-	{ .n = "can1_gclk",   .id = 57, .r = { .min = 0, .max = 80000000 }, },
-	{ .n = "classd_gclk", .id = 59, .r = { .min = 0, .max = 100000000 },
-	  .pll = true },
+	{ .n = "sdmmc0_gclk", .id = 31, .chg_pid = INT_MIN, },
+	{ .n = "sdmmc1_gclk", .id = 32, .chg_pid = INT_MIN, },
+	{ .n = "tcb0_gclk",   .id = 35, .chg_pid = INT_MIN, .r = { .min = 0, .max = 83000000 }, },
+	{ .n = "tcb1_gclk",   .id = 36, .chg_pid = INT_MIN, .r = { .min = 0, .max = 83000000 }, },
+	{ .n = "pwm_gclk",    .id = 38, .chg_pid = INT_MIN, .r = { .min = 0, .max = 83000000 }, },
+	{ .n = "isc_gclk",    .id = 46, .chg_pid = INT_MIN, },
+	{ .n = "pdmic_gclk",  .id = 48, .chg_pid = INT_MIN, },
+	{ .n = "i2s0_gclk",   .id = 54, .chg_pid = 5, },
+	{ .n = "i2s1_gclk",   .id = 55, .chg_pid = 5, },
+	{ .n = "can0_gclk",   .id = 56, .chg_pid = INT_MIN, .r = { .min = 0, .max = 80000000 }, },
+	{ .n = "can1_gclk",   .id = 57, .chg_pid = INT_MIN, .r = { .min = 0, .max = 80000000 }, },
+	{ .n = "classd_gclk", .id = 59, .chg_pid = 5, .r = { .min = 0, .max = 100000000 }, },
 };
 
 static const struct clk_programmable_layout sama5d2_programmable_layout = {
@@ -324,8 +323,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 						 sama5d2_gck[i].n,
 						 parent_names, 6,
 						 sama5d2_gck[i].id,
-						 sama5d2_gck[i].pll,
-						 &sama5d2_gck[i].r);
+						 &sama5d2_gck[i].r,
+						 sama5d2_gck[i].chg_pid);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.7.4

