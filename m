Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3183C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30FD207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFBGfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:35:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51528 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBGfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:35:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F04631A264E;
        Tue,  2 Jun 2020 08:35:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 34F061A2603;
        Tue,  2 Jun 2020 08:35:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2EFED402DF;
        Tue,  2 Jun 2020 14:35:07 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] ARM: dts: imx: Change sdhci node name on i.MX27/i.MX31 SoCs
Date:   Tue,  2 Jun 2020 14:24:50 +0800
Message-Id: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change i.MX27/i.MX31 node name from sdhci to mmc to be compliant
with yaml schema, it requires the nodename to be "mmc".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx27.dtsi | 6 +++---
 arch/arm/boot/dts/imx31.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index ee04771..47de96b 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -265,7 +265,7 @@
 				status = "disabled";
 			};
 
-			sdhci1: sdhci@10013000 {
+			sdhci1: mmc@10013000 {
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10013000 0x1000>;
 				interrupts = <11>;
@@ -277,7 +277,7 @@
 				status = "disabled";
 			};
 
-			sdhci2: sdhci@10014000 {
+			sdhci2: mmc@10014000 {
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10014000 0x1000>;
 				interrupts = <10>;
@@ -431,7 +431,7 @@
 				status = "disabled";
 			};
 
-			sdhci3: sdhci@1001e000 {
+			sdhci3: mmc@1001e000 {
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x1001e000 0x1000>;
 				interrupts = <9>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 4f3d7ab..eedf2d7 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -173,7 +173,7 @@
 			reg = <0x50000000 0x100000>;
 			ranges;
 
-			sdhci1: sdhci@50004000 {
+			sdhci1: mmc@50004000 {
 				compatible = "fsl,imx31-mmc";
 				reg = <0x50004000 0x4000>;
 				interrupts = <9>;
@@ -184,7 +184,7 @@
 				status = "disabled";
 			};
 
-			sdhci2: sdhci@50008000 {
+			sdhci2: mmc@50008000 {
 				compatible = "fsl,imx31-mmc";
 				reg = <0x50008000 0x4000>;
 				interrupts = <8>;
-- 
2.7.4

