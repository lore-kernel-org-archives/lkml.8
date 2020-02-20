Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE3C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03A24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTuFKk9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBTIgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41595 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgBTIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:36:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so1268905plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOuik/xQdjhmgeRHVU1F9OsoH/tgDDUcKjmqkiPVOZc=;
        b=GTuFKk9sVnbtm+TPdAJUPyFffbMj1DJ+Rq88BP21LKKkeKiGW+wCr7hsWkdu7ER8NT
         NAA1NRJv6+V2QGPJSri6UdTNdQTinJbxpLTAGyZayu2rv0DsRXTpm34mpyAmGI1+mp1g
         SgXCqUVLwGD2J1gLOa8WBYApqlJLK6Ra2CUEdSnKCbor9k7VUmvzpTxjJpx+ooEwDZVg
         yltg69Q6c0t0vynFAUjlc8NIKqVFERTTP4XSE6LpDhGFLMyT0xeWtPHU32YCspuiBpCe
         Hj2LJJ8Ow1f8dt07GHr0P0kBMTCc9Vp96EDwrU9dwMLg6PW+PGZ9lUAaX8CdJxNxgWjj
         QRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOuik/xQdjhmgeRHVU1F9OsoH/tgDDUcKjmqkiPVOZc=;
        b=kmQ5L7CryrGoyZhX5UsKxF+CTAwK6kfjDw1H5ztdBkY9BgLErN01+y69dSIN4BOELo
         EdnnLjkjT7V/RcHFyw7hknwRndpDDTEOseVMfII/ujFuM7XYYuFzWkCWgLzsWBckZAEm
         lP3vwVSyvCqYD87LIe7xfMdS1zuJI2KoxAf0pg3KLtduiPWvnqc9SfwQ/aCkilT+J3bv
         DJtRoCSTL2pkYqOvhw+EU64UINumh4ZKiPM5ZHk8nW/XiRNGOb9MI66uFCHy/sFDFVUw
         zSMt41sgkGFjb2yL9/VkrYXiWDOMOac9JLLLZyC60B6sa6l5LlqvtN7eGkgAfQOkoG0S
         01xg==
X-Gm-Message-State: APjAAAVbW4lEiFZ4Q9PQ7SDdMWdWUYWzqwDJUODPHYTUz+u1fg4YkiHn
        huV/H04/REpWD4R8SZ5ZrnY=
X-Google-Smtp-Source: APXvYqx61DAP56pqHMjI66GBxwpRYUpggqeu+U1edpVHeDuWzdLliNY2/SWqE8LcxSU8RBlwVPhkhA==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr2218837pjz.135.1582187759650;
        Thu, 20 Feb 2020 00:35:59 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:59 -0800 (PST)
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
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 6/6] arm64: allwinner: a64: enable LCD-related hardware for Pinebook
Date:   Thu, 20 Feb 2020 00:35:08 -0800
Message-Id: <20200220083508.792071-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
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

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 69 ++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index c06c540e6c08..f5633f550d8a 100644
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
@@ -177,12 +197,45 @@ &pwm {
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				anx6345_in_tcon0: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_anx6345>;
+				};
+			};
+
+			anx6345_out: port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				anx6345_out_edp: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&panel_edp_in>;
+				};
+			};
+		};
+	};
 };
 
 &r_pio {
@@ -357,6 +410,20 @@ &sound {
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
+	tcon0_out_anx6345: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&anx6345_in_tcon0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.25.0

