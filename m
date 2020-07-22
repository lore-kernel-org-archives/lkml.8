Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8842207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0VDiaHs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgGVHi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:59 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:64012 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgGVHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403535; x=1626939535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=q/KrSNSOFDTAG/E13R2VwHMLla9bwvWFizRzydRetFA=;
  b=0VDiaHs2+vu5lO/z0UeDxVRNu3Aa1NaLGTivJgM3yUJH77V3tFz4o2nl
   QbCOtASwkUqPyEm2ZuP9DmnPdpNcaSi1befhSYtsbHJ6xs1MO5oq7z8Bk
   Iw1g2iaVYHfeBFvyhH+pgZ8vRYqr2kclySiGfKPmwxU7Cp5oIWcXB30yf
   Ge0pT/JVNlc3qDVvoSN8L0HxW808cW78yDtxBW8c4vqoqe8D7I/KEV0rM
   qlEW+etK9KJJKmXK035UVME1YZTiSocKQ7qnsEV0IqeElMNEfapbFFv+H
   Coi+k7ejigbqZwnXtDw8NtY235TjBPU6XPHaiXucfY2o96y1QUgn1zyi+
   g==;
IronPort-SDR: HhieLPTmjOtUgHLM++5w7IusK3ti/xQk/azUSljAj0+bxB0kfryEXv+YblDotOGmo1kb6kgvSY
 +jIwS5LealCmthQGSIArlNEyFM9g4jWLVlAVw/K8KNLIbZeXpoYiw9CruQZty6AyfwhjzDadH2
 yNwGttElTWR3474/vOjPEqg6VdIgNOWpAuZY8YlROBNSydBCCLI3/KNlmDvnxtMMLFTzGqt8Z3
 0SwppTslYZAN9/+dZE+X1zG8zhCheaNiCC9kPBzFqpSGy+9Ue7b+FK4/Mba/6C+uRVM0q8P/pu
 fBg=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="84911227"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:54 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 06/18] clk: at91: sam9x60-pll: use frac when setting frequency
Date:   Wed, 22 Jul 2020 10:38:14 +0300
Message-ID: <1595403506-8209-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
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
 drivers/clk/at91/clk-sam9x60-pll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index a933abebfbaf..1f0bcc6b4fea 100644
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
@@ -155,7 +158,8 @@ static unsigned long sam9x60_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
 
-	return (parent_rate * (pll->mul + 1)) / (pll->div + 1);
+	return DIV_ROUND_CLOSEST_ULL((parent_rate * (pll->mul + 1) +
+		((u64)parent_rate * pll->frac >> 22)), (pll->div + 1));
 }
 
 static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
-- 
2.7.4

