Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F786C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A621D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRIus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:50:48 -0500
Received: from comms.puri.sm ([159.203.221.185]:39774 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgBRIuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:50:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 68149E1147;
        Tue, 18 Feb 2020 00:50:46 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lk0MWPi-t2nB; Tue, 18 Feb 2020 00:50:45 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 3/9] arm64: dts: librem5-devkit: add the simcom 7100 modem and sgtl5000 audio codec
Date:   Tue, 18 Feb 2020 09:49:36 +0100
Message-Id: <20200218084942.4884-4-martin.kepplinger@puri.sm>
In-Reply-To: <20200218084942.4884-1-martin.kepplinger@puri.sm>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add the simcomm modem and the sgtl5000 audio codec.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 25135b08d4f8..ec12477d925d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -148,6 +148,53 @@
 		regulator-always-on;
 	};
 
+	wwan_codec: sound-wwan-codec {
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
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&audio_codec>;
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
+			sound-dai = <&wwan_codec>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		pinctrl-names = "default";
@@ -426,6 +473,19 @@
 		vddio-supply = <&reg_3v3_p>;
 	};
 
+	audio_codec: sgtl5000@a {
+		compatible = "fsl,sgtl5000";
+		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
+		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+		assigned-clock-rates = <24576000>;
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		VDDD-supply = <&reg_1v8_p>;
+		VDDIO-supply = <&reg_3v3_p>;
+		VDDA-supply = <&reg_3v3_p>;
+	};
+
 	touchscreen@5d {
 		compatible = "goodix,gt5688";
 		reg = <0x5d>;
-- 
2.20.1

