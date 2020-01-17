Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E0C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08162072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UNShMxo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAQMe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:34:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgAQMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:34:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200117123454euoutp02be5aaffdad448d19a8be097ae79ddefa~qrLDPB6CP1741817418euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200117123454euoutp02be5aaffdad448d19a8be097ae79ddefa~qrLDPB6CP1741817418euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579264494;
        bh=7bP9Wbe+T9coiCBMja9JahNXtgI+R3IuhPdHDcd8cX8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UNShMxo7ocw3tn5KKPT8l7hMeBxTo+QquRrwFsN3bAl4yE/focZJT0GysHytWxgJC
         TRnwlrmuAr0Uk9xwX8xboOk/F/3x1f0e0ciOSSG/RDSoJYfj034646Nzvh12641Wud
         NFIFCM+FVkA+mLMCHBrqau6y7VeniNRmMlmc8Pyc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117123454eucas1p2de60f9266adf3a935de282e71d4edf2c~qrLDFfyr61731917319eucas1p2r;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.7F.60679.EE9A12E5; Fri, 17
        Jan 2020 12:34:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200117123454eucas1p2a7a3a6b64fae5382ef404ac2542aa4b3~qrLCkmeKI0707507075eucas1p2O;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117123454eusmtrp1156f933cff6cb9ccca6ab86824979ee2~qrLCj6sY70166501665eusmtrp1s;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-0d-5e21a9ee079f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.C8.08375.DE9A12E5; Fri, 17
        Jan 2020 12:34:53 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117123453eusmtip26a8f9e3b15c4043a2c313dadd63eee55~qrLCQWAoT1301313013eusmtip2B;
        Fri, 17 Jan 2020 12:34:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/3] ARM: dts: exynos: Add GPU thermal zone cooling maps for
 Odroid XU3/XU4/HC1
Date:   Fri, 17 Jan 2020 13:34:46 +0100
Message-Id: <20200117123448.13807-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7djPc7rvVirGGXQuk7fYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3YHNY9OqTjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vg
        yjh2dClbwQmJii3NOxgbGO8JdjFyckgImEis+NnH0sXIxSEksIJR4sXRD6wQzhdGidn3/rJB
        OJ8ZJVYe+8MC09L6+jxU1XJGic8PviK0XHo4kxmkik3AUKLrbRcbiC0i4CzRMLWRCaSIWWAb
        o8TrBTPZQRLCAokSl5dfAGtgEVCVWLZ4N2MXIwcHr4CtxKR2W4ht8hKrNxxgBumVEDjCJrH0
        5FN2iISLxJYfD5ghbGGJV8e3QMVlJE5P7mGBaGhmlHh4bi07hNPDKHG5aQYjRJW1xJ1zv9hA
        tjELaEqs36UPEXaU2LphNTNIWEKAT+LGW3AoMQOZk7ZNhwrzSnS0CUFUq0nMOr4Obu3BC5eg
        zvGQ+Dl9ExOILSQQK7H012r2CYxysxB2LWBkXMUonlpanJueWmyUl1quV5yYW1yal66XnJ+7
        iREY8af/Hf+yg3HXn6RDjAIcjEo8vAXLFOOEWBPLiitzDzFKcDArifDe7QUK8aYkVlalFuXH
        F5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwFhtcG9Jyp13Dx7e/y7Z0f1C
        +o+soHTQzyn8mlEHo9IaLD4kx8+eu4FJ7XTj+vBPvcyOm/+F8rFqMxX2znU793iv24ba9dN1
        F6TUaO4OrNFbfHTm1IdvvSbPNFx8/f7USV+vnBTjvRD56uOGTdvfqjjHvli4IaW87T3DpG0T
        w6c3XIlbbxe69fpvJZbijERDLeai4kQAvADGv/QCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t/xe7pvVyrGGTS/sbHYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3YHNY9OqTjaPvi2rGD0+b5ILYI7SsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzh2dClbwQmJii3NOxgbGO8J
        djFyckgImEi0vj7P2sXIxSEksJRRYtunbSwQCRmJk9MaWCFsYYk/17rYIIo+MUqcmbiaCSTB
        JmAo0fUWJMHJISLgKnFoRS8zSBGzwA5Gie6WC+wgCWGBeImLzcsYQWwWAVWJZYt3A9kcHLwC
        thKT2m0hFshLrN5wgHkCI88CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgWG27djPzTsY
        L20MPsQowMGoxMNbsEwxTog1say4MvcQowQHs5II791eoBBvSmJlVWpRfnxRaU5q8SFGU6Dd
        E5mlRJPzgTGQVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBcfaZ
        mpPhh567XtlSdoSZZ6NARomy0qbeOYdV/+Sfm6q40+hyoMQnq5PhBwN7e/ZyzOC87HL22xbe
        z3dn7PqbsLA+aVZ49UrjBbt959TITpQ8vKsj8OuM++c92LLYj7/dvlNWsj56Z1xBc+3Pwn2Z
        C+JbSx6YBv9xv32h3VjvfsPkFTfnZp/3v6LEUpyRaKjFXFScCAA07B+qSQIAAA==
X-CMS-MailID: 20200117123454eucas1p2a7a3a6b64fae5382ef404ac2542aa4b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200117123454eucas1p2a7a3a6b64fae5382ef404ac2542aa4b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200117123454eucas1p2a7a3a6b64fae5382ef404ac2542aa4b3
References: <CGME20200117123454eucas1p2a7a3a6b64fae5382ef404ac2542aa4b3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trip points and cooling maps for GPU thermal zone for Odroid
XU3/XU4/HC1 boards. Trip points are based on the CPU thermal zone for the
those boards.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 32 ++++++++++
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 59 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index f163206265bb..8f38ef5bff55 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -215,6 +215,38 @@
 				};
 			};
 		};
+		gpu_thermal: gpu-thermal {
+			thermal-sensors = <&tmu_gpu 0>;
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
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

