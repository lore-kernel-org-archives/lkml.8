Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE2C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A3320658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XEiKII58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgGOLZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:35 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9413 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgGOLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812331; x=1626348331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UFiLg3HndQzEMmbFV+IqhvK1C6Up8/+N0yxf7QIo9nY=;
  b=XEiKII58I0fUSJpVTJ2y96CBYmNZ+8tu2zCx7EDDCxDRrFSYH7hFpylI
   /xZyRcR+pLB5HkEPpKZiP5wPPB02MhgoBM7boDjA2qoOIelQg85XmjkC7
   HmfLSwS59fVfesih75S2f0XJPMHFJpmc6s7/PqMdMlGMf8t5HkYxDpIIf
   i3hkyeR9XoQABVj3MjCJaFP93uMhIGlOs4nd5IRIRZgKDs5nYbJ3CMSSd
   RLvAzOuVsNYwTSWcN8Sj1GOPMr7eWeQF8a6aW+X4EFqjr6OwnEMWQQFS5
   qDkny4W5BfPp4iMHTPqBfMJKmbh8IJdIc8CERy2Gz1MLo+97XnlTPY8Pp
   g==;
IronPort-SDR: j8jmlxMeeJqaJvswNT53WHr4us/YkL/c+cJh63F98pMx3pV9pU7p5hmvYecCpobSU+UsztkCfV
 aWyyrc3JbqeV/IsVnUD77e9nPlez17Cxh3bgoEoW+gHTvA82iP6YW3BUuysTkxFCu3rxNf13/2
 /6xk6yaWEASZMVx/6MLCVSneKWJVcZi+shce3DjZYLWc4u9XL4n4vMxbPcHNrI0JfjFSDtPiCj
 hm7Q42GvmSHaJRx8Xlbp2Y2LBdiGTvmyoMvMz3FwMX81+s2gzrVaIkf6dWRfMtSBOMfpJgmtMQ
 g+Q=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="79986188"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:25:30 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 14/19] clk: at91: clk-peripheral: add support for changeable parent rate
Date:   Wed, 15 Jul 2020 14:24:22 +0300
Message-ID: <1594812267-6697-15-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some peripheral clocks on SAMA7G5 supports requesting parent to change
its rate (image related clocks: csi, csi2dc, isc). Add support
so that if registered with this option the clock rate to be
requested from parent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91sam9n12.c    |   2 +-
 drivers/clk/at91/at91sam9x5.c     |   4 +-
 drivers/clk/at91/clk-peripheral.c | 109 ++++++++++++++++++++++++++++++++++++--
 drivers/clk/at91/dt-compat.c      |   3 +-
 drivers/clk/at91/pmc.h            |   3 +-
 drivers/clk/at91/sam9x60.c        |   2 +-
 drivers/clk/at91/sama5d2.c        |   5 +-
 drivers/clk/at91/sama5d3.c        |   3 +-
 drivers/clk/at91/sama5d4.c        |   4 +-
 9 files changed, 119 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 630dc5d87171..f4c36e6e4deb 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -222,7 +222,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 							 at91sam9n12_periphck[i].n,
 							 "masterck",
 							 at91sam9n12_periphck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 0ce3da080287..52a9d2f7ec83 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -257,7 +257,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 							 at91sam9x5_periphck[i].n,
 							 "masterck",
 							 at91sam9x5_periphck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -270,7 +270,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 							 extra_pcks[i].n,
 							 "masterck",
 							 extra_pcks[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 4c9a4147dfe5..7867eaf0447f 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -38,6 +38,7 @@ struct clk_sam9x5_peripheral {
 	u32 div;
 	const struct clk_pcr_layout *layout;
 	bool auto_div;
+	int chg_pid;
 };
 
 #define to_clk_sam9x5_peripheral(hw) \
@@ -238,6 +239,87 @@ clk_sam9x5_peripheral_recalc_rate(struct clk_hw *hw,
 	return parent_rate >> periph->div;
 }
 
+static void clk_sam9x5_peripheral_best_diff(struct clk_rate_request *req,
+					    struct clk_hw *parent,
+					    unsigned long parent_rate,
+					    u32 shift, long *best_diff,
+					    long *best_rate)
+{
+	unsigned long tmp_rate = parent_rate >> shift;
+	unsigned long tmp_diff = abs(req->rate - tmp_rate);
+
+	if (*best_diff < 0 || *best_diff >= tmp_diff) {
+		*best_rate = tmp_rate;
+		*best_diff = tmp_diff;
+		req->best_parent_rate = parent_rate;
+		req->best_parent_hw = parent;
+	}
+}
+
+static int clk_sam9x5_peripheral_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	struct clk_rate_request req_parent = *req;
+	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long tmp_rate;
+	long best_rate = LONG_MIN;
+	long best_diff = LONG_MIN;
+	u32 shift;
+
+	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max)
+		return parent_rate;
+
+	/* Fist step: check the available dividers. */
+	for (shift = 0; shift <= PERIPHERAL_MAX_SHIFT; shift++) {
+		tmp_rate = parent_rate >> shift;
+
+		if (periph->range.max && tmp_rate > periph->range.max)
+			continue;
+
+		clk_sam9x5_peripheral_best_diff(req, parent, parent_rate,
+						shift, &best_diff, &best_rate);
+
+		if (!best_diff || best_rate <= req->rate)
+			break;
+	}
+
+	if (periph->chg_pid < 0)
+		goto end;
+
+	/* Step two: try to request rate from parent. */
+	parent = clk_hw_get_parent_by_index(hw, periph->chg_pid);
+	if (!parent)
+		goto end;
+
+	for (shift = 0; shift <= PERIPHERAL_MAX_SHIFT; shift++) {
+		req_parent.rate = req->rate << shift;
+
+		if (__clk_determine_rate(parent, &req_parent))
+			continue;
+
+		clk_sam9x5_peripheral_best_diff(req, parent, req_parent.rate,
+						shift, &best_diff, &best_rate);
+
+		if (!best_diff)
+			break;
+	}
+end:
+	if (best_rate < 0 ||
+	    (periph->range.max && best_rate > periph->range.max))
+		return -EINVAL;
+
+	pr_debug("PCK: %s, best_rate = %ld, parent clk: %s @ %ld\n",
+		 __func__, best_rate,
+		 __clk_get_name((req->best_parent_hw)->clk),
+		 req->best_parent_rate);
+
+	req->rate = best_rate;
+
+	return 0;
+}
+
 static long clk_sam9x5_peripheral_round_rate(struct clk_hw *hw,
 					     unsigned long rate,
 					     unsigned long *parent_rate)
@@ -320,11 +402,21 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 	.set_rate = clk_sam9x5_peripheral_set_rate,
 };
 
+static const struct clk_ops sam9x5_peripheral_chg_ops = {
+	.enable = clk_sam9x5_peripheral_enable,
+	.disable = clk_sam9x5_peripheral_disable,
+	.is_enabled = clk_sam9x5_peripheral_is_enabled,
+	.recalc_rate = clk_sam9x5_peripheral_recalc_rate,
+	.determine_rate = clk_sam9x5_peripheral_determine_rate,
+	.set_rate = clk_sam9x5_peripheral_set_rate,
+};
+
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
-				    u32 id, const struct clk_range *range)
+				    u32 id, const struct clk_range *range,
+				    int chg_pid)
 {
 	struct clk_sam9x5_peripheral *periph;
 	struct clk_init_data init;
@@ -339,10 +431,16 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &sam9x5_peripheral_ops;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
-	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	if (chg_pid < 0) {
+		init.flags = 0;
+		init.ops = &sam9x5_peripheral_ops;
+	} else {
+		init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+			     CLK_SET_RATE_PARENT;
+		init.ops = &sam9x5_peripheral_chg_ops;
+	}
 
 	periph->id = id;
 	periph->hw.init = &init;
@@ -353,6 +451,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		periph->auto_div = true;
 	periph->layout = layout;
 	periph->range = *range;
+	periph->chg_pid = chg_pid;
 
 	hw = &periph->hw;
 	ret = clk_hw_register(NULL, &periph->hw);
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index cc95d42f4d53..1b90c4f7b1d1 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -463,7 +463,8 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 								 &dt_pcr_layout,
 								 name,
 								 parent_name,
-								 id, &range);
+								 id, &range,
+								 INT_MIN);
 		}
 
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 29d150feaa46..34c9506e6275 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -168,7 +168,8 @@ struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
-				    u32 id, const struct clk_range *range);
+				    u32 id, const struct clk_range *range,
+				    int chg_pid);
 
 struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 3ad16d74577e..25b57c6105cd 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -277,7 +277,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 							 sam9x60_periphck[i].n,
 							 "masterck",
 							 sam9x60_periphck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 6a685d00f16d..c7765b664940 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -291,7 +291,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 							 sama5d2_periphck[i].n,
 							 "masterck",
 							 sama5d2_periphck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -304,7 +304,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 							 sama5d2_periph32ck[i].n,
 							 "h32mxck",
 							 sama5d2_periph32ck[i].id,
-							 &sama5d2_periph32ck[i].r);
+							 &sama5d2_periph32ck[i].r,
+							 INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 5e4e44dd4c37..1597124609e5 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -223,7 +223,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 							 sama5d3_periphck[i].n,
 							 "masterck",
 							 sama5d3_periphck[i].id,
-							 &sama5d3_periphck[i].r);
+							 &sama5d3_periphck[i].r,
+							 INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 662ff5fa6e98..fa121897d95d 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -246,7 +246,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 							 sama5d4_periphck[i].n,
 							 "masterck",
 							 sama5d4_periphck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -259,7 +259,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 							 sama5d4_periph32ck[i].n,
 							 "h32mxck",
 							 sama5d4_periph32ck[i].id,
-							 &range);
+							 &range, INT_MIN);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.7.4

