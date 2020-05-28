Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0856A20890
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgE1DXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:23:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55764 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgE1DXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:23:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 385F81A0BA1;
        Thu, 28 May 2020 05:23:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D1D31A0A6D;
        Thu, 28 May 2020 05:23:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E725E402FB;
        Thu, 28 May 2020 11:22:57 +0800 (SGT)
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
Subject: [PATCH 4/4] ARM: dts: imx: change iim node name on i.MX SoCs
Date:   Thu, 28 May 2020 11:12:50 +0800
Message-Id: <1590635570-8541-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
References: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change IIM node name from iim to efuse to be compliant
with yaml schema, it requires the nodename to be one of
"eeprom|efuse|nvram".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 arch/arm/boot/dts/imx31.dtsi | 2 +-
 arch/arm/boot/dts/imx35.dtsi | 2 +-
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 1123e683..4eaf4eb 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -542,7 +542,7 @@
 				interrupts = <26>;
 			};
 
-			iim: iim@53ff0000 {
+			iim: efuse@53ff0000 {
 				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 002cd22..ee04771 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -540,7 +540,7 @@
 				#clock-cells = <1>;
 			};
 
-			iim: iim@10028000 {
+			iim: efuse@10028000 {
 				compatible = "fsl,imx27-iim";
 				reg = <0x10028000 0x1000>;
 				interrupts = <62>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 18270ec..4f3d7ab 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -217,7 +217,7 @@
 				status = "disabled";
 			};
 
-			iim: iim@5001c000 {
+			iim: efuse@5001c000 {
 				compatible = "fsl,imx31-iim", "fsl,imx27-iim";
 				reg = <0x5001c000 0x1000>;
 				interrupts = <19>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 2ebf2c1..502112b 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -320,7 +320,7 @@
 				status = "disabled";
 			};
 
-			iim@53ff0000 {
+			efuse@53ff0000 {
 				compatible = "fsl,imx35-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index d3583aa..c83bc77 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -466,7 +466,7 @@
 				reg = <0x83f00000 0x60>;
 			};
 
-			iim: iim@83f98000 {
+			iim: efuse@83f98000 {
 				compatible = "fsl,imx51-iim", "fsl,imx27-iim";
 				reg = <0x83f98000 0x4000>;
 				interrupts = <69>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index afa57bf..ed6b0c8 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -667,7 +667,7 @@
 				reg = <0x63f00000 0x60>;
 			};
 
-			iim: iim@63f98000 {
+			iim: efuse@63f98000 {
 				compatible = "fsl,imx53-iim", "fsl,imx27-iim";
 				reg = <0x63f98000 0x4000>;
 				interrupts = <69>;
-- 
2.7.4

