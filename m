Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgF2UC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:02:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38474 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgF2Tjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:39:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB92C200F4E;
        Mon, 29 Jun 2020 09:51:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB19B200F49;
        Mon, 29 Jun 2020 09:51:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B6161402E0;
        Mon, 29 Jun 2020 15:51:11 +0800 (SGT)
From:   andy.tang@nxp.com
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/2] arm64: dts: ls1046a: add more thermal zone support
Date:   Mon, 29 Jun 2020 15:45:18 +0800
Message-Id: <20200629074519.28851-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

There are 5 thermal zones in ls1046a soc. Add the rest thermal zone
nodes to enable them.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 88 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index d4c1da3d4bde..9896379309d8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -117,19 +117,79 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		ddr-controller {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				ddr-ctrler-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				ddr-ctrler-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		serdes {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+
+			trips {
+				serdes-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				serdes-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		fman {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 2>;
+
+			trips {
+				fman-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				fman-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		core-cluster {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
 
 			trips {
-				cpu_alert: cpu-alert {
+				core_cluster_alert: core-cluster-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu-crit {
+				core_cluster_crit: core-cluster-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -138,7 +198,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&core_cluster_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -147,6 +207,26 @@
 				};
 			};
 		};
+
+		sec {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 4>;
+
+			trips {
+				sec-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				sec-crit {
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

