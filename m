Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0813C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00062086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200960;
	bh=n2DBcRjxaj1t4sHwdJk4bsRlu5l7HDV144qQF4OWSPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lwkoz2BhJuqaLFbf18xaFk7H+5MAFUxm4sPk04WJLxptBrcSSmzaW4oA8z07f4ZmJ
	 4dOKcYgsEABc3lfK15DdhrkrOvmbCtiUzOzwjA0ckTqxPwJ1m3A39RDkXStWVAY7S+
	 TqYZojEiValDGxSLkAupPRWCVQhnZvEuAwuziqcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgIDG3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgIDG2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69E4208CA;
        Fri,  4 Sep 2020 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200887;
        bh=n2DBcRjxaj1t4sHwdJk4bsRlu5l7HDV144qQF4OWSPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVOTbHEYPwhLycY7tYrtSoFGmA+pvhOntZG2BOfrXEv6mLdtaIXnrbb15A9dQT09D
         kiiDbRiD0SvZpwb88GpZyldsLE/6Y6QuxmoPeMIY6IO74ZX2IOD7JRpf2XuQn198fN
         oHreTCLaj34MTE0vH+mRrE8NiPP3P9Jh+hXBEGsY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 06/14] arm64: dts: imx8mn-evk: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:35 +0200
Message-Id: <20200904062743.6273-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904062743.6273-1-krzk@kernel.org>
References: <20200904062743.6273-1-krzk@kernel.org>
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
index 76e0225729b1..7f4b904e9982 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -223,13 +223,13 @@
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
@@ -248,7 +248,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
 		>;
@@ -266,7 +266,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
@@ -278,7 +278,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
@@ -306,7 +306,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000194
 			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -322,7 +322,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000196
 			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.17.1

