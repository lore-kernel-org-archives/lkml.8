Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F01C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7240D20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xW8cgBAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgGVHjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:35 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35079 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgGVHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403570; x=1626939570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F4n24Hn6n8rbcY6NrrFZqVIgnii0kjjrLD9A3P447NY=;
  b=xW8cgBAWCkFlybFJTj2q8BhAe3+S4T3Kq4sEda1XBTJ5ofOGx1h0IHSJ
   1slKpeiOK1CTwyLF0Ws2ObinIGoq2kv+FdX9qLvckRpCNWG3amSIZmFSS
   NTW4xBrU4gpbxwlyHgHTKJITMX6HiZrAlNjHyMDxBA8v8YxzhfUJFgFVw
   uC64X+wtYVxEHUZPkcSi/q3Pqwu6q21xmJotFJ2tHoCCys8hgKCwqd6Ks
   o3wZ3dSQIqzagd8jyJ200Hlf0qYUMauinJHubLUGCPU8gmS4iuIGfCtVU
   dTS+Ir5dO8orSB4m+lbj/YUgbmyNxyml1dzYXR+zjRU7b/BsLiswYxdsR
   A==;
IronPort-SDR: 8tqsPIy6OS+1S8akhEdPg7EvV3pJfM753vVZ3PvbUJ9Dtqtad92mRlbIETXWm9MmtuDmtJ4I6U
 8UWHoGdhuLhUVc/oi+DliRRYCMxwpC2Yje6S5eTMQdBdfx5Jlv3ybTJgKGMBwHMC3nSugG0XEq
 5eza0aQH+zwtZ0ZuRsEgHBHL5yjq3euVi8BrqFP54WXP0ds16cZLJ1/oEgyeDIaETotkreYo4U
 LndlmMmFr4OBcKdaV7ytnixQ+Jpehw5ZSyGhZNK8vx6Auca8rcuyD7zvmNZ7KuDRLF3DsWStyY
 cPk=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="20120870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:51 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 16/18] clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs
Date:   Wed, 22 Jul 2020 10:38:24 +0300
Message-ID: <1595403506-8209-17-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SAMA7G5 PLLs support multiple outputs (e.g. AUDIO PLL).
For these, split the PLL clock in two: fractional clock and
divider clock. In case PLLs supports multiple outputs (since these
outputs are dividers (with different settings) sharing the same
fractional part), it will register one fractional clock and multiple
divider clocks (dividers sharing the fractional clock).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 547 +++++++++++++++++++++++++------------
 drivers/clk/at91/pmc.h             |  22 +-
 drivers/clk/at91/sam9x60.c         |  50 +++-
 3 files changed, 433 insertions(+), 186 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 1f0bcc6b4fea..b473298ef7e6 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -25,20 +25,31 @@
 #define FCORE_MIN		(600000000)
 #define FCORE_MAX		(1200000000)
 
-#define PLL_MAX_ID		1
+#define PLL_MAX_ID		7
 
-struct sam9x60_pll {
-	struct clk_hw hw;
+struct sam9x60_pll_core {
 	struct regmap *regmap;
 	spinlock_t *lock;
 	const struct clk_pll_characteristics *characteristics;
-	u32 frac;
+	const struct clk_pll_layout *layout;
+	struct clk_hw hw;
 	u8 id;
-	u8 div;
+};
+
+struct sam9x60_frac {
+	struct sam9x60_pll_core core;
+	u32 frac;
 	u16 mul;
 };
 
-#define to_sam9x60_pll(hw) container_of(hw, struct sam9x60_pll, hw)
+struct sam9x60_div {
+	struct sam9x60_pll_core core;
+	u8 div;
+};
+
+#define to_sam9x60_pll_core(hw)	container_of(hw, struct sam9x60_pll_core, hw)
+#define to_sam9x60_frac(core)	container_of(core, struct sam9x60_frac, core)
+#define to_sam9x60_div(core)	container_of(core, struct sam9x60_div, core)
 
 static inline bool sam9x60_pll_ready(struct regmap *regmap, int id)
 {
@@ -49,43 +60,53 @@ static inline bool sam9x60_pll_ready(struct regmap *regmap, int id)
 	return !!(status & BIT(id));
 }
 
-static int sam9x60_pll_prepare(struct clk_hw *hw)
+static bool sam9x60_frac_pll_ready(struct regmap *regmap, u8 id)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
-	struct regmap *regmap = pll->regmap;
-	unsigned long flags;
-	u8 div;
-	u16 mul;
-	u32 val, frac;
+	return sam9x60_pll_ready(regmap, id);
+}
 
-	spin_lock_irqsave(pll->lock, flags);
-	regmap_write(regmap, AT91_PMC_PLL_UPDT, pll->id);
+static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
 
-	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
-	div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, val);
+	return (parent_rate * (frac->mul + 1) +
+		((u64)parent_rate * frac->frac >> 22));
+}
 
+static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	struct regmap *regmap = core->regmap;
+	unsigned int val, cfrac, cmul;
+	unsigned long flags;
+
+	spin_lock_irqsave(core->lock, flags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
-	mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
-	frac = FIELD_GET(PMC_PLL_CTRL1_FRACR_MSK, val);
+	cmul = (val & core->layout->mul_mask) >> core->layout->mul_shift;
+	cfrac = (val & core->layout->frac_mask) >> core->layout->frac_shift;
 
-	if (sam9x60_pll_ready(regmap, pll->id) &&
-	    (div == pll->div && mul == pll->mul && frac == pll->frac)) {
-		spin_unlock_irqrestore(pll->lock, flags);
-		return 0;
-	}
+	if (sam9x60_frac_pll_ready(regmap, core->id) &&
+	    (cmul == frac->mul && cfrac == frac->frac))
+		goto unlock;
 
-	/* Recommended value for AT91_PMC_PLL_ACR */
-	if (pll->characteristics->upll)
+	/* Recommended value for PMC_PLL_ACR */
+	if (core->characteristics->upll)
 		val = AT91_PMC_PLL_ACR_DEFAULT_UPLL;
 	else
 		val = AT91_PMC_PLL_ACR_DEFAULT_PLLA;
 	regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
 	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
-		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul) |
-		     FIELD_PREP(PMC_PLL_CTRL1_FRACR_MSK, pll->frac));
+		     (frac->mul << core->layout->mul_shift) |
+		     (frac->frac << core->layout->frac_shift));
 
-	if (pll->characteristics->upll) {
+	if (core->characteristics->upll) {
 		/* Enable the UTMI internal bandgap */
 		val |= AT91_PMC_PLL_ACR_UTMIBG;
 		regmap_write(regmap, AT91_PMC_PLL_ACR, val);
@@ -100,229 +121,409 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 	}
 
 	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
-	regmap_write(regmap, AT91_PMC_PLL_CTRL0,
-		     AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL |
-		     AT91_PMC_PLL_CTRL0_ENPLLCK | pll->div);
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL,
+			   AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL);
 
 	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
-	while (!sam9x60_pll_ready(regmap, pll->id))
+	while (!sam9x60_pll_ready(regmap, core->id))
 		cpu_relax();
 
-	spin_unlock_irqrestore(pll->lock, flags);
+unlock:
+	spin_unlock_irqrestore(core->lock, flags);
 
 	return 0;
 }
 
-static int sam9x60_pll_is_prepared(struct clk_hw *hw)
+static void sam9x60_frac_pll_unprepare(struct clk_hw *hw)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct regmap *regmap = core->regmap;
+	unsigned long flags;
 
-	return sam9x60_pll_ready(pll->regmap, pll->id);
+	spin_lock_irqsave(core->lock, flags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0, AT91_PMC_PLL_CTRL0_ENPLL, 0);
+
+	if (core->characteristics->upll)
+		regmap_update_bits(regmap, AT91_PMC_PLL_ACR,
+				   AT91_PMC_PLL_ACR_UTMIBG | AT91_PMC_PLL_ACR_UTMIVR, 0);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
+
+	spin_unlock_irqrestore(core->lock, flags);
 }
 
-static void sam9x60_pll_unprepare(struct clk_hw *hw)
+static int sam9x60_frac_pll_is_prepared(struct clk_hw *hw)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
-	unsigned long flags;
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+
+	return sam9x60_pll_ready(core->regmap, core->id);
+}
 
-	spin_lock_irqsave(pll->lock, flags);
+static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
+					      unsigned long rate,
+					      unsigned long parent_rate,
+					      bool update)
+{
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	unsigned long tmprate, remainder;
+	unsigned long nmul = 0;
+	unsigned long nfrac = 0;
 
-	regmap_write(pll->regmap, AT91_PMC_PLL_UPDT, pll->id);
+	if (rate < FCORE_MIN || rate > FCORE_MAX)
+		return -ERANGE;
 
-	regmap_update_bits(pll->regmap, AT91_PMC_PLL_CTRL0,
-			   AT91_PMC_PLL_CTRL0_ENPLLCK, 0);
+	/*
+	 * Calculate the multiplier associated with the current
+	 * divider that provide the closest rate to the requested one.
+	 */
+	nmul = mult_frac(rate, 1, parent_rate);
+	tmprate = mult_frac(parent_rate, nmul, 1);
+	remainder = rate - tmprate;
 
-	regmap_update_bits(pll->regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
+	if (remainder) {
+		nfrac = DIV_ROUND_CLOSEST_ULL((u64)remainder * (1 << 22),
+					      parent_rate);
 
-	regmap_update_bits(pll->regmap, AT91_PMC_PLL_CTRL0,
-			   AT91_PMC_PLL_CTRL0_ENPLL, 0);
+		tmprate += DIV_ROUND_CLOSEST_ULL((u64)nfrac * parent_rate,
+						 (1 << 22));
+	}
 
-	if (pll->characteristics->upll)
-		regmap_update_bits(pll->regmap, AT91_PMC_PLL_ACR,
-				   AT91_PMC_PLL_ACR_UTMIBG |
-				   AT91_PMC_PLL_ACR_UTMIVR, 0);
+	/* Check if resulted rate is a valid.  */
+	if (tmprate < FCORE_MIN || tmprate > FCORE_MAX)
+		return -ERANGE;
 
-	regmap_update_bits(pll->regmap, AT91_PMC_PLL_UPDT,
-			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
+	if (update) {
+		frac->mul = nmul - 1;
+		frac->frac = nfrac;
+	}
 
-	spin_unlock_irqrestore(pll->lock, flags);
+	return tmprate;
 }
 
-static unsigned long sam9x60_pll_recalc_rate(struct clk_hw *hw,
-					     unsigned long parent_rate)
+static long sam9x60_frac_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *parent_rate)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 
-	return DIV_ROUND_CLOSEST_ULL((parent_rate * (pll->mul + 1) +
-		((u64)parent_rate * pll->frac >> 22)), (pll->div + 1));
+	return sam9x60_frac_pll_compute_mul_frac(core, rate, *parent_rate, false);
 }
 
-static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
-					 unsigned long rate,
-					 unsigned long parent_rate,
-					 bool update)
+static int sam9x60_frac_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
 {
-	const struct clk_pll_characteristics *characteristics =
-							pll->characteristics;
-	unsigned long bestremainder = ULONG_MAX;
-	unsigned long maxdiv, mindiv, tmpdiv;
-	long bestrate = -ERANGE;
-	unsigned long bestdiv = 0;
-	unsigned long bestmul = 0;
-	unsigned long bestfrac = 0;
-	u64 fcore = 0;
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 
-	if (rate < characteristics->output[0].min ||
-	    rate > characteristics->output[0].max)
-		return -ERANGE;
+	return sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate, true);
+}
 
-	if (!pll->characteristics->upll) {
-		mindiv = parent_rate / rate;
-		if (mindiv < 2)
-			mindiv = 2;
+static const struct clk_ops sam9x60_frac_pll_ops = {
+	.prepare = sam9x60_frac_pll_prepare,
+	.unprepare = sam9x60_frac_pll_unprepare,
+	.is_prepared = sam9x60_frac_pll_is_prepared,
+	.recalc_rate = sam9x60_frac_pll_recalc_rate,
+	.round_rate = sam9x60_frac_pll_round_rate,
+	.set_rate = sam9x60_frac_pll_set_rate,
+};
 
-		maxdiv = DIV_ROUND_UP(parent_rate * PLL_MUL_MAX, rate);
-		if (maxdiv > PLL_DIV_MAX)
-			maxdiv = PLL_DIV_MAX;
-	} else {
-		mindiv = maxdiv = UPLL_DIV;
-	}
+static int sam9x60_div_pll_prepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+	struct regmap *regmap = core->regmap;
+	unsigned long flags;
+	unsigned int val, cdiv;
 
-	for (tmpdiv = mindiv; tmpdiv <= maxdiv; tmpdiv++) {
-		unsigned long remainder;
-		unsigned long tmprate;
-		unsigned long tmpmul;
-		unsigned long tmpfrac = 0;
+	spin_lock_irqsave(core->lock, flags);
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
+	cdiv = (val & core->layout->div_mask) >> core->layout->div_shift;
 
-		/*
-		 * Calculate the multiplier associated with the current
-		 * divider that provide the closest rate to the requested one.
-		 */
-		tmpmul = mult_frac(rate, tmpdiv, parent_rate);
-		tmprate = mult_frac(parent_rate, tmpmul, tmpdiv);
-		remainder = rate - tmprate;
+	/* Stop if enabled an nothing changed. */
+	if (!!(val & core->layout->endiv_mask) && cdiv == div->div)
+		goto unlock;
 
-		if (remainder) {
-			tmpfrac = DIV_ROUND_CLOSEST_ULL((u64)remainder * tmpdiv * (1 << 22),
-							parent_rate);
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   core->layout->div_mask | core->layout->endiv_mask,
+			   (div->div << core->layout->div_shift) |
+			   (1 << core->layout->endiv_shift));
 
-			tmprate += DIV_ROUND_CLOSEST_ULL((u64)tmpfrac * parent_rate,
-							 tmpdiv * (1 << 22));
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
-			if (tmprate > rate)
-				remainder = tmprate - rate;
-			else
-				remainder = rate - tmprate;
-		}
+	while (!sam9x60_pll_ready(regmap, core->id))
+		cpu_relax();
+
+unlock:
+	spin_unlock_irqrestore(core->lock, flags);
+
+	return 0;
+}
+
+static void sam9x60_div_pll_unprepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct regmap *regmap = core->regmap;
+	unsigned long flags;
+
+	spin_lock_irqsave(core->lock, flags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   core->layout->endiv_mask, 0);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
+
+	spin_unlock_irqrestore(core->lock, flags);
+}
+
+static int sam9x60_div_pll_is_prepared(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct regmap *regmap = core->regmap;
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(core->lock, flags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
+
+	spin_unlock_irqrestore(core->lock, flags);
 
-		fcore = parent_rate * (tmpmul + 1) +
-			((u64)parent_rate * tmpfrac >> 22);
-		if (fcore < FCORE_MIN || fcore > FCORE_MAX)
+	return !!(val & core->layout->endiv_mask);
+}
+
+static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+
+	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
+}
+
+static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
+					unsigned long *parent_rate,
+					unsigned long rate)
+{
+	const struct clk_pll_characteristics *characteristics =
+							core->characteristics;
+	struct clk_hw *parent = clk_hw_get_parent(&core->hw);
+	unsigned long tmp_rate, tmp_parent_rate, tmp_diff;
+	long best_diff = -1, best_rate = -EINVAL;
+	u32 divid, best_div;
+
+	if (!rate)
+		return 0;
+
+	if (rate < characteristics->output[0].min ||
+	    rate > characteristics->output[0].max)
+		return -ERANGE;
+
+	for (divid = 1; divid < core->layout->div_mask; divid++) {
+		tmp_parent_rate = clk_hw_round_rate(parent, rate * divid);
+		if (!tmp_parent_rate)
 			continue;
 
-		/*
-		 * Compare the remainder with the best remainder found until
-		 * now and elect a new best multiplier/divider pair if the
-		 * current remainder is smaller than the best one.
-		 */
-		if (remainder < bestremainder) {
-			bestremainder = remainder;
-			bestdiv = tmpdiv;
-			bestmul = tmpmul;
-			bestrate = tmprate;
-			bestfrac = tmpfrac;
+		tmp_rate = DIV_ROUND_CLOSEST_ULL(tmp_parent_rate, divid);
+		tmp_diff = abs(rate - tmp_rate);
+
+		if (best_diff < 0 || best_diff > tmp_diff) {
+			*parent_rate = tmp_parent_rate;
+			best_rate = tmp_rate;
+			best_diff = tmp_diff;
+			best_div = divid;
 		}
 
-		/* We've found a perfect match!  */
-		if (!remainder)
+		if (!best_diff)
 			break;
 	}
 
-	/* Check if bestrate is a valid output rate  */
-	if (fcore < FCORE_MIN || fcore > FCORE_MAX ||
-	    bestrate < characteristics->output[0].min ||
-	    bestrate > characteristics->output[0].max)
+	if (best_rate < characteristics->output[0].min ||
+	    best_rate > characteristics->output[0].max)
 		return -ERANGE;
 
-	if (update) {
-		pll->div = bestdiv - 1;
-		pll->mul = bestmul - 1;
-		pll->frac = bestfrac;
-	}
-
-	return bestrate;
+	return best_rate;
 }
 
-static long sam9x60_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *parent_rate)
+static long sam9x60_div_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *parent_rate)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 
-	return sam9x60_pll_get_best_div_mul(pll, rate, *parent_rate, false);
+	return sam9x60_div_pll_compute_div(core, parent_rate, rate);
 }
 
-static int sam9x60_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
+static int sam9x60_div_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
 {
-	struct sam9x60_pll *pll = to_sam9x60_pll(hw);
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+
+	div->div = DIV_ROUND_CLOSEST(parent_rate, rate) - 1;
 
-	return sam9x60_pll_get_best_div_mul(pll, rate, parent_rate, true);
+	return 0;
 }
 
-static const struct clk_ops pll_ops = {
-	.prepare = sam9x60_pll_prepare,
-	.unprepare = sam9x60_pll_unprepare,
-	.is_prepared = sam9x60_pll_is_prepared,
-	.recalc_rate = sam9x60_pll_recalc_rate,
-	.round_rate = sam9x60_pll_round_rate,
-	.set_rate = sam9x60_pll_set_rate,
+static const struct clk_ops sam9x60_div_pll_ops = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.set_rate = sam9x60_div_pll_set_rate,
 };
 
 struct clk_hw * __init
-sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
-			 const char *name, const char *parent_name, u8 id,
-			 const struct clk_pll_characteristics *characteristics)
+sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
+			      const char *name, const char *parent_name,
+			      struct clk_hw *parent_hw, u8 id,
+			      const struct clk_pll_characteristics *characteristics,
+			      const struct clk_pll_layout *layout, bool critical)
 {
-	struct sam9x60_pll *pll;
+	struct sam9x60_frac *frac;
 	struct clk_hw *hw;
 	struct clk_init_data init;
-	unsigned int pllr;
+	unsigned long parent_rate, flags;
+	unsigned int val;
 	int ret;
 
-	if (id > PLL_MAX_ID)
+	if (id > PLL_MAX_ID || !lock || !parent_hw)
 		return ERR_PTR(-EINVAL);
 
-	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll)
+	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
+	if (!frac)
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &pll_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.ops = &sam9x60_frac_pll_ops;
 	init.flags = CLK_SET_RATE_GATE;
+	if (critical)
+		init.flags |= CLK_IS_CRITICAL;
+
+	frac->core.id = id;
+	frac->core.hw.init = &init;
+	frac->core.characteristics = characteristics;
+	frac->core.layout = layout;
+	frac->core.regmap = regmap;
+	frac->core.lock = lock;
+
+	spin_lock_irqsave(frac->core.lock, flags);
+	if (sam9x60_pll_ready(regmap, id)) {
+		regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+				   AT91_PMC_PLL_UPDT_ID_MSK, id);
+		regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
+		frac->mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
+		frac->frac = FIELD_GET(PMC_PLL_CTRL1_FRACR_MSK, val);
+	} else {
+		/*
+		 * This means the PLL is not setup by bootloaders. In this
+		 * case we need to set the minimum rate for it. Otherwise
+		 * a clock child of this PLL may be enabled before setting
+		 * its rate leading to enabling this PLL with unsupported
+		 * rate. This will lead to PLL not being locked at all.
+		 */
+		parent_rate = clk_hw_get_rate(parent_hw);
+		if (!parent_rate) {
+			hw = ERR_PTR(-EINVAL);
+			goto free;
+		}
+
+		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
+							parent_rate, true);
+		if (ret <= 0) {
+			hw = ERR_PTR(ret);
+			goto free;
+		}
+	}
+	spin_unlock_irqrestore(frac->core.lock, flags);
+
+	hw = &frac->core.hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(frac);
+		hw = ERR_PTR(ret);
+	}
 
-	pll->id = id;
-	pll->hw.init = &init;
-	pll->characteristics = characteristics;
-	pll->regmap = regmap;
-	pll->lock = lock;
+	return hw;
+
+free:
+	spin_unlock_irqrestore(frac->core.lock, flags);
+	kfree(frac);
+	return hw;
+}
+
+struct clk_hw * __init
+sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
+			     const char *name, const char *parent_name, u8 id,
+			     const struct clk_pll_characteristics *characteristics,
+			     const struct clk_pll_layout *layout, bool critical)
+{
+	struct sam9x60_div *div;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	unsigned long flags;
+	unsigned int val;
+	int ret;
+
+	if (id > PLL_MAX_ID || !lock)
+		return ERR_PTR(-EINVAL);
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.ops = &sam9x60_div_pll_ops;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		     CLK_SET_RATE_PARENT;
+	if (critical)
+		init.flags |= CLK_IS_CRITICAL;
+
+	div->core.id = id;
+	div->core.hw.init = &init;
+	div->core.characteristics = characteristics;
+	div->core.layout = layout;
+	div->core.regmap = regmap;
+	div->core.lock = lock;
+
+	spin_lock_irqsave(div->core.lock, flags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_ID_MSK, id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
+	div->div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, val);
 
-	regmap_write(regmap, AT91_PMC_PLL_UPDT, id);
-	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &pllr);
-	pll->div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, pllr);
-	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &pllr);
-	pll->mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, pllr);
+	spin_unlock_irqrestore(div->core.lock, flags);
 
-	hw = &pll->hw;
+	hw = &div->core.hw;
 	ret = clk_hw_register(NULL, hw);
 	if (ret) {
-		kfree(pll);
+		kfree(div);
 		hw = ERR_PTR(ret);
 	}
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 8d3e22f566cf..6340b9be8205 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -54,8 +54,14 @@ struct clk_master_characteristics {
 
 struct clk_pll_layout {
 	u32 pllr_mask;
-	u16 mul_mask;
+	u32 mul_mask;
+	u32 frac_mask;
+	u32 div_mask;
+	u32 endiv_mask;
 	u8 mul_shift;
+	u8 frac_shift;
+	u8 div_shift;
+	u8 endiv_shift;
 };
 
 extern const struct clk_pll_layout at91rm9200_pll_layout;
@@ -181,9 +187,17 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name);
 
 struct clk_hw * __init
-sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
-			 const char *name, const char *parent_name, u8 id,
-			 const struct clk_pll_characteristics *characteristics);
+sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
+			     const char *name, const char *parent_name, u8 id,
+			     const struct clk_pll_characteristics *characteristics,
+			     const struct clk_pll_layout *layout, bool critical);
+
+struct clk_hw * __init
+sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
+			      const char *name, const char *parent_name,
+			      struct clk_hw *parent_hw, u8 id,
+			      const struct clk_pll_characteristics *characteristics,
+			      const struct clk_pll_layout *layout, bool critical);
 
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index f2306615c7e7..88574d799208 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -42,6 +42,20 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.upll = true,
 };
 
+static const struct clk_pll_layout pll_frac_layout = {
+	.mul_mask = GENMASK(31, 24),
+	.frac_mask = GENMASK(21, 0),
+	.mul_shift = 24,
+	.frac_shift = 0,
+};
+
+static const struct clk_pll_layout pll_div_layout = {
+	.div_mask = GENMASK(7, 0),
+	.endiv_mask = BIT(29),
+	.div_shift = 0,
+	.endiv_shift = 29,
+};
+
 static const struct clk_programmable_layout sam9x60_programmable_layout = {
 	.pres_mask = 0xff,
 	.pres_shift = 8,
@@ -156,6 +170,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	const char *td_slck_name, *md_slck_name, *mainxtal_name;
 	struct pmc_data *sam9x60_pmc;
 	const char *parent_names[6];
+	struct clk_hw *main_osc_hw;
 	struct regmap *regmap;
 	struct clk_hw *hw;
 	int i;
@@ -200,6 +215,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
+	main_osc_hw = hw;
 
 	parent_names[0] = "main_rc_osc";
 	parent_names[1] = "main_osc";
@@ -209,15 +225,31 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	sam9x60_pmc->chws[PMC_MAIN] = hw;
 
-	hw = sam9x60_clk_register_pll(regmap, &pmc_pll_lock, "pllack",
-				      "mainck", 0, &plla_characteristics);
+	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
+					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
+					   0, &plla_characteristics,
+					   &pll_frac_layout, true);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
+					  "pllack_fracck", 0, &plla_characteristics,
+					  &pll_div_layout, true);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sam9x60_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = sam9x60_clk_register_pll(regmap, &pmc_pll_lock, "upllck",
-				      "main_osc", 1, &upll_characteristics);
+	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "upllck_fracck",
+					   "main_osc", main_osc_hw, 1,
+					   &upll_characteristics,
+					   &pll_frac_layout, false);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "upllck_divck",
+					  "upllck_fracck", 1, &upll_characteristics,
+					  &pll_div_layout, false);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -225,7 +257,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	parent_names[0] = md_slck_name;
 	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
+	parent_names[2] = "pllack_divck";
 	hw = at91_clk_register_master(regmap, "masterck", 3, parent_names,
 				      &sam9x60_master_layout,
 				      &mck_characteristics);
@@ -234,8 +266,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	sam9x60_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "pllack";
-	parent_names[1] = "upllck";
+	parent_names[0] = "pllack_divck";
+	parent_names[1] = "upllck_divck";
 	parent_names[2] = "main_osc";
 	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
 	if (IS_ERR(hw))
@@ -245,8 +277,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_names[1] = td_slck_name;
 	parent_names[2] = "mainck";
 	parent_names[3] = "masterck";
-	parent_names[4] = "pllack";
-	parent_names[5] = "upllck";
+	parent_names[4] = "pllack_divck";
+	parent_names[5] = "upllck_divck";
 	for (i = 0; i < 8; i++) {
 		char name[6];
 
-- 
2.7.4

