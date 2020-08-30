Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC9C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D63206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796536;
	bh=uQCj/HLwG7euETSyzEphZLcSpSGJVabxZwir3jTUtnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyCahz8NpwPfoqCenNhq3gYTNOCsXl+BV/3zRiksVPDzjbigmcNodgJtD60hMGqIg
	 uCUQ+nWOUDhmQS6y5iFAnUNameuqWOlO0nO9NMXog0AhaLHAQVvYIA2/UKXHeGGdeK
	 4qnCdMMolBVla4K45zJUAr4yxhDaZZnCvTHUrlx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgH3OIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbgH3NzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DDF214DB;
        Sun, 30 Aug 2020 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795716;
        bh=uQCj/HLwG7euETSyzEphZLcSpSGJVabxZwir3jTUtnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtmWAuUK4aV7S2K2blvrDqm8waDpaYCS5g/MQPiPO4/JxnpYAkzqzMB+4kLHOUjp2
         nYzmMRUNh7EYUDctZlPAuKP1ffm6/AUSM7xo3L5+6ma49p+4darkdLStWBy0bJsamU
         ibuRDlzr3t80q8/Bpq7+Ejw/5RQAoQUBTWZvO2pE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 27/33] ARM: dts: exynos: Override thermal by label in Exynos4412 Odroids
Date:   Sun, 30 Aug 2020 15:51:54 +0200
Message-Id: <20200830135200.24304-27-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using full paths to extend or override a device tree node is error prone
since if there was a typo error, a new node will be created instead of
extending the node as it was desired.  This will lead to run-time errors
that could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 34 ++++++--------
 arch/arm/boot/dts/exynos4412-odroidu3.dts     | 46 +++++++++----------
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 6d3576e21ffa..ca3c78e0966c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -66,25 +66,6 @@
 			clock-frequency = <24000000>;
 		};
 	};
-
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			cooling-maps {
-				cooling_map0: map0 {
-				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
-						      <&cpu2 7 7>, <&cpu3 7 7>;
-				};
-				cooling_map1: map1 {
-				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 13 13>,
-						      <&cpu1 13 13>,
-						      <&cpu2 13 13>,
-						      <&cpu3 13 13>;
-			       };
-		       };
-		};
-	};
 };
 
 &bus_dmc {
@@ -172,6 +153,21 @@
 	};
 };
 
+&cpu_thermal {
+	cooling-maps {
+		cooling_map0: map0 {
+			/* Corresponds to 800MHz at freq_table */
+			cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
+					 <&cpu2 7 7>, <&cpu3 7 7>;
+		};
+		cooling_map1: map1 {
+			/* Corresponds to 200MHz at freq_table */
+			cooling-device = <&cpu0 13 13>, <&cpu1 13 13>,
+					 <&cpu2 13 13>, <&cpu3 13 13>;
+		};
+	};
+};
+
 &pinctrl_1 {
 	gpio_power_key: power_key {
 		samsung,pins = "gpx1-3";
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 8ff243ba4542..b8549d846f86 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -37,31 +37,6 @@
 		#cooling-cells = <2>;
 		cooling-levels = <0 102 170 230>;
 	};
-
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			cooling-maps {
-				map0 {
-				     trip = <&cpu_alert1>;
-				     cooling-device = <&cpu0 9 9>, <&cpu1 9 9>,
-						      <&cpu2 9 9>, <&cpu3 9 9>,
-						      <&fan0 1 2>;
-				};
-				map1 {
-				     trip = <&cpu_alert2>;
-				     cooling-device = <&cpu0 15 15>,
-						      <&cpu1 15 15>,
-						      <&cpu2 15 15>,
-						      <&cpu3 15 15>,
-						      <&fan0 2 3>;
-				};
-				map2 {
-				     trip = <&cpu_alert0>;
-				     cooling-device = <&fan0 0 1>;
-				};
-			};
-		};
-	};
 };
 
 &adc {
@@ -76,6 +51,27 @@
 	regulator-max-microvolt = <3300000>;
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert1>;
+			cooling-device = <&cpu0 9 9>, <&cpu1 9 9>,
+					 <&cpu2 9 9>, <&cpu3 9 9>,
+					 <&fan0 1 2>;
+		};
+		map1 {
+			trip = <&cpu_alert2>;
+			cooling-device = <&cpu0 15 15>, <&cpu1 15 15>,
+					 <&cpu2 15 15>, <&cpu3 15 15>,
+					 <&fan0 2 3>;
+		};
+		map2 {
+			trip = <&cpu_alert0>;
+			cooling-device = <&fan0 0 1>;
+		};
+	};
+};
+
 &hdmicec {
 	needs-hpd;
 };
-- 
2.17.1

