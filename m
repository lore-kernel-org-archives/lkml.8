Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85A320848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633387;
	bh=JMjwvcNs4b37P7xm+7gxQw/xSmaryGBbQ40tRtlOM9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dx4B2v4sF60JwHfpDjvjzr1BOzO1Y143Lezu8rcWqNIABDhEjc5I+r92d+4yQGu8u
	 GQmfGBUfYjUn72MglzaWH8y5APsWvepbWQPyPLKH/it0iBGb3a9HWEPyKS2IEDGf+6
	 SgwA+jY2BccwddEIBWtWjUEAk+6mWYG0+TVmVkh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH1Qtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgH1Qt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C882520848;
        Fri, 28 Aug 2020 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633366;
        bh=JMjwvcNs4b37P7xm+7gxQw/xSmaryGBbQ40tRtlOM9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3TwHkT8ZSUalQOaGJQmePU3Dz1GwJ4qYWBvs7AkbCMxbPqd9xk58a4Boj0CkVMmR
         L2NxplrVlvGN8c7tulbF95z9oDWmS5otNt/L/HwYg5ItWCrNYTOIY3ufmOTzW7RxER
         LXU8NYktR7BpSyPfc1AzD+IlcxUY5clTmeMna2DE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 06/19] arm64: dts: imx8mm-beacon: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:37 +0200
Message-Id: <20200828164750.10377-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects pin configuration groups to end with 'grp'
suffix.  This fixes dtbs_check warnings like:

  pinctrl@30330000: 'pcal6414-gpio', 'pmicirq', 'usdhc1grp100mhz', 'usdhc1grp200mhz', 'usdhc1grpgpio',
    'usdhc2grp100mhz', 'usdhc2grp200mhz', 'usdhc2grpgpio', 'usdhc3grp100mhz', 'usdhc3grp200mhz'
    do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi  |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index bf0859f1e1fa..16e4910aeb1e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -210,7 +210,7 @@
 		>;
 	};
 
-	pinctrl_pcal6414: pcal6414-gpio {
+	pinctrl_pcal6414: pcal6414-gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
@@ -240,7 +240,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CD_B_USDHC2_CD_B	0x41
 			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
@@ -259,7 +259,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK	0x194
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d4
@@ -271,7 +271,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK	0x196
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d6
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 620a124dfb5f..502faf6144b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -290,7 +290,7 @@
 			>;
 		};
 
-		pinctrl_pmic: pmicirq {
+		pinctrl_pmic: pmicirqgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
 			>;
@@ -309,7 +309,7 @@
 			>;
 		};
 
-		pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		pinctrl_usdhc1_gpio: usdhc1gpiogrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
 			>;
@@ -326,7 +326,7 @@
 			>;
 		};
 
-		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
 				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
@@ -337,7 +337,7 @@
 			>;
 		};
 
-		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
 				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
@@ -364,7 +364,7 @@
 			>;
 		};
 
-		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
 				MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -380,7 +380,7 @@
 			>;
 		};
 
-		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 			fsl,pins = <
 				MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
 				MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.17.1

