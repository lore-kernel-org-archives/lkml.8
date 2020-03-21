Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA4C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6120775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="b3k5KTMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgCUVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:18:07 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34121 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCUVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:18:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48lD586W0tzqB;
        Sat, 21 Mar 2020 22:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584825484; bh=sRoF0NTwXhM6qBx6PuKDME7an8NdRlb3aLRGEWm6gbI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=b3k5KTMr/dIZl82IKfC6wl4NTkz5MkliCylvznacPGK9wzNJ26WmKFE+L2LJTsWvv
         2/tXRCsmuvhEC6qLZYRBBVD/Tbm04JMkvmaWZlT4g38U5ZEtrmz1jTyWiCzRkPYble
         U7zvFo30MaoIYgVl29ZllySZ/Zl93GjI8LK5Tw8RW9LtQanUeRA+D+sx2cqgDkcc9v
         QP7QieAbZFRa+plH4xxaM7DnljRY+ykkZ/j1ARGX9m6VPfw4awj6cTi6EBPrY7Pkly
         POo4PpZLF+YCfOcqlg+VdrP44BWIEU9c8EEaN0toj63q8+Nr6bZVVcnwGj7V4p9le+
         6mnD0CYKjVlfw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 21 Mar 2020 22:18:04 +0100
Message-Id: <135082dfafaa8bc106286dfbe7dd94b708c33f4b.1584825247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1584825247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1584825247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 3/3] clk: at91: sama5d2: allow setting all PMC clock
 parents via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to have clocks accessible via phandle to select them
as peripheral clock parent using assigned-clock-parents in DT.
PLLACK and AUDIOPLLCK were missing for sama5d2. Add them.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: rebase to clk/clk-at91 branch
v3: no changes
---
 drivers/clk/at91/sama5d2.c       | 6 +++++-
 include/dt-bindings/clock/at91.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index c3f4aa6a2d29..e57362e98129 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -21,6 +21,8 @@
 #define PMC_MCK2		4
 #define PMC_I2S0_MUX		5
 #define PMC_I2S1_MUX		6
+#define PMC_PLLACK		7
+#define PMC_AUDIOPLLCK		8
 
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-- 
2.20.1

