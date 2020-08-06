Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAAFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FB723119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ize4rl6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgHFQ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:57:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47306 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgHFQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200806160655euoutp01103c9047e55195029008d8a819eccc6b~ouX0kfPpU0549205492euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 16:06:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200806160655euoutp01103c9047e55195029008d8a819eccc6b~ouX0kfPpU0549205492euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596730015;
        bh=65AZBJdmRj5/qT/7JuMIu80ghQZcER+MLbhq5Zbw4Vs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ize4rl6bBdi6nnrQmHgj1ch4ZNqATzNVZmFQd37LsoFcOHFRGuoLJ4pVPrWCB++Lg
         fKESkmsjpKUKMN8k9uOn4PkpwTqUZyfF2Y6LCIFCHOU4cFHqQeqrmAAOjV7XxoN/Wh
         IqqFSun/klDWNOFWtGyRwK3TuJsTPSfoUbwKpbD4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200806160653eucas1p2e54542d3d003b3475a7620bc2065165a~ouXzlzrP02782927829eucas1p21;
        Thu,  6 Aug 2020 16:06:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.78.06318.D9A2C2F5; Thu,  6
        Aug 2020 17:06:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f~ouXzF8yay2588125881eucas1p2E;
        Thu,  6 Aug 2020 16:06:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200806160653eusmtrp162b907b4b677ef5ea07e678a506cc89c~ouXzFPsA31409414094eusmtrp1U;
        Thu,  6 Aug 2020 16:06:53 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-ba-5f2c2a9d3f9a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 57.BC.06017.D9A2C2F5; Thu,  6
        Aug 2020 17:06:53 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200806160652eusmtip168f0faf32f75261a82f1d4a1ef7b97cb~ouXyjqvse1679816798eusmtip1C;
        Thu,  6 Aug 2020 16:06:52 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
Date:   Thu,  6 Aug 2020 18:06:46 +0200
Message-Id: <20200806160646.1997-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7pztXTiDRZtMbXYOGM9q8X1L89Z
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvF4TftrBb/rm1ksVi16w+jA5fH+xut7B47Z91l
        99i0qpPNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJOt61jKbitW/F971uWBsa5ql2MnBwS
        AiYSc74tYu9i5OIQEljBKLH0+wMmCOcLo8SzFWvYIJzPjBKde/cwwrQ86XwFVbWcUeLa9Jns
        cC3nV3axgFSxCRhK9B7tA+sQEZCVuHXsJ9goZoFmJonP/U1gRcIC4RLfZ/1nA7FZBFQlps7Y
        ww5i8wpYSVzteMEEsU5eYvWGA8wgzRIC79kkTv+7DORwADkuEt/ORUDUCEu8Or6FHcKWkTg9
        uYcFor6ZUaJn9212CGcCo8T94wugnrCWuHPuFxvIIGYBTYn1u/Qhwo4Slx7NhZrPJ3HjrSBI
        mBnInLRtOlSYV6KjTQiiWkXi96rpUGdKSXQ/+c8CYXtIzNp5E2yRkECsxO7rl5kmMMrNQti1
        gJFxFaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCqOP3v+NcdjPv+JB1iFOBgVOLhrfij
        HS/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5ak
        ZqemFqQWwWSZODilGhhD/u76P4FrWbpJmG7/jfvRDSuuxUWdMXjGuHAiR2Gr8WvV0DS9eWKx
        TFJei562O1XtCr11NrFM7P6xvHiJRmWHfB+H077TmpYxTGhI39C1ZGNzcItUl8XN5U8PHU4q
        dM86PPlqz3Qt+SPL61pzE6MlVsbaihZ7TVtX+TNnoce91N7+Wzck5ZRYijMSDbWYi4oTAXDZ
        JOgRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xu7pztXTiDVrbRC02zljPanH9y3NW
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wpx+E07q8W/axtZLFbt+sPowOXx/kYru8fOWXfZ
        PTat6mTz6NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzTbetYCm7rVnzf+5algXGuahcjJ4eEgInEk85XTF2MXBxCAksZJZo/
        7GTpYuQASkhJzG9RgqgRlvhzrYsNouYTo8SVww+YQBJsAoYSvUf7GEFsEQFZiVvHfoIVMQv0
        Mkm0f9/CApIQFgiVaJj2D6yBRUBVYuqMPewgNq+AlcTVjhdMEBvkJVZvOMA8gZFnASPDKkaR
        1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAA3Xbs55YdjF3vgg8xCnAwKvHwVvzRjhdiTSwrrsw9
        xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOUTmaVEk/OB0ZNXEm9oamhuYWlobmxu
        bGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFR75UP6x7uX6sUtl8+eTNeSvB0z02h8C/p
        8QdLGa5U3VFc/jri2gOG05c5pvutS/8mLMf3OfDzrKNSMw8VTcwvymQ+6rt30vqHXCu/R1dY
        x69I/h+cESmbsUZ20cXCpd8DpmateOrimyN5u/7M3jSztfxtR1xbVyudX73m+qmzTc17goU4
        L6vXKbEUZyQaajEXFScCAPO11bxmAgAA
X-CMS-MailID: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the .set_rate callback for some PLLs there is a loop polling state
of the PLL lock bit and it may become an endless loop when something
goes wrong with the PLL. For some PLLs there is already (duplicated)
code for polling with a timeout. This patch refactors that code a bit
and moves it to a common helper function which is then used
in .set_rate callbacks for all the PLLs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 94 +++++++++++++----------------------
 1 file changed, 35 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index ac70ad785d8e..0929644be99a 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -63,6 +63,27 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
 	return rate_table[i - 1].rate;
 }
 
+static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
+				 unsigned int reg_mask)
+{
+	ktime_t timeout;
+
+	/* Wait until the PLL is in steady locked state */
+	timeout = ktime_add_ms(ktime_get(), PLL_TIMEOUT_MS);
+
+	while (!(readl_relaxed(pll->con_reg) & reg_mask)) {
+		if (ktime_after(ktime_get(), timeout)) {
+			pr_err("%s: Could not lock PLL %s\n",
+				__func__, clk_hw_get_name(&pll->hw));
+			return -EFAULT;
+		}
+
+		cpu_relax();
+	}
+
+	return 0;
+}
+
 static int samsung_pll3xxx_enable(struct clk_hw *hw)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
@@ -241,12 +262,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
 
@@ -318,7 +336,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 					unsigned long parent_rate)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 tmp, pll_con0, pll_con1;
+	u32 pll_con0, pll_con1;
 	const struct samsung_pll_rate_table *rate;
 
 	rate = samsung_get_pll_settings(pll, drate);
@@ -356,13 +374,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -437,7 +450,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1;
-	ktime_t start;
 
 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -489,20 +501,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -588,7 +587,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1, lock;
-	ktime_t start;
 
 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -648,20 +646,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -1035,14 +1020,9 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -1132,13 +1112,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw *hw, unsigned long drate,
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
2.17.1

