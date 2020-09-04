Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84554C2BC84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56950208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200925;
	bh=NRMAmJr0Gkm7nBbGMLvELUmiuyQArn+RHcFME+AYl4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsvwAYXktb1u14av0DinGtKa6+x30uJp3qOQijov2XNnXLh3k/+GqvqNKYubt+tn0
	 DnLZpLXCcXX2hHw1NIPjPtb48ji7OJYUb/jOfKgJPbyiZ+xnQeKUYxQ73tbPlqh36J
	 /m4UrPdoI4kQFJHRXPp9GlQ6Ows9jo1QSrjHcmNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgIDG2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbgIDG2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F2C20748;
        Fri,  4 Sep 2020 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200893;
        bh=NRMAmJr0Gkm7nBbGMLvELUmiuyQArn+RHcFME+AYl4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ce/ilprH8Dc/IB4KeNGGLzjSN7Vn0wMBsKknl6XR8IhU4abT02AZJri95arQWax5
         TBXbUWoP60WeLFMWlpeLWw+YbNm+Kd0m907OBgPwpLhx5LLXd1twZbYWWtwjUq/zBg
         gsHi1idtrFHp+3uz9ExAF2PEgYTZpcLe9PhfEFfs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 08/14] arm64: dts: imx8mq-librem5-devkit: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:37 +0200
Message-Id: <20200904062743.6273-8-krzk@kernel.org>
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
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index a80e53428c2f..10f30ff85fd3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -735,7 +735,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
@@ -752,7 +752,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
@@ -769,13 +769,13 @@
 		>;
 	};
 
-	pinctrl_usdhc2_pwr: usdhc2grppwr {
+	pinctrl_usdhc2_pwr: usdhc2pwrgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20		0x80 /* WIFI_WAKE */
 		>;
@@ -792,7 +792,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x8d
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcd
@@ -803,7 +803,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcf
-- 
2.17.1

