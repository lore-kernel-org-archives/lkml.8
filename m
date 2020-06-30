Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3A6206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgF3D0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:26:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54832 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgF3D0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:26:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD88C201286;
        Tue, 30 Jun 2020 05:26:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DE4F201280;
        Tue, 30 Jun 2020 05:26:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A330402F0;
        Tue, 30 Jun 2020 11:26:12 +0800 (SGT)
From:   andy.tang@nxp.com
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/2] arm64: dts: ls208xa: add more thermal zone support
Date:   Tue, 30 Jun 2020 11:20:14 +0800
Message-Id: <20200630032014.22956-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630032014.22956-1-andy.tang@nxp.com>
References: <20200630032014.22956-1-andy.tang@nxp.com>
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
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 132 +++++++++++++++++-
 1 file changed, 126 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3944ef16ec60..019e99826645 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -78,28 +78,88 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		ddr-controller1 {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
 
-			thermal-sensors = <&tmu 4>;
+			trips {
+				ddr-ctrler1-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
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
+				ddr-ctrler2-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
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
 
 			trips {
-				cpu_alert: cpu-alert {
-					temperature = <75000>;
+				ddr-ctrler3-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit: cpu-crit {
+
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
+			thermal-sensors = <&tmu 4>;
+
+			trips {
+				core_cluster1_alert: core-cluster1-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				core_cluster1_crit: core-cluster1-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&core_cluster1_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -112,6 +172,66 @@
 				};
 			};
 		};
+
+		core-cluster2 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 5>;
+
+			trips {
+				core-cluster2-alert {
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
+		};
+
+		core-cluster3 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 6>;
+
+			trips {
+				core-cluster3-alert {
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
+		};
+
+		core-cluster4 {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 7>;
+
+			trips {
+				core-cluster4-alert {
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
+		};
 	};
 
 	timer {
-- 
2.17.1

