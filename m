Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEB320738
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633431;
	bh=Cgxn33agiAyp87HeECnZVMhxGfb2+DrRvu3F+O4k4xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAq1pa7indjCvof/bSDFlgKlNheOfzS2nJGZMdP7ZNb2Uggy7KhmF7vWbjxtkEXOJ
	 DjXFALhimqcyzbHPq+w0T1JayL2QIGHExcxkRLHZPtw2mNMYAMyHsOsGm7FDu3h9F+
	 c59CXwx04yUxeKx3HkTZeLGXha+Rcl8ghZ8eO8Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgH1Qua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbgH1QuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:50:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DC820C56;
        Fri, 28 Aug 2020 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633422;
        bh=Cgxn33agiAyp87HeECnZVMhxGfb2+DrRvu3F+O4k4xU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMecWnAgOXRnqFZguFNZP++EQZeOKRRS5Pe+Zk8bSrrUsCjXle74AErcIw7+ZWsoF
         ervXUHTa8lWgRKeZ7FLmxkSRfE3N+9xeZjqe8jJFQWe4m2Vyjhj0irN8yl5C6TFrFF
         3KKcfKi81CTMl2bK/i/TBBzarDVDs/FzlFRWjCSY=
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
Subject: [PATCH v2 15/19] arm64: dts: imx8mq-phanbell: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:46 +0200
Message-Id: <20200828164750.10377-16-krzk@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index 3f541ddf0768..d6d3a3d5abc3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -365,7 +365,7 @@
 		>;
 	};
 
-	pinctrl_pmic: pmicirq {
+	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
 		>;
@@ -395,7 +395,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
@@ -412,7 +412,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
@@ -429,7 +429,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
@@ -448,7 +448,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
@@ -460,7 +460,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
-- 
2.17.1

