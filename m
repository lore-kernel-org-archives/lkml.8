Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B14C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70209206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796147;
	bh=uNfTXwgoO6BxRl6jN3Qy3MaFxligNIVyKs8EdVjfwzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QpR0TdXVga5at0jyan1/SDFpTgt+8u5T0kpbZ8JeoxvqiHEFWYTPnDKUGew88InJG
	 rngZwo4VxgtttCAqgPmoxd0t8OCI2ZzsdMiBhtlW8+xvkye5I/vUKxUELcXWFZLL6s
	 THUYZ2lcxjTMbtvAqNvuo9Y2+pfWx3ZjXSXE+gO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgH3OCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgH3N4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:56:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215FE21531;
        Sun, 30 Aug 2020 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795735;
        bh=uNfTXwgoO6BxRl6jN3Qy3MaFxligNIVyKs8EdVjfwzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoFwOJrNry2znxlpy9F6HfjXoyXSqdosgorTx85N6brLUYqkDSxsZvbm8Ji3LhzFg
         44lvMG7bW8wY5W9QhCAVQWSqLlsr8Zjd3diXihaGt5Q2K8F5HyvT2O6BTW18EBzXLr
         IVEqCI0MDShvWjBZnTzTsOZ1xQdUFk91pQ/3MOPc=
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
Subject: [PATCH 33/33] ARM: dts: exynos: Correct whitespace and indentation issues
Date:   Sun, 30 Aug 2020 15:52:00 +0200
Message-Id: <20200830135200.24304-33-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double space after '=' and fix indentation in Exynos3250,
Exynos4210 and Exynos4412 boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250-monk.dts         |   2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |   2 +-
 arch/arm/boot/dts/exynos4210-trats.dts        | 138 +++++++++---------
 .../boot/dts/exynos4210-universal_c210.dts    |   4 +-
 arch/arm/boot/dts/exynos4412-i9300.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-i9305.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-n710x.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts       |   2 +-
 8 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index ca29d7ed8216..9d77a73bc92b 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -26,7 +26,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x1ff00000>;
+		reg = <0x40000000 0x1ff00000>;
 	};
 
 	firmware@205f000 {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index aba8350cfdaf..3df003af0d15 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -30,7 +30,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x1ff00000>;
+		reg = <0x40000000 0x1ff00000>;
 	};
 
 	firmware@205f000 {
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 75483e08b4b4..2b49c1d77391 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -316,135 +316,135 @@
 
 		regulators {
 			valive_reg: LDO2 {
-			     regulator-name = "VALIVE_1.1V_C210";
-			     regulator-min-microvolt = <1100000>;
-			     regulator-max-microvolt = <1100000>;
-			     regulator-always-on;
+				regulator-name = "VALIVE_1.1V_C210";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
 			};
 
 			vusb_reg: LDO3 {
-			     regulator-name = "VUSB_1.1V_C210";
-			     regulator-min-microvolt = <1100000>;
-			     regulator-max-microvolt = <1100000>;
+				regulator-name = "VUSB_1.1V_C210";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
 			};
 
 			vmipi_reg: LDO4 {
-			     regulator-name = "VMIPI_1.8V";
-			     regulator-min-microvolt = <1800000>;
-			     regulator-max-microvolt = <1800000>;
+				regulator-name = "VMIPI_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
 
 			vpda_reg: LDO6 {
-			     regulator-name = "VCC_1.8V_PDA";
-			     regulator-min-microvolt = <1800000>;
-			     regulator-max-microvolt = <1800000>;
-			     regulator-always-on;
+				regulator-name = "VCC_1.8V_PDA";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 			};
 
 			vcam_reg: LDO7 {
-			     regulator-name = "CAM_ISP_1.8V";
-			     regulator-min-microvolt = <1800000>;
-			     regulator-max-microvolt = <1800000>;
+				regulator-name = "CAM_ISP_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
 
 			vusbdac_reg: LDO8 {
-			     regulator-name = "VUSB+VDAC_3.3V_C210";
-			     regulator-min-microvolt = <3300000>;
-			     regulator-max-microvolt = <3300000>;
+				regulator-name = "VUSB+VDAC_3.3V_C210";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 			};
 
 			vccpda_reg: LDO9 {
-			     regulator-name = "VCC_2.8V_PDA";
-			     regulator-min-microvolt = <2800000>;
-			     regulator-max-microvolt = <2800000>;
-			     regulator-always-on;
+				regulator-name = "VCC_2.8V_PDA";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
 			};
 
 			vpll_reg: LDO10 {
-			     regulator-name = "VPLL_1.1V_C210";
-			     regulator-min-microvolt = <1100000>;
-			     regulator-max-microvolt = <1100000>;
-			     regulator-always-on;
+				regulator-name = "VPLL_1.1V_C210";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
 			};
 
 			vtcam_reg: LDO12 {
-			     regulator-name = "VT_CAM_1.8V";
-			     regulator-min-microvolt = <1800000>;
-			     regulator-max-microvolt = <1800000>;
+				regulator-name = "VT_CAM_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
 
 			vcclcd_reg: LDO13 {
-			     regulator-name = "VCC_3.3V_LCD";
-			     regulator-min-microvolt = <3300000>;
-			     regulator-max-microvolt = <3300000>;
+				regulator-name = "VCC_3.3V_LCD";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 			};
 
 			vlcd_reg: LDO15 {
-			     regulator-name = "VLCD_2.2V";
-			     regulator-min-microvolt = <2200000>;
-			     regulator-max-microvolt = <2200000>;
+				regulator-name = "VLCD_2.2V";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
 			};
 
 			camsensor_reg: LDO16 {
-			     regulator-name = "CAM_SENSOR_IO_1.8V";
-			     regulator-min-microvolt = <1800000>;
-			     regulator-max-microvolt = <1800000>;
+				regulator-name = "CAM_SENSOR_IO_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
 
 			tflash_reg: LDO17 {
-			     regulator-name = "VTF_2.8V";
-			     regulator-min-microvolt = <2800000>;
-			     regulator-max-microvolt = <2800000>;
+				regulator-name = "VTF_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 			};
 
 			vddq_reg: LDO21 {
-			     regulator-name = "VDDQ_M1M2_1.2V";
-			     regulator-min-microvolt = <1200000>;
-			     regulator-max-microvolt = <1200000>;
-			     regulator-always-on;
+				regulator-name = "VDDQ_M1M2_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
 			};
 
 			varm_breg: BUCK1 {
-			     regulator-name = "VARM_1.2V_C210";
-			     regulator-min-microvolt = <900000>;
-			     regulator-max-microvolt = <1350000>;
-			     regulator-always-on;
+				regulator-name = "VARM_1.2V_C210";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
 			};
 
 			vint_breg: BUCK2 {
-			     regulator-name = "VINT_1.1V_C210";
-			     regulator-min-microvolt = <900000>;
-			     regulator-max-microvolt = <1100000>;
-			     regulator-always-on;
+				regulator-name = "VINT_1.1V_C210";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
 			};
 
 			camisp_breg: BUCK4 {
-			     regulator-name = "CAM_ISP_CORE_1.2V";
-			     regulator-min-microvolt = <1200000>;
-			     regulator-max-microvolt = <1200000>;
+				regulator-name = "CAM_ISP_CORE_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 			};
 
 			vmem_breg: BUCK5 {
-			     regulator-name = "VMEM_1.2V_C210";
-			     regulator-min-microvolt = <1200000>;
-			     regulator-max-microvolt = <1200000>;
-			     regulator-always-on;
+				regulator-name = "VMEM_1.2V_C210";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
 			};
 
 			vccsub_breg: BUCK7 {
-			     regulator-name = "VCC_SUB_2.0V";
-			     regulator-min-microvolt = <2000000>;
-			     regulator-max-microvolt = <2000000>;
-			     regulator-always-on;
+				regulator-name = "VCC_SUB_2.0V";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
 			};
 
 			safe1_sreg: ESAFEOUT1 {
-			     regulator-name = "SAFEOUT1";
+				regulator-name = "SAFEOUT1";
 			};
 
 			safe2_sreg: ESAFEOUT2 {
-			     regulator-name = "SAFEOUT2";
-			     regulator-boot-on;
+				regulator-name = "SAFEOUT2";
+				regulator-boot-on;
 			};
 
 			EN32KHZ_AP {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 546d84fe4599..a9f4db533183 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -49,7 +49,7 @@
 	};
 
 	vemmc_reg: voltage-regulator {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "VMEM_VDD_2_8V";
 		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
@@ -111,7 +111,7 @@
 	};
 
 	tsp_reg: voltage-regulator {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "TSP_2_8V";
 		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
diff --git a/arch/arm/boot/dts/exynos4412-i9300.dts b/arch/arm/boot/dts/exynos4412-i9300.dts
index 3691802b69c5..07fbcf845c49 100644
--- a/arch/arm/boot/dts/exynos4412-i9300.dts
+++ b/arch/arm/boot/dts/exynos4412-i9300.dts
@@ -17,7 +17,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x40000000>;
+		reg = <0x40000000 0x40000000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-i9305.dts b/arch/arm/boot/dts/exynos4412-i9305.dts
index 54a2a55dbf70..6bc3d897f432 100644
--- a/arch/arm/boot/dts/exynos4412-i9305.dts
+++ b/arch/arm/boot/dts/exynos4412-i9305.dts
@@ -10,7 +10,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x80000000>;
+		reg = <0x40000000 0x80000000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-n710x.dts b/arch/arm/boot/dts/exynos4412-n710x.dts
index 2361d89a79a8..a47b7f35fc80 100644
--- a/arch/arm/boot/dts/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/exynos4412-n710x.dts
@@ -8,7 +8,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x80000000>;
+		reg = <0x40000000 0x80000000>;
 	};
 
 	/* bootargs are passed in by bootloader */
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index aac533933c61..7b447b63007e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -18,7 +18,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg =  <0x40000000 0x40000000>;
+		reg = <0x40000000 0x40000000>;
 	};
 
 	chosen {
-- 
2.17.1

