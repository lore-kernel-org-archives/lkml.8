Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39671C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1582075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgESWl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:41:59 -0400
Received: from v6.sk ([167.172.42.174]:58510 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESWl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:41:59 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 04E49610D3;
        Tue, 19 May 2020 22:41:57 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 01/13] clk: mmp: frac: Do not lose last 4 digits of precision
Date:   Wed, 20 May 2020 00:41:39 +0200
Message-Id: <20200519224151.2074597-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While calculating the output rate of a fractional divider clock, the
value is divided and multipled by 10000, discarding the least
significant digits -- presumably to fit the intermediate value within 32
bits.

The precision we're losing is, however, not insignificant for things like
I2S clock. Maybe also elsewhere, now that since commit ea56ad60260e ("clk:
mmp2: Stop pretending PLL outputs are constant") the parent rates are more
precise and no longer rounded to 10000s.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-frac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index fabc09aca6c4..ed9928f5bdc7 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -28,13 +28,15 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 		unsigned long *prate)
 {
 	struct mmp_clk_factor *factor = to_clk_factor(hw);
-	unsigned long rate = 0, prev_rate;
+	u64 rate = 0, prev_rate;
 	int i;
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
 		prev_rate = rate;
-		rate = (((*prate / 10000) * factor->ftbl[i].den) /
-			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
+		rate = *prate;
+		rate *= factor->ftbl[i].den;
+		do_div(rate, factor->ftbl[i].num * factor->masks->factor);
+
 		if (rate > drate)
 			break;
 	}
@@ -54,6 +56,7 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 	struct mmp_clk_factor *factor = to_clk_factor(hw);
 	struct mmp_clk_factor_masks *masks = factor->masks;
 	unsigned int val, num, den;
+	u64 rate;
 
 	val = readl_relaxed(factor->base);
 
@@ -66,8 +69,11 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 	if (!den)
 		return 0;
 
-	return (((parent_rate / 10000)  * den) /
-			(num * factor->masks->factor)) * 10000;
+	rate = parent_rate;
+	rate *= den;
+	do_div(rate, num * factor->masks->factor);
+
+	return rate;
 }
 
 /* Configures new clock rate*/
@@ -78,12 +84,14 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct mmp_clk_factor_masks *masks = factor->masks;
 	int i;
 	unsigned long val;
-	unsigned long rate = 0;
 	unsigned long flags = 0;
+	u64 rate = 0;
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
-		rate = (((prate / 10000) * factor->ftbl[i].den) /
-			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
+		rate = prate;
+		rate *= factor->ftbl[i].den;
+		do_div(rate, factor->ftbl[i].num * factor->masks->factor);
+
 		if (rate > drate)
 			break;
 	}
-- 
2.26.2

