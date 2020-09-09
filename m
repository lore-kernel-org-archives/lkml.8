Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294972166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599671864;
	bh=N/D7fR7BGgOx2lZpaHNGW+Rl2JGBL1AiJ7z668klV+c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WrqAYnx7e88wQv0Ru7/xDxsvaNNg8KY84mgXIGGyF58L8Mivyh+5hUMQNupNmi1ae
	 BWUvPScC/bf0VKkz5UREUbjCfhgnBrcVN1A4Z3iampRFQrjJlAe2uhJw6IcsqXh37g
	 HgB5BBzokOVpi0RkO/a6AYYJhH06eFUftA50PAN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgIIRRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgIIP2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B79F022283;
        Wed,  9 Sep 2020 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664687;
        bh=N/D7fR7BGgOx2lZpaHNGW+Rl2JGBL1AiJ7z668klV+c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=slbCvm8U9lnMRQ+hYn/j7ofXUJ13IRFPxhcVUHN1f8DL+IaFG+Ya316Ugp94pgsLs
         jxEDbN4cgxppFXnS7x2Qg3d9KlFoiCLKsbwkNh2FDiXRKMdRJDAfJ6+hQV42yv099P
         5vZDq1/udt0+KpTcENIgTTFXEUjgIX+juo6fXGMs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mm-var-som-symphony: Adjust ethernet pin configuration
Date:   Wed,  9 Sep 2020 17:17:54 +0200
Message-Id: <20200909151755.17783-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909151755.17783-1-krzk@kernel.org>
References: <20200909151755.17783-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Symphony board uses GPIO from expander as Ethernet PHY reset pin,
not the GPIO1_IO9.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../dts/freescale/imx8mm-var-som-symphony.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index 1c427260e887..07214d7dfc06 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -181,6 +181,26 @@
 	status = "disabled";
 };
 
+&pinctrl_fec1 {
+	fsl,pins = <
+		MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+		MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
+		MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+		MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+		MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+		MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+		MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+		MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+		MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+		MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+		MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+		MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+		MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+		MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
+	>;
+};
+
 &iomuxc {
 	pinctrl_captouch: captouchgrp {
 		fsl,pins = <
-- 
2.17.1

