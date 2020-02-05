Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13FDC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9129217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBEObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:02 -0500
Received: from comms.puri.sm ([159.203.221.185]:48826 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgBEObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 999CBE049D;
        Wed,  5 Feb 2020 06:31:00 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8X0Ugy737Zw9; Wed,  5 Feb 2020 06:30:59 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 03/12] arm64: dts: librem5-devkit: allow modem to wake the system from suspend
Date:   Wed,  5 Feb 2020 15:29:54 +0100
Message-Id: <20200205143003.28408-4-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Connect the WoWWAN signal to a gpio key to wake up the system from suspend.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 8162576e8f3d..ac6ba227e1da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -33,7 +33,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
+		pinctrl-0 = <&pinctrl_gpio_keys>, <&pinctrl_wwan_in>;
 
 		btn1 {
 			label = "VOL_UP";
@@ -55,6 +55,15 @@
 			wakeup-source;
 			linux,code = <KEY_HP>;
 		};
+
+		wwan_wake {
+			label = "WWAN_WAKE";
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <8 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+			linux,code = <KEY_PHONE>;
+		};
 	};
 
 	leds {
@@ -767,11 +776,19 @@
 		>;
 	};
 
-	pinctrl_wwan: wwangrp {
+	pinctrl_wwan_in: wwaningrp {
+		fsl,pins = <
+		/* nWoWWAN */
+		MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80
+		>;
+	};
+
+	pinctrl_wwan_out: wwanoutgrp {
 		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4	0x09 /* nWWAN_DISABLE */
-			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80 /* nWoWWAN */
-			MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19 /* WWAN_RESET */
+		/* nWWAN_DISABLE */
+		MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4	0x09
+		/* WWAN_RESET */
+		MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19
 		>;
 	};
 };
-- 
2.20.1

