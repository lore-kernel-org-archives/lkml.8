Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16158C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC429222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBEObE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:04 -0500
Received: from comms.puri.sm ([159.203.221.185]:48854 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBEObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6FA10E03CF;
        Wed,  5 Feb 2020 06:31:01 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4qrC0zwEtsvC; Wed,  5 Feb 2020 06:30:56 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 02/12] arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
Date:   Wed,  5 Feb 2020 15:29:53 +0100
Message-Id: <20200205143003.28408-3-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add the simcomm modem and the sai6 interface that connects it, as well
as the sgtl5000 audio codec.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 9702db69d3ed..8162576e8f3d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -148,6 +148,51 @@
 		regulator-always-on;
 	};
 
+	sim7100_codec: sound-wwan-codec {
+		compatible = "option,gtm601";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+
+	sound-wwan {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SIMCom SIM7100";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,cpu {
+			sound-dai = <&sai6>;
+		};
+		telephony_link_master: simple-audio-card,codec {
+			sound-dai = <&sim7100_codec>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		pinctrl-names = "default";
@@ -749,6 +794,16 @@
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

