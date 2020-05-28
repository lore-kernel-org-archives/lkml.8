Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE3AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A2C2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgE1DXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:23:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55698 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgE1DXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:23:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 941261A0A5E;
        Thu, 28 May 2020 05:23:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A43B41A0A63;
        Thu, 28 May 2020 05:23:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7D0E8402BF;
        Thu, 28 May 2020 11:22:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, peng.fan@nxp.com, aford173@gmail.com,
        jun.li@nxp.com, shengjiu.wang@nxp.com, horia.geanta@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, agx@sigxcpu.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] ARM: dts: imx: change ocotp node name on i.MX6/7 SoCs
Date:   Thu, 28 May 2020 11:12:47 +0800
Message-Id: <1590635570-8541-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
References: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change OCOTP node name from ocotp-ctrl to efuse to be compliant with
yaml schema, it requires the nodename to be one of "eeprom|efuse|nvram".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 arch/arm/boot/dts/imx7ulp.dtsi | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 43d44d5..e14a6f2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1162,7 +1162,7 @@
 				status = "disabled";
 			};
 
-			ocotp: ocotp-ctrl@21bc000 {
+			ocotp: efuse@21bc000 {
 				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6QDL_CLK_IIM>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d8efc0a..11e7bf3 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -952,7 +952,7 @@
 				status = "disabled";
 			};
 
-			ocotp: ocotp-ctrl@21bc000 {
+			ocotp: efuse@21bc000 {
 				compatible = "fsl,imx6sl-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SL_CLK_OCOTP>;
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index bf7f048..b715aa7 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -786,7 +786,7 @@
 				clocks = <&clks IMX6SLL_CLK_MMDC_P0_IPG>;
 			};
 
-			ocotp: ocotp-ctrl@21bc000 {
+			ocotp: efuse@21bc000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6sll-ocotp", "syscon";
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8c4473b..5cccf69 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1053,7 +1053,7 @@
 				status = "disabled";
 			};
 
-			ocotp: ocotp-ctrl@21bc000 {
+			ocotp: efuse@21bc000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6sx-ocotp", "syscon";
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 505fd4f..a7a85c2 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -946,7 +946,7 @@
 				status = "disabled";
 			};
 
-			ocotp: ocotp-ctrl@21bc000 {
+			ocotp: efuse@21bc000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6ul-ocotp", "syscon";
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 3904558..4771d70 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -526,7 +526,7 @@
 				};
 			};
 
-			ocotp: ocotp-ctrl@30350000 {
+			ocotp: efuse@30350000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx7d-ocotp", "syscon";
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index f7c4878..3674396 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -452,7 +452,7 @@
 			reg = <0x410a3000 0x1000>;
 		};
 
-		ocotp: ocotp-ctrl@410a6000 {
+		ocotp: efuse@410a6000 {
 			compatible = "fsl,imx7ulp-ocotp", "syscon";
 			reg = <0x410a6000 0x4000>;
 			clocks = <&scg1 IMX7ULP_CLK_DUMMY>;
-- 
2.7.4

