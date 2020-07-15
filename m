Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A04C43445
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81592063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xmlvZB5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgGOLZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:17 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62473 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgGOLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812314; x=1626348314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8dIByDF3Y164tHomY/zGzq3PXxCWBj6ZbgXYwU93O08=;
  b=xmlvZB5NWwi3g43pGwG/sPPldIXOz1+CHiPot1RzLJvcdSYM+0cctffp
   Ygc0hDbYMxAtQZm6DJM1C4rhaG+05hlr3uVlk4gcGjVnXIPy8nJyXDRs2
   kMwzOh42ze4QIy+fKaZ+LaOxezYJLLXr9EfNfd5KGIO5GWLpxzkdEV4kB
   +cgQF+V9XULINKfXf/yXm5rNaj6Zs632qjAnwt5oLFmzhCnafCJeEWqRe
   hWOMS6tpcq1Mhr1sU5UPuAtJBm2r64tiO0M/mJuzHFKc3IljFiZ3/+Pne
   YpeM2EYLuegXZd3XE56Hm/TOC7W9/E3V/axYz9vQ7npPVtxH0IOLcmEO7
   Q==;
IronPort-SDR: OdGwsq1MARl/h4hAjIkEB93UlsO9xMmwXDVnkYw0v70olMJnNBkHbMXhk5Rk705xMDoKjfhFGd
 Wo8UKsZzzAtLAHBZTZZvs61nTBTApeogrDf9LlXHDwsEc40mJ7rVNVQj/mzljI6XaZ9+jt3ClT
 /w241l+AYoNVpBJX2Q8c+FhvZx9DX5jNs/JNX3KSBhp8URVP96gsFUKBc4OBqneLK7XqPnQcwI
 ZvPpjW1u1x002MA4bVhJbTkzu+xQ9FSdR2zw2SQ4YSfphAUz8p3MnvoPZnNOg+JLYkSErpCNhS
 k0k=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962868"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:42 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 10/19] clk: at91: replace conditional operator with double logical not
Date:   Wed, 15 Jul 2020 14:24:18 +0300
Message-ID: <1594812267-6697-11-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace conditional operator with double logical not.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-generated.c  | 2 +-
 drivers/clk/at91/clk-main.c       | 6 +++---
 drivers/clk/at91/clk-master.c     | 2 +-
 drivers/clk/at91/clk-peripheral.c | 2 +-
 drivers/clk/at91/clk-system.c     | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index f8e557e0e1b8..2448bdc63425 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -83,7 +83,7 @@ static int clk_generated_is_enabled(struct clk_hw *hw)
 	regmap_read(gck->regmap, gck->layout->offset, &status);
 	spin_unlock_irqrestore(gck->lock, flags);
 
-	return status & AT91_PMC_PCR_GCKEN ? 1 : 0;
+	return !!(status & AT91_PMC_PCR_GCKEN);
 }
 
 static unsigned long
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 37c22667e831..5c83e899084f 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -175,7 +175,7 @@ static bool clk_main_rc_osc_ready(struct regmap *regmap)
 
 	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return status & AT91_PMC_MOSCRCS;
+	return !!(status & AT91_PMC_MOSCRCS);
 }
 
 static int clk_main_rc_osc_prepare(struct clk_hw *hw)
@@ -336,7 +336,7 @@ static int clk_rm9200_main_is_prepared(struct clk_hw *hw)
 
 	regmap_read(clkmain->regmap, AT91_CKGR_MCFR, &status);
 
-	return status & AT91_PMC_MAINRDY ? 1 : 0;
+	return !!(status & AT91_PMC_MAINRDY);
 }
 
 static unsigned long clk_rm9200_main_recalc_rate(struct clk_hw *hw,
@@ -398,7 +398,7 @@ static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
 
 	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return status & AT91_PMC_MOSCSELS ? 1 : 0;
+	return !!(status & AT91_PMC_MOSCSELS);
 }
 
 static int clk_sam9x5_main_prepare(struct clk_hw *hw)
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index e7e0ba652de1..88d545b1698c 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -33,7 +33,7 @@ static inline bool clk_master_ready(struct regmap *regmap)
 
 	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return status & AT91_PMC_MCKRDY ? 1 : 0;
+	return !!(status & AT91_PMC_MCKRDY);
 }
 
 static int clk_master_prepare(struct clk_hw *hw)
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c2ab4860a2bf..4c9a4147dfe5 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -208,7 +208,7 @@ static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
 	regmap_read(periph->regmap, periph->layout->offset, &status);
 	spin_unlock_irqrestore(periph->lock, flags);
 
-	return status & AT91_PMC_PCR_EN ? 1 : 0;
+	return !!(status & AT91_PMC_PCR_EN);
 }
 
 static unsigned long
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index c4b3877aa445..f83ec0de86c3 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -34,7 +34,7 @@ static inline bool clk_system_ready(struct regmap *regmap, int id)
 
 	regmap_read(regmap, AT91_PMC_SR, &status);
 
-	return status & (1 << id) ? 1 : 0;
+	return !!(status & (1 << id));
 }
 
 static int clk_system_prepare(struct clk_hw *hw)
@@ -74,7 +74,7 @@ static int clk_system_is_prepared(struct clk_hw *hw)
 
 	regmap_read(sys->regmap, AT91_PMC_SR, &status);
 
-	return status & (1 << sys->id) ? 1 : 0;
+	return !!(status & (1 << sys->id));
 }
 
 static const struct clk_ops system_ops = {
-- 
2.7.4

