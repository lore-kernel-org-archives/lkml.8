Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C1C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB0F206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ulKfNKLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHMJzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:55:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48573 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:55:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200813095520euoutp019d488b8672173e62d552b68cbde8b586~qy0ZPCRIc2827528275euoutp01t
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:55:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200813095520euoutp019d488b8672173e62d552b68cbde8b586~qy0ZPCRIc2827528275euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597312520;
        bh=pbcmhTFv8QmhXk6820rAhoNUO/TkBc40q1AEGWorLLY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ulKfNKLHnNU686NzmkHNDE8oKr+P2cPE/yJq9DclFoasVbl+ni61RMRDbiPRPmqHD
         FexeoNekhtvteI/Dp6QMeD0WegW+mPXtqbBkrAQ/0PKF4LL7LMCJBlv5mwhMWH73qQ
         YPL4fiolJEmuiDlr9sKTi8EE9Uwxv7wFJKhs1leY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200813095520eucas1p230b921067a32bdf9dd3973d09cbdf52b~qy0Y_0Tvr1596915969eucas1p2t;
        Thu, 13 Aug 2020 09:55:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.C2.05997.80E053F5; Thu, 13
        Aug 2020 10:55:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200813095520eucas1p209432599420d62e0e54a5545334c329c~qy0YpIMZh1146911469eucas1p2t;
        Thu, 13 Aug 2020 09:55:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200813095520eusmtrp2fe4e9b5d47a39aa0810c3ed57fe67bea~qy0YoVe951763817638eusmtrp2Z;
        Thu, 13 Aug 2020 09:55:20 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-79-5f350e080c68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.E2.06314.70E053F5; Thu, 13
        Aug 2020 10:55:20 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200813095519eusmtip1dd85c2a532534f620e64589b11d3d65f~qy0YKPvHN3006430064eusmtip1_;
        Thu, 13 Aug 2020 09:55:19 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
Date:   Thu, 13 Aug 2020 11:55:08 +0200
Message-Id: <20200813095508.7563-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7ocfKbxBt9eCllsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2Vot/1zayWKza9YfRgcvj/Y1Wdo+ds+6y
        e2xa1cnm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBkzJ69gKdhiUjGhn6WB8aJWFyMnh4SA
        iUT3261sXYxcHEICKxglLi9aygrhfGGUeLroFguE85lRYvrk94wwLa+uP2GCSCxnlPjRfpMZ
        ruXXmTXsIFVsAoYSvUf7wDpEBGQlbh37CbaEWaCZSeJzfxMLSEJYIEri4bpnYDaLgKpE3+1L
        YA28AlYSsxdsYoVYJy+xesMBsA0SAq/ZJDZd+cgMkXCRWPf2CwuELSzx6vgWdghbRuL/zvlM
        EA3NjBI9u2+zQzgTGCXuH18A9YW1xJ1zv4Bu4gC6SVNi/S59EFNCwFHi61NGCJNP4sZbQZBi
        ZiBz0rbpzBBhXomONiGIGSoSv1dNZ4KwpSS6n/yHusZDouHTNbBrhARiJdo+rGaewCg3C2HV
        AkbGVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGJ4vS/4192MO76k3SIUYCDUYmHd8Iv
        43gh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEk
        NTs1tSC1CCbLxMEp1cAocJhJ68mKWLZrDCvfz4xX2T6ndSHXrAK200+277lw8flUlZvPXl5W
        3G2rPyXg4NqITasvtF887Xh99R8g9dRi2d/E65nXl046bjVBaM+eqW/lE1ZJVZ+fZn16lbaO
        zIl+Yat/z76+Lqm9c9kzMtBBeb6czMk3rDdjv2iG1jyLWqwlbtB580mBEktxRqKhFnNRcSIA
        a1z/hRADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xu7ocfKbxBjOsLTbOWM9qcf3Lc1aL
        jz33WC0u75rDZjHj/D4mi7VH7rJbXDzlanH4TTurxb9rG1ksVu36w+jA5fH+Riu7x85Zd9k9
        Nq3qZPPo27KK0ePzJrkA1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jJmTV7AUbDGpmNDP0sB4UauLkZNDQsBE4tX1J0xdjFwcQgJLGSW2Tm8A
        cjiAElIS81uUIGqEJf5c62KDqPnEKHFp9wpmkASbgKFE79E+RhBbREBW4taxn2BFzAK9TBLt
        37ewgCSEBSIkJh28yA5iswioSvTdvgTWwCtgJTF7wSZWiA3yEqs3HGCewMizgJFhFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmBwbjv2c/MOxksbgw8xCnAwKvHwTvhlHC/EmlhWXJl7iFGC
        g1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDIyevJN7Q1NDcwtLQ3Njc2MxC
        SZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj6NtlL3IOOdlLbVt1baECK0eLaFTlvnOyucrP
        fKpE+RQN1k3aflmxTEsnzlFw2fXFKj+Pbp8fu+3h2lf71n+bt1nqyG1zSdncVfmlIjy1Cw9L
        T/o4p++9HevbnRduT9U3qfyjWcL198dr1u89Z84dWugdv6drpqN8htlG47qstue7OHdZNAiZ
        KrEUZyQaajEXFScCAAQEVetkAgAA
X-CMS-MailID: 20200813095520eucas1p209432599420d62e0e54a5545334c329c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200813095520eucas1p209432599420d62e0e54a5545334c329c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200813095520eucas1p209432599420d62e0e54a5545334c329c
References: <CGME20200813095520eucas1p209432599420d62e0e54a5545334c329c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the .set_rate callback for some PLLs there is a loop polling state
of the PLL lock bit and it may become an endless loop when something
goes wrong with the PLL. For some PLLs there is already code for polling
with a timeout but it uses the ktime API, which doesn't work in some
conditions when the set_rate op is called, in particular during
initialization of the clk provider before the clocksource initialization
has completed. Hence the ktime API cannot be used to reliably detect
the PLL locking timeout.

This patch adds a common helper function for busy waiting on the PLL lock
bit with timeout detection.

Actual PLL lock time depends on the P divider value, the VCO frequency
and a constant PLL type specific LOCK_FACTOR and can be calculated as

 lock_time = Pdiv * LOCK_FACTOR / VCO_freq

Common timeout value of 10 ms is used for all the PLLs with an assumption
that maximum possible value of Pdiv is 64, maximum possible LOCK_FACTOR
value is 3000 and minimum VCO frequency is 24 MHz.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v3:
 - use busy-loop with udelay() instead of ktime API
Changes for v2:
 - use common readl_relaxed_poll_timeout_atomic() macro
---
 drivers/clk/samsung/clk-pll.c | 94 ++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index ac70ad7..c83d261 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -15,7 +15,7 @@
 #include "clk.h"
 #include "clk-pll.h"

-#define PLL_TIMEOUT_MS		10
+#define PLL_TIMEOUT_US		10000U

 struct samsung_clk_pll {
 	struct clk_hw		hw;
@@ -63,6 +63,25 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
 	return rate_table[i - 1].rate;
 }

+static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
+				 unsigned int reg_mask)
+{
+	int i;
+
+	/* Wait until the PLL is in steady locked state */
+	for (i = 0; i < PLL_TIMEOUT_US / 2; i++) {
+		if (readl_relaxed(pll->con_reg) & reg_mask)
+			return 0;
+
+		udelay(2);
+		cpu_relax();
+	}
+
+	pr_err("Could not lock PLL %s\n", clk_hw_get_name(&pll->hw));
+
+	return -ETIMEDOUT;
+}
+
 static int samsung_pll3xxx_enable(struct clk_hw *hw)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
@@ -241,12 +260,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	writel_relaxed(tmp, pll->con_reg);

 	/* Wait until the PLL is locked if it is enabled. */
-	if (tmp & BIT(pll->enable_offs)) {
-		do {
-			cpu_relax();
-			tmp = readl_relaxed(pll->con_reg);
-		} while (!(tmp & BIT(pll->lock_offs)));
-	}
+	if (tmp & BIT(pll->enable_offs))
+		return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
+
 	return 0;
 }

@@ -318,7 +334,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 					unsigned long parent_rate)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 tmp, pll_con0, pll_con1;
+	u32 pll_con0, pll_con1;
 	const struct samsung_pll_rate_table *rate;

 	rate = samsung_get_pll_settings(pll, drate);
@@ -356,13 +372,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_con1 |= rate->kdiv << PLL36XX_KDIV_SHIFT;
 	writel_relaxed(pll_con1, pll->con_reg + 4);

-	/* wait_lock_time */
-	if (pll_con0 & BIT(pll->enable_offs)) {
-		do {
-			cpu_relax();
-			tmp = readl_relaxed(pll->con_reg);
-		} while (!(tmp & BIT(pll->lock_offs)));
-	}
+	if (pll_con0 & BIT(pll->enable_offs))
+		return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));

 	return 0;
 }
@@ -437,7 +448,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1;
-	ktime_t start;

 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -489,20 +499,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	writel_relaxed(con0, pll->con_reg);

 	/* Wait for locking. */
-	start = ktime_get();
-	while (!(readl_relaxed(pll->con_reg) & PLL45XX_LOCKED)) {
-		ktime_t delta = ktime_sub(ktime_get(), start);
-
-		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
-			pr_err("%s: could not lock PLL %s\n",
-					__func__, clk_hw_get_name(hw));
-			return -EFAULT;
-		}
-
-		cpu_relax();
-	}
-
-	return 0;
+	return samsung_pll_lock_wait(pll, PLL45XX_LOCKED);
 }

 static const struct clk_ops samsung_pll45xx_clk_ops = {
@@ -588,7 +585,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1, lock;
-	ktime_t start;

 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -648,20 +644,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	writel_relaxed(con1, pll->con_reg + 0x4);

 	/* Wait for locking. */
-	start = ktime_get();
-	while (!(readl_relaxed(pll->con_reg) & PLL46XX_LOCKED)) {
-		ktime_t delta = ktime_sub(ktime_get(), start);
-
-		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
-			pr_err("%s: could not lock PLL %s\n",
-					__func__, clk_hw_get_name(hw));
-			return -EFAULT;
-		}
-
-		cpu_relax();
-	}
-
-	return 0;
+	return samsung_pll_lock_wait(pll, PLL46XX_LOCKED);
 }

 static const struct clk_ops samsung_pll46xx_clk_ops = {
@@ -1035,14 +1018,9 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
 			(rate->sdiv << PLL2550XX_S_SHIFT);
 	writel_relaxed(tmp, pll->con_reg);

-	/* wait_lock_time */
-	do {
-		cpu_relax();
-		tmp = readl_relaxed(pll->con_reg);
-	} while (!(tmp & (PLL2550XX_LOCK_STAT_MASK
-			<< PLL2550XX_LOCK_STAT_SHIFT)));
-
-	return 0;
+	/* Wait for locking. */
+	return samsung_pll_lock_wait(pll,
+			PLL2550XX_LOCK_STAT_MASK << PLL2550XX_LOCK_STAT_SHIFT);
 }

 static const struct clk_ops samsung_pll2550xx_clk_ops = {
@@ -1132,13 +1110,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw *hw, unsigned long drate,
 	con1 |= ((rate->kdiv & PLL2650X_K_MASK) << PLL2650X_K_SHIFT);
 	writel_relaxed(con1, pll->con_reg + 4);

-	do {
-		cpu_relax();
-		con0 = readl_relaxed(pll->con_reg);
-	} while (!(con0 & (PLL2650X_LOCK_STAT_MASK
-			<< PLL2650X_LOCK_STAT_SHIFT)));
-
-	return 0;
+	/* Wait for locking. */
+	return samsung_pll_lock_wait(pll,
+			PLL2650X_LOCK_STAT_MASK << PLL2650X_LOCK_STAT_SHIFT);
 }

 static const struct clk_ops samsung_pll2650x_clk_ops = {
--
2.7.4

