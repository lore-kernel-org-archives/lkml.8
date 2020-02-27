Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAADC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8E2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgB0NR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:17:59 -0500
Received: from comms.puri.sm ([159.203.221.185]:39728 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbgB0NR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:17:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D9018E01B5;
        Thu, 27 Feb 2020 05:17:55 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xoAh7AvDkITZ; Thu, 27 Feb 2020 05:17:55 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/8] arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
Date:   Thu, 27 Feb 2020 14:17:28 +0100
Message-Id: <20200227131733.4228-4-martin.kepplinger@puri.sm>
In-Reply-To: <20200227131733.4228-1-martin.kepplinger@puri.sm>
References: <20200227131733.4228-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add the simcom SIM7100 modem and the sai6 interface that connects it.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index c829e4579540..84443e4857d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -148,6 +148,11 @@
 		regulator-always-on;
 	};
 
+	wwan_codec: sound-wwan-codec {
+		compatible = "option,gtm601";
+		#sound-dai-cells = <0>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sgtl5000";
@@ -176,6 +181,22 @@
 		};
 	};
 
+	sound-wwan {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SIMCom SIM7100";
+		simple-audio-card,format = "dsp_a";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai6>;
+		};
+
+		telephony_link_master: simple-audio-card,codec {
+			sound-dai = <&wwan_codec>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		pinctrl-names = "default";
@@ -618,6 +639,15 @@
 		>;
 	};
 
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK     0xd6
+			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x16
@@ -802,6 +832,16 @@
 	status = "okay";
 };
 
+&sai6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai6>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI6>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-synchronous-rx;
+	status = "okay";
+};
+
 &uart1 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.20.1

