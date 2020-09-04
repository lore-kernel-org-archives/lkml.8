Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D628AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3D3206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200944;
	bh=Hn72MHPN13T3SxFJctnkzgUT/lUEXMXAJFvr00iCQY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yu2GneCnEsh0RMgFhnP8Olo8tGoGJ2Tvw9V0ULUMsY9vWoAAjrt5W/l80LKEfHsO9
	 qr+QtF+B8bkebbarijnupSY9yz/8+njl7h9Wpw9+EyPZnu8zc/oxCrWnPuOKAMmkFf
	 o8AbkmB17nGYu5s2nIiAjgqKngd711KaENNCAGfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgIDG3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDG2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A7C206A5;
        Fri,  4 Sep 2020 06:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200890;
        bh=Hn72MHPN13T3SxFJctnkzgUT/lUEXMXAJFvr00iCQY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObkZQJ5EKjsuBB2lLZu3pzEK81PXzqBDKJy+2ZS9kqQ0BUWr0fF4l2C/oktCnPjrX
         ZHxUBYqKIAJW8TyYQ84qtmOUOpQbvlRkmyLPuXCn69mum+r/Rv2t1AMspEU/EtV7F5
         n14AFeIOEWsvtjCSZXZsPtaPCrJRj8+SABsfLpHg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 07/14] arm64: dts: imx8mq-evk: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:36 +0200
Message-Id: <20200904062743.6273-7-krzk@kernel.org>
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

