Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA569208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgCJI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:58:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54668 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJI6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:58:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3209F2004D7;
        Tue, 10 Mar 2020 09:58:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 934382004E2;
        Tue, 10 Mar 2020 09:58:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 71E85402E5;
        Tue, 10 Mar 2020 16:58:36 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Date:   Tue, 10 Mar 2020 16:52:16 +0800
Message-Id: <1583830337-23889-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the labels alphabetically for consistency.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 60 +++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 13460a3..2ed7aba 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -30,29 +30,8 @@
 	};
 };
 
-&adma_lpuart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart0>;
-	status = "okay";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
+&adma_dsp {
 	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-		};
-	};
 };
 
 &adma_i2c1 {
@@ -131,6 +110,35 @@
 	};
 };
 
+&adma_lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
+
+&scu_key {
+	status = "okay";
+};
+
 &usdhc1 {
 	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
 	assigned-clock-rates = <200000000>;
@@ -229,11 +237,3 @@
 		>;
 	};
 };
-
-&adma_dsp {
-	status = "okay";
-};
-
-&scu_key {
-	status = "okay";
-};
-- 
2.7.4

