Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C71206BE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgGFVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:13:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55272 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFVNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:13:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C891200747;
        Mon,  6 Jul 2020 23:13:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F0A120057C;
        Mon,  6 Jul 2020 23:13:47 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 20321203C3;
        Mon,  6 Jul 2020 23:13:47 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2] arm64: dts: imx8m: Add NOC nodes
Date:   Tue,  7 Jul 2020 00:13:26 +0300
Message-Id: <1594070006-816-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Add nodes for the main interconnect of the imx8m series chips.

These nodes are bound to by devfreq and interconnect drivers.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Changes since v1:
 - picked up the bindinds header which were part of the original patch
   from Leonard

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 ++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 ++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 76f040e..970d132 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mm.h>
 
 #include "imx8mm-pinfunc.h"
 
@@ -877,6 +878,29 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150M {
+					opp-hz = /bits/ 64 <150000000>;
+				};
+				opp-375M {
+					opp-hz = /bits/ 64 <375000000>;
+				};
+				opp-750M {
+					opp-hz = /bits/ 64 <750000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9385dd7..cd38aae 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mn.h>
 
 #include "imx8mn-pinfunc.h"
 
@@ -764,6 +765,29 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MN_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100M {
+					opp-hz = /bits/ 64 <100000000>;
+				};
+				opp-600M {
+					opp-hz = /bits/ 64 <600000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f70435c..d585650 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -11,6 +11,7 @@
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
 
 / {
@@ -1045,6 +1046,29 @@
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+				opp-400M {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.7.4

