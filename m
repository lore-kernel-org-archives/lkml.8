Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D53C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6126520717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XDNCX6kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgGVHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:29 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35061 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgGVHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403563; x=1626939563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xeJGYYWfqxuElT8pORMUc+duPmsYD+ajjbf/se+Q6Lc=;
  b=XDNCX6kDibk3l11PQsGXU4qKvSwvJ/6zHnMKwiNEizaGBWhaszABzDHO
   ij7KiAW5YQcHfLWtFeKojE/FyIX1A+ZYO+IKmgrq5EPDRbykJOtlJ1NbF
   4uAtzQ986g5UoBQfRtBpg3OgV6NaCSRuwkvlosehKroq0nEA+ojaqJ9cO
   79mvx7wJlRsoS9awUI0ZHoQz2BLFzxsi4AIusiaCZy4oxFbxsfT5846pR
   R6/C0dO3wsZ+k+1pgQOzd8On4Xim8KxK7344fshLTN1cfWsHmnkfaVZgm
   3gTcdE3JPjPFoWnmn9JhSpZHQri1tmR5Lkn3j9ULezECyd9MauceDfUoW
   w==;
IronPort-SDR: Ua5bpM4H8wZ2uGNS/M1bX8ReqRqbN3CGWAbM4A0TOxPTp0k9nZGsLpHc3Wf3Znpr5D3TetIBnj
 pcprs7YOHz6ESR2tReqL8C54K2NCObSRF4eo6als2CY8tHlA3cXuHIX69vpdg/g0s5bw8bwF6X
 mP8BGdoJ43dYKHAOlrFx2+Ifcy8SZMyIh5pxe4f6mCp8F8att+/g7cbKZTBy5IqNcti5IiQkwi
 5CWhPM3EFTVT0uzTBUbTkFOcrHGNdHK69A9cMlgnxHUMkB+RcU77ZtNPvAyni4P6C1KYPJf4ke
 BLs=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="20120859"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:44 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 14/18] clk: at91: clk-programmable: add mux_table option
Date:   Wed, 22 Jul 2020 10:38:22 +0300
Message-ID: <1595403506-8209-15-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mux table option. This is necessary for IP versions that has
gaps in the range of available clock sources (e.g. SAMA7G5).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c       |  3 ++-
 drivers/clk/at91/at91sam9260.c      |  3 ++-
 drivers/clk/at91/at91sam9g45.c      |  3 ++-
 drivers/clk/at91/at91sam9n12.c      |  3 ++-
 drivers/clk/at91/at91sam9rl.c       |  3 ++-
 drivers/clk/at91/at91sam9x5.c       |  3 ++-
 drivers/clk/at91/clk-programmable.c | 11 ++++++++++-
 drivers/clk/at91/dt-compat.c        | 11 ++++++-----
 drivers/clk/at91/pmc.h              |  3 ++-
 drivers/clk/at91/sam9x60.c          |  3 ++-
 drivers/clk/at91/sama5d2.c          |  3 ++-
 drivers/clk/at91/sama5d3.c          |  3 ++-
 drivers/clk/at91/sama5d4.c          |  3 ++-
 13 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 38bdb4981315..2c3d8e6ca63c 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -160,7 +160,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 4, i,
-						    &at91rm9200_programmable_layout);
+						    &at91rm9200_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 6d0723aa8b13..bb81ff731ad8 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -436,7 +436,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 4, i,
-						    &at91rm9200_programmable_layout);
+						    &at91rm9200_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 9873b583c260..6b538f90fa45 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -181,7 +181,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9g45_programmable_layout);
+						    &at91sam9g45_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index f4c36e6e4deb..bd07542abd4b 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -199,7 +199,8 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &at91sam9x5_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 0d1cc44b056f..a343eb69bb35 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -137,7 +137,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91rm9200_programmable_layout);
+						    &at91rm9200_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 52a9d2f7ec83..22b9aad9efb8 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -226,7 +226,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &at91sam9x5_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 8ee66fbee3d9..fcf8f6a1c2c6 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -21,6 +21,7 @@
 struct clk_programmable {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	u32 *mux_table;
 	u8 id;
 	const struct clk_programmable_layout *layout;
 };
@@ -108,6 +109,9 @@ static int clk_programmable_set_parent(struct clk_hw *hw, u8 index)
 	if (layout->have_slck_mck)
 		mask |= AT91_PMC_CSSMCK_MCK;
 
+	if (prog->mux_table)
+		pckr = clk_mux_index_to_val(prog->mux_table, 0, index);
+
 	if (index > layout->css_mask) {
 		if (index > PROG_MAX_RM9200_CSS && !layout->have_slck_mck)
 			return -EINVAL;
@@ -134,6 +138,9 @@ static u8 clk_programmable_get_parent(struct clk_hw *hw)
 	if (layout->have_slck_mck && (pckr & AT91_PMC_CSSMCK_MCK) && !ret)
 		ret = PROG_MAX_RM9200_CSS + 1;
 
+	if (prog->mux_table)
+		ret = clk_mux_val_to_index(&prog->hw, prog->mux_table, 0, ret);
+
 	return ret;
 }
 
@@ -182,7 +189,8 @@ struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap,
 			       const char *name, const char **parent_names,
 			       u8 num_parents, u8 id,
-			       const struct clk_programmable_layout *layout)
+			       const struct clk_programmable_layout *layout,
+			       u32 *mux_table)
 {
 	struct clk_programmable *prog;
 	struct clk_hw *hw;
@@ -206,6 +214,7 @@ at91_clk_register_programmable(struct regmap *regmap,
 	prog->layout = layout;
 	prog->hw.init = &init;
 	prog->regmap = regmap;
+	prog->mux_table = mux_table;
 
 	hw = &prog->hw;
 	ret = clk_hw_register(NULL, &prog->hw);
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 1b90c4f7b1d1..a50084de97d4 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -677,7 +677,8 @@ CLK_OF_DECLARE(at91sam9x5_clk_plldiv, "atmel,at91sam9x5-clk-plldiv",
 
 static void __init
 of_at91_clk_prog_setup(struct device_node *np,
-		       const struct clk_programmable_layout *layout)
+		       const struct clk_programmable_layout *layout,
+		       u32 *mux_table)
 {
 	int num;
 	u32 id;
@@ -711,7 +712,7 @@ of_at91_clk_prog_setup(struct device_node *np,
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, num_parents,
-						    id, layout);
+						    id, layout, mux_table);
 		if (IS_ERR(hw))
 			continue;
 
@@ -721,21 +722,21 @@ of_at91_clk_prog_setup(struct device_node *np,
 
 static void __init of_at91rm9200_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, &at91rm9200_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91rm9200_programmable_layout, NULL);
 }
 CLK_OF_DECLARE(at91rm9200_clk_prog, "atmel,at91rm9200-clk-programmable",
 	       of_at91rm9200_clk_prog_setup);
 
 static void __init of_at91sam9g45_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, &at91sam9g45_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91sam9g45_programmable_layout, NULL);
 }
 CLK_OF_DECLARE(at91sam9g45_clk_prog, "atmel,at91sam9g45-clk-programmable",
 	       of_at91sam9g45_clk_prog_setup);
 
 static void __init of_at91sam9x5_clk_prog_setup(struct device_node *np)
 {
-	of_at91_clk_prog_setup(np, &at91sam9x5_programmable_layout);
+	of_at91_clk_prog_setup(np, &at91sam9x5_programmable_layout, NULL);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_prog, "atmel,at91sam9x5-clk-programmable",
 	       of_at91sam9x5_clk_prog_setup);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 34c9506e6275..8d3e22f566cf 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -188,7 +188,8 @@ sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
 			       const char **parent_names, u8 num_parents, u8 id,
-			       const struct clk_programmable_layout *layout);
+			       const struct clk_programmable_layout *layout,
+			       u32 *mux_table);
 
 struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 25b57c6105cd..f2306615c7e7 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -254,7 +254,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 6, i,
-						    &sam9x60_programmable_layout);
+						    &sam9x60_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c7765b664940..8b220762941a 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -268,7 +268,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 6, i,
-						    &sama5d2_programmable_layout);
+						    &sama5d2_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 1597124609e5..c500924dd414 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -200,7 +200,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &at91sam9x5_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index fa121897d95d..92d8d4141b43 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -223,7 +223,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &at91sam9x5_programmable_layout,
+						    NULL);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.7.4

