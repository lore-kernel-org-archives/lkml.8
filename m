Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E89C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2CB208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595950;
	bh=YKA5ZQ6xQuK7/axErohadLOOxrTTzusock+I6lSVols=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kZiYwXjzRVN+clLThV5Cv5k0erXefV0bMeDxo3C3zHtkza5HS08uCOguyK9dhula5
	 g+ysMMyIMazMynf5z5GkOWlm5xpA9CrZna6apLA0ngG9U4aO4YztU+IFupVpOnXaJF
	 qSyOgOmcRnW9+zwXqLMPjP+jso9oxqG0cEqLN9L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgIHUM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgIHPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175F823D99;
        Tue,  8 Sep 2020 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577464;
        bh=YKA5ZQ6xQuK7/axErohadLOOxrTTzusock+I6lSVols=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsYDhSvt5XQoUSq0sd5XwiHacUheT0WHPxvKefh917Asncn0qCMXgo2WpxOewfDjz
         Kyu5lWSGvvVTxaFceSLEA6eDfpEp1OxHdDD8VI/QIYPzTeeKKCYhi6LEBUFepnA1zx
         r3Ta+kp0THQPcnZjE3RrWs4vPERyWSJzqaP3GwgA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 8/8] arm64: dts: imx8mm-var-som-symphony: Drop unused gpioledgrp
Date:   Tue,  8 Sep 2020 17:02:41 +0200
Message-Id: <20200908150241.5771-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908150241.5771-1-krzk@kernel.org>
References: <20200908150241.5771-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpioledgrp in iomux is not used, so it can be dropped.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index b84d94e10c26..fbf321cdcf16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -193,12 +193,6 @@
 		>;
 	};
 
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
-		>;
-	};
-
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-- 
2.17.1

