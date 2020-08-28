Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED75DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C342A20791
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633449;
	bh=1uXd9ISJsirAUfbmjnYLzUw+I40c4LhHjYZ4wB/ECos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uI3E3ij52rZmhxl/1AzBBJWHwYgz+7QanDsuPBTAaDKvXLh2qaOKAY6aeXEeOXXbj
	 cV7wIoLG0jfI2M38/M89lbjT1ejAvvg4/HmNUrx9I2N+Eg7UdgInSVXiUR2k1cj+im
	 p9sfJxgttZuYcfYX7k1yd4EGc3QBACPDOx2oRpng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgH1Qur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgH1Quo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:50:44 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028AB20791;
        Fri, 28 Aug 2020 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633443;
        bh=1uXd9ISJsirAUfbmjnYLzUw+I40c4LhHjYZ4wB/ECos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBs8LtnhOYHd2PYIU2qPcVzAB5Ovc/K6ig2BrElsHUhfBHj6Gv52ffgOCNBcsCeh2
         JABQVsofQl2DZ6pOJbJ77znd+QfNtIAR0wFClRqv1B/cT+rKa9ptuvPix+QHfKmOPP
         vvX2biLwoXBdktSTLSt969p4CGEaQp0ApqlN77NU=
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
Subject: [PATCH v2 18/19] arm64: dts: imx8mq-hummingboard-pulse: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:49 +0200
Message-Id: <20200828164750.10377-19-krzk@kernel.org>
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
 .../boot/dts/freescale/imx8mq-hummingboard-pulse.dts      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
index bfd91c1ed6a5..366693f31992 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dts
@@ -214,13 +214,13 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
 		>;
 	};
 
-	pinctrl_usdhc2_vmmc: usdhc2vmmcgpio {
+	pinctrl_usdhc2_vmmc: usdhc2vmmcgpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x41
 		>;
@@ -238,7 +238,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8d
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
@@ -250,7 +250,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9f
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xdf
-- 
2.17.1

