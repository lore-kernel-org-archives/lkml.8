Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF352220E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445804;
	bh=VXgt2tx5O4PMvPYQWsJ40a0pQ96+5woG6XYfjopagNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tY6JYLZjZQ4WJ2VHDMXlO675ruMKnHqrbIxIqcXwTMAKQHWvJK2BRJ9dGTOhaKkNK
	 HoIB70gcN+x8d92/wfhEqflSImr4NNfrqdgRV8+QoeDeHeEYC5+cUxmLa6I1qIdoEi
	 UIBNoS422HmSUP9E50dNj3tM6LfEjQSZ8W9nzWjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgFRCDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730993AbgFRBXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D22214DB;
        Thu, 18 Jun 2020 01:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443411;
        bh=VXgt2tx5O4PMvPYQWsJ40a0pQ96+5woG6XYfjopagNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vIqSHIVXsjC6+O0HxcWNP7CCoxkmHPXMMSLDUNHC9N0ws5zHcyBIj+hlVzG3bB68
         ZHHqPPW2KDNx/GB/vYYA4I2uy9PAb4HCKzuyFZabSS/F8AOiwX4svWTkCEr408w6DI
         jjo9/Nt8T+fj32OH8qImIPxVj966YkAjPwpcVUGM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 054/172] arm64: dts: mt8173: fix unit name warnings
Date:   Wed, 17 Jun 2020 21:20:20 -0400
Message-Id: <20200618012218.607130-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit 72b29215aced394d01ca25e432963b619daa0098 ]

Fixing several unit name warnings:

Warning (unit_address_vs_reg): /oscillator@0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /oscillator@1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /oscillator@2: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-point@0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-point@1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/cpu_crit@0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/map@0: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/map@1: node has a unit name, but no reg property
Warning (unit_address_vs_reg): /reserved-memory/vpu_dma_mem_region: node has a reg or ranges property, but no unit name
Warning (simple_bus_reg): /soc/pinctrl@10005000: simple-bus unit address format error, expected "1000b000"
Warning (simple_bus_reg): /soc/interrupt-controller@10220000: simple-bus unit address format error, expected "10221000"

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Link: https://lore.kernel.org/r/20200210063523.133333-4-hsinyi@chromium.org
[mb: drop fixes for '_' in property name]
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index abd2f15a544b..bd9fc50ac154 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -223,21 +223,21 @@ psci {
 		cpu_on	      = <0x84000003>;
 	};
 
-	clk26m: oscillator@0 {
+	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 		clock-output-names = "clk26m";
 	};
 
-	clk32k: oscillator@1 {
+	clk32k: oscillator1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32000>;
 		clock-output-names = "clk32k";
 	};
 
-	cpum_ck: oscillator@2 {
+	cpum_ck: oscillator2 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
@@ -253,19 +253,19 @@ cpu_thermal: cpu_thermal {
 			sustainable-power = <1500>; /* milliwatts */
 
 			trips {
-				threshold: trip-point@0 {
+				threshold: trip-point0 {
 					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				target: trip-point@1 {
+				target: trip-point1 {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit@0 {
+				cpu_crit: cpu_crit0 {
 					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -273,12 +273,12 @@ cpu_crit: cpu_crit@0 {
 			};
 
 			cooling-maps {
-				map@0 {
+				map0 {
 					trip = <&target>;
 					cooling-device = <&cpu0 0 0>;
 					contribution = <3072>;
 				};
-				map@1 {
+				map1 {
 					trip = <&target>;
 					cooling-device = <&cpu2 0 0>;
 					contribution = <1024>;
@@ -291,7 +291,7 @@ reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		vpu_dma_reserved: vpu_dma_mem_region {
+		vpu_dma_reserved: vpu_dma_mem_region@b7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0xb7000000 0 0x500000>;
 			alignment = <0x1000>;
@@ -343,7 +343,7 @@ syscfg_pctl_a: syscfg_pctl_a@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
-		pio: pinctrl@10005000 {
+		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8173-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;
 			mediatek,pctl-regmap = <&syscfg_pctl_a>;
@@ -541,7 +541,7 @@ mipi_tx1: mipi-dphy@10216000 {
 			status = "disabled";
 		};
 
-		gic: interrupt-controller@10220000 {
+		gic: interrupt-controller@10221000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
-- 
2.25.1

