Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD0C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07492253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s/8kj1l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUHFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:05:23 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45364 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:05:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121070521euoutp0218e5e50de91459f5c00fe348da581857~r1QcnFjO72351723517euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:05:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121070521euoutp0218e5e50de91459f5c00fe348da581857~r1QcnFjO72351723517euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579590321;
        bh=jz6YdJe+9oiv3h/P57nB26DlekL22/ed76FQBVgaSrY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=s/8kj1l7tfs2HhdCctTtxpgpPHXDVKLe1BqaH/X3xHeuwYn266LNYVFpurUt0klUP
         8G430K+qe/QDCh1GQwG3qpQApxcn5lbGj3TLLeKTtZ5PruCm0vIo/m1RFnY7YPeChQ
         Q0PootTQZfF/W1y+PWUaW7prKeK/avWkAtDu0OHI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200121070520eucas1p1661b2a62ef7419e85b38bb21dcf6e19f~r1QcLwOsC0793607936eucas1p1M;
        Tue, 21 Jan 2020 07:05:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.57.60679.0B2A62E5; Tue, 21
        Jan 2020 07:05:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da~r1Qb1Vxbf3176231762eucas1p23;
        Tue, 21 Jan 2020 07:05:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121070520eusmtrp28b76c75abbbe60b93670cba358a3f8f2~r1Qb0rSk31202912029eusmtrp2C;
        Tue, 21 Jan 2020 07:05:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-e8-5e26a2b00467
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.45.07950.0B2A62E5; Tue, 21
        Jan 2020 07:05:20 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200121070519eusmtip2238a581f3dbd3c7f444f819c61f486ec~r1QbcZOYR2994429944eusmtip2Q;
        Tue, 21 Jan 2020 07:05:19 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2] ARM: dts: exynos: Add GPU thermal zone cooling maps for
 Odroid XU3/XU4/HC1
Date:   Tue, 21 Jan 2020 08:05:10 +0100
Message-Id: <20200121070510.31520-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7djPc7obFqnFGcx5JGWxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+QuuwObx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fA
        lbH+51vmgocSFXMf7GNtYPwq2MXIySEhYCLxuOEDcxcjF4eQwApGiek/t7NBOF8YJe6sv8UM
        UiUk8JlR4tgDEZiOtqa/UEXLGSWeT/zAAtdxsO0MO0gVm4ChRNfbLjYQW0TAWaJhaiMTSBGz
        wDZGidcLZoIVCQskSJyesIaxi5GDg0VAVaJtJlg9r4CtxOMntxkhtslLrN5wAOw+CYEDbBJt
        d14yQyRcJLZObWaHsIUlXh3fAmXLSPzfOZ8JoqGZUeLhubXsEE4Po8TlphlQY60l7pz7xQay
        mVlAU2L9Ln2IsKNE1+OP7CBhCQE+iRtvwYHEDGRO2jadGSLMK9HRJgRRrSYx6/g6uLUHL1yC
        Os1DYv2v9eyQkIuV2HLmBdMERrlZCLsWMDKuYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93E
        CIz30/+Of9nBuOtP0iFGAQ5GJR7eF5NV44RYE8uKK3MPMUpwMCuJ8C5oAgrxpiRWVqUW5ccX
        leakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAqFbiK+J9cvuRpcLrGN5vcdsl
        elRld1yFzxr9rcm6msUTfns+upTwqiaiWsPkiNf71O7+ebtYVBzWzTQ0FJwpzbvmXf3N9XO3
        mLvq2CbZXj60yuiczQJ7/+bPfQrpx0T7k6bbfvVOiDb0Drq+tZ6tUeb3k6T1hlkFPzpq6jeF
        sYVyyJsI3ctTYinOSDTUYi4qTgQAgyVECfMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t/xe7obFqnFGcw9yWGxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+QuuwObx6ZVnWwefVtWMXp83iQXwBylZ1OUX1qSqpCRX1xi
        qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H+51vmgocSFXMf7GNtYPwq
        2MXIySEhYCLR1vSXrYuRi0NIYCmjxNHZE1khEjISJ6c1QNnCEn+udUEVfWKUWH3/LCNIgk3A
        UKLrLUiCk0NEwFXi0IpeZpAiZoEdjBLdLRfYQRLCAnESZ1o/snQxcnCwCKhKtM0Eq+cVsJV4
        /OQ2I8QCeYnVGw4wT2DkWcDIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwzLYd+7llB2PX
        u+BDjAIcjEo8vA7TVOOEWBPLiitzDzFKcDArifAuaAIK8aYkVlalFuXHF5XmpBYfYjQF2j2R
        WUo0OR8YA3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgP6Dak
        ztq690m/2co9felvKg9oPFdKDs45zPytqvvK3vlKJZMaTZMdlgksW5RtbHbxWPpaA8HP1/nm
        layKnBM58Uzo8rkpeVK2R23543ZmTLT306sq52/5bMq36FyQ7TW5GSv3n9q1aWnrRUf28mdO
        pY4fGbt4Pprsnx7FmbRSf8NLQ3+mlg4lluKMREMt5qLiRABVraLlSQIAAA==
X-CMS-MailID: 20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da
References: <CGME20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trip points and cooling maps for GPU thermal zone for Odroid
XU3/XU4/HC1 boards. Trip points are based on the CPU thermal zone for the
those boards.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- removed polling-delay related properties for HC1 as requested by Krzysztof
--
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 30 ++++++++++
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 59 +++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index f163206265bb..812659260278 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -215,6 +215,36 @@
 				};
 			};
 		};
+		gpu_thermal: gpu-thermal {
+			thermal-sensors = <&tmu_gpu 0>;
+			trips {
+				gpu_alert0: gpu-alert-0 {
+					temperature = <70000>;
+					hysteresis = <10000>;
+					type = "active";
+				};
+				gpu_alert1: gpu-alert-1 {
+					temperature = <85000>;
+					hysteresis = <10000>;
+					type = "active";
+				};
+				gpu_crit0: gpu-crit-0 {
+					temperature = <120000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&gpu 0 2>;
+				};
+				map1 {
+					trip = <&gpu_alert1>;
+					cooling-device = <&gpu 3 6>;
+				};
+			};
+		};
 	};
 
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1865a708b49f..5da2d81e3be2 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -357,6 +357,65 @@
 				};
 			};
 		};
+		gpu_thermal: gpu-thermal {
+			thermal-sensors = <&tmu_gpu 0>;
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			trips {
+				gpu_alert0: gpu-alert-0 {
+					temperature = <50000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+				gpu_alert1: gpu-alert-1 {
+					temperature = <60000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+				gpu_alert2: gpu-alert-2 {
+					temperature = <70000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+				gpu_crit0: gpu-crit-0 {
+					temperature = <120000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+				gpu_alert3: gpu-alert-3 {
+					temperature = <70000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+				gpu_alert4: gpu-alert-4 {
+					temperature = <85000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&fan0 0 1>;
+				};
+				map1 {
+					trip = <&gpu_alert1>;
+					cooling-device = <&fan0 1 2>;
+				};
+				map2 {
+					trip = <&gpu_alert2>;
+					cooling-device = <&fan0 2 3>;
+				};
+				map3 {
+					trip = <&gpu_alert3>;
+					cooling-device = <&gpu 0 2>;
+				};
+				map4 {
+					trip = <&gpu_alert4>;
+					cooling-device = <&gpu 3 6>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.17.1

