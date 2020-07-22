Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2EC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3C20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aLmebJr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgGVHjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:16 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:35885 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbgGVHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403552; x=1626939552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eF0q0JFTXO3fXXnMUO4I2tCnNMv7GZu0sKvedYlGPkI=;
  b=aLmebJr85Af0HCEke8K3REUc293f49BnvW1Njoe3jvaI9DKGKLmWJ0Ur
   fVhjbHhNkjC4A+Cf5/AclSnvHMp4wOYshweTTZ8ks3M1URIxKg4pt1K2j
   wLILl/Pi4e9+SGw3W1vxLQK9lp4t0N1THUxRYf2mwE32REh39LAZhamQr
   J5Vqotjq3QeiiX7P2e7Zb80DDNV0Yvog3qKoq1nMD6Llaqn1XaGMeC8Rv
   h4u1fqxPHE66FLnL2I7yKlSO9hbu2o1D25DDi+E+LsFtTV+92MLxn+lQ4
   5OEYRlh+S89u8hYdmlVv/KevMoV/VEiS0j/eQld/jY9NFGpRnjlNHbWUB
   g==;
IronPort-SDR: GCe3zXZ7zBKoAA8H7Oc4BQbTT18u7I5pYHkEtogUXGyJHTKoaGlwWmSWXhYU0FqcBppUJaa53V
 m2Fvgq53wQHezFWfyscSCqXrJ2++IdTxoNfWwskjfttrBSLuNRt8Cq3NKhMI9/E0Wgas1gMZxQ
 A+RmXj/FQUbL2hIspP6JgZ8XH65v/qhxpC01VvmEhUURtJEkpm8CCKKdG0CAw7nDbrRMUMiZ2/
 S3Rg3XfnopeIZb8GMmjvIBUdP+v/uVgFafyV/P2GhqK4Y+3dLumevhAA85VyTKvEDfC6WnR7na
 Bv4=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="84153176"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:32 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 11/18] clk: at91: clk-generated: add mux_table option
Date:   Wed, 22 Jul 2020 10:38:19 +0300
Message-ID: <1595403506-8209-12-git-send-email-claudiu.beznea@microchip.com>
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
 drivers/clk/at91/clk-generated.c | 13 ++++++++++---
 drivers/clk/at91/dt-compat.c     |  5 +++--
 drivers/clk/at91/pmc.h           |  2 +-
 drivers/clk/at91/sam9x60.c       |  2 +-
 drivers/clk/at91/sama5d2.c       |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index f9ca04c97128..b4fc8d71daf2 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -23,6 +23,7 @@ struct clk_generated {
 	struct regmap *regmap;
 	struct clk_range range;
 	spinlock_t *lock;
+	u32 *mux_table;
 	u32 id;
 	u32 gckdiv;
 	const struct clk_pcr_layout *layout;
@@ -201,7 +202,11 @@ static int clk_generated_set_parent(struct clk_hw *hw, u8 index)
 	if (index >= clk_hw_get_num_parents(hw))
 		return -EINVAL;
 
-	gck->parent_id = index;
+	if (gck->mux_table)
+		gck->parent_id = clk_mux_index_to_val(gck->mux_table, 0, index);
+	else
+		gck->parent_id = index;
+
 	return 0;
 }
 
@@ -273,8 +278,9 @@ struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id,
-			    const struct clk_range *range, int chg_pid)
+			    u32 *mux_table, u8 num_parents, u8 id,
+			    const struct clk_range *range,
+			    int chg_pid)
 {
 	struct clk_generated *gck;
 	struct clk_init_data init;
@@ -300,6 +306,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	gck->range = *range;
 	gck->chg_pid = chg_pid;
 	gck->layout = layout;
+	gck->mux_table = mux_table;
 
 	clk_generated_startup(gck);
 	hw = &gck->hw;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 8a652c44c25a..cc95d42f4d53 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -158,8 +158,9 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &dt_pcr_layout, name,
-						 parent_names, num_parents,
-						 id, &range, chg_pid);
+						 parent_names, NULL,
+						 num_parents, id, &range,
+						 chg_pid);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 949b1a7b91e5..2bfe1405f9f8 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -122,7 +122,7 @@ struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id,
+			    u32 *mux_table, u8 num_parents, u8 id,
 			    const struct clk_range *range, int chg_pid);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index c4e34c0909e3..3ad16d74577e 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -288,7 +288,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sam9x60_pcr_layout,
 						 sam9x60_gck[i].n,
-						 parent_names, 6,
+						 parent_names, NULL, 6,
 						 sam9x60_gck[i].id,
 						 &sam9x60_gck[i].r, INT_MIN);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 42637d9531d3..6a685d00f16d 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -321,7 +321,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama5d2_pcr_layout,
 						 sama5d2_gck[i].n,
-						 parent_names, 6,
+						 parent_names, NULL, 6,
 						 sama5d2_gck[i].id,
 						 &sama5d2_gck[i].r,
 						 sama5d2_gck[i].chg_pid);
-- 
2.7.4

