Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E21C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B92206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGYLPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:15:10 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:37408 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgGYLPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:15:09 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jul 2020 07:15:08 EDT
Received: from localhost.localdomain (80-110-125-173.cgn.dynamic.surfer.at [80.110.125.173])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6D62DC8DE4;
        Sat, 25 Jul 2020 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1595675308; bh=XGCgnG3zaA6+JlKqdyeyx7BIoqEDrm/wMUBHk9wYz5A=;
        h=From:To:Cc:Subject:Date;
        b=I3YwHjrzdGV0mj4IygSFtz10bUCzT4ak1a1dqmSaIWRzyjkZrncZRgNTb+ZWAa0tP
         aENeUq5LGblOB7aI4nrdU6IpbQRq3utoZMLDtrga5czAYqonNtZiFs2P/acXxxxO58
         qkYqsME4grc9Avg3vJEP9PhcfJs5loQN/TL3wHAQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sun50i-pinephone: add led flash
Date:   Sat, 25 Jul 2020 13:08:12 +0200
Message-Id: <20200725110812.199529-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All revisions of the PinePhone have an SGM3140 LED flash. The gpios were
swapped on v1.0 of the board but this was fixed in later revisions.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi      | 11 +++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
index 0c42272106afa..b579b03d4e026 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
@@ -9,3 +9,8 @@ / {
 	model = "Pine64 PinePhone Developer Batch (1.0)";
 	compatible = "pine64,pinephone-1.0", "allwinner,sun50i-a64";
 };
+
+&sgm3140 {
+	flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 3e99a87e9ce52..8552587aac248 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -28,3 +28,8 @@ &backlight {
 	num-interpolated-steps = <50>;
 	default-brightness-level = <400>;
 };
+
+&sgm3140 {
+	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
index a9f5b670c9b82..ec77715ba4a2a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
@@ -38,3 +38,8 @@ &lis3mdl {
 	interrupt-parent = <&pio>;
 	interrupts = <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
 };
+
+&sgm3140 {
+	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 25150aba749dc..e0bc1bcc1c1f3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -60,6 +60,17 @@ vibrator {
 		enable-gpios = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
 		vcc-supply = <&reg_dcdc1>;
 	};
+
+	sgm3140: led-controller {
+		compatible = "sgmicro,sgm3140";
+		vin-supply = <&reg_dcdc1>;
+
+		sgm3140_flash: led {
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			flash-max-timeout-us = <250000>;
+		};
+	};
 };
 
 &codec {
-- 
2.27.0

