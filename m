Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4FFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49532073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593973087;
	bh=0GevC1+q3BWzJXYuZzUUcj1pdUwJhe2DRs/CzP22WFg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gl/4jx/KANW3A9fQVfFqw6bDDWyNi1BQAQ/mLWy6yzdO96OUIQ7nB8JGhzGCw2Muq
	 QQ8tw76aKFBeJStTJfEw2ex4MY1vZTSevE1olFlyjlYyw1pAY1QXnWLCqV0mDoxd/p
	 oRaJdZjU0YJSXWL/paU3kJ+bW53OX3nRXdgIpWUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGESSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGESSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:18:06 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC55B20720;
        Sun,  5 Jul 2020 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593973085;
        bh=0GevC1+q3BWzJXYuZzUUcj1pdUwJhe2DRs/CzP22WFg=;
        h=From:To:Cc:Subject:Date:From;
        b=Spmrn55bFywzi+5baaJbwsQBJU0qIj0iJpOf344wfoXtyjtc46YRyv9pS9aBOhdWM
         VQolQZjLEWurgMpgPg8hYi7ehmfj/T6lWGMe6EnE26S97/2BvP6hbjmtHyFpCOGUAZ
         zhal1vkc86rP+to+ZLug3tKd4CSswispJsqtdTYw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v3] ARM: dts: exynos: Remove DMA controller bus node name to fix dtschema warnings
Date:   Sun,  5 Jul 2020 20:17:54 +0200
Message-Id: <20200705181754.13284-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep DMA controller nodes under AMBA bus node.
Remove the "amba" node to fix dtschema warnings like:

    amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Keep the alphabetical order in exynos4210-universal_c210.dts, as suggested by Marek

Changes since v1:
1. Remove the bus, as suggested by Marek
---
 arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
 arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
 .../boot/dts/exynos4210-universal_c210.dts    |  28 ++--
 arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
 arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
 arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
 6 files changed, 187 insertions(+), 226 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 044e5da64a76..d3fb45a56527 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -418,33 +418,26 @@
 			status = "disabled";
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@12680000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12680000 0x1000>;
-				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@12690000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12690000 0x1000>;
-				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		adc: adc@126c0000 {
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d2779a790ce3..a1e54449f33f 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -669,45 +669,37 @@
 			status = "disabled";
 		};
 
-		amba: amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@12680000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12680000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@12690000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12690000 0x1000>;
-				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma1: mdma@12850000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12850000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		pdma0: pdma@12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma1: mdma@12850000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12850000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
 		};
 
 		fimd: fimd@11c00000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 02fde1a75ebd..99ce53b120ac 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -181,20 +181,6 @@
 	};
 };
 
-&amba {
-	mdma0: mdma@12840000 {
-		compatible = "arm,pl330", "arm,primecell";
-		reg = <0x12840000 0x1000>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clock CLK_MDMA>;
-		clock-names = "apb_pclk";
-		#dma-cells = <1>;
-		#dma-channels = <8>;
-		#dma-requests = <1>;
-		power-domains = <&pd_lcd0>;
-	};
-};
-
 &camera {
 	status = "okay";
 
@@ -616,6 +602,20 @@
 	/delete-property/dma-names;
 };
 
+&soc {
+	mdma0: mdma@12840000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x12840000 0x1000>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clock CLK_MDMA>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+		#dma-channels = <8>;
+		#dma-requests = <1>;
+		power-domains = <&pd_lcd0>;
+	};
+};
+
 &sysram {
 	smp-sram@0 {
 		status = "disabled";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6135af7ef39..e3dbe4166836 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -679,56 +679,48 @@
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121A0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121B0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma0: mdma@10800000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10800000 0x1000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
-
-			mdma1: mdma@11c10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x11C10000 0x1000>;
-				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma0: mdma@10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+		};
+
+		mdma1: mdma@11c10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
 		};
 
 		gsc_0:  gsc@13e00000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2eab80bf5f3a..abe75b9e39f5 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -189,34 +189,26 @@
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121a0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121a0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
 
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121b0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121b0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		audi2s0: i2s@3830000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b672080e7469..c76460b70532 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -433,76 +433,68 @@
 			power-domains = <&mau_pd>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			adma: adma@3880000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x03880000 0x1000>;
-				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_audss EXYNOS_ADMA>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <6>;
-				#dma-requests = <16>;
-				power-domains = <&mau_pd>;
-			};
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121A0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121B0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma0: mdma@10800000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10800000 0x1000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		adma: adma@3880000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x03880000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_audss EXYNOS_ADMA>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <6>;
+			#dma-requests = <16>;
+			power-domains = <&mau_pd>;
+		};
 
-			mdma1: mdma@11c10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x11C10000 0x1000>;
-				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-				/*
-				 * MDMA1 can support both secure and non-secure
-				 * AXI transactions. When this is enabled in
-				 * the kernel for boards that run in secure
-				 * mode, we are getting imprecise external
-				 * aborts causing the kernel to oops.
-				 */
-				status = "disabled";
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma0: mdma@10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+		};
+
+		mdma1: mdma@11c10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+			/*
+			 * MDMA1 can support both secure and non-secure
+			 * AXI transactions. When this is enabled in
+			 * the kernel for boards that run in secure
+			 * mode, we are getting imprecise external
+			 * aborts causing the kernel to oops.
+			 */
+			status = "disabled";
 		};
 
 		i2s0: i2s@3830000 {
-- 
2.17.1

