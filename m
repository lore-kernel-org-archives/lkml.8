Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E9DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFCF20885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593705134;
	bh=rZcMyW7K8GPI7NAMM95uy9U0ekWtlscAh24Mfbuxev0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMdRooUW8DGE5cDaQz67XdruM4ld+5Nq91Q4MhGkBNPRIcwIheixf2i1IF/fgc3/t
	 Yl+un7CDJSJR+XZBpM/SK/dowftkXI2YddGgpkHrVbmQhF/YwXczYipUiwMN5rSrEH
	 T4vZYIDGHOlFA9BE/Xmi2jojGVKOMV/L8lkTgVPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGBPwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGBPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:09 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706F520771;
        Thu,  2 Jul 2020 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705128;
        bh=rZcMyW7K8GPI7NAMM95uy9U0ekWtlscAh24Mfbuxev0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj+jvoX/97OIVT1xk/TbSlFCz6fyvpJVqqcu6af/5TC/y7lraBgPmPadrP7h/1e3C
         qC5rrORsyoef3nydtUl7+rp5ceTK6n6V9l7gSxzxkHskDVIhKqbbCq6/TrIvEjpPWa
         XbHMU26st/Rq8+8CxJDScQ4lJ22vdGLXl7+aF9hM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus node name to fix dtschema warnings
Date:   Thu,  2 Jul 2020 17:51:45 +0200
Message-Id: <20200702155149.12854-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep DMA controller nodes under AMBA bus node.
Remove the "amba" node to fix dtschema warnings like:

    amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove the bus, as suggested by Marek
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 47 +++++++++-------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 47 +++++++++-------------
 2 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 57b433a1c900..74ac4ac75865 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1756,33 +1756,26 @@
 			status = "disabled";
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@15610000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x15610000 0x1000>;
-				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu_fsys CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@15600000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x15600000 0x1000>;
-				interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu_fsys CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@15610000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x15610000 0x1000>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_fsys CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@15600000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x15600000 0x1000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_fsys CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		audio-subsystem@11400000 {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index c0b63b0d39ab..b9ed6a33e290 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -105,33 +105,26 @@
 				<0x11006000 0x2000>;
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@10e10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10E10000 0x1000>;
-				interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_fsys0 ACLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@10eb0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10EB0000 0x1000>;
-				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_fsys0 ACLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@10e10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10E10000 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 ACLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@10eb0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10EB0000 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 ACLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		clock_topc: clock-controller@10570000 {
-- 
2.17.1

