Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BC6206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eqnN+jgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHZRQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:16:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55466 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHZRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:16:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826171558euoutp01ad084ff1f3344bc78b6bd02d0c4e2a91~u4N0pfIrG1113311133euoutp01v
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 17:15:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826171558euoutp01ad084ff1f3344bc78b6bd02d0c4e2a91~u4N0pfIrG1113311133euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598462158;
        bh=RxDUEZhTgTZLzG9DMWoYoQ5hya6u+BHoB4EoxDqSuFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqnN+jgcbJG8nDHBQ0iaCHMyirgwF02LokHJbCiRddC3ydfIbkMZM4TwznXDw8+Cx
         O1Nj6t3chRhf7HZAlGhbAWDPlaeKQB8M7tAwB9iyi8dAia+w5stBXgjaiYcEIsFKIq
         z1MAyC2Wa64Y3ANIFsIcyVUctqgCjJyIjJUcG7p0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200826171557eucas1p1864bf2eb479deef8cb35fb6896ff3c06~u4N0G9wAk1333013330eucas1p1Z;
        Wed, 26 Aug 2020 17:15:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.A5.06456.DC8964F5; Wed, 26
        Aug 2020 18:15:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39~u4Nzy2lcc1338413384eucas1p1U;
        Wed, 26 Aug 2020 17:15:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826171557eusmtrp21a09873186da79dc19061299ba07e422~u4NzyFJ170949209492eusmtrp2C;
        Wed, 26 Aug 2020 17:15:57 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-ba-5f4698cd7a32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.4C.06314.DC8964F5; Wed, 26
        Aug 2020 18:15:57 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200826171556eusmtip19fde2d31ddd702dcf329a3c2df3dbb2c~u4NzF61qg3051230512eusmtip1i;
        Wed, 26 Aug 2020 17:15:56 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 3/3] clk: samsung: Use cached clk_hws instead of
 __clk_lookup() calls
Date:   Wed, 26 Aug 2020 19:15:29 +0200
Message-Id: <20200826171529.23618-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826171529.23618-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7pnZ7jFG1z8oWqxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BYXT7latO49wm5x
        +E07q8W/axtZLFbt+sPowO/x/kYru8fOWXfZPTat6mTz2Lyk3qNvyypGj8+b5ALYorhsUlJz
        MstSi/TtErgy1n7awl4wO7Ti4LP/zA2Mv927GDk5JARMJPZ2zmPrYuTiEBJYwSgxYdYkKOcL
        o8SbpRsYIZzPjBK/Li1khWm5/WwGE4gtJLCcUWLPFku4jh1bd7ODJNgEDCV6j/YxgtgiArIS
        t479BBvLLPCVWaJryyewbmGBcImlVyezgNgsAqoSU998BLN5Bawlviw7xwixTV5i9YYDzCA2
        p4CNxK+lZ5lBBkkIbGKXuNTXAFXkIvH63DFmCFtY4tXxLewQtozE/53zmSAamhklenbfZodw
        JjBK3D++AKrbWuLOuV9A93EA3acpsX6XPkTYUWJe60EWkLCEAJ/EjbeCIGFmIHPStunMEGFe
        iY42IYhqFYnfq6YzQdhSEt1P/rNA2B4SX+bcYIGEUD+jxMEPVxknMMrPQli2gJFxFaN4amlx
        bnpqsWFearlecWJucWleul5yfu4mRmD6Of3v+KcdjF8vJR1iFOBgVOLh1Yh3ixdiTSwrrsw9
        xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJM
        HJxSDYxsK4tWNjgk3U4++DHxUsfNozH62TePnHoyd03JlYumLqvkDHItMkOfRk2/Uyd0i8Wr
        UF3cedL+JKN7JrPXPj+66FS4NQ97VrBcxYvV7BES+nm8txPz4ncxnW07weWn9ZlbQYPPZe39
        VRHL2RcURQVdju46bZXSH1N6rMj/3Xv7WVuFc+LmbVZiKc5INNRiLipOBAAYL8bqOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd2zM9ziDWZ+4bHYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Sx9shddouLp1wtWvceYbc4
        /Kad1eLftY0sFqt2/WF04Pd4f6OV3WPnrLvsHptWdbJ5bF5S79G3ZRWjx+dNcgFsUXo2Rfml
        JakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZaz9tYS+YHVpx
        8Nl/5gbG3+5djJwcEgImErefzWDqYuTiEBJYyijR07YUyOEASkhJzG9RgqgRlvhzrYsNouYT
        o8SyVW0sIAk2AUOJ3qN9jCC2iICsxK1jP8GKmAUaWSTOTlzDCpIQFgiV2PDpBRuIzSKgKjH1
        zUewZl4Ba4kvy84xQmyQl1i94QAziM0pYCPxa+lZMFsIqObO5lusExj5FjAyrGIUSS0tzk3P
        LTbUK07MLS7NS9dLzs/dxAiMhW3Hfm7ewXhpY/AhRgEORiUeXo14t3gh1sSy4srcQ4wSHMxK
        IrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BTpqIrOUaHI+ME7zSuINTQ3NLSwNzY3Njc0slMR5
        OwQOxggJpCeWpGanphakFsH0MXFwSjUw2l5//LdJmP3XqUdHud/KxZyIZzOJuh6d/jH+t6lo
        JdPnWUXqJ4pf/jdWsuFlvLuprftuRM2FHw/Zkwp7JXNcg//P61JI/Bp4Od7v0Yf3R9er8Z+c
        /XY1f8Znnzt7eXvb1R/+9vQvKaz7OlFcpP/UppdL/d/umXd9xsy4qY+dEvVjE2SEejb+VGIp
        zkg01GIuKk4EAMVdmWCbAgAA
X-CMS-MailID: 20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39
References: <20200826171529.23618-1-s.nawrocki@samsung.com>
        <CGME20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the CPU clock registration two parent clocks are required, these
are now being passed as struct clk_hw pointers, rather than by the
global scope names. That allows us to avoid  __clk_lookup() calls
and simplifies a bit the CPU clock registration function.
While at it drop unneeded extern keyword in the function declaration.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c        | 37 +++++++++++++++---------------------
 drivers/clk/samsung/clk-cpu.h        |  6 +++---
 drivers/clk/samsung/clk-exynos3250.c |  6 ++++--
 drivers/clk/samsung/clk-exynos4.c    |  7 +++++--
 drivers/clk/samsung/clk-exynos5250.c |  4 +++-
 drivers/clk/samsung/clk-exynos5420.c |  6 +++---
 drivers/clk/samsung/clk-exynos5433.c | 10 ++++++++--
 7 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index efc4fa6..00ef4d1 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -401,26 +401,34 @@ static int exynos5433_cpuclk_notifier_cb(struct notifier_block *nb,
 
 /* helper function to register a CPU clock */
 int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
-		unsigned int lookup_id, const char *name, const char *parent,
-		const char *alt_parent, unsigned long offset,
-		const struct exynos_cpuclk_cfg_data *cfg,
+		unsigned int lookup_id, const char *name,
+		const struct clk_hw *parent, const struct clk_hw *alt_parent,
+		unsigned long offset, const struct exynos_cpuclk_cfg_data *cfg,
 		unsigned long num_cfgs, unsigned long flags)
 {
 	struct exynos_cpuclk *cpuclk;
 	struct clk_init_data init;
-	struct clk *parent_clk;
+	const char *parent_name;
 	int ret = 0;
 
+	if (IS_ERR(parent) || IS_ERR(alt_parent)) {
+		pr_err("%s: invalid parent clock(s)\n", __func__);
+		return -EINVAL;
+	}
+
 	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
 	if (!cpuclk)
 		return -ENOMEM;
 
+	parent_name = clk_hw_get_name(parent);
+
 	init.name = name;
 	init.flags = CLK_SET_RATE_PARENT;
-	init.parent_names = &parent;
+	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.ops = &exynos_cpuclk_clk_ops;
 
+	cpuclk->alt_parent = alt_parent;
 	cpuclk->hw.init = &init;
 	cpuclk->ctrl_base = ctx->reg_base + offset;
 	cpuclk->lock = &ctx->lock;
@@ -430,23 +438,8 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	else
 		cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
 
-	cpuclk->alt_parent = __clk_get_hw(__clk_lookup(alt_parent));
-	if (!cpuclk->alt_parent) {
-		pr_err("%s: could not lookup alternate parent %s\n",
-				__func__, alt_parent);
-		ret = -EINVAL;
-		goto free_cpuclk;
-	}
-
-	parent_clk = __clk_lookup(parent);
-	if (!parent_clk) {
-		pr_err("%s: could not lookup parent clock %s\n",
-				__func__, parent);
-		ret = -EINVAL;
-		goto free_cpuclk;
-	}
 
-	ret = clk_notifier_register(parent_clk, &cpuclk->clk_nb);
+	ret = clk_notifier_register(parent->clk, &cpuclk->clk_nb);
 	if (ret) {
 		pr_err("%s: failed to register clock notifier for %s\n",
 				__func__, name);
@@ -471,7 +464,7 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 free_cpuclk_data:
 	kfree(cpuclk->cfg);
 unregister_clk_nb:
-	clk_notifier_unregister(parent_clk, &cpuclk->clk_nb);
+	clk_notifier_unregister(parent->clk, &cpuclk->clk_nb);
 free_cpuclk:
 	kfree(cpuclk);
 	return ret;
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index ad38cc2..af74686 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -46,7 +46,7 @@ struct exynos_cpuclk_cfg_data {
  */
 struct exynos_cpuclk {
 	struct clk_hw				hw;
-	struct clk_hw				*alt_parent;
+	const struct clk_hw			*alt_parent;
 	void __iomem				*ctrl_base;
 	spinlock_t				*lock;
 	const struct exynos_cpuclk_cfg_data	*cfg;
@@ -62,9 +62,9 @@ struct exynos_cpuclk {
 #define CLK_CPU_HAS_E5433_REGS_LAYOUT	(1 << 2)
 };
 
-extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
+int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 			unsigned int lookup_id, const char *name,
-			const char *parent, const char *alt_parent,
+			const struct clk_hw *parent, const struct clk_hw *alt_parent,
 			unsigned long offset,
 			const struct exynos_cpuclk_cfg_data *cfg,
 			unsigned long num_cfgs, unsigned long flags);
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 17897c7..17df7f9 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -808,14 +808,16 @@ static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
 static void __init exynos3250_cmu_init(struct device_node *np)
 {
 	struct samsung_clk_provider *ctx;
+	struct clk_hw **hws;
 
 	ctx = samsung_cmu_register_one(np, &cmu_info);
 	if (!ctx)
 		return;
 
+	hws = ctx->clk_data.hws;
 	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_core_p[0], mout_core_p[1], 0x14200,
-			e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
+			hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL_USER_C],
+			0x14200, e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
 			CLK_CPU_HAS_DIV1);
 
 	exynos3_core_down_clock(ctx->reg_base);
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 51564fc..436fcd2 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1233,6 +1233,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc soc)
 {
 	struct samsung_clk_provider *ctx;
+	struct clk_hw **hws;
+
 	exynos4_soc = soc;
 
 	reg_base = of_iomap(np, 0);
@@ -1240,6 +1242,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 		panic("%s: failed to map registers\n", __func__);
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
@@ -1302,7 +1305,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 			exynos4210_fixed_factor_clks,
 			ARRAY_SIZE(exynos4210_fixed_factor_clks));
 		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_core_p4210[0], mout_core_p4210[1], 0x14200,
+			hws[CLK_MOUT_APLL], hws[CLK_SCLK_MPLL], 0x14200,
 			e4210_armclk_d, ARRAY_SIZE(e4210_armclk_d),
 			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
 	} else {
@@ -1317,7 +1320,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4x12_fixed_factor_clks));
 
 		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_core_p4x12[0], mout_core_p4x12[1], 0x14200,
+			hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL_USER_C], 0x14200,
 			e4412_armclk_d, ARRAY_SIZE(e4412_armclk_d),
 			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
 	}
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 7bcff76..06588fa 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -782,6 +782,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 {
 	struct samsung_clk_provider *ctx;
 	unsigned int tmp;
+	struct clk_hw **hws;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -792,6 +793,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	}
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
@@ -821,7 +823,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
 	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL], 0x200,
 			exynos5250_armclk_d, ARRAY_SIZE(exynos5250_armclk_d),
 			CLK_CPU_HAS_DIV1);
 
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index d07cee2..ba4e0a4 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1625,15 +1625,15 @@ static void __init exynos5x_clk_init(struct device_node *np,
 
 	if (soc == EXYNOS5420) {
 		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			hws[CLK_MOUT_APLL], hws[CLK_MOUT_MSPLL_CPU], 0x200,
 			exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
 	} else {
 		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			hws[CLK_MOUT_APLL], hws[CLK_MOUT_MSPLL_CPU], 0x200,
 			exynos5800_eglclk_d, ARRAY_SIZE(exynos5800_eglclk_d), 0);
 	}
 	exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
-		mout_kfc_p[0], mout_kfc_p[1], 0x28200,
+		hws[CLK_MOUT_KPLL], hws[CLK_MOUT_MSPLL_KFC],  0x28200,
 		exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0);
 
 	samsung_clk_extended_sleep_init(reg_base,
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 6f29ecd..f203074 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -3679,6 +3679,7 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	struct samsung_clk_provider *ctx;
+	struct clk_hw **hws;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -3701,8 +3702,10 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, apollo_gate_clks,
 				  ARRAY_SIZE(apollo_gate_clks));
 
+	hws = ctx->clk_data.hws;
+
 	exynos_register_cpu_clock(ctx, CLK_SCLK_APOLLO, "apolloclk",
-		mout_apollo_p[0], mout_apollo_p[1], 0x200,
+		hws[CLK_MOUT_APOLLO_PLL], hws[CLK_MOUT_BUS_PLL_APOLLO_USER], 0x200,
 		exynos5433_apolloclk_d, ARRAY_SIZE(exynos5433_apolloclk_d),
 		CLK_CPU_HAS_E5433_REGS_LAYOUT);
 
@@ -3933,6 +3936,7 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	struct samsung_clk_provider *ctx;
+	struct clk_hw **hws;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -3955,8 +3959,10 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, atlas_gate_clks,
 				  ARRAY_SIZE(atlas_gate_clks));
 
+	hws = ctx->clk_data.hws;
+
 	exynos_register_cpu_clock(ctx, CLK_SCLK_ATLAS, "atlasclk",
-		mout_atlas_p[0], mout_atlas_p[1], 0x200,
+		hws[CLK_MOUT_ATLAS_PLL], hws[CLK_MOUT_BUS_PLL_ATLAS_USER], 0x200,
 		exynos5433_atlasclk_d, ARRAY_SIZE(exynos5433_atlasclk_d),
 		CLK_CPU_HAS_E5433_REGS_LAYOUT);
 
-- 
2.7.4

