Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC516C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B363A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj9USULV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBZILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:11:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39869 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBZIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so1058287pfy.6;
        Wed, 26 Feb 2020 00:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/9ulr35We1VvK4OKOtO+SeDdjZAIuN626KlRGL51e8=;
        b=Uj9USULV1YhIjRQTGet+GBQYuuhLAkRgQq5aOXkZU55ZeXZOwYCvjYC0XTbkwI02vn
         nMqNb637FbLBsLL+0OixEVNpFP/WYWrCLF5zLIEBTSZkXEK2J8hPyn24masq/KXBnUXK
         1WpXqTxgjbgl1eq/uxSXJMuc6aResWHy1sQuEaEYBEWdEyvPqtQts5z5Su639wYEgo9n
         wE96FuZQY46tDJyTJqt+ZJrzDYNCNenLNiqWFwxe/zxWzBuM58iQ9ur+6Ym5ldZxRpj8
         JJ2JlN+8/BPq8Wk9S0SAMAUumaOifHahGje65ULSbNA6Krngc4WuiBgliS4rekKjbPPq
         Xcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/9ulr35We1VvK4OKOtO+SeDdjZAIuN626KlRGL51e8=;
        b=FYSyEY5DB830VSGRY1uFHmk/+/dh6jT2NcyPwm/Xwb3wGKRWYGdlUUkrpUZq49x9KB
         A15A3fGw1f7jcztTo+RO9PkdMtL6udJqTLJQEz/6azYWhr3FVjUU6EsZ8hc78rQToDKY
         G2T94F3TWTOIUWxtMrrj0KmOZtkza7gBdFBLtHowFqeeGoxESXxdy+nDXQ0Sd8+3H8Et
         F2LjDNMAClvClQLTIbFYV94i0AV8aE0/KUg1vN1crWqkVFX9fp6Qc8ak2QmXVHdWUGDw
         XDYh7A7CI6cUtT5abGeav2E6Wpr+FLzMofzAuHPF1SSUZRTDli0KiTYFLBKpUId0BOmj
         8/4g==
X-Gm-Message-State: APjAAAWOaxOHGsq3TdbF2AOdQr9vSN5UivHkB0jp36DLnVJbdD4I+HlL
        8xfOFAbEv2L9zlZMaTKhPQc=
X-Google-Smtp-Source: APXvYqwdqfkaKNsVj/z20Fl00qUooa5Fc8g4w6gy6KhAC3QgiEMz+qOhI4aMxTYoHDNd7Lx/skz8fQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr3012096pfy.166.1582704649041;
        Wed, 26 Feb 2020 00:10:49 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:48 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 6/6] arm64: allwinner: a64: enable LCD-related hardware for Pinebook
Date:   Wed, 26 Feb 2020 00:10:11 -0800
Message-Id: <20200226081011.1347245-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Pinebook has an ANX6345 bridge connected to the RGB666 LCD output and
eDP panel input. The bridge is controlled via I2C that's connected to
R_I2C bus.

Enable all this hardware in device tree.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index c06c540e6c08..0033f6a43d98 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -48,6 +48,18 @@ lid_switch {
 		};
 	};
 
+	panel_edp: panel-edp {
+		compatible = "neweast,wjfh116008a";
+		backlight = <&backlight>;
+		power-supply = <&reg_dc1sw>;
+
+		port {
+			panel_edp_in: endpoint {
+				remote-endpoint = <&anx6345_out_edp>;
+			};
+		};
+	};
+
 	reg_vbklt: vbklt {
 		compatible = "regulator-fixed";
 		regulator-name = "vbklt";
@@ -109,6 +121,10 @@ &dai {
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	phys = <&usbphy 0>;
 	phy-names = "usb";
@@ -119,6 +135,10 @@ &ehci1 {
 	status = "okay";
 };
 
+&mixer0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -177,12 +197,38 @@ &pwm {
 	status = "okay";
 };
 
-/* The ANX6345 eDP-bridge is on r_i2c */
 &r_i2c {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_i2c_pl89_pins>;
 	status = "okay";
+
+	anx6345: anx6345@38 {
+		compatible = "analogix,anx6345";
+		reg = <0x38>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		dvdd25-supply = <&reg_dldo2>;
+		dvdd12-supply = <&reg_fldo1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			anx6345_in: port@0 {
+				reg = <0>;
+				anx6345_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_anx6345>;
+				};
+			};
+
+			anx6345_out: port@1 {
+				reg = <1>;
+				anx6345_out_edp: endpoint {
+					remote-endpoint = <&panel_edp_in>;
+				};
+			};
+		};
+	};
 };
 
 &r_pio {
@@ -357,6 +403,19 @@ &sound {
 			"MIC2", "Internal Microphone Right";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_anx6345: endpoint {
+		remote-endpoint = <&anx6345_in_tcon0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.25.0

