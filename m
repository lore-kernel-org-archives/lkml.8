Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F44C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7476720936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633409;
	bh=Hn72MHPN13T3SxFJctnkzgUT/lUEXMXAJFvr00iCQY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9EzCgJnqajlDW5ibhCSyW7m4W11EncWy31hrhRHyrwxxrETN4wKjorIzZ5Zj3ERV
	 6DkWfih1PIGCOu3NJ0tZKO4+fm6NyXAEsTLL+Ujan9Zk+D2EjaHn2SvRENWb53mD35
	 70JcBROgY4mrzcGLBL+etzyQc2T8dhDuZsAmu67w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH1QuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgH1Qt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAE920CC7;
        Fri, 28 Aug 2020 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633397;
        bh=Hn72MHPN13T3SxFJctnkzgUT/lUEXMXAJFvr00iCQY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/28Dx6sIVxnEB6tOpw037w0sR0+fid4bLswaAT1Sdm8ug6dFwOXYMPuZLyyLil0a
         jENJE2xFM8Xqkzqh/asb3c+zvcLN26A7giqJJsnblL2Fs9aFHMDeO0BQHlQoND7hjL
         oQ10VNQzZ3U1y2rLW6lMX32++S3RvqZarIiXEGeY=
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
Subject: [PATCH v2 13/19] arm64: dts: imx8mq-evk: Align pin configuration group names with schema
Date:   Fri, 28 Aug 2020 18:47:44 +0200
Message-Id: <20200828164750.10377-14-krzk@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index a088831d2e24..7c6808814856 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -407,7 +407,7 @@
 		>;
 	};
 
-	pinctrl_reg_usdhc2: regusdhc2grpgpio {
+	pinctrl_reg_usdhc2: regusdhc2gpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
 		>;
-- 
2.17.1

