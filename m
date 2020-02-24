Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA890C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F9C20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="NLuyiR9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBXQyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:54:31 -0500
Received: from vps.xff.cz ([195.181.215.36]:59666 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXQya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582563269; bh=bXleBqxpwvxMLnOw4FuIKeZikmPAgqyT4C7j2/p3/WA=;
        h=From:To:Cc:Subject:Date:From;
        b=NLuyiR9Q7d/imiTXP42D1TVu/I0SKzHae44k3Y8poVJnmljL5ZdzUVKleIRauIGnB
         Zl43UHhSc0bLaurhrdnLUFF7hRx3fVUGq4GpjblSQVPEqvvF7LZgaNAwmox58VdQPH
         Gwsp8ypgtPo9bZGbEcrRLELhN0XcH1HD2vQUDJd4=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ARM: dts: sun8i-a83t: Add thermal trip points/cooling maps
Date:   Mon, 24 Feb 2020 17:54:17 +0100
Message-Id: <20200224165417.334617-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables passive cooling by down-regulating CPU voltage
and frequency.

For the trip points, I used values from the BSP code directly.

The critical trip point value is 30°C above the maximum recommended
ambient temperature (70°C) for the SoC from the datasheet, so there's
some headroom even at such a high ambient temperature.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 60 +++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

v2:
- added more detail to the commit description

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 74ac7ee9383cf..53c2b6a836f27 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -72,7 +72,7 @@ cpu0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -83,7 +83,7 @@ cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -94,7 +94,7 @@ cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -116,7 +116,7 @@ cpu100: cpu@100 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@101 {
+		cpu101: cpu@101 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -127,7 +127,7 @@ cpu@101 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@102 {
+		cpu102: cpu@102 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -138,7 +138,7 @@ cpu@102 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@103 {
+		cpu103: cpu@103 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -1188,12 +1188,60 @@ cpu0_thermal: cpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu0_hot: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_very_hot: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu0_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1_thermal: cpu1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				cpu1_hot: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_very_hot: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu1_hot>;
+					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu_thermal: gpu-thermal {
-- 
2.25.1

