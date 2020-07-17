Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C1C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E0D204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001666;
	bh=fsR2V9nMIGiFHgCWlU7kwwTgW3J9FqqBZRna6Su3DBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9Y+4YK3LgyPpQQdkdfwbJpLkDDtFmx5lGtGm5n02HrXsu7E8Ik+TU+hEwgYsaXku
	 YdtT2W7A9AGPQtPd+x5UFjQK0+SgmskZsNizs+UjMNd7sRbiX3s+lLYczixDKzncHd
	 VaGWS+qQKjUSC5rmBik6fGWt0QvNmcI9R210cTHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGQQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGQQBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:01:01 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0772083B;
        Fri, 17 Jul 2020 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001660;
        bh=fsR2V9nMIGiFHgCWlU7kwwTgW3J9FqqBZRna6Su3DBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZG2Ki6oBuZkZFWpVRuw/FgN0huucmjfwGn0ka0zUewV80jHFJ7v8SPNJdafLGUMXm
         7vLIbOJ9ED5wYqUBGvHFMQbzutmOVK0h+G1BRcS4xGDyrnK+KIFtN1BMDURTvc7mk+
         X6J3rQUcAWf8aNOtE5ll2mAJy+dPHux8gwQQdDJ8=
Received: by wens.tw (Postfix, from userid 1000)
        id 3FABF5FD07; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: dts: allwinner: h5: Add trip and cooling maps to CPU thermal zones
Date:   Sat, 18 Jul 2020 00:00:50 +0800
Message-Id: <20200717160053.31191-6-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

This enables passive cooling by down-regulating CPU voltage and frequency.
The trip points were copied from the H3.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 09523f6011c5..6735e316a39c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -3,6 +3,8 @@
 
 #include <arm/sunxi-h3-h5.dtsi>
 
+#include <dt-bindings/thermal/thermal.h>
+
 / {
 	cpus {
 		#address-cells = <1>;
@@ -15,6 +17,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -24,6 +27,7 @@ cpu1: cpu@1 {
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -33,6 +37,7 @@ cpu2: cpu@2 {
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -42,6 +47,7 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -173,6 +179,30 @@ cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_hot_trip: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu_thermal {
-- 
2.27.0

