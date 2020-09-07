Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9551F21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JPOB01GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgIGIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgIGIdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:33:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2534C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:33:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so13497825wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tf/pPuP/quD6UX7EbsHW6QHRSABL9O5KfoCfXcuWE28=;
        b=JPOB01GQC1EyMKgIY9XWJHIybEP5Kk0Mpazg12h1ld+lYOavG/ORNCQ5E+DVx8sZkV
         yeSp/Iza0lKp0ly4OCn1zK5IbdKv75HP7DeNlJCa8yDUt4Ylwgl+7ekFHntm05cdt2iB
         NUorJTBx29g9kSLL3BY6M3iRw9AjeoA0xpaTMVG64YqKLc9yT7srFA0fjlBgvqa0KeMa
         9+14TezNRNDJoZ8/56DGplnxQ0InDL3adAX/vCps1gwkD21czgLgyRev9+CqMQl2KkV1
         jC2pwhNvoQ4zAVN2g2rOZxx2xbdAKiwK62uIzX34TvxfaJl/VCk2q7BeXg69nOaATQU+
         x4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tf/pPuP/quD6UX7EbsHW6QHRSABL9O5KfoCfXcuWE28=;
        b=Fvt2ozR4aSLIeUg+mgUrkoUYRTM7SixePMHZy0QwRKoSatkiK6OnHrh+coCALuFQb8
         WPUcZYfcY6rMjYZf21g7HBPjAC3mMKYYJsFLJHJuJvUVQuIUMkhahW/UIjFRX2mkUZrX
         SvyDDJ6lopu0zGXj8LARTrV2sDl4K18m9cZ0P1FR0eCHv27y+N0RB0/AL5rKX+amY7r2
         ZgRU+Tv8VPunwLys/mHDLs3VYxt9+19g4xrfrZN6zlKv/f2l55VWSJEaWJcjuipeIA3O
         xGzWkSswbtwZemfnU77dvwgHtls7TlGUJhoc+EHHM37aKsMHjxqA+16SKeLWCPi22gEJ
         i5AQ==
X-Gm-Message-State: AOAM5310+/ly6zWXz2Rzu/9p88Um6VWS5au9Uj/PT9FODhQctMGC3O8T
        rnJKDrkL1cU/hi9y964pu6o6Og==
X-Google-Smtp-Source: ABdhPJzlXWWJxUL+NR0WVb8iGxSGFRhnUwwKhX4IAQt9btsq140rrTUEi09a9mEZEaHQVqchSMIfZQ==
X-Received: by 2002:a1c:62d4:: with SMTP id w203mr18358593wmb.146.1599467589332;
        Mon, 07 Sep 2020 01:33:09 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o5sm25205111wmc.33.2020.09.07.01.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:33:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson-axg-s400: add MIPI DSI panel nodes
Date:   Mon,  7 Sep 2020 10:33:00 +0200
Message-Id: <20200907083300.14412-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907083300.14412-1-narmstrong@baylibre.com>
References: <20200907083300.14412-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes for :
- Backlight of the tl070wsh30 panel
- MIPI-DSI attributes
- TDO TL070WSH30 TFT-LCD panel

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index cb1360ae1211..abfad67ca06b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -7,6 +7,7 @@
 
 #include "meson-axg.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	compatible = "amlogic,s400", "amlogic,a113d", "amlogic,meson-axg";
@@ -116,6 +117,16 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
+	panel_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_ab 1 78125 PWM_POLARITY_INVERTED>;
+		enable-gpios = <&gpio GPIOZ_5 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vcc_5v>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <250>;
+	};
+
 	main_12v: regulator-main_12v {
 		compatible = "regulator-fixed";
 		regulator-name = "12V";
@@ -434,6 +445,42 @@
 	};
 };
 
+
+&mipi_dsi {
+	status = "okay";
+
+	assigned-clocks = <&clkc CLKID_GP0_PLL>;
+	assigned-clock-rates = <283500000>;
+
+	panel@0 {
+		compatible = "tdo,tl070wsh30";
+		reset-gpios = <&gpio GPIOZ_6 GPIO_ACTIVE_LOW>;
+		power-supply = <&vcc_3v3>;
+		backlight = <&panel_backlight>;
+		reg = <0>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&mipi_pcie_analog_dphy {
+	status = "okay";
+};
+
+&mipi_dphy {
+	status = "okay";
+};
+
+&mipi_dsi_panel_port {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
 &pdm {
 	pinctrl-0 = <&pdm_dclk_a14_pins>, <&pdm_din0_pins>,
 		    <&pdm_din1_pins>, <&pdm_din2_pins>, <&pdm_din3_pins>;
@@ -443,7 +490,7 @@
 
 &pwm_ab {
 	status = "okay";
-	pinctrl-0 = <&pwm_a_x20_pins>;
+	pinctrl-0 = <&pwm_a_x20_pins>, <&pwm_b_z_pins>;
 	pinctrl-names = "default";
 };
 
-- 
2.22.0

