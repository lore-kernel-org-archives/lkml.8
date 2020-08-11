Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB46C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC0720782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kIG1M8fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgHKPNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:13:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50152 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:13:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200811151259euoutp0248871dca3313183ed29b1acf4599bbe0~qP3K6_kSL0371103711euoutp02w
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:12:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200811151259euoutp0248871dca3313183ed29b1acf4599bbe0~qP3K6_kSL0371103711euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597158779;
        bh=gacXBuln4oGWnyT4m4WiEPmqSVavwuGzS9Pg8D+Y3KI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kIG1M8fOqbQEgPh//QbObK8crnbqJoOt16VfF2GuxK/CccjljP6FIp6HU4GcpEB2G
         oJEYB4wa8gD2C2aqvgqIYwNy+n55XH9RzzuY/Ps4WH9Oic4e042kd4UrtpOa16Hed8
         qdsvkO4K6CBCnLOK3APPX+zWBe5s25jvJz+j04dg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200811151259eucas1p157d758c20a7780fdb04984f13b15af01~qP3KngQBt2259822598eucas1p1H;
        Tue, 11 Aug 2020 15:12:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.47.05997.B75B23F5; Tue, 11
        Aug 2020 16:12:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200811151259eucas1p19d1f6a21e46ac9382a89cd3d3cb0b6c8~qP3KS6FBt3049230492eucas1p1_;
        Tue, 11 Aug 2020 15:12:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200811151259eusmtrp14d9a5a366111308363f3e66fd4d9324f~qP3KSPGBv0657606576eusmtrp1S;
        Tue, 11 Aug 2020 15:12:59 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-42-5f32b57b63f7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.F0.06314.B75B23F5; Tue, 11
        Aug 2020 16:12:59 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200811151258eusmtip1b8a1ea51e78d8003e6696c8f72839ad4~qP3JwOT_l3252832528eusmtip1t;
        Tue, 11 Aug 2020 15:12:58 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 1/2] clk: samsung: exynos5420: Add definition of clock ID
 for mout_sw_aclk_g3d
Date:   Tue, 11 Aug 2020 17:12:50 +0200
Message-Id: <20200811151251.31613-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87rVW43iDRadl7TYOGM9q8X1L89Z
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvF4TftrBb/rm1ksVi16w+jA5fH+xut7B47Z91l
        99i0qpPNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDIm3znAXHCMreLSp5IGxlOsXYycHBIC
        JhJdX98B2VwcQgIrGCXOTNrCBOF8YZS49PccC4TzmVHi2uu7jDAtF242QbUsZ5SY1PWEDa7l
        y/l5TCBVbAKGEr1H+8A6RARkJW4d+wlWxCzQzCTxub+JBSQhLJAscb+1A6yBRUBV4umXZ2wg
        Nq+AtcSmHVfYIdbJS6zecIAZwn7PJnFmVwaE7SKxb/4kJghbWOLV8S1Q9TISpyf3gN0tIdDM
        KNGz+zY7hDOBUeL+8QVQT1hL3Dn3C2gbB9BJmhLrd+lDhB0ltl66xwoSlhDgk7jxVhAkzAxk
        Tto2nRkizCvR0SYEUa0i8XvVdKgTpCS6n/xngbA9JNr2rwOzhQRiJR5Ne8w4gVFuFsKuBYyM
        qxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQITxel/x7/sYNz1J+kQowAHoxIP74KJRvFC
        rIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZq
        akFqEUyWiYNTqoFRdfsxG/0dkw5cnrpY1/KuR8pbdtvF00zbl3LUNja8O62359Wui+fNDk5t
        +hf84WiTU3+Iscyrsis7/ru/fvLe0ayQ32lG0uqlV87kC1Y4R7IHvXuh//LFw68fU7O5Va+p
        n1U+cjVcTqVC7Ub2LL5qvvju1HPcJ2cW/zFjdHR9MN1NuXehS+d9JZbijERDLeai4kQAZP2x
        vhADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xu7rVW43iDXZ/ZrXYOGM9q8X1L89Z
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvF4TftrBb/rm1ksVi16w+jA5fH+xut7B47Z91l
        99i0qpPNo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DIm3znAXHCMreLSp5IGxlOsXYycHBICJhIXbjYB2VwcQgJLGSU2bf7C
        3MXIAZSQkpjfogRRIyzx51oXG4gtJPCJUWLBaVUQm03AUKL3aB8jiC0iICtx69hPNpA5zAK9
        TBLt37ewgCSEBRIlFrW2MIHYLAKqEk+/PAMbxCtgLbFpxxV2iAXyEqs3HGCewMizgJFhFaNI
        amlxbnpusaFecWJucWleul5yfu4mRmBwbjv2c/MOxksbgw8xCnAwKvHwLphoFC/EmlhWXJl7
        iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDIyevJN7Q1NDcwtLQ3Njc
        2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPj5LlJ/Ec8j0s63zm57rCviEHlodXbF0Zt
        jiz/Jrln4QuZBNezda89uWc/fCKauPrRRMPAT9uuG/FYPF9b9H+BqNXy/bWLnb3NJt69N2nS
        V9bLx06qHHt9dH0hC/8cAwHRzYGFxxo7BWtmiL1YydD7SXhX+5Nb67dczl/kXcEb/qLgFNeT
        4z/77ZRYijMSDbWYi4oTAef0sixkAgAA
X-CMS-MailID: 20200811151259eucas1p19d1f6a21e46ac9382a89cd3d3cb0b6c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811151259eucas1p19d1f6a21e46ac9382a89cd3d3cb0b6c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811151259eucas1p19d1f6a21e46ac9382a89cd3d3cb0b6c8
References: <CGME20200811151259eucas1p19d1f6a21e46ac9382a89cd3d3cb0b6c8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ID for the mout_sw_aclk_g3d (SW_CLKMUX_ACLK_G3D) clock,
mostly for internal use in the CMU driver. It will allow to avoid the
__clk_lookup() call when setting up the clock during the clock provider
initialization.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 02d5ac4..ff917c8 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -230,6 +230,7 @@
 #define CLK_MOUT_USER_MAU_EPLL	659
 #define CLK_MOUT_SCLK_SPLL	660
 #define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
+#define CLK_MOUT_SW_ACLK_G3D	662
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
2.7.4

