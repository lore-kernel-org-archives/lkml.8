Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4358CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F7B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lhSGIvlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFZA4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:56:34 -0400
Received: from vps.xff.cz ([195.181.215.36]:45400 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgFZA4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132969; bh=KzfpMNtW3y5p91+Te+S/UaRtGnueNT8aRYpe1i9+jq4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lhSGIvlFDTMrykauS2HhpKQ0XgBth/QfcgKFOa59t6HB0asHV3Dj+stn6cF16Qm5q
         80+hDWBCj/8wfu8/H4aH1At4bAd8Shom5hzNQP7o2KjamVoJLZFgTWg+aUajy99feZ
         4F1OxkRbb21t4gS+3FqSXyn++VP7ZIdqnwfMJMLY=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Ondrej Jirman <megous@megous.com>
Subject: [PATCH v5 12/13] arm64: dts: sun50i-a64-pinephone: Enable LCD support on PinePhone
Date:   Fri, 26 Jun 2020 02:56:00 +0200
Message-Id: <20200626005601.241022-13-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
display.

Backlight levels curve was optimized by Martijn Braam using a
lux meter.

Add its device nodes.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../allwinner/sun50i-a64-pinephone-1.1.dts    | 19 ++++++++++
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 35 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 06a775c41664..3e99a87e9ce5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -9,3 +9,22 @@ / {
 	model = "Pine64 PinePhone Braveheart (1.1)";
 	compatible = "pine64,pinephone-1.1", "allwinner,sun50i-a64";
 };
+
+&backlight {
+	power-supply = <&reg_ldo_io0>;
+	/*
+	 * PWM backlight circuit on this PinePhone revision was changed since
+	 * 1.0, and the lowest PWM duty cycle that doesn't lead to backlight
+	 * being off is around 20%. Duty cycle for the lowest brightness level
+	 * also varries quite a bit between individual boards, so the lowest
+	 * value here was chosen as a safe default.
+	 */
+	brightness-levels = <
+		774  793  814  842
+		882  935  1003 1088
+		1192 1316 1462 1633
+		1830 2054 2309 2596
+		2916 3271 3664 4096>;
+	num-interpolated-steps = <50>;
+	default-brightness-level = <400>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index cefda145c3c9..85a7aa5efd32 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -16,6 +16,13 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+		/* Backlight configuration differs per PinePhone revision. */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -84,6 +91,30 @@ &dai {
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "xingbangda,xbd599";
+		reg = <0>;
+		reset-gpios = <&pio 3 23 GPIO_ACTIVE_LOW>; /* PD23 */
+		iovcc-supply = <&reg_dldo2>;
+		vcc-supply = <&reg_ldo_io0>;
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -188,6 +219,10 @@ &r_pio {
 	 */
 };
 
+&r_pwm {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.27.0

