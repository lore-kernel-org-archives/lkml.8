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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753D320716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kmm4Tfqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHKL1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:27:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43570 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgHKL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:27:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200811112701euoutp01f2876495cb4b031d4e2b37bc56d08914~qMx3psJsJ1304313043euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:27:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200811112701euoutp01f2876495cb4b031d4e2b37bc56d08914~qMx3psJsJ1304313043euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597145221;
        bh=mb3uJApwo1DYzh9StpkGFcFQ+kpnacrAYQ1U+QTV1+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmm4TfqoQ+WcKBwYNQ6/1Z7KnOnTS0Md+pwNmGo+H3oi3fMmpCw6roi+JgQEwyinT
         IwbHNyuFO7wOw+iPemR/LITXjJ869IRf6E1QJQ3utb6SRoEiQDiKVtNwuWjkNIx1bA
         JnCFD2/rI8b8JTCVL2hh+23p9C0zAs92ST4VkIYw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200811112701eucas1p16b0c9addefd5c317cf1d36e3d3874ae9~qMx3VDfPl1263112631eucas1p1X;
        Tue, 11 Aug 2020 11:27:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.D9.06456.480823F5; Tue, 11
        Aug 2020 12:27:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200811112700eucas1p28bccc0c1a9e0c37d08f5f5bcd512cf30~qMx3CjDse0422204222eucas1p2K;
        Tue, 11 Aug 2020 11:27:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200811112700eusmtrp2e37e2bbaf70a0d7a057f17c4afc0a3b5~qMx3B7nAP2089620896eusmtrp2e;
        Tue, 11 Aug 2020 11:27:00 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-2a-5f3280849289
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.B3.06017.480823F5; Tue, 11
        Aug 2020 12:27:00 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200811112700eusmtip2e9fa1b04b7188e2de2b42fec938f3d8f~qMx2jy6sQ2620926209eusmtip2G;
        Tue, 11 Aug 2020 11:27:00 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/2] clk: samsung: exynos5420: Avoid __clk_lookup() calls
 when enabling clocks
Date:   Tue, 11 Aug 2020 13:26:45 +0200
Message-Id: <20200811112645.24596-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811112645.24596-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd3WBqN4g54NTBYbZ6xntbj+5Tmr
        xceee6wWl3fNYbOYcX4fk8XaI3fZLS6ecrU4/Kad1eLftY0sFqt2/WF04PJ4f6OV3WPnrLvs
        HptWdbJ59G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV0bHgcnsBS8FKn5PaWJrYPzD28XIySEh
        YCJx9e9RNhBbSGAFo8Tkt0ldjFxA9hdGiQUrJjBBOJ8ZJeZ/aGGE6Vi34hULRGI5o8THSccY
        4Vr27FzBAlLFJmAo0Xu0D6xDREBW4taxn2wgRcwCzUwSn/ubwIqEBRIk1i39CFbEIqAqcePa
        I1YQm1fAWuLJwy42iHXyEqs3HGAGsTkFbCRe7nsMNkhCoJ1d4s6/a1A3uUh8bv/IDmELS7w6
        vgXKlpH4v3M+E0RDM6NEz+7b7BDOBEaJ+8cXQHVbS9w59wtoLAfQfZoS63fpg5gSAo4SzRs9
        IUw+iRtvBUGKmYHMSdumM0OEeSU62oQgZqhI/F41nQnClpLofvKfBcL2kFj1/g40tPoZJf4/
        3Mg8gVF+FsKuBYyMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQJTyOl/xz/tYPx6KekQ
        owAHoxIPb4G1YbwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifMa
        L3oZKySQnliSmp2aWpBaBJNl4uCUamDMenIyRfGTmEV8XWhlqPuD2wuLfr24biyZ/fPGXdcL
        PJslb2tWFnAFO06qfLd3Dt+hF7adV9YFTXjUraQ6q/6xXIjc78S41J6LvI2KwqZXqhUcDMWz
        ryepW2YGGJbW3OksfjGrdVPll0+/XuVWyceIpL3WlHq6cIr6IiYTl2NH94asda0oZVNiKc5I
        NNRiLipOBAC2W3cCHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xe7otDUbxBnOOa1tsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2Vot/1zayWKza9YfRgcvj/Y1Wdo+ds+6y
        e2xa1cnm0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkdByazF7wUqPg9pYmtgfEPbxcjJ4eEgInEuhWvWLoYuTiEBJYySvw6
        2wzkcAAlpCTmtyhB1AhL/LnWxQZR84lR4u7rTiaQBJuAoUTv0T5GEFtEQFbi1rGfYEXMAr1M
        Eu3ft7CAJIQF4iQO9ZwHK2IRUJW4ce0RK4jNK2At8eQhyFSQDfISqzccYAaxOQVsJF7uewwW
        FwKqmbbrM/MERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAgN627GfW3Ywdr0LPsQo
        wMGoxMNbYG0YL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAR01klhJN
        zgdGW15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkarYh6F+dMk
        A78lVD1b1tOV1PnmnwynxrujM9obq4WVmI4rrnRKXX0xQeummJm0beWNdevm2N2eZms5ZYbB
        MuOe+2158XpVheUTC776CSyRVtu20/FWLrtG0xUxgaUzmq77+oovfTp5zoO9TG/+/RJkj+Nh
        ddJeEtp1Ku01259nP/2jp0RNfKvEUpyRaKjFXFScCACJgNdwfgIAAA==
X-CMS-MailID: 20200811112700eucas1p28bccc0c1a9e0c37d08f5f5bcd512cf30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811112700eucas1p28bccc0c1a9e0c37d08f5f5bcd512cf30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811112700eucas1p28bccc0c1a9e0c37d08f5f5bcd512cf30
References: <20200811112645.24596-1-s.nawrocki@samsung.com>
        <CGME20200811112700eucas1p28bccc0c1a9e0c37d08f5f5bcd512cf30@eucas1p2.samsung.com>
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

Depends on patch:
[PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled

 drivers/clk/samsung/clk-exynos5420.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index bd62087..06841a6 100644
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
@@ -1649,17 +1649,18 @@ static void __init exynos5x_clk_init(struct device_node *np,
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

