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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C35020782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HVZNKte1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgHKPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:13:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50183 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgHKPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:13:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200811151304euoutp02314a1980df789036a022d4b6ad390a7e~qP3Pm4SRn0371103711euoutp020
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200811151304euoutp02314a1980df789036a022d4b6ad390a7e~qP3Pm4SRn0371103711euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597158784;
        bh=Qz+hV2GCRttQ2uizAY0tcxIPtMSHzsO775+uHnq3Kxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVZNKte1apN8RZ5jThG6UwodvLpzYevf9qB7PGrJ0hmGSqLlAWhA39hogKzXCwvNv
         vJaj6Ava5pbjXgW5Xo99Nt3LcHab2Sfbqa+H2yp+MeDG7naMwJVrp0kn1Wm+8R14/v
         C/Xs5xkyoJuzKeTvhXKffZ522U/cPHIZ4aQm3120=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200811151304eucas1p23950b7066be8aaed351107cf59a74cff~qP3PRrdzY0245302453eucas1p2H;
        Tue, 11 Aug 2020 15:13:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.47.05997.085B23F5; Tue, 11
        Aug 2020 16:13:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200811151304eucas1p2c113097f89229b51bb55329c38990830~qP3OzmPIu2075420754eucas1p2w;
        Tue, 11 Aug 2020 15:13:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200811151304eusmtrp1142d935c6c7ee63f0371c2c7a19af72c~qP3Oy6Mad0657606576eusmtrp1j;
        Tue, 11 Aug 2020 15:13:04 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-51-5f32b580f61d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.F0.06314.F75B23F5; Tue, 11
        Aug 2020 16:13:03 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200811151303eusmtip1684539202febbc9b0d0e9e3862df5b7b~qP3OUuQod3160231602eusmtip1G;
        Tue, 11 Aug 2020 15:13:03 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/2] clk: samsung: exynos5420: Avoid __clk_lookup() calls
 when enabling clocks
Date:   Tue, 11 Aug 2020 17:12:51 +0200
Message-Id: <20200811151251.31613-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811151251.31613-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd2GrUbxBs+vyVhsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2Vot/1zayWKza9YfRgcvj/Y1Wdo+ds+6y
        e2xa1cnm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBld3UvYC24JVXyY/pOlgXE7fxcjJ4eE
        gInE8VsNjF2MXBxCAisYJdZNWscK4XxhlHj8ci4zhPOZUeJO+2VGmJZL9ycwQSSWM0r8X7qf
        Da7lzoP9rCBVbAKGEr1H+8A6RARkJW4d+wlWxCzQzCTxub+JpYuRg0NYIFniz29XkBoWAVWJ
        i0efM4PYvALWErs67rBDbJOXWL3hAFicU8BG4szfm2DHSgi0s0u8/X2dGaLIReLsjGWsELaw
        xKvjW6CaZSROT+5hgWhoZpTo2X2bHcKZwChx//gCqIesJe6c+8UGchGzgKbE+l36EGFHiUuT
        37KChCUE+CRuvBUECTMDmZO2TWeGCPNKdLQJQVSrSPxeNZ0JwpaS6H7ynwWixEPi1zJPSPj0
        M0rs6HvLPIFRfhbCrgWMjKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECU8jpf8e/7GDc
        9SfpEKMAB6MSD++CiUbxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBsVbx7lr/q792qPFej9Od0L3eau2LzXN2Gsh1
        e/zfc2D7Co4Kq2OF/793mamHba6zzzyRXuz80cPXQfWSuyWHos2fJRHC/k4ii78Z1tbtl0s/
        4aZnuzu0dpZa8dmFVXu5Rdutt/x/KiQX7CTFqz3xTWHV+v5lzO6dKx7wlok7Mtb/fiZ55OwC
        JZbijERDLeai4kQA6mouPx0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7r1W43iDbquW1lsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2Vot/1zayWKza9YfRgcvj/Y1Wdo+ds+6y
        e2xa1cnm0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehld3UvYC24JVXyY/pOlgXE7fxcjJ4eEgInEpfsTmLoYuTiEBJYySmw4
        0sfaxcgBlJCSmN+iBFEjLPHnWhcbRM0nRomfG46zgiTYBAwleo/2MYLYIgKyEreO/QQrYhbo
        ZZJo/76FBSQhLJAocfdEB5jNIqAqcfHoc2YQm1fAWmJXxx12iA3yEqs3HACLcwrYSJz5exNs
        qBBQzczeU+wTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAzobcd+bt7BeGlj8CFG
        AQ5GJR7eBRON4oVYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKi
        yfnAaMsriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cA42YzL/ujj
        WbaBpq94dKcLsoUys29b4vH+zRK7Z3InLvzsuF4qOt1Y/47NZbO2lI6V9z4eLvnQK7T+MYd/
        xtOX/4UORf6b5MR+imP6OUM+M/8MAc21yxdqe2s85qsTuXe+2I5TsnFKwC//nE1/Qx0kbX2q
        ugX2cr+7ecuU+9zZ6NoKx5Q3OcJKLMUZiYZazEXFiQBh8deXfgIAAA==
X-CMS-MailID: 20200811151304eucas1p2c113097f89229b51bb55329c38990830
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811151304eucas1p2c113097f89229b51bb55329c38990830
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811151304eucas1p2c113097f89229b51bb55329c38990830
References: <20200811151251.31613-1-s.nawrocki@samsung.com>
        <CGME20200811151304eucas1p2c113097f89229b51bb55329c38990830@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a clk ID to the mout_sw_aclk_g3d clk definition so related
clk pointer gets cached in the driver's private data and can be used
later instead of a __clk_lookup() call.

With that we have all clocks used in the clk_prepare_enable() calls in the
clk provider init callback cached in clk_data.hws[] and we can reference
the clk pointers directly rather than using __clk_lookup() with global names.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v2:
 - added missing part of the patch lost during rebase of the previous version
---
 drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index bd62087..f76ebd6 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -712,8 +712,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 			SRC_TOP12, 8, 1),
 	MUX(0, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
 			SRC_TOP12, 12, 1),
-	MUX_F(0, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1,
-	      CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_SW_ACLK_G3D, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p,
+			SRC_TOP12, 16, 1, CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
 			SRC_TOP12, 20, 1),
 	MUX(CLK_MOUT_SW_ACLK300, "mout_sw_aclk300_disp1",
@@ -1560,6 +1560,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		enum exynos5x_soc soc)
 {
 	struct samsung_clk_provider *ctx;
+	struct clk_hw **hws;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -1649,17 +1650,18 @@ static void __init exynos5x_clk_init(struct device_node *np,
 				     exynos5x_subcmus);
 	}
 
+	hws = ctx->clk_data.hws;
 	/*
 	 * Keep top part of G3D clock path enabled permanently to ensure
 	 * that the internal busses get their clock regardless of the
 	 * main G3D clock enablement status.
 	 */
-	clk_prepare_enable(__clk_lookup("mout_sw_aclk_g3d"));
+	clk_prepare_enable(hws[CLK_MOUT_SW_ACLK_G3D]->clk);
 	/*
 	 * Keep top BPLL mux enabled permanently to ensure that DRAM operates
 	 * properly.
 	 */
-	clk_prepare_enable(__clk_lookup("mout_bpll"));
+	clk_prepare_enable(hws[CLK_MOUT_BPLL]->clk);
 
 	samsung_clk_of_add_provider(np, ctx);
 }
-- 
2.7.4

