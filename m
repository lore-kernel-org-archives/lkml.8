Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC77C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A643C20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ginu5CJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHKLZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:25:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44407 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHKLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:25:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200811112519euoutp023e2e64ddc8037be16e1f0c5b2c6c5e62~qMwYUhixy1402614026euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:25:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200811112519euoutp023e2e64ddc8037be16e1f0c5b2c6c5e62~qMwYUhixy1402614026euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597145119;
        bh=UetpTzb41uZXUqDRqGv81XPLqlICT89xD4sslekpfGQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ginu5CJoRQi6elI72KRZE409VdLsA7tD4EBrXR20/3cMZ61D3bpwJjVlywaRpQqZ0
         erm116PYTOae6fykPfF6ujtXUwzInds+2J1I7pkFxqCd8lkXGmlqYXBIfw5UnW0BkJ
         dWO9gBioOHByx0af7vgLOhlJWnooQFyhU9UegiVs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200811112518eucas1p1c44be5e3880db5cf0851e1e3f66cab4d~qMwYFHBuj3160631606eucas1p1f;
        Tue, 11 Aug 2020 11:25:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.99.06456.E10823F5; Tue, 11
        Aug 2020 12:25:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54~qMwXpoyN42581625816eucas1p2v;
        Tue, 11 Aug 2020 11:25:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200811112518eusmtrp15a7002b80ab6b3e3737a8ea40605fbf4~qMwXouTtc1876518765eusmtrp1d;
        Tue, 11 Aug 2020 11:25:18 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-0d-5f32801ef5e0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.41.06314.E10823F5; Tue, 11
        Aug 2020 12:25:18 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200811112517eusmtip2a2872d544bab1a6283d97cc409af8286~qMwXHNgW-2649626496eusmtip27;
        Tue, 11 Aug 2020 11:25:17 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
Date:   Tue, 11 Aug 2020 13:25:07 +0200
Message-Id: <20200811112507.24418-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87pyDUbxBiv+aVpsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2Vot/1zayWKza9YfRgcvj/Y1Wdo+ds+6y
        e2xa1cnm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmrVqxkKXhjVDG9YQ5rA+M2zS5GDg4J
        AROJSV8luxi5OIQEVjBKNL/4yd7FyAnkfGGUWPmoAsL+zCix9r0iiA1S/+x2CztEw3JGie7n
        T6AcoIY/i44yg1SxCRhK9B7tYwSxRQRkJW4d+8kGUsQs0Mwk8bm/iQUkISwQJbHl+ho2EJtF
        QFXiStsvsNW8AtYS//ZvZ4NYJy+xesMBZpBmCYHXbBIHrzxkhLjbRWL/T0uIGmGJV8e3sEPY
        MhKnJ/ewQNQ3M0r07L7NDuFMYJS4f3wBI0SVtcSdc7/YQAYxC2hKrN+lDxF2lNj4+jozxHw+
        iRtvBUHCzEDmpG3TocK8Eh1tQhDVKhK/V01ngrClJLqf/GeBsD0kjn1eyQQJuViJo/s+M01g
        lJuFsGsBI+MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwCRx+t/xTzsYv15KOsQowMGo
        xMNbYG0YL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYK
        CaQnlqRmp6YWpBbBZJk4OKUaGFUfTNLek3bww66m8InzbaVSrac+7e7cccfDnHHamuM2/zo+
        cfA9ea+xOLryv8zWZ94BjSwhK2et3OcW681zJVspvu7J4t9NryK2lTJuFYjwCHwZk9yuXvRv
        rkRTkoSggN6aroayhzkTnHnUZOtcpwr51y98u//qsfqwnPX1/9Lypt//xW68TImlOCPRUIu5
        qDgRACk3CqAOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xe7pyDUbxBhsb+Sw2zljPanH9y3NW
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wpx+E07q8W/axtZLFbt+sPowOXx/kYru8fOWXfZ
        PTat6mTz6NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYxVK1ayFLwxqpjeMIe1gXGbZhcjJ4eEgInEs9st7CC2kMBSRom+WwFd
        jBxAcSmJ+S1KECXCEn+udbFBlHxilPi4XB3EZhMwlOg92scIYosIyErcOvYTqIaLg1mgl0mi
        /fsWFpCEsECERPfpE2DNLAKqElfafoHt4hWwlvi3fzsbxAJ5idUbDjBPYORZwMiwilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzA4tx37uXkH46WNwYcYBTgYlXh4C6wN44VYE8uKK3MPMUpw
        MCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEUaPlEZinR5Hxg5OSVxBuaGppbWBqaG5sbm1ko
        ifN2CByMERJITyxJzU5NLUgtgulj4uCUamBMOrZceMFkKZYjR09ne90IP/P6zcN1/Rm+ycyx
        VoFSXB4eq3/a9dbPu3Br8rTFMz9Nv/9OZcWb08mzd88LZtt5+M2SQ4o9wYrXt/JMtp+sdzs1
        TsMnc+8X5ynSL3JymDLvbK7N7n+1463YlwcxF8Vamzg/fPVxM3D4+P5lzBpv7nLBnxeEuSoq
        lViKMxINtZiLihMBElvMRmQCAAA=
X-CMS-MailID: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the .set_rate callback for some PLLs there is a loop polling state
of the PLL lock bit and it may become an endless loop when something
goes wrong with the PLL. For some PLLs there is already (a duplicated)
code for polling with timeout. This patch replaces that code with
the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
helper function, which is then used for all the PLLs. The downside
of switching to the common macro is that we drop the cpu_relax() call.
Using a common helper function rather than the macro directly allows
to avoid repeating the error message in the code and to avoid the object
code size increase due to inlining.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v2:
 - use common readl_relaxed_poll_timeout_atomic() macro
---
 drivers/clk/samsung/clk-pll.c | 92 +++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index ac70ad7..c3c1efe 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -9,13 +9,14 @@
 #include <linux/errno.h>
 #include <linux/hrtimer.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include "clk.h"
 #include "clk-pll.h"
 
-#define PLL_TIMEOUT_MS		10
+#define PLL_TIMEOUT_US		10000U
 
 struct samsung_clk_pll {
 	struct clk_hw		hw;
@@ -63,6 +64,22 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
 	return rate_table[i - 1].rate;
 }
 
+static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
+				 unsigned int reg_mask)
+{
+	u32 val;
+	int ret;
+
+	/* Wait until the PLL is in steady locked state */
+	ret = readl_relaxed_poll_timeout_atomic(pll->con_reg, val,
+					val & reg_mask, 0, PLL_TIMEOUT_US);
+	if (ret < 0)
+		pr_err("%s: Could not lock PLL %s\n",
+		       __func__, clk_hw_get_name(&pll->hw));
+
+	return ret;
+}
+
 static int samsung_pll3xxx_enable(struct clk_hw *hw)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
@@ -241,12 +258,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
 
@@ -318,7 +332,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 					unsigned long parent_rate)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 tmp, pll_con0, pll_con1;
+	u32 pll_con0, pll_con1;
 	const struct samsung_pll_rate_table *rate;
 
 	rate = samsung_get_pll_settings(pll, drate);
@@ -356,13 +370,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -437,7 +446,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1;
-	ktime_t start;
 
 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -489,20 +497,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -588,7 +583,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate;
 	u32 con0, con1, lock;
-	ktime_t start;
 
 	/* Get required rate settings from table */
 	rate = samsung_get_pll_settings(pll, drate);
@@ -648,20 +642,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -1035,14 +1016,9 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
@@ -1132,13 +1108,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw *hw, unsigned long drate,
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

