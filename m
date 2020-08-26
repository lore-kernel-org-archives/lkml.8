Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF302080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m+XqbdUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHZRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:16:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55441 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:15:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826171553euoutp016df3e17e8d72ca4f12b837f2a4eecce7~u4Nv-OD_i1318813188euoutp01G
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 17:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826171553euoutp016df3e17e8d72ca4f12b837f2a4eecce7~u4Nv-OD_i1318813188euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598462153;
        bh=fKIuwKFeT9zSibTNKAwdoCGoX7KTA5WkyoSjB9OenCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+XqbdUahk0pIcWaCRz/BFdaQkJR6SpDceQLHpU6bnu7oDFrk1+30rNIo14Q8jooc
         Z8lsIq+lq6GgPFPcIaNfdlRNLWhONu1P1ET10lM5wtds85zBPwI7h1UTbjbg+n9kiA
         OcCersVhcsN5bBefaZpuFxxGtaPkcuKJ/NpaamvM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826171552eucas1p2bff3aacf8ed7f544377ffaaf2110880d~u4Nvjb0CZ0758607586eucas1p2P;
        Wed, 26 Aug 2020 17:15:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.95.06456.8C8964F5; Wed, 26
        Aug 2020 18:15:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08~u4NvECRAE0562605626eucas1p2W;
        Wed, 26 Aug 2020 17:15:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826171552eusmtrp1f1b81e24af4fdd89efb482aec1afb9f8~u4NvDLk4H0677906779eusmtrp12;
        Wed, 26 Aug 2020 17:15:52 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-b1-5f4698c8c36d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.0E.06017.8C8964F5; Wed, 26
        Aug 2020 18:15:52 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200826171551eusmtip153cd029b426f6ae84f64bc754d16ddab~u4NucIc_w0053800538eusmtip1h;
        Wed, 26 Aug 2020 17:15:51 +0000 (GMT)
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
Subject: [PATCH 2/3] clk: samsung: exynos5420/5250: Add IDs to the CPU
 parent clk definitions
Date:   Wed, 26 Aug 2020 19:15:28 +0200
Message-Id: <20200826171529.23618-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826171529.23618-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7onZrjFG1z7rWOxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BYXT7latO49wm5x
        +E07q8W/axtZLFbt+sPowO/x/kYru8fOWXfZPTat6mTz2Lyk3qNvyypGj8+b5ALYorhsUlJz
        MstSi/TtErgy9i+5wF7wTajiXOMltgbGr/xdjJwcEgImErf33WXqYuTiEBJYwShx98lbKOcL
        o8SKl/uZIZzPjBJzL78BynCAtcz+xg4RX84o8evID0aQUWAdU7b6gdhsAoYSvUf7wOIiArIS
        t479ZANpYBb4yizRteUTE0hCWCBeYvXj1awgNouAqkTHwidgcV4Ba4krD2YwQdwnL7F6wwFm
        EJtTwEbi19KzYBdJCGxilzjxaQUzRJGLxK1F89ggbGGJV8e3sEPYMhKnJ/ewQDQ0M0r07L7N
        DuFMYJS4f3wBI0SVtcSdc7/YQH5jFtCUWL9LHyLsKPGs7R4LxMt8EjfeCoKEmYHMSdumM0OE
        eSU62oQgqlUkfq+aDnWzlET3k/8sELaHRMOk09DQ6meUuP3lMNsERvlZCMsWMDKuYhRPLS3O
        TU8tNsxLLdcrTswtLs1L10vOz93ECEw+p/8d/7SD8eulpEOMAhyMSjy8GvFu8UKsiWXFlbmH
        GCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJ
        g1OqgVFRWa9gzrOeyKzCNben1F7cmaCy7Mpy2RiWtZNXd+WFz9v6RGbz6bKan1mz7sRO3H5Y
        gz1NL+D7id3pWlun2xesL9OebfzYd/vSuwpbOK9YBy5K1f1x/bX04iAFL6snV+4w/iyqDql+
        +Ey/Mu5q8fnMJ9eVTu056+iQwti6u9+idk5Cj8r+/feUWIozEg21mIuKEwGCo4W8OgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Xd0TM9ziDS6s47XYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Sx9shddouLp1wtWvceYbc4
        /Kad1eLftY0sFqt2/WF04Pd4f6OV3WPnrLvsHptWdbJ5bF5S79G3ZRWjx+dNcgFsUXo2Rfml
        JakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ+5dcYC/4JlRx
        rvESWwPjV/4uRg4OCQETidnf2LsYuTiEBJYySjz/9YwRIi4lMb9FqYuRE8gUlvhzrYsNouYT
        o8SqS5uZQRJsAoYSvUf7GEFsEQFZiVvHfoIVMQs0skicnbiGFWSQsECsRM/LBJAaFgFViY6F
        T5hAbF4Ba4krD2YwQSyQl1i94QDYTE4BG4lfS8+C2UJANXc232KdwMi3gJFhFaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmAcbDv2c8sOxq53wYcYBTgYlXh4NeLd4oVYE8uKK3MPMUpwMCuJ
        8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnAGM0riTc0NTS3sDQ0NzY3NrNQEuft
        EDgYIySQnliSmp2aWpBaBNPHxMEp1cDoZsnO+v+3ymnZD0phZSvyBdmMUrYob5c4u5XHq/O3
        TqRSf0XviwK+1DdiW3KWJLybLfyr99m/dW92N01Oj+D6tiZ4yzPb4rtWTH0PTy3ZnBPHuHoJ
        d27NwtdhzC8mv7ux5emFvtlllyY18U/xv/cvqzvrkm26wYrKCyE1b2auqOO3qircLZOuxFKc
        kWioxVxUnAgAjRux0JkCAAA=
X-CMS-MailID: 20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08
References: <20200826171529.23618-1-s.nawrocki@samsung.com>
        <CGME20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use non-zero clock IDs in definitions of the CPU parent clocks
for exynos5420, exynos5250 SoCs. This will allow us to reference
the parent clocks directly in the driver by cached struct clk_hw
pointers, rather than doing clk lookup by name.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |  4 ++--
 drivers/clk/samsung/clk-exynos5420.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 931c70a..7bcff76 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -253,14 +253,14 @@ static const struct samsung_mux_clock exynos5250_mux_clks[] __initconst = {
 	/*
 	 * CMU_CPU
 	 */
-	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+	MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 					CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
 
 	/*
 	 * CMU_CORE
 	 */
-	MUX(0, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
+	MUX(CLK_MOUT_MPLL, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
 
 	/*
 	 * CMU_TOP
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index f76ebd6..d07cee2 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -596,13 +596,14 @@ static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
 static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(0, "mout_user_pclk66_gpio", mout_user_pclk66_gpio_p,
 			SRC_TOP7, 4, 1),
-	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
-
-	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+	MUX(CLK_MOUT_MSPLL_KFC, "mout_mspll_kfc", mout_mspll_cpu_p,
+	    SRC_TOP7, 8, 2),
+	MUX(CLK_MOUT_MSPLL_CPU, "mout_mspll_cpu", mout_mspll_cpu_p,
+	    SRC_TOP7, 12, 2),
+	MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
-	MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
+	MUX_F(CLK_MOUT_KPLL, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
 	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
 	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
-- 
2.7.4

