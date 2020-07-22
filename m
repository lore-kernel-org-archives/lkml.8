Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E423C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D8D20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AuA8bZzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgGVHjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:08 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23413 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgGVHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403545; x=1626939545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Mx5qNI6SKDaX4fYwafSWV0rZJ0buUqtkfN1L0ooylh4=;
  b=AuA8bZzrazf4INbBSn1AZ151V/atkRyz+CxU2V4RqYljssp5qfkJPhYI
   R2Hhb/XRKDmoFr44KrcthWJXKH19Ha29/0Sd41OzgLul9dEE8LLdfkugW
   VaxFt/uOXHA7PGDCWq9So1xDeD9BQ21gHXoiCTdtC6VD7S9vZ/igTseeI
   oxc69XAMN2XWmzyHK2/vvdPRJoFtLLqY/fgB5p7MpaHAuI6jFShx0JnEj
   6q8sUspZPvR1+JlR0MTcWS5K4ZX2I5Jlhmlr/vF0rdgNM0pGWsMPnHqyr
   rJdascjEaVON1gOe0glXxMykXIePvBahZBMu5JMkETY6o56RK6NEribqg
   Q==;
IronPort-SDR: 3JVOmTzegiMdw7xKa1Oy2vF4zOhLsZwXATLgyg9msS8rOLs0WfTGT+W+6Ma9nPcDyVoZ7EwjRA
 WkERcVEwkuP7qfPeTmUw9xAMpJbplt63ITHNz55fxxv8pe33gll4zgoxkI0aZ1u6PKVbn81qTl
 OxItQfq4G58Q7rHoLpyQ8VvbvYrV0Fifmyv2jCrPXORkN8FchCZA0K6YKvhFIQGvKksJXeVaTl
 8XfuQYkLOP0syVaNOy6VNq36OAitp8wUu4KdFzl4eEo4Ni3IYMpQlsT1az+PJ+PUZgvknuGVUh
 iDY=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="82772070"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:39:03 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 09/18] clk: at91: replace conditional operator with double logical not
Date:   Wed, 22 Jul 2020 10:38:17 +0300
Message-ID: <1595403506-8209-10-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace conditional operator with double logical not as code
may be simpler to read.

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

