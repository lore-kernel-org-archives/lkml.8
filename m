Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D62206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Igs8SeG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgIDOHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:07:41 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60964 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbgIDOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:05:07 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084DM2qK005938;
        Fri, 4 Sep 2020 15:23:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=9tDNNyjW1JFlsbbCLIY7DyEV8OK1r9OXdF3FnYfERXw=;
 b=Igs8SeG/ZKp3N0XD8OfxBgvi/CRjxUi0S9+7BaZJ9q139ip+kCpiFe6mmtCBU71yMNnc
 4Z71DgRMm2U78YwyMo78Z4KWA6jt5CxjYxIGRsQ+kW9m5yaf7Sl1rTkJwCKPYIh/igvS
 U5TyC+njDLQHWmR28nlZ9XNq+t9q5Z5OB10PWGTV5ywvgm0H4Zci3iiovApvJWqUN5pI
 y+bDQc+Nz2GXdB6Ke+J2L4B9CFL6APrNREUMEWckiumicZ9V6SUqC1xfk15pm6DjtiTf
 yaDGGtDZmrtyP/g9qt/rYG6ub1C4qumM9c07c6Wq1dT6xGoXt2ik+C5hEbmpdJP6aKZ2 rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337csw9xvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 15:23:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FA1B10002A;
        Fri,  4 Sep 2020 15:23:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 447B82B0EBD;
        Fri,  4 Sep 2020 15:23:04 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep 2020 15:23:03
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <linux@armlinux.org.uk>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: add FMC2 EBI support for stm32mp157c
Date:   Fri, 4 Sep 2020 15:20:43 +0200
Message-ID: <1599225643-5558-3-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1599225643-5558-1-git-send-email-christophe.kerello@st.com>
References: <1599225643-5558-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_07:2020-09-04,2020-09-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FMC2 External Bus Interface support on stm32mp157c.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi     | 43 +++++++++++++++++++++++------------
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 16 +++++++------
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bfe2902..4fd7572 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1302,23 +1302,38 @@
 			dma-requests = <48>;
 		};
 
-		fmc: nand-controller@58002000 {
-			compatible = "st,stm32mp15-fmc2";
-			reg = <0x58002000 0x1000>,
-			      <0x80000000 0x1000>,
-			      <0x88010000 0x1000>,
-			      <0x88020000 0x1000>,
-			      <0x81000000 0x1000>,
-			      <0x89010000 0x1000>,
-			      <0x89020000 0x1000>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&mdma1 20 0x10 0x12000a02 0x0 0x0>,
-			       <&mdma1 20 0x10 0x12000a08 0x0 0x0>,
-			       <&mdma1 21 0x10 0x12000a0a 0x0 0x0>;
-			dma-names = "tx", "rx", "ecc";
+		fmc: memory-controller@58002000 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "st,stm32mp1-fmc2-ebi";
+			reg = <0x58002000 0x1000>;
 			clocks = <&rcc FMC_K>;
 			resets = <&rcc FMC_R>;
 			status = "disabled";
+
+			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
+				 <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
+				 <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
+				 <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
+				 <4 0 0x80000000 0x10000000>; /* NAND */
+
+			nand-controller@4,0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp1-fmc2-nfc";
+				reg = <4 0x00000000 0x1000>,
+				      <4 0x08010000 0x1000>,
+				      <4 0x08020000 0x1000>,
+				      <4 0x01000000 0x1000>,
+				      <4 0x09010000 0x1000>,
+				      <4 0x09020000 0x1000>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
+				       <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
+				       <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
+				dma-names = "tx", "rx", "ecc";
+				status = "disabled";
+			};
 		};
 
 		qspi: spi@58003000 {
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 85628e1..a55e80c 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -158,14 +158,16 @@
 	pinctrl-0 = <&fmc_pins_a>;
 	pinctrl-1 = <&fmc_sleep_pins_a>;
 	status = "okay";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
-	nand@0 {
-		reg = <0>;
-		nand-on-flash-bbt;
-		#address-cells = <1>;
-		#size-cells = <1>;
+	nand-controller@4,0 {
+		status = "okay";
+
+		nand@0 {
+			reg = <0>;
+			nand-on-flash-bbt;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
1.9.1

