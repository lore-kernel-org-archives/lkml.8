Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE451C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4E820731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgELVy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:54:26 -0400
Received: from lists.gateworks.com ([108.161.130.12]:51387 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbgELVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:54:25 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jYctT-0007Fl-Pl; Tue, 12 May 2020 21:56:55 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw5910: add support for bcm4330-bt
Date:   Tue, 12 May 2020 14:54:15 -0700
Message-Id: <1589320455-23844-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sterling-LWB has a BCM4330 which has a UART based bluetooth
HCI. Add support for binding to the bcm_hci driver to take care
of handling the shutdown gpio and loading firmware.

Because the shutdown gpio is more of an enable than a regulator
go ahead and replace the regulator with a shutdown-gpio.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 30fe47f..b850f8f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -83,19 +83,6 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
-
-	reg_bt: regulator-bt {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_bt>;
-		compatible = "regulator-fixed";
-		regulator-name = "bt";
-		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <100>;
-		enable-active-high;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
 };
 
 
@@ -231,9 +218,14 @@
 /* Sterling-LWB Bluetooth */
 &uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
+	pinctrl-0 = <&pinctrl_uart4>,<&pinctrl_bten>;
 	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		shutdown-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 /* GPS */
@@ -288,6 +280,12 @@
 		>;
 	};
 
+	pinctrl_bten: btengrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b1
+		>;
+	};
+
 	pinctrl_ecspi3: escpi3grp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
@@ -393,12 +391,6 @@
 		>;
 	};
 
-	pinctrl_reg_bt: regbtgrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b1
-		>;
-	};
-
 	pinctrl_reg_wl: regwlgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x1b0b1
-- 
2.7.4

