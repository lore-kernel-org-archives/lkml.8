Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F83C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AACB207DA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFBGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:35:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39390 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFBGfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:35:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA88120096A;
        Tue,  2 Jun 2020 08:35:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC807200971;
        Tue,  2 Jun 2020 08:35:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F8CD4031F;
        Tue,  2 Jun 2020 14:35:08 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] ARM: dts: imx: Change esdhc node name on i.MX2/i.MX3/i.MX5 SoCs
Date:   Tue,  2 Jun 2020 14:24:51 +0800
Message-Id: <1591079092-18625-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
References: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change i.MX2/i.MX3/i.MX5 SoCs esdhc node name from esdhc to mmc to
be compliant with yaml schema, it requires the nodename to be "mmc".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx25.dtsi | 4 ++--
 arch/arm/boot/dts/imx35.dtsi | 6 +++---
 arch/arm/boot/dts/imx50.dtsi | 8 ++++----
 arch/arm/boot/dts/imx51.dtsi | 8 ++++----
 arch/arm/boot/dts/imx53.dtsi | 8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 4eaf4eb..b045c6d 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -453,7 +453,7 @@
 				interrupts = <22>;
 			};
 
-			esdhc1: esdhc@53fb4000 {
+			esdhc1: mmc@53fb4000 {
 				compatible = "fsl,imx25-esdhc";
 				reg = <0x53fb4000 0x4000>;
 				interrupts = <9>;
@@ -462,7 +462,7 @@
 				status = "disabled";
 			};
 
-			esdhc2: esdhc@53fb8000 {
+			esdhc2: mmc@53fb8000 {
 				compatible = "fsl,imx25-esdhc";
 				reg = <0x53fb8000 0x4000>;
 				interrupts = <8>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 502112b..e154087 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -231,7 +231,7 @@
 				#interrupt-cells = <2>;
 			};
 
-			esdhc1: esdhc@53fb4000 {
+			esdhc1: mmc@53fb4000 {
 				compatible = "fsl,imx35-esdhc";
 				reg = <0x53fb4000 0x4000>;
 				interrupts = <7>;
@@ -240,7 +240,7 @@
 				status = "disabled";
 			};
 
-			esdhc2: esdhc@53fb8000 {
+			esdhc2: mmc@53fb8000 {
 				compatible = "fsl,imx35-esdhc";
 				reg = <0x53fb8000 0x4000>;
 				interrupts = <8>;
@@ -249,7 +249,7 @@
 				status = "disabled";
 			};
 
-			esdhc3: esdhc@53fbc000 {
+			esdhc3: mmc@53fbc000 {
 				compatible = "fsl,imx35-esdhc";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <9>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 1f4ecbc..377951a 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -115,7 +115,7 @@
 				reg = <0x50000000 0x40000>;
 				ranges;
 
-				esdhc1: esdhc@50004000 {
+				esdhc1: mmc@50004000 {
 					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
@@ -127,7 +127,7 @@
 					status = "disabled";
 				};
 
-				esdhc2: esdhc@50008000 {
+				esdhc2: mmc@50008000 {
 					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
@@ -176,7 +176,7 @@
 					status = "disabled";
 				};
 
-				esdhc3: esdhc@50020000 {
+				esdhc3: mmc@50020000 {
 					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
@@ -188,7 +188,7 @@
 					status = "disabled";
 				};
 
-				esdhc4: esdhc@50024000 {
+				esdhc4: mmc@50024000 {
 					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index c83bc77..db5827d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -185,7 +185,7 @@
 				reg = <0x70000000 0x40000>;
 				ranges;
 
-				esdhc1: esdhc@70004000 {
+				esdhc1: mmc@70004000 {
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70004000 0x4000>;
 					interrupts = <1>;
@@ -196,7 +196,7 @@
 					status = "disabled";
 				};
 
-				esdhc2: esdhc@70008000 {
+				esdhc2: mmc@70008000 {
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
@@ -245,7 +245,7 @@
 					status = "disabled";
 				};
 
-				esdhc3: esdhc@70020000 {
+				esdhc3: mmc@70020000 {
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
@@ -257,7 +257,7 @@
 					status = "disabled";
 				};
 
-				esdhc4: esdhc@70024000 {
+				esdhc4: mmc@70024000 {
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ed6b0c8..9a4fc99 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -236,7 +236,7 @@
 				reg = <0x50000000 0x40000>;
 				ranges;
 
-				esdhc1: esdhc@50004000 {
+				esdhc1: mmc@50004000 {
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
@@ -248,7 +248,7 @@
 					status = "disabled";
 				};
 
-				esdhc2: esdhc@50008000 {
+				esdhc2: mmc@50008000 {
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
@@ -301,7 +301,7 @@
 					status = "disabled";
 				};
 
-				esdhc3: esdhc@50020000 {
+				esdhc3: mmc@50020000 {
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
@@ -313,7 +313,7 @@
 					status = "disabled";
 				};
 
-				esdhc4: esdhc@50024000 {
+				esdhc4: mmc@50024000 {
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
-- 
2.7.4

