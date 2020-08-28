Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB31C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFC720B80
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633422;
	bh=ldF6UHOHHJVbzEDB7ln+iQ6yBk9UNL7dYnbB0GYXwD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6IKxSky9dvSmZ1I4viUGYYu8zN8ag7bBmeizkAMXO1G4qaTnX8oOsSQL+ific8LO
	 fVoO6A+hDDbBTNZfvOcZNiPzDmZBQRi7/8JvCmGPOow0ZDDHaOsPcqgU4LV/qpkI3D
	 gCT8JSeTxDXvm86e2seW/H71ZNFi4BXofXqW+tsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgH1QuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgH1Qtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053032100A;
        Fri, 28 Aug 2020 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633375;
        bh=ldF6UHOHHJVbzEDB7ln+iQ6yBk9UNL7dYnbB0GYXwD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ec2OVgetZCt/A8lcosbZYAsAPiVGkVKlLMJh3LlHj3h0NCeyw36wC3rVsOpgbaGq8
         TaqnrNwQN5SwVdAFALOI/kpb1842OVoNHLyFzK9vNmSw7LkR65q4SI4zyPRzwhHebC
         QACHh1WhDBTCafZuyt0GS2zYWkQDYdhRtuba0i4I=
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
Subject: [PATCH v2 08/19] arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC
Date:   Fri, 28 Aug 2020 18:47:39 +0200
Message-Id: <20200828164750.10377-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71847 PMIC has a 32.768 kHz clock.  Adding necessary parent
allows to probe the bd718x7 clock driver fixing boot errors:

    bd718xx-clk bd71847-clk.1.auto: No parent clk found
    bd718xx-clk: probe of bd71847-clk.1.auto failed with error -22

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 3cb8b6bcb657..0115f07bbc9d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -149,6 +149,10 @@
 		interrupts = <3 GPIO_ACTIVE_LOW>;
 		rohm,reset-snvs-powered;
 
+		#clock-cells = <0>;
+		clocks = <&osc_32k 0>;
+		clock-output-names = "clk-32k-out";
+
 		regulators {
 			buck1_reg: BUCK1 {
 				regulator-name = "buck1";
-- 
2.17.1

