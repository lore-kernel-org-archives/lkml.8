Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C811D2223D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgDPOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:52:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgDPOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:51:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 00BA52A21ED
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4C63F4800F7; Thu, 16 Apr 2020 16:51:38 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>,
        Samu Nuutamo <samu.nuutamo@vincit.fi>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Date:   Thu, 16 Apr 2020 16:51:23 +0200
Message-Id: <20200416145123.73039-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Ray <ian.ray@ge.com>

Use kernel LED interface for the alarm LEDs.

Signed-off-by: Ian Ray <ian.ray@ge.com>
[Rebased]
Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
[Rebased]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 49 +++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 5ff9a179c83c..34ce41600098 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -176,7 +176,7 @@ pwm_bl: backlight {
 		power-supply = <&reg_3v3_lcd>;
 	};
 
-	leds {
+	leds-brightness {
 		compatible = "pwm-leds";
 
 		alarm-brightness {
@@ -185,6 +185,32 @@ alarm-brightness {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_alarmled_pins>;
+
+		alarm1 {
+			label = "alarm:red";
+			gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		alarm2 {
+			label = "alarm:yellow";
+			gpios = <&gpio7 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		alarm3 {
+			label = "alarm:blue";
+			gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		alarm4 {
+			label = "alarm:silenced";
+			gpios = <&gpio7 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	gpio-poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
@@ -909,18 +935,10 @@ MX53_PAD_NANDF_CS2__GPIO6_15		0x0
 			MX53_PAD_NANDF_CS3__GPIO6_16		0x0
 			/* POWER_AND_BOOT_STATUS_INDICATOR */
 			MX53_PAD_PATA_INTRQ__GPIO7_2		0x1e4
-			/* ACTIVATE_ALARM_LIGHT_RED */
-			MX53_PAD_PATA_DIOR__GPIO7_3		0x0
-			/* ACTIVATE_ALARM_LIGHT_YELLOW */
-			MX53_PAD_PATA_DA_1__GPIO7_7		0x0
-			/* ACTIVATE_ALARM_LIGHT_CYAN */
-			MX53_PAD_PATA_DA_2__GPIO7_8		0x0
 			/* RUNNING_ON_BATTERY_INDICATOR_GREEN */
 			MX53_PAD_GPIO_16__GPIO7_11		0x0
 			/* BATTERY_STATUS_INDICATOR_AMBER */
 			MX53_PAD_GPIO_17__GPIO7_12		0x0
-			/* AUDIO_ALARMS_SILENCED_INDICATOR */
-			MX53_PAD_GPIO_18__GPIO7_13		0x0
 		>;
 	};
 
@@ -1080,4 +1098,17 @@ pinctrl_usb_otg: usbotggrp {
 			MX53_PAD_KEY_COL4__USBOH3_USBOTG_OC	0x180
 		>;
 	};
+
+	pinctrl_alarmled_pins: qmx6alarmledgrp {
+		fsl,pins = <
+			/* ACTIVATE_ALARM_LIGHT_RED */
+			MX53_PAD_PATA_DIOR__GPIO7_3		0x0
+			/* ACTIVATE_ALARM_LIGHT_YELLOW */
+			MX53_PAD_PATA_DA_1__GPIO7_7		0x0
+			/* ACTIVATE_ALARM_LIGHT_CYAN */
+			MX53_PAD_PATA_DA_2__GPIO7_8		0x0
+			/* AUDIO_ALARMS_SILENCED_INDICATOR */
+			MX53_PAD_GPIO_18__GPIO7_13		0x0
+		>;
+	};
 };
-- 
2.25.1

