Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AEBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33F22087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946899;
	bh=56oK4bkH4Y7WAiT0wfBSemvii29zdPdfw2cIkGdmvyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DCgvlWXOatz7xXc2qrWnxOFT+J/X4D24sNLDCBjGCH4t2fB5NrqwMB+uJJiAqj1gC
	 gqnukWVePkyWZGq3SMXH6kOjkVgvoJF+Rn4EhqgdIG9XJ23kpgDT4aT4KT75nszByo
	 MrGqE0lZf/N7t2TtLOvya0pV4PTOfPCuawkM+Wvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIAHy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgIAHyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:54:54 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073692098B;
        Tue,  1 Sep 2020 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946892;
        bh=56oK4bkH4Y7WAiT0wfBSemvii29zdPdfw2cIkGdmvyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJoUVaP+7HEgd9UlfaWiYHjUlY1Q19ywn16LATI2dbMDPDVm8recHv/6qejf9SyIg
         4gRr8X8zlscHJNjdCTxUPZsoanhqcAKrsS4BnKKZCQBkad3tCdrnCfujHXoR3238FE
         WF0iX4mzqBrZm9tzDz6/Fq1H60HFO7kcm+/yDjHI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 06/13] ARM: dts: exynos: Correct whitespace and indentation issues in Exynos5
Date:   Tue,  1 Sep 2020 09:54:10 +0200
Message-Id: <20200901075417.22481-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double space after '=' and fix indentation in Exynos5250,
Exynos5410 and Exynos5420 DTS files.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5.dtsi                |  8 ++---
 arch/arm/boot/dts/exynos5250-arndale.dts      | 10 +++----
 arch/arm/boot/dts/exynos5250-spring.dts       | 30 +++++++++----------
 arch/arm/boot/dts/exynos5250.dtsi             |  8 ++---
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  8 ++---
 arch/arm/boot/dts/exynos5410.dtsi             | 12 ++++----
 arch/arm/boot/dts/exynos5420.dtsi             | 16 +++++-----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +--
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 9660104be4c9..9ce9fb3fc190 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -211,13 +211,13 @@
 		};
 
 		prng: rng@10830400 {
-		      compatible = "samsung,exynos5250-prng";
-		      reg = <0x10830400 0x200>;
+			compatible = "samsung,exynos5250-prng";
+			reg = <0x10830400 0x200>;
 		};
 
 		trng: rng@10830600 {
-		      compatible = "samsung,exynos5250-trng";
-		      reg = <0x10830600 0x100>;
+			compatible = "samsung,exynos5250-trng";
+			reg = <0x10830600 0x100>;
 		};
 
 		g2d: g2d@10850000 {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index ec94af640cd5..f2bcce167b2d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -243,11 +243,11 @@
 		s5m8767,pmic-buck3-dvs-voltage = <1100000>;
 		s5m8767,pmic-buck4-dvs-voltage = <1200000>;
 		s5m8767,pmic-buck-dvs-gpios = <&gpd1 0 GPIO_ACTIVE_HIGH>,
-		                              <&gpd1 1 GPIO_ACTIVE_HIGH>,
-		                              <&gpd1 2 GPIO_ACTIVE_HIGH>;
+					      <&gpd1 1 GPIO_ACTIVE_HIGH>,
+					      <&gpd1 2 GPIO_ACTIVE_HIGH>;
 		s5m8767,pmic-buck-ds-gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>,
-		                             <&gpx2 4 GPIO_ACTIVE_HIGH>,
-		                             <&gpx2 5 GPIO_ACTIVE_HIGH>;
+					     <&gpx2 4 GPIO_ACTIVE_HIGH>,
+					     <&gpx2 5 GPIO_ACTIVE_HIGH>;
 
 		s5m8767_osc: clocks {
 			compatible = "samsung,s5m8767-clk";
@@ -544,7 +544,7 @@
 	samsung,i2c-max-bus-freq = <40000>;
 	samsung,i2c-slave-addr = <0x38>;
 
-	sata_phy_i2c:sata-phy@38 {
+	sata_phy_i2c: sata-phy@38 {
 		compatible = "samsung,exynos-sataphy-i2c";
 		reg = <0x38>;
 	};
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 3d501926c227..b6fcf847fc2f 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -114,12 +114,12 @@
 		wakeup-source;
 
 		s5m8767,pmic-buck-dvs-gpios = <&gpd1 0 GPIO_ACTIVE_LOW>, /* DVS1 */
-		                              <&gpd1 1 GPIO_ACTIVE_LOW>, /* DVS2 */
-		                              <&gpd1 2 GPIO_ACTIVE_LOW>; /* DVS3 */
+					      <&gpd1 1 GPIO_ACTIVE_LOW>, /* DVS2 */
+					      <&gpd1 2 GPIO_ACTIVE_LOW>; /* DVS3 */
 
 		s5m8767,pmic-buck-ds-gpios = <&gpx2 3 GPIO_ACTIVE_LOW>, /* SET1 */
-		                             <&gpx2 4 GPIO_ACTIVE_LOW>, /* SET2 */
-		                             <&gpx2 5 GPIO_ACTIVE_LOW>; /* SET3 */
+					     <&gpx2 4 GPIO_ACTIVE_LOW>, /* SET2 */
+					     <&gpx2 5 GPIO_ACTIVE_LOW>; /* SET3 */
 
 		/*
 		 * The following arrays of DVS voltages are not used, since we are
@@ -127,26 +127,26 @@
 		 * to please the driver.
 		 */
 		s5m8767,pmic-buck2-dvs-voltage = <1350000>, <1300000>,
-		                                 <1250000>, <1200000>,
-		                                 <1150000>, <1100000>,
-		                                 <1000000>, <950000>;
+						 <1250000>, <1200000>,
+						 <1150000>, <1100000>,
+						 <1000000>, <950000>;
 
 		s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
-		                                 <1100000>, <1100000>,
-		                                 <1000000>, <1000000>,
-		                                 <1000000>, <1000000>;
+						 <1100000>, <1100000>,
+						 <1000000>, <1000000>,
+						 <1000000>, <1000000>;
 
 		s5m8767,pmic-buck4-dvs-voltage = <1200000>, <1200000>,
-		                                 <1200000>, <1200000>,
-		                                 <1200000>, <1200000>,
-		                                 <1200000>, <1200000>;
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>;
 
 		clocks {
 			compatible = "samsung,s5m8767-clk";
 			#clock-cells = <1>;
 			clock-output-names = "en32khz_ap",
-			                     "en32khz_cp",
-			                     "en32khz_bt";
+					     "en32khz_cp",
+					     "en32khz_bt";
 		};
 
 		regulators {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e3dbe4166836..0249d16e187f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -723,7 +723,7 @@
 			#dma-requests = <1>;
 		};
 
-		gsc_0:  gsc@13e00000 {
+		gsc_0: gsc@13e00000 {
 			compatible = "samsung,exynos5250-gsc", "samsung,exynos5-gsc";
 			reg = <0x13e00000 0x1000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -733,7 +733,7 @@
 			iommus = <&sysmmu_gsc0>;
 		};
 
-		gsc_1:  gsc@13e10000 {
+		gsc_1: gsc@13e10000 {
 			compatible = "samsung,exynos5250-gsc", "samsung,exynos5-gsc";
 			reg = <0x13e10000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
@@ -743,7 +743,7 @@
 			iommus = <&sysmmu_gsc1>;
 		};
 
-		gsc_2:  gsc@13e20000 {
+		gsc_2: gsc@13e20000 {
 			compatible = "samsung,exynos5250-gsc", "samsung,exynos5-gsc";
 			reg = <0x13e20000 0x1000>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
@@ -753,7 +753,7 @@
 			iommus = <&sysmmu_gsc2>;
 		};
 
-		gsc_3:  gsc@13e30000 {
+		gsc_3: gsc@13e30000 {
 			compatible = "samsung,exynos5250-gsc", "samsung,exynos5-gsc";
 			reg = <0x13e30000 0x1000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 4f9297ae0763..75b4150c26d7 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -109,10 +109,10 @@
 	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 			<&clock_audss EXYNOS_MOUT_AUDSS>;
 
-	assigned-clock-rates =  <0>,
-				<0>,
-				<96000000>,
-				<19200000>;
+	assigned-clock-rates = <0>,
+			       <0>,
+			       <96000000>,
+			       <19200000>;
 };
 
 &cpu0_thermal {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index abe75b9e39f5..60a87684b1af 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -238,16 +238,16 @@
 			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu1_thermal: cpu1-thermal {
-		       thermal-sensors = <&tmu_cpu1>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu1>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu2_thermal: cpu2-thermal {
-		       thermal-sensors = <&tmu_cpu2>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu2>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu3_thermal: cpu3-thermal {
-		       thermal-sensors = <&tmu_cpu3>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu3>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c76460b70532..83580f076a58 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1199,20 +1199,20 @@
 			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu1_thermal: cpu1-thermal {
-		       thermal-sensors = <&tmu_cpu1>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu1>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu2_thermal: cpu2-thermal {
-		       thermal-sensors = <&tmu_cpu2>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu2>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu3_thermal: cpu3-thermal {
-		       thermal-sensors = <&tmu_cpu3>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_cpu3>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 		gpu_thermal: gpu-thermal {
-		       thermal-sensors = <&tmu_gpu>;
-		       #include "exynos5420-trip-points.dtsi"
+			thermal-sensors = <&tmu_gpu>;
+			#include "exynos5420-trip-points.dtsi"
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index afe090578e8f..b1cf9414ce17 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -333,8 +333,8 @@
 		compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
 		density		= <16384>;
 		io-width	= <32>;
-		#address-cells  = <1>;
-		#size-cells     = <0>;
+		#address-cells	= <1>;
+		#size-cells	= <0>;
 
 		tRFC-min-tck		= <17>;
 		tRRD-min-tck		= <2>;
-- 
2.17.1

