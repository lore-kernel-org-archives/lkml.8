Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4103C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C47206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599671918;
	bh=YrPDcU8CAauI5I1aJRFu4u8EEBAbnGremxHMZQRp3ms=;
	h=From:To:Subject:Date:List-ID:From;
	b=G7Y+rvncj4vrcxxhtOG2yjxlSZmkaPzsEpu+4FP17r/u75wkDVvTaZf/n7qQu8evL
	 C4QdUOL1YHgAu6nVv1ItcvdzS0ADH7fxo7pbA0tEm+i6tbrPFBsJ7E+aJ87//l9awG
	 OWl5AVpm7PeRHScqxslD0mkIHmOy+gSmjeC/oJso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgIIRSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgIIP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C3D22276;
        Wed,  9 Sep 2020 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664684;
        bh=YrPDcU8CAauI5I1aJRFu4u8EEBAbnGremxHMZQRp3ms=;
        h=From:To:Subject:Date:From;
        b=qUpIqDTile1YKhos64e+JX+Vd1ZPbBaihbYqVqYHNa9BmqbJur/oIeojIfO+mg+S0
         Arp8CWRYSUDB3NauXHi2VUUuD6nUXIwirUwJY3GDUPVmQ9mHI/DSkBut62rN8hvGbU
         vudS1hkGrjbPpflVIPvAxqRVCuBBIEIuRMaXlACE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: imx8mm-var-som-symphony: Remove unneeded i2c3 properties
Date:   Wed,  9 Sep 2020 17:17:53 +0200
Message-Id: <20200909151755.17783-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c3 clock frequency and pin configuration are already set by
imx8mm-var-som.dtsi.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index fbf321cdcf16..1c427260e887 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -121,11 +121,6 @@
 };
 
 &i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
 	/* Capacitive touch controller */
 	ft5x06_ts: touchscreen@38 {
 		compatible = "edt,edt-ft5406";
-- 
2.17.1

