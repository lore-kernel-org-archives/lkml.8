Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA7DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A662072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFBGfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:35:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51744 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFBGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:35:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F85C1A266B;
        Tue,  2 Jun 2020 08:35:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC9351A0BEC;
        Tue,  2 Jun 2020 08:35:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F6CB4030C;
        Tue,  2 Jun 2020 14:35:08 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] ARM: dts: imx: Change usdhc node name on i.MX6/i.MX7 SoCs
Date:   Tue,  2 Jun 2020 14:24:52 +0800
Message-Id: <1591079092-18625-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
References: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change i.MX6/i.MX7 SoCs usdhc node name from usdhc to mmc to be
compliant with yaml schema, it requires the nodename to be "mmc".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 arch/arm/boot/dts/imx6sl.dtsi  | 8 ++++----
 arch/arm/boot/dts/imx6sx.dtsi  | 8 ++++----
 arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
 arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index deb09df..346a52f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1056,7 +1056,7 @@
 					     <0 126 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			usdhc1: usdhc@2190000 {
+			usdhc1: mmc@2190000 {
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -1068,7 +1068,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc@2194000 {
+			usdhc2: mmc@2194000 {
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -1080,7 +1080,7 @@
 				status = "disabled";
 			};
 
-			usdhc3: usdhc@2198000 {
+			usdhc3: mmc@2198000 {
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
@@ -1092,7 +1092,7 @@
 				status = "disabled";
 			};
 
-			usdhc4: usdhc@219c000 {
+			usdhc4: mmc@219c000 {
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 11e7bf3..e2d2532 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -854,7 +854,7 @@
 				status = "disabled";
 			};
 
-			usdhc1: usdhc@2190000 {
+			usdhc1: mmc@2190000 {
 				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -866,7 +866,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc@2194000 {
+			usdhc2: mmc@2194000 {
 				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -878,7 +878,7 @@
 				status = "disabled";
 			};
 
-			usdhc3: usdhc@2198000 {
+			usdhc3: mmc@2198000 {
 				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
@@ -890,7 +890,7 @@
 				status = "disabled";
 			};
 
-			usdhc4: usdhc@219c000 {
+			usdhc4: mmc@219c000 {
 				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 995e1b1..430c21a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -943,7 +943,7 @@
 				status = "disabled";
 			};
 
-			usdhc1: usdhc@2190000 {
+			usdhc1: mmc@2190000 {
 				compatible = "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -955,7 +955,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc@2194000 {
+			usdhc2: mmc@2194000 {
 				compatible = "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -967,7 +967,7 @@
 				status = "disabled";
 			};
 
-			usdhc3: usdhc@2198000 {
+			usdhc3: mmc@2198000 {
 				compatible = "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
@@ -979,7 +979,7 @@
 				status = "disabled";
 			};
 
-			usdhc4: usdhc@219c000 {
+			usdhc4: mmc@219c000 {
 				compatible = "fsl,imx6sx-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 2d64802..e5aab37 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -861,7 +861,7 @@
 				status = "disabled";
 			};
 
-			usdhc1: usdhc@2190000 {
+			usdhc1: mmc@2190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -875,7 +875,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc@2194000 {
+			usdhc2: mmc@2194000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 3cba731..1cfaf41 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1126,7 +1126,7 @@
 				reg = <0x30b30200 0x200>;
 			};
 
-			usdhc1: usdhc@30b40000 {
+			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -1138,7 +1138,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc@30b50000 {
+			usdhc2: mmc@30b50000 {
 				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -1150,7 +1150,7 @@
 				status = "disabled";
 			};
 
-			usdhc3: usdhc@30b60000 {
+			usdhc3: mmc@30b60000 {
 				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4

