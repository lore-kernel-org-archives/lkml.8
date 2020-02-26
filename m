Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E91EC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA14222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBZFmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:42:20 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40400 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgBZFmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:42:17 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0211216721;
        Wed, 26 Feb 2020 06:42:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63984216704;
        Wed, 26 Feb 2020 06:42:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A32BE402CA;
        Wed, 26 Feb 2020 13:41:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: Make iomuxc node name generic
Date:   Wed, 26 Feb 2020 13:36:18 +0800
Message-Id: <1582695378-25461-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582695378-25461-1-git-send-email-Anson.Huang@nxp.com>
References: <1582695378-25461-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, use "pinctrl" instead of "iomuxc"
for all i.MX6/7 SoCs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6q.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b3a128..bba25d0 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -86,7 +86,7 @@
 		};
 
 		aips1: bus@2000000 {
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6dl-iomuxc";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0fad13f..907cf83 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -181,7 +181,7 @@
 				};
 			};
 
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6q-iomuxc";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70fb8b5..8baad74 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -908,7 +908,7 @@
 				};
 			};
 
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6dl-iomuxc", "fsl,imx6q-iomuxc";
 				reg = <0x20e0000 0x4000>;
 			};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c8ec46f..0359902 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -728,7 +728,7 @@
 				reg = <0x020e0000 0x38>;
 			};
 
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6sl-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e47d346..43e36e1 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -806,7 +806,7 @@
 				};
 			};
 
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6sx-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index e1807e9..c53898b 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -693,7 +693,7 @@
 				interrupt-parent = <&intc>;
 			};
 
-			iomuxc: iomuxc@20e0000 {
+			iomuxc: pinctrl@20e0000 {
 				compatible = "fsl,imx6ul-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 196bbd6..6932600 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -490,7 +490,7 @@
 				status = "disabled";
 			};
 
-			iomuxc: iomuxc@30330000 {
+			iomuxc: pinctrl@30330000 {
 				compatible = "fsl,imx7d-iomuxc";
 				reg = <0x30330000 0x10000>;
 			};
-- 
2.7.4

