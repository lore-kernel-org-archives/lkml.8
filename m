Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A34C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03D3206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ox3V68X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgEDT6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:58:51 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:19104 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgEDT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:58:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GDFK1YW0zLn;
        Mon,  4 May 2020 21:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588622325; bh=q0nuuPw8GBajf6QHE752Jg1Lm8HpYJyCO7HmMMBN/yM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ox3V68X3HsLVRf9xE5CpYyhIHq/66R7WX3ii19aacH4veN9dpvpS+FHUdpGqTRid8
         OrK+0jKt+zd7u0EQ6VLoXUu/r99PiQKFPAqPucAfXqAOrYBBYyV4phrROsRZ6BI7EQ
         I+35UBw/HG/ggI9k1IBTWhK2ByFVr4dsy/T6wRltOS14TV6eBSbiYKXetXf5a7P0tt
         z3M/Y2mGTOe8RbrmDvNSYqQst2lTrb+BWxVVUwfx4DJEEVofMHFyjgnauscTzeunWg
         yUwnU7LZVtt9mchwbHBq7g4UgEPvArj5sj8lXt9kRR7SSZc9L5Nm2b6WgahansW5+0
         irijgU//jMzcQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:58:44 +0200
Message-Id: <74a5cd94fb7fb0058d905d83f192a4cc85fa6b5b.1588622158.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588622158.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588622158.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 3/3] clk: at91: allow setting all PMC clock parents via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to have clocks accessible via phandle to select them
as peripheral clock parent using assigned-clock-parents in DT.
Add support for PLLACK/PLLBCK/AUDIOPLLCK clocks where available.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: rebase to clk/clk-at91 branch
v3: no changes
v4: extend to whole family
v5: fix copy-and-paste bugs for SAMA5D3/4
---
 drivers/clk/at91/at91rm9200.c    | 6 +++++-
 drivers/clk/at91/at91sam9260.c   | 6 +++++-
 drivers/clk/at91/at91sam9g45.c   | 4 +++-
 drivers/clk/at91/at91sam9n12.c   | 6 +++++-
 drivers/clk/at91/at91sam9rl.c    | 4 +++-
 drivers/clk/at91/at91sam9x5.c    | 4 +++-
 drivers/clk/at91/sam9x60.c       | 4 +++-
 drivers/clk/at91/sama5d2.c       | 6 +++++-
 drivers/clk/at91/sama5d3.c       | 4 +++-
 drivers/clk/at91/sama5d4.c       | 4 +++-
 include/dt-bindings/clock/at91.h | 3 +++
 11 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 8da88e9a95d8..38bdb4981315 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -98,7 +98,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	at91rm9200_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91rm9200_pmc = pmc_data_allocate(PMC_PLLBCK + 1,
 					    nck(at91rm9200_systemck),
 					    nck(at91rm9200_periphck), 0, 4);
 	if (!at91rm9200_pmc)
@@ -123,12 +123,16 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91rm9200_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91rm9200_pmc->chws[PMC_PLLBCK] = hw;
+
 	parent_names[0] = slowxtal_name;
 	parent_names[1] = "mainck";
 	parent_names[2] = "pllack";
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 7e5ff252fffc..6d0723aa8b13 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -352,7 +352,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	if (IS_ERR(regmap))
 		return;
 
-	at91sam9260_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91sam9260_pmc = pmc_data_allocate(PMC_PLLBCK + 1,
 					    ndck(data->sck, data->num_sck),
 					    ndck(data->pck, data->num_pck),
 					    0, data->num_progck);
@@ -399,12 +399,16 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9260_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
 				   data->pllb_layout,
 				   data->pllb_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9260_pmc->chws[PMC_PLLBCK] = hw;
+
 	parent_names[0] = slck_name;
 	parent_names[1] = "mainck";
 	parent_names[2] = "pllack";
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 5d18eb04c218..9873b583c260 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -115,7 +115,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	at91sam9g45_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91sam9g45_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					    nck(at91sam9g45_systemck),
 					    nck(at91sam9g45_periphck), 0, 2);
 	if (!at91sam9g45_pmc)
@@ -143,6 +143,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9g45_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 3a2564c2f724..630dc5d87171 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -128,7 +128,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	at91sam9n12_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91sam9n12_pmc = pmc_data_allocate(PMC_PLLBCK + 1,
 					   nck(at91sam9n12_systemck), 31, 0, 2);
 	if (!at91sam9n12_pmc)
 		return;
@@ -162,11 +162,15 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9n12_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
 				   &at91rm9200_pll_layout, &pllb_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9n12_pmc->chws[PMC_PLLBCK] = hw;
+
 	parent_names[0] = slck_name;
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index bcf07f6a0e0e..0d1cc44b056f 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -87,7 +87,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	at91sam9rl_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91sam9rl_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					   nck(at91sam9rl_systemck),
 					   nck(at91sam9rl_periphck), 0, 2);
 	if (!at91sam9rl_pmc)
@@ -105,6 +105,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9rl_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index f13756b407e2..0ce3da080287 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -150,7 +150,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (IS_ERR(regmap))
 		return;
 
-	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	at91sam9x5_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					   nck(at91sam9x5_systemck), 31, 0, 2);
 	if (!at91sam9x5_pmc)
 		return;
@@ -184,6 +184,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (IS_ERR(hw))
 		goto err_free;
 
+	at91sam9x5_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index db14e0427c7f..3e20aa68259f 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -182,7 +182,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sam9x60_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					nck(sam9x60_systemck),
 					nck(sam9x60_periphck),
 					nck(sam9x60_gck), 8);
@@ -214,6 +214,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sam9x60_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = sam9x60_clk_register_pll(regmap, &pmc_pll_lock, "upllck",
 				      "main_osc", 1, &upll_characteristics);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index ae5e83cadb3d..b3fa2291ccd8 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -166,7 +166,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama5d2_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
+	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
 					nck(sama5d2_systemck),
 					nck(sama5d2_periph32ck),
 					nck(sama5d2_gck), 3);
@@ -202,6 +202,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d2_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
 					      "mainck");
 	if (IS_ERR(hw))
@@ -217,6 +219,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d2_pmc->chws[PMC_AUDIOPLLCK] = hw;
+
 	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 507eef6797f1..5e4e44dd4c37 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -125,7 +125,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama5d3_pmc = pmc_data_allocate(PMC_MAIN + 1,
+	sama5d3_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					nck(sama5d3_systemck),
 					nck(sama5d3_periphck), 0, 3);
 	if (!sama5d3_pmc)
@@ -158,6 +158,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d3_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 80692902b4e4..662ff5fa6e98 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -140,7 +140,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 + 1,
+	sama5d4_pmc = pmc_data_allocate(PMC_PLLACK + 1,
 					nck(sama5d4_systemck),
 					nck(sama5d4_periph32ck), 0, 3);
 	if (!sama5d4_pmc)
@@ -173,6 +173,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d4_pmc->chws[PMC_PLLACK] = hw;
+
 	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index c3f4aa6a2d29..adcf608b41fa 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -21,6 +21,9 @@
 #define PMC_MCK2		4
 #define PMC_I2S0_MUX		5
 #define PMC_I2S1_MUX		6
+#define PMC_PLLACK		7
+#define PMC_PLLBCK		8
+#define PMC_AUDIOPLLCK		8		/* SAMA5D2-only, no PLLB there */
 
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-- 
2.20.1

