Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2596E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296108;
	bh=vxbLV+STRC09+mFwG0u3yWhMHTkrX3R2cxAN/HKppaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0sAhtFz4imE/5puLY8QtoAZYFJPCH6R3V9rtPz/CL0PT7peB2QsNNTzFmseBY+Dx
	 ZKCfb9ZbhvnLBczimMSSkeBTzbVIL6H946mx2kYNNB+ifb6THnB2HjZB65knEE5ZJI
	 0ishARSVufclTeuLBkIXr5pMyv3zDm9dnwKj4U9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHXTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHXTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:08:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3927820897;
        Mon, 24 Aug 2020 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296102;
        bh=vxbLV+STRC09+mFwG0u3yWhMHTkrX3R2cxAN/HKppaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1TaWayN4OpKj0jgL2lsvbH/7vGz+xg8siK7JsuKe98xCf8Qg4WmKiTxGaAPuu0Fv
         o4+wSkDLsOAKu9dSdzWqliYN0CAKjdral3Gzm5tT0g657c7U/XtRvGjtvXR9TEsWPA
         zar93ngbUYyLViyBWDD0u/7de8Y1EneHIw/7qeXM=
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
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 14/16] arm64: dts: imx8mq-sr-som: Align pin configuration group names with schema
Date:   Mon, 24 Aug 2020 21:06:59 +0200
Message-Id: <20200824190701.8447-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824190701.8447-1-krzk@kernel.org>
References: <20200824190701.8447-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects pin configuration groups to end with 'grp'
suffix, otherwise dtbs_check complain with a warning like:

    ... do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
index 404c46671b96..0187890a90c5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
@@ -275,7 +275,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
@@ -292,7 +292,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
-- 
2.17.1

