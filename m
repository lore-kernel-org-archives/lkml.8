Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0620848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633372;
	bh=L7V/fZmvMYn+I9d6Q43WyzdCTSdcBitg3AhIwRjBFJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXTev6zWTy2H7Iui24vJAScXgtJzm94QEyArfXm4xeJys9BEyhsMdCGOZkosD2X02
	 XCFifM4UVk1V9Rv3m6F13zbe9S9ZW0ngeZJnIjHGJIsKbi7a6cvNZ/dZm03Hn5YsK+
	 kH7JlBE4ZHVay0+dHdEULHQIM7Lc4Tg0I37h99v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgH1Qt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgH1QtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D7920848;
        Fri, 28 Aug 2020 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633356;
        bh=L7V/fZmvMYn+I9d6Q43WyzdCTSdcBitg3AhIwRjBFJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6K3N9wzm2uWvu1TiSb1qkHo4I1cIvrust62+zZL5CWIJIAz695IqdKnmP30lsgyD
         qpURlT2UToAqvtTjiF1VVuGrM2Snw2CUqx0qw8MNJobKFb61EV/QNhnzznUc3a3UXp
         VJCOn7OaHpXOkerLmWa/NI6AGJLMcaixCdoRgStc=
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
Subject: [PATCH v2 04/19] arm64: dts: imx8mm-beacon-som: Align regulator names with schema
Date:   Fri, 28 Aug 2020 18:47:35 +0200
Message-Id: <20200828164750.10377-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects regulator names to be lowercase.  Changing to
lowercase has multiple effects:
1. LDO6 supply is now properly configured, because regulator driver
   looks for supplies by lowercase name,
2. User-visible names via sysfs or debugfs are now lowercase,
2. dtbs_check warnings are fixed:

    pmic@4b: regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 94911b1707ef..f627e82ad929 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -79,7 +79,7 @@
 
 		regulators {
 			buck1_reg: BUCK1 {
-				regulator-name = "BUCK1";
+				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
@@ -88,7 +88,7 @@
 			};
 
 			buck2_reg: BUCK2 {
-				regulator-name = "BUCK2";
+				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
@@ -100,7 +100,7 @@
 
 			buck3_reg: BUCK3 {
 				// BUCK5 in datasheet
-				regulator-name = "BUCK3";
+				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-boot-on;
@@ -109,7 +109,7 @@
 
 			buck4_reg: BUCK4 {
 				// BUCK6 in datasheet
-				regulator-name = "BUCK4";
+				regulator-name = "buck4";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -118,7 +118,7 @@
 
 			buck5_reg: BUCK5 {
 				// BUCK7 in datasheet
-				regulator-name = "BUCK5";
+				regulator-name = "buck5";
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
 				regulator-boot-on;
@@ -127,7 +127,7 @@
 
 			buck6_reg: BUCK6 {
 				// BUCK8 in datasheet
-				regulator-name = "BUCK6";
+				regulator-name = "buck6";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
 				regulator-boot-on;
@@ -135,7 +135,7 @@
 			};
 
 			ldo1_reg: LDO1 {
-				regulator-name = "LDO1";
+				regulator-name = "ldo1";
 				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -143,7 +143,7 @@
 			};
 
 			ldo2_reg: LDO2 {
-				regulator-name = "LDO2";
+				regulator-name = "ldo2";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -151,7 +151,7 @@
 			};
 
 			ldo3_reg: LDO3 {
-				regulator-name = "LDO3";
+				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -159,7 +159,7 @@
 			};
 
 			ldo4_reg: LDO4 {
-				regulator-name = "LDO4";
+				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -167,7 +167,7 @@
 			};
 
 			ldo6_reg: LDO6 {
-				regulator-name = "LDO6";
+				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
-- 
2.17.1

