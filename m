Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0864F207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200909;
	bh=vxbLV+STRC09+mFwG0u3yWhMHTkrX3R2cxAN/HKppaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wvFomdvUIZ/EKrwr/8UfYcen+hl1Ca4D0222uNzC/VQT+sdP7y80S0pcKaBEivHwE
	 qiEGZ2AZ+Fy82zsJi9FtIUIFuzqxnEG9e/tRmfTDOTolH+1EqV5KqQJ5BXW78Uxdpg
	 nhaSG1af8kQ8gumgfeSceZerhS5hiPxKzdG2RmVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbgIDG2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F0E2086A;
        Fri,  4 Sep 2020 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200905;
        bh=vxbLV+STRC09+mFwG0u3yWhMHTkrX3R2cxAN/HKppaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdqpqBOm2sg9Qwtl/ZfcUKIgBHuopJLJsmafOFYSGUakRkeLEv2FYktecnDyqbfJA
         0sPDwwemqQaGOLvxw/G4FsGRejm8PGj9c3yoXe5qzy2w8l2gIfmTmDiCua3teVdXGo
         Bc8ZJb9pwC25+hUEK4ALb+Cvgk7AI51Qe/R9wCRY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 11/14] arm64: dts: imx8mq-sr-som: Align pin configuration group names with schema
Date:   Fri,  4 Sep 2020 08:27:40 +0200
Message-Id: <20200904062743.6273-11-krzk@kernel.org>
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

