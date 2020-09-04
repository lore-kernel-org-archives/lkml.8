Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE6A20748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200884;
	bh=Xmoe2FnEQ6TTzKPtCuOetJANkq2kohb1mBIp4SOjZdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAdWnLd1uwZZtuWS5578lg1KBbf1kmlGIERvLVIOYAQmR7EDbDZ1T4wQf23YdNHAl
	 eU0sxGUXvW0Oeqq7AI75Aap28WjnZcRqxxNwAiVMFnbsmHiXrAbdKsvwEhT82IWwLj
	 N0+KuZ8oFpAXGdm2h3QcsFmPIgYeh8M592R6Fe+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgIDG2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:27:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B574206A5;
        Fri,  4 Sep 2020 06:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200878;
        bh=Xmoe2FnEQ6TTzKPtCuOetJANkq2kohb1mBIp4SOjZdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUit8UXbLL7NXIEUr0VkH3PblkoudQJPLrTrv3ktsztBOykoMohGVRhhzvoQvLhNk
         PWxw1HTKtI6Bew8Dzu5WBuprHXLIHpjdAJM2nG3Cs8PcqBvo4wfg3aLV6FB3Uhz0sN
         RTGOh4Csht4mOt/inDZhSY4YXI/F3q/tm+gQNJoA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 03/14] arm64: dts: imx8mm-evk: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:32 +0200
Message-Id: <20200904062743.6273-3-krzk@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 1c39a2b90ee1..27e54583a8e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -456,13 +456,13 @@
 		>;
 	};
 
-	pinctrl_pmic: pmicirq {
+	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
 		>;
 	};
 
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
@@ -490,7 +490,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
 		>;
@@ -508,7 +508,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
@@ -520,7 +520,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
@@ -548,7 +548,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -564,7 +564,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.17.1

