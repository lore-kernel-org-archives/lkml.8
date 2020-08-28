Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8673E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598642461;
	bh=gg2I7iMb6OgA5dtiSOOaAGUtpDuVwxZjU6y+IDz5DSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i18hd8ak49MPIZ6sjNHcl9NzWWO2NWkxRkHbqGf2CsXq9qnbWYp2SAmEkvZPrTBj+
	 I34jQvxZP1UmMM5YXxnki7HAC84H0V2l4ns48FN0qbfYCpK6Y7VvVYN39nVPtcsi/7
	 xVqlsKdXUlVLMuD8wJ8xj96BMuAEkmajC7pJ0zpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1TVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgH1TU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:20:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E5820848;
        Fri, 28 Aug 2020 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642456;
        bh=gg2I7iMb6OgA5dtiSOOaAGUtpDuVwxZjU6y+IDz5DSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m685vn0t2iAFeEmQcOqeeWofdmPp2b9lga7g0CkOk+wT9fiTM8l8LuAGzf42QTjY6
         /ttg/xCdvug6Cb0ENzL8bvjqhsHIRPrn5ILL/xFHWye+RC+P14bk6W0BwEa9AGl22u
         ULeUu9yeIygOF+0pAiSwgGS4E5Q/Pm4bYpGkzpNg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/4] ARM: dts: imx28: Align GPMI NAND node name with schema
Date:   Fri, 28 Aug 2020 21:20:36 +0200
Message-Id: <20200828192037.22897-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828192037.22897-1-krzk@kernel.org>
References: <20200828192037.22897-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects NAND controller to be named
"nand-controller", otherwise dtbs_check complain with a warning like:

    arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
        $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx28-apf28.dts      | 2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts | 2 +-
 arch/arm/boot/dts/imx28-evk.dts        | 2 +-
 arch/arm/boot/dts/imx28-m28.dtsi       | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts     | 2 +-
 arch/arm/boot/dts/imx28.dtsi           | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 3ed2b328f7ef..14a92fe59770 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -17,7 +17,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index c5acc19c982d..b86be320496b 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -13,7 +13,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 96c1d106bc64..7e2b0f198dfa 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -97,7 +97,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
 					     &gpmi_pins_evk>;
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 0bac72d5351f..2bdb4c093545 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -16,7 +16,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 91bd6deffee5..865ac3d573c7 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -17,7 +17,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index a2b799c56f8f..94dfbf5b3f34 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -100,7 +100,7 @@
 				status = "disabled";
 			};
 
-			gpmi: gpmi-nand@8000c000 {
+			gpmi: nand-controller@8000c000 {
 				compatible = "fsl,imx28-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1

