Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE64EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C520791
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633455;
	bh=4XlFYSUqyUgXNY2lTOdDnWrKsSE6d2W+mwPpeXHRPfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZBOM6Mg88O7DUCAkjUhyhJThXGjqIArXXG9//0LuOyQCFGUcVUwS3UZz8B1LOa2DV
	 d32lx/H0k8VFSOayQDICAFI05zgBM9AV211LhnZZUNowTMwLRS3bbRppO3PJ2gX/65
	 qJtUQ3Q+YcWniSlKlphojelVsTR6GWdlN0GHqjnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgH1Qux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgH1Qus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:50:48 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1A620825;
        Fri, 28 Aug 2020 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633447;
        bh=4XlFYSUqyUgXNY2lTOdDnWrKsSE6d2W+mwPpeXHRPfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qe1Zgr32Q9ocb0IQe+4DreGTDpSTQIDngobDu4OdGen3kyQvajwsoEOEuF3pD/uug
         Y0aMj+JLZjqIkSOZ3zZBCJ5vNnyYkQtcPqAmdf/aWI7v4O4ni9oH92fJBmJ4bDvX9N
         WwZgr0S4wGXzGhw3/WeRNLMzoRrqXvFigpoDYbB8=
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
Subject: [PATCH v2 19/19] arm64: dts: imx8qxp-colibri: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:50 +0200
Message-Id: <20200828164750.10377-20-krzk@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
index 75f17a29f81e..f38acff0d25c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
@@ -494,7 +494,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
 			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD		0x21
@@ -511,7 +511,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
 			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD		0x21
@@ -554,7 +554,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041	/* SODIMM  47 */
 			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x21		/* SODIMM 190 */
@@ -566,7 +566,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041	/* SODIMM  47 */
 			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x21		/* SODIMM 190 */
-- 
2.17.1

