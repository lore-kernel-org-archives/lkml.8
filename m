Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F93C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCF72070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H0dVFVn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgGOLZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:25:05 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9354 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgGOLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812303; x=1626348303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RsPoKJ4J3O4xPV4BROlwwQyvlKQvA1BW5zhI6GJXNbI=;
  b=H0dVFVn7hMIHuBkNAWxOY9P0A2tOvC4OpEYQKvljuRFHYzy4uq9CWPh5
   EC8X8s1tfGjmykJ4bZxEoJ6lYFE1k257SLiERavPmqsYwrNbSgG/Yw48+
   eUEbxO6n6kLIhoJkOGOIfPqKDhy07I888uH+Ur9Apnk3SaeJhJD4KS/YM
   8ziO88QuAJhqABcbW8HYuINELoxdY68vch7K1C6+88NuNKk4bcaeh+8aC
   3YjVEoMBLqJiEq5eBZf//fjFqvVkhoQ9zc9MpweW2JCgLbS7u/Iypx9+2
   pccwJrHCsiylstZU9ZiTzGTTvzX82aSaUVJe+dbGWCQzJ0e4h5kjLcedD
   g==;
IronPort-SDR: Ax53Xeo1wb4lypR1a1vJiOWikC00R9LmsXKlzPc/MWYnjtssmZPDxpLqHPwn33UoxvTNeAmTJ7
 yGBYCGK+MGUuJ+cdRqFhqOBmW7ElPjze9+VXXoXAWSAhz12PioenQdlKccJcb2iDFkQcymlfAi
 LfaO4+XEFv1yVDSBvY5z0dmww5Z9tfMrZg28t300vsq7KhHGH7hN78H7x9mu/Vjfu+M8XRgeK7
 Itl2qf6KYHzzAWw8O9kXU0FR55cbHMT/sM1DeBAl5eNSXON3M8Yh5+PgWx27CH6dKslPJYsgY0
 JvU=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="79986126"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:25:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:29 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:24:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 07/19] clk: at91: sam9x60-pll: use frac when setting frequency
Date:   Wed, 15 Jul 2020 14:24:15 +0300
Message-ID: <1594812267-6697-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
the fractional part of PLL wasn't set on registers but it was
calculated and taken into account for determining div and mul
(see sam9x60_pll_get_best_div_mul()).

Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 00f2afd6e9b6..13e15bd48770 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -16,6 +16,7 @@
 
 #define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
 #define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(31, 24)
+#define	PMC_PLL_CTRL1_FRACR_MSK	GENMASK(21, 0)
 
 #define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
 #define UPLL_DIV		2
@@ -55,7 +56,7 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 	unsigned long flags;
 	u8 div;
 	u16 mul;
-	u32 val;
+	u32 val, frac;
 
 	spin_lock_irqsave(pll->lock, flags);
 	regmap_write(regmap, AT91_PMC_PLL_UPDT, pll->id);
@@ -65,9 +66,10 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 
 	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
 	mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
+	frac = FIELD_GET(PMC_PLL_CTRL1_FRACR_MSK, val);
 
 	if (sam9x60_pll_ready(regmap, pll->id) &&
-	    (div == pll->div && mul == pll->mul)) {
+	    (div == pll->div && mul == pll->mul && frac == pll->frac)) {
 		spin_unlock_irqrestore(pll->lock, flags);
 		return 0;
 	}
@@ -80,7 +82,8 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 	regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
 	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
-		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul));
+		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul) |
+		     FIELD_PREP(PMC_PLL_CTRL1_FRACR_MSK, pll->frac));
 
 	if (pll->characteristics->upll) {
 		/* Enable the UTMI internal bandgap */
-- 
2.7.4

