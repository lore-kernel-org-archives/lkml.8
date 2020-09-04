Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADFBC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FA720748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200875;
	bh=oEcLyFzzzoRu+O9dRmWrcqh+WugXQFGAASOZgfojBhE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jUY53IniFhkYTAPMBV6e3Ffs1mVrVmifFsaZDOi5Ex5WVgkzdcCthkkK40q/RfQrX
	 xUYQZrCnu9Ph3wgdAmXtLIAlL7aNOlsNW9NLmu0Od1QJUj7l5pbvC1omUUxcLKVpBc
	 qOWwROYPzy7TvD1a8rbMtk04budtSUfu3y1P/HNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIDG1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDG1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:27:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DBF206A5;
        Fri,  4 Sep 2020 06:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200873;
        bh=oEcLyFzzzoRu+O9dRmWrcqh+WugXQFGAASOZgfojBhE=;
        h=From:To:Cc:Subject:Date:From;
        b=lwEBE2V0Y22WSHX8j7GoS6YpYrVChK9aLG8TltSEzFJ/KudNRH3OOh0zQ21MvA219
         3o7tq73F8f7+3l24eLtYe88cMlt/UYLE6Ho7ieuni7SPJ5Y5u04HKayerBm5Mm4wcn
         s3G4EMtHxghAWY1coT+2C7N2tNpHkiPDuWJxy1N0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 01/14] arm64: dts: imx8mm-beacon: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:30 +0200
Message-Id: <20200904062743.6273-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
index 5b5af8b381df..d6b9dedd168f 100644
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

