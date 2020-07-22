Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE727C43457
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB85320709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DWo1Pdk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgGVHjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:35912 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgGVHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403562; x=1626939562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UFiLg3HndQzEMmbFV+IqhvK1C6Up8/+N0yxf7QIo9nY=;
  b=DWo1Pdk/DSvbPQxKxiK5Gb5GfV+wb9k3NngA7XWz9eiabdfuiTqPk0jA
   6nh3YW5e2zv1pyh7arem6NaO0low9zIpSoL0T0wIseyhmgz2rjSncgLkH
   MGib2vxBeP8lpODPPnP8Qz+kzWcPWWpL0tSGNOhhRggZN8NhqLX4OmDUg
   cdduVbZw+hF2Ya0EOQ6XDCfhi3e9k7yGf7VGPQWtgDnSi41eejdaKDIKl
   zKk50lEsT125DR3WSeOdVSPkFaDz0dDrUQW/HtWYShJ4lfGevKXm5PkfW
   s2U9y9vynGfVRVMTv2rk8BshrKfEpA+UHeQRCYSQw8Kpg9eVfesPyUJrK
   Q==;
IronPort-SDR: CUPdrQ2ymy8QDH5xg0rodkZZjge4wHSPeWQhuJ2fHGMwcP52zJ1B48aAbieTnlkfZUD8x42kCv
 ceCpkt1DLbjw1rWpHS8PQxU9x1mYnfkV24CykkLZZoZE8PgEvElCvTnY1Tr7XdXzTqwxbmgaXm
 YpRCMgbf6E0iQ68a+KUVGsqhttql9+6GezpSWpNMybO4mSfuAfdOqSiGYgLYD1RaI8hg5Yd/MZ
 JY8KlAZZRWWbGVNZ6LTeuBx1G+U2uOBk/tC/Sxc2P8d97gbU+o+vAsg5L05i0RnbOgGidbVYEq
 js4=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="84153210"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:38 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 13/18] clk: at91: clk-peripheral: add support for changeable parent rate
Date:   Wed, 22 Jul 2020 10:38:21 +0300
Message-ID: <1595403506-8209-14-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
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

