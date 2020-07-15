Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63201C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5612067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGOGzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:55:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34616 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbgGOGzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:55:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8983E1A03AA;
        Wed, 15 Jul 2020 08:55:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7FD31A03D4;
        Wed, 15 Jul 2020 08:55:38 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E7E02402BF;
        Wed, 15 Jul 2020 14:55:33 +0800 (SGT)
From:   andy.tang@nxp.com
To:     shawnguo@kernel.org
Cc:     amit.kucheria@linaro.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/2 v2] arm64: dts: ls208xa: add more thermal zone support
Date:   Wed, 15 Jul 2020 14:49:09 +0800
Message-Id: <20200715064909.9161-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715064909.9161-1-andy.tang@nxp.com>
References: <20200715064909.9161-1-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

There are 7 thermal zones in ls208xa soc. Add the other thermal zone
nodes to enable them.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v2:
	- remove useless alert trip
	- add cooling-map to core cluster zones.

 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 141 ++++++++++++++++--
 1 file changed, 132 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 41102dacc2e1..cc36c969dd9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -79,20 +79,62 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		ddr-controller1 {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
 
+			trips {
+				ddr-ctrler1-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-controller2 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 2>;
+
+			trips {
+				ddr-ctrler2-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr-controller3 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 3>;
+
+			trips {
+				ddr-ctrler3-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		core-cluster1 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
 
 			trips {
-				cpu_alert: cpu-alert {
-					temperature = <75000>;
+				core_cluster1_alert: core-cluster1-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit: cpu-crit {
-					temperature = <85000>;
+
+				core-cluster1-crit {
+					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -100,14 +142,95 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&core_cluster1_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		core-cluster2 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 5>;
+
+			trips {
+				core_cluster2_alert: core-cluster2-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				core-cluster2-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&core_cluster2_alert>;
+					cooling-device =
 						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		core-cluster3 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 6>;
+
+			trips {
+				core_cluster3_alert: core-cluster3-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				core-cluster3-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&core_cluster3_alert>;
+					cooling-device =
 						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		core-cluster4 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 7>;
+
+			trips {
+				core_cluster4_alert: core-cluster4-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				core-cluster4-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&core_cluster4_alert>;
+					cooling-device =
 						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
-- 
2.17.1

