Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1111B2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NgAaYx9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgE2Qcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33806 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgE2Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163229euoutp02ce8546b6a66533c2b34266886d4a9f30~TjNcotokx1718617186euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529163229euoutp02ce8546b6a66533c2b34266886d4a9f30~TjNcotokx1718617186euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769949;
        bh=R2nTxZ8Vk3NOcRJ/akm3wcxThuA94Et9AZ9J5chxdR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgAaYx9Yx56xTVFv/HSuWuwmq3DdZChsD42wxZXC1Fecjm8Ez01/ivrAcSvT+0W+b
         T/5HyykFcLYxynHAm2VxIEaNDR7EozABMNruY6+ZHsweGBBg2+HTnXynR3RqSs33HA
         3b/SdGgzYbuRA3ifyU9Et90EdjJYJ+7loTKCO8jA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529163228eucas1p2445ecd81aba2c451d05fb1165ec7f3c2~TjNcOMMr61961119611eucas1p2b;
        Fri, 29 May 2020 16:32:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.BB.60679.C1931DE5; Fri, 29
        May 2020 17:32:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163228eucas1p1d05340fef9ffc724f5d3d9f5709a600f~TjNbuigW02226622266eucas1p1G;
        Fri, 29 May 2020 16:32:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529163228eusmtrp14a2cff2cbc8cfe598faf1d864cee31b4~TjNbt9zd_2579525795eusmtrp1K;
        Fri, 29 May 2020 16:32:28 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-14-5ed1391cdf7a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.25.07950.C1931DE5; Fri, 29
        May 2020 17:32:28 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163227eusmtip1bf2e39c4ee8804bf947d863379c12603~TjNbAGEEL2038020380eusmtip1b;
        Fri, 29 May 2020 16:32:27 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 5/6] ARM: dts: exynos: Add interconnects to
 Exynos4412 mixer
Date:   Fri, 29 May 2020 18:31:59 +0200
Message-Id: <20200529163200.18031-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87oylhfjDKb2q1rcn9fKaLFxxnpW
        i+tfnrNaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW9xuXMFm
        cfhNO6vFjMkv2Rz4PDat6mTzuHNtD5vH/e7jTB6bl9R79G1ZxejxeZNcAFsUl01Kak5mWWqR
        vl0CV0bbqpiCbo6KLdPfMjYw3mfrYuTkkBAwkZje38TaxcjFISSwglHi9rRljBDOF0aJqZdu
        QWU+M0qcaXvCDtMy82o7E0RiOaPEgt0XmeBaLv86zgJSxSZgKNF7tI8RxBYRcJFoezqPBaSI
        WWAPk8S+2e/AioQFQiW+/voOVsQioCrxe2Yv2ApeAWuJO0t3M0Ksk5dYveEAM4jNKWAj0f1n
        BjNEjaDEyZlPwOYwA9U0b53NDLJAQuAWu8T5h9uhml0kFl/fDvWqsMSr41ugfpCROD25hwWi
        oZlRomf3bXYIZwKjxP3jC6C6gc449wuomwNohabE+l36EGFHiZY7bewgYQkBPokbbwUhjuCT
        mLRtOjNEmFeio00IolpF4veq6UwQtpRE95P/LBC2h8S+/U8ZJzAqzkLyziwk78xC2LuAkXkV
        o3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYPI6/e/4lx2Mu/4kHWIU4GBU4uGt0LoYJ8Sa
        WFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YW
        pBbBZJk4OKUaGEN7zmbPDnNZ7rfp2ELDupn2jMJt7T3XM9/5+oul7eCNPcXMmH71/m0NeUlu
        69yjKrKvVZo2hT/zz3l6zO5qY41ErdyLthdX/r7zSFXTZthhutdSUtsmdedh1srWsEWr4p7r
        G3Xxz2y0KGbg0TebUB8np/9h9YI1O39yfwjesHJSAs+i+ur5SizFGYmGWsxFxYkA0juTSVoD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7oylhfjDE7uZLO4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYy2VTEF3RwVW6a/ZWxg
        vM/WxcjJISFgIjHzajtTFyMXh5DAUkaJJZPvAiU4gBJSEvNblCBqhCX+XOtig6j5xCjxacEr
        RpAEm4ChRO/RPjBbRMBD4lTrWlaQImaBE0wST3o3gm0QFgiWeDDzNyuIzSKgKvF7Zi87iM0r
        YC1xZ+luRogN8hKrNxxgBrE5BWwkuv/MALOFgGraHs9ihagXlDg58wkLyHHMAuoS6+cJgYSZ
        gVqbt85mnsAoOAtJ1SyEqllIqhYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMZtx35u
        2cHY9S74EKMAB6MSD+8FnYtxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7E
        aAr02kRmKdHkfGCiyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnV
        wKggfNR7/70FOQ1Hqpdt9zj4cPluX740pqfSE5y2XhFaku4WcOHabKe/R6qFTCuOuO5ZIbhC
        Jt7V9KHerdDoFa5fWbQ6Kp+7rq3QcGI60RKwU/uUW7joVQMmSdmD78W5glwyrjOmBs6Y2DKn
        tOrc3j9Xzqu9z66+FvjinI6T+VHd88bb2oU7BJVYijMSDbWYi4oTAeYuJA3cAgAA
X-CMS-MailID: 20200529163228eucas1p1d05340fef9ffc724f5d3d9f5709a600f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163228eucas1p1d05340fef9ffc724f5d3d9f5709a600f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163228eucas1p1d05340fef9ffc724f5d3d9f5709a600f
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163228eucas1p1d05340fef9ffc724f5d3d9f5709a600f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch adds an 'interconnects' property to Exynos4412 DTS in order to
declare the interconnect path used by the mixer. Please note that the
'interconnect-names' property is not needed when there is only one path in
'interconnects', in which case calling of_icc_get() with a NULL name simply
returns the right path.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes for v5:
 - none.
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index a7496d3..eee86d2 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -776,6 +776,7 @@
 	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
 	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
 };
 
 &pmu {
-- 
2.7.4

