Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB0220771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGWFrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:47:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40380 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgGWFri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:47:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E81D200B72;
        Thu, 23 Jul 2020 07:47:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FF69200B70;
        Thu, 23 Jul 2020 07:47:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2AEC7402F2;
        Thu, 23 Jul 2020 07:47:27 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx7d-sdb: Add notes for audio sound card
Date:   Thu, 23 Jul 2020 13:43:36 +0800
Message-Id: <1595483016-8822-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the SAI device node, configure audio clock
and pinctrl.

Enable the audio sound card, which use the SAI1 and
wm8960, and enable headphone detection.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 17cca8a9f77b..b50b19f2d0f1 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -146,6 +146,24 @@ panel_in: endpoint {
 			};
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx7d-evk-wm8960",
+			     "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&codec>;
+		hp-det-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "AMIC",
+			"AMIC", "MICB";
+	};
 };
 
 &adc1 {
@@ -363,6 +381,13 @@ codec: wm8960@1a {
 		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
 		clock-names = "mclk";
 		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+		assigned-clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_SRC>,
+				  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
+				  <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+		assigned-clock-rates = <0>, <884736000>, <12288000>;
 	};
 };
 
@@ -391,6 +416,28 @@ &reg_1p2 {
 	vin-supply = <&sw2_reg>;
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <884736000>, <36864000>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3 &pinctrl_sai3_mclk>;
+	assigned-clocks = <&clks IMX7D_SAI3_ROOT_SRC>,
+			  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
+			  <&clks IMX7D_SAI3_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <884736000>, <36864000>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -550,6 +597,7 @@ MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
+				MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59  /* headphone detect */
 			>;
 		};
 
@@ -615,6 +663,33 @@ MX7D_PAD_LCD_RESET__LCD_RESET		0x79
 			>;
 		};
 
+		pinctrl_sai1: sai1grp {
+			fsl,pins = <
+				MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+				MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
+				MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
+				MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+				MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+			>;
+		};
+
+		pinctrl_sai2: sai2grp {
+			fsl,pins = <
+				MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
+				MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
+				MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
+				MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
+			>;
+		};
+
+		pinctrl_sai3: sai3grp {
+			fsl,pins = <
+				MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
+				MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
+				MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
+			>;
+		};
+
 		pinctrl_spi4: spi4grp {
 			fsl,pins = <
 				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
@@ -776,4 +851,10 @@ pinctrl_usb_otg2_vbus_reg: usbotg2vbusreggrp {
 			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14
 		>;
 	};
+
+	pinctrl_sai3_mclk: sai3grp_mclk {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO03__SAI3_MCLK	0x1f
+		>;
+	};
 };
-- 
2.27.0

