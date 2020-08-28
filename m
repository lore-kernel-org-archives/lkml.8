Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C68C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DB620936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633399;
	bh=CFDMzcJagCMCiZtXxH7iFplsC+3dBIHoQLjxzKqhIcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0KFwhagOdOWIgjFTTnz3ePo8LeYxjIwurT5SjtkQC4I7sQl25rsBO0Zdx+YjPDhQ
	 s0WAu1+gOJnEXQsIDXO0Md5a1OEOb46kIYd5nYX4wBfph2BGiIA45W8+6U7TqEHm7i
	 b5S5bGcuFjyaUpLUgxhdO9A2s+sCOqXsmfsIxbkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgH1Qt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgH1Qtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C8B2098B;
        Fri, 28 Aug 2020 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633393;
        bh=CFDMzcJagCMCiZtXxH7iFplsC+3dBIHoQLjxzKqhIcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhcjZjjIH+dFzJpGeyiNdvWLA9A7I3yX0NhPQ/3r6mSCJRJbP3SDiV8QytJhzeQx1
         9QVXl/Ji9vQ4/eOJkxNsFCowMzJicTHuWtVGidgyr06fnodFWI/kxjs2tYtjoaZxnU
         +sS0Ave8IhrV+yC6kxoFHbuR8ebbSFXlGe8I+Oa8=
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
Subject: [PATCH v2 12/19] arm64: dts: imx8mn-evk: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:43 +0200
Message-Id: <20200828164750.10377-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects pin configuration groups to end with 'grp'
suffix, otherwise dtbs_check complain with a warning like:

    ... do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 48892ed562b4..ed9b5241acc7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -221,13 +221,13 @@
 		>;
 	};
 
-	pinctrl_pmic: pmicirq {
+	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
 		>;
 	};
 
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
@@ -246,7 +246,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
 		>;
@@ -264,7 +264,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
@@ -276,7 +276,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
@@ -304,7 +304,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000194
 			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -320,7 +320,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000196
 			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.17.1

