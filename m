Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFE5C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CB9206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796571;
	bh=lag4MfJv21Stf+8O4CxR6SYPZ0pwLkTauExbFs+gKQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4UJilLXkfvgphyFeNVaVwfGFbGLzyj/I3XRZTPw6qsxk3TUp72Nqr+WSGtKMzRRG
	 q0G18jLToZM5u/wrkLFTXnkaSmDqbDKMmzL5s+MIhRy8DUIkoSqHKSlbZmr1wB37Ad
	 /7kcxvIAvJZHKMRwa9GmuunaSIsSWT2Az5ey7LY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgH3OJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgH3NzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DC12137B;
        Sun, 30 Aug 2020 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795713;
        bh=lag4MfJv21Stf+8O4CxR6SYPZ0pwLkTauExbFs+gKQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMacvtQjF2udKdk9edSTLdF54HGZKATHiF3jsgmY7QD7moM6f3Cu4IDAGQCuZadXI
         VyPpThmcRTi2WDMtNLzuEwDwiMPSxIS1imL8l6MPdIb+MHgDt3AToVKD4H6L1tw9HD
         EsMtWx0gqxAQ4r9EDZb/bk3rxsKRrVEdG+XuO9nc=
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
Subject: [PATCH 26/33] ARM: dts: exynos: Override thermal by label in Midas
Date:   Sun, 30 Aug 2020 15:51:53 +0200
Message-Id: <20200830135200.24304-26-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos4412-midas.dtsi | 34 +++++++++++--------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 32d2e539b2dd..7e7c243ff196 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -319,25 +319,6 @@
 		pulldown-ohm = <100000>; /* 100K */
 		io-channels = <&adc 2>;  /* Battery temperature */
 	};
-
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			cooling-maps {
-				map0 {
-				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
-						      <&cpu2 7 7>, <&cpu3 7 7>;
-				};
-				map1 {
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
 
 &adc {
@@ -406,6 +387,21 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			/* Corresponds to 800MHz at freq_table */
+			cooling-device = <&cpu0 7 7>, <&cpu1 7 7>,
+					 <&cpu2 7 7>, <&cpu3 7 7>;
+		};
+		map1 {
+			/* Corresponds to 200MHz at freq_table */
+			cooling-device = <&cpu0 13 13>, <&cpu1 13 13>,
+					 <&cpu2 13 13>, <&cpu3 13 13>;
+		};
+	};
+};
+
 &csis_0 {
 	status = "okay";
 	vddcore-supply = <&ldo8_reg>;
-- 
2.17.1

