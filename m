Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8DD20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="CkrTLh5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHGI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgHGI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:28:32 -0400
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A1C061575;
        Fri,  7 Aug 2020 01:28:31 -0700 (PDT)
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id 33507962D5;
        Fri,  7 Aug 2020 08:28:25 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id 094C540118;
        Fri,  7 Aug 2020 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596788905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nWPayKsCIQcmixUKDuEmF/he+X5xSVTlAUFKbJ8mW0=;
        b=CkrTLh5h04i7Le5rTWBBxhc1acReVqrrXQ2qvguWyaEVawgkG/ingM382Ko1xFEn7YSoce
        +VwscJ8+nm7JI0rEugwdQWYE/SPHt66W/vXqBPmw0l76AEMRVIwpaOFeXpsI+NHLpDFDsO
        kZHV22jPTil5/jjGr2UM18pC7Z06lrE=
Received: from localhost.localdomain (fttx-pool-37.60.0.190.bambit.de [37.60.0.190])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 6DE5C8031C;
        Fri,  7 Aug 2020 08:28:24 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
Date:   Fri,  7 Aug 2020 10:27:53 +0200
Message-Id: <20200807082754.6790-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807082754.6790-1-linux@fw-web.de>
References: <20200807082754.6790-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

mt7623a has no graphics support so move nodes
from generic mt7623.dtsi to mt7623n.dtsi

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/boot/dts/mt7623.dtsi  | 99 ----------------------------------
 arch/arm/boot/dts/mt7623n.dtsi | 99 ++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index d94f24eb7f43..d09b5671c91b 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -14,7 +14,6 @@
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/reset/mt2701-resets.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -297,17 +296,6 @@ timer: timer@10008000 {
 		clock-names = "system-clk", "rtc-clk";
 	};
 
-	smi_common: smi@1000c000 {
-		compatible = "mediatek,mt7623-smi-common",
-			     "mediatek,mt2701-smi-common";
-		reg = <0 0x1000c000 0 0x1000>;
-		clocks = <&infracfg CLK_INFRA_SMI>,
-			 <&mmsys CLK_MM_SMI_COMMON>,
-			 <&infracfg CLK_INFRA_SMI>;
-		clock-names = "apb", "smi", "async";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
-	};
-
 	pwrap: pwrap@1000d000 {
 		compatible = "mediatek,mt7623-pwrap",
 			     "mediatek,mt2701-pwrap";
@@ -339,17 +327,6 @@ sysirq: interrupt-controller@10200100 {
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
-	iommu: mmsys_iommu@10205000 {
-		compatible = "mediatek,mt7623-m4u",
-			     "mediatek,mt2701-m4u";
-		reg = <0 0x10205000 0 0x1000>;
-		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&infracfg CLK_INFRA_M4U>;
-		clock-names = "bclk";
-		mediatek,larbs = <&larb0 &larb1 &larb2>;
-		#iommu-cells = <1>;
-	};
-
 	efuse: efuse@10206000 {
 		compatible = "mediatek,mt7623-efuse",
 			     "mediatek,mt8173-efuse";
@@ -725,70 +702,6 @@ mmc0: mmc@11230000 {
 		status = "disabled";
 	};
 
-	g3dsys: syscon@13000000 {
-		compatible = "mediatek,mt7623-g3dsys",
-			     "mediatek,mt2701-g3dsys",
-			     "syscon";
-		reg = <0 0x13000000 0 0x200>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	mmsys: syscon@14000000 {
-		compatible = "mediatek,mt7623-mmsys",
-			     "mediatek,mt2701-mmsys",
-			     "syscon";
-		reg = <0 0x14000000 0 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	larb0: larb@14010000 {
-		compatible = "mediatek,mt7623-smi-larb",
-			     "mediatek,mt2701-smi-larb";
-		reg = <0 0x14010000 0 0x1000>;
-		mediatek,smi = <&smi_common>;
-		mediatek,larb-id = <0>;
-		clocks = <&mmsys CLK_MM_SMI_LARB0>,
-			 <&mmsys CLK_MM_SMI_LARB0>;
-		clock-names = "apb", "smi";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
-	};
-
-	imgsys: syscon@15000000 {
-		compatible = "mediatek,mt7623-imgsys",
-			     "mediatek,mt2701-imgsys",
-			     "syscon";
-		reg = <0 0x15000000 0 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	larb2: larb@15001000 {
-		compatible = "mediatek,mt7623-smi-larb",
-			     "mediatek,mt2701-smi-larb";
-		reg = <0 0x15001000 0 0x1000>;
-		mediatek,smi = <&smi_common>;
-		mediatek,larb-id = <2>;
-		clocks = <&imgsys CLK_IMG_SMI_COMM>,
-			 <&imgsys CLK_IMG_SMI_COMM>;
-		clock-names = "apb", "smi";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-	};
-
-	jpegdec: jpegdec@15004000 {
-		compatible = "mediatek,mt7623-jpgdec",
-			     "mediatek,mt2701-jpgdec";
-		reg = <0 0x15004000 0 0x1000>;
-		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
-			  <&imgsys CLK_IMG_JPGDEC>;
-		clock-names = "jpgdec-smi",
-			      "jpgdec";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
-		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
-			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
-	};
-
 	vdecsys: syscon@16000000 {
 		compatible = "mediatek,mt7623-vdecsys",
 			     "mediatek,mt2701-vdecsys",
@@ -797,18 +710,6 @@ vdecsys: syscon@16000000 {
 		#clock-cells = <1>;
 	};
 
-	larb1: larb@16010000 {
-		compatible = "mediatek,mt7623-smi-larb",
-			     "mediatek,mt2701-smi-larb";
-		reg = <0 0x16010000 0 0x1000>;
-		mediatek,smi = <&smi_common>;
-		mediatek,larb-id = <1>;
-		clocks = <&vdecsys CLK_VDEC_CKGEN>,
-			 <&vdecsys CLK_VDEC_LARB>;
-		clock-names = "apb", "smi";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
-	};
-
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
index 7724a4d05b89..a47e82468895 100644
--- a/arch/arm/boot/dts/mt7623n.dtsi
+++ b/arch/arm/boot/dts/mt7623n.dtsi
@@ -7,8 +7,18 @@
  */
 
 #include "mt7623.dtsi"
+#include <dt-bindings/memory/mt2701-larb-port.h>
 
 / {
+	g3dsys: syscon@13000000 {
+		compatible = "mediatek,mt7623-g3dsys",
+			     "mediatek,mt2701-g3dsys",
+			     "syscon";
+		reg = <0 0x13000000 0 0x200>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	mali: gpu@13040000 {
 		compatible = "mediatek,mt7623-mali", "arm,mali-450";
 		reg = <0 0x13040000 0 0x30000>;
@@ -32,4 +42,93 @@ mali: gpu@13040000 {
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
 		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
 	};
+
+	mmsys: syscon@14000000 {
+		compatible = "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys",
+			     "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	larb0: larb@14010000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x14010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <0>;
+		clocks = <&mmsys CLK_MM_SMI_LARB0>,
+			 <&mmsys CLK_MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
+	larb1: larb@16010000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x16010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <1>;
+		clocks = <&vdecsys CLK_VDEC_CKGEN>,
+			 <&vdecsys CLK_VDEC_LARB>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
+	};
+
+	larb2: larb@15001000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x15001000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <2>;
+		clocks = <&imgsys CLK_IMG_SMI_COMM>,
+			 <&imgsys CLK_IMG_SMI_COMM>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+	};
+
+	imgsys: syscon@15000000 {
+		compatible = "mediatek,mt7623-imgsys",
+			     "mediatek,mt2701-imgsys",
+			     "syscon";
+		reg = <0 0x15000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	iommu: mmsys_iommu@10205000 {
+		compatible = "mediatek,mt7623-m4u",
+			     "mediatek,mt2701-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb0 &larb1 &larb2>;
+		#iommu-cells = <1>;
+	};
+
+	jpegdec: jpegdec@15004000 {
+		compatible = "mediatek,mt7623-jpgdec",
+			     "mediatek,mt2701-jpgdec";
+		reg = <0 0x15004000 0 0x1000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+			  <&imgsys CLK_IMG_JPGDEC>;
+		clock-names = "jpgdec-smi",
+			      "jpgdec";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+		mediatek,larb = <&larb2>;
+		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+	};
+
+	smi_common: smi@1000c000 {
+		compatible = "mediatek,mt7623-smi-common",
+			     "mediatek,mt2701-smi-common";
+		reg = <0 0x1000c000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_SMI>,
+			 <&mmsys CLK_MM_SMI_COMMON>,
+			 <&infracfg CLK_INFRA_SMI>;
+		clock-names = "apb", "smi", "async";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
 };
-- 
2.25.1

