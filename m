Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1808DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C4E206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200931;
	bh=tMAMGxqIF7yzVEB7ojVRCLXtOkuEnHAvF6XNEXvOM7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tBMqHfaS7+q7xF1ZVcsqinoqNmYNZlzAWwiZR+Wozzjg3Ag9EJhlLbS56z0U/dEc7
	 UoP0JKFyyLNS5zCPC3En8G4wCrLhiqKaSQfJ96ZInRoeVx2eDEsKkmHsxSIK7YVDco
	 zCA8jCzR5Nx+5oqCJcqc+2L957Ib0vDwebQIR2Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgIDG2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgIDG2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F71D2074D;
        Fri,  4 Sep 2020 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200884;
        bh=tMAMGxqIF7yzVEB7ojVRCLXtOkuEnHAvF6XNEXvOM7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcC8PZF2HNXPFjRI3AgZjvqm5oi1H7w0qA8rD90Shwa/lk56qzBI+E5v6GC9jHQmP
         PnQxdgjPflRP6+2vzIRJ+8VaCGioauD/7cgdnc3etfaRqt2PHCH/2Nz+o811vEcAIq
         dSbnAuc86Jaour8kkox2cSShMjBWGptaQLPVs+GE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 05/14] arm64: dts: imx8mn-ddr4-evk: Align regulator names with schema
Date:   Fri,  4 Sep 2020 08:27:34 +0200
Message-Id: <20200904062743.6273-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904062743.6273-1-krzk@kernel.org>
References: <20200904062743.6273-1-krzk@kernel.org>
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
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 3ac8f9d3c372..8f7155716c84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -60,7 +60,7 @@
 
 		regulators {
 			buck1_reg: BUCK1 {
-				regulator-name = "BUCK1";
+				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
@@ -69,7 +69,7 @@
 			};
 
 			buck2_reg: BUCK2 {
-				regulator-name = "BUCK2";
+				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
@@ -79,14 +79,14 @@
 
 			buck3_reg: BUCK3 {
 				// BUCK5 in datasheet
-				regulator-name = "BUCK3";
+				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
 			};
 
 			buck4_reg: BUCK4 {
 				// BUCK6 in datasheet
-				regulator-name = "BUCK4";
+				regulator-name = "buck4";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -95,7 +95,7 @@
 
 			buck5_reg: BUCK5 {
 				// BUCK7 in datasheet
-				regulator-name = "BUCK5";
+				regulator-name = "buck5";
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
 				regulator-boot-on;
@@ -104,7 +104,7 @@
 
 			buck6_reg: BUCK6 {
 				// BUCK8 in datasheet
-				regulator-name = "BUCK6";
+				regulator-name = "buck6";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
 				regulator-boot-on;
@@ -112,7 +112,7 @@
 			};
 
 			ldo1_reg: LDO1 {
-				regulator-name = "LDO1";
+				regulator-name = "ldo1";
 				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -120,7 +120,7 @@
 			};
 
 			ldo2_reg: LDO2 {
-				regulator-name = "LDO2";
+				regulator-name = "ldo2";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -128,7 +128,7 @@
 			};
 
 			ldo3_reg: LDO3 {
-				regulator-name = "LDO3";
+				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -136,7 +136,7 @@
 			};
 
 			ldo4_reg: LDO4 {
-				regulator-name = "LDO4";
+				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -144,7 +144,7 @@
 			};
 
 			ldo6_reg: LDO6 {
-				regulator-name = "LDO6";
+				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
-- 
2.17.1

