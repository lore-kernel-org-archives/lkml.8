Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91945C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B22A2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HuiGKxnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgGAJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgGAJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC0C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:46:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so21711353wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LMkCbMP/fW3R0JY/uxUZEZ9R2osohzFUesMp17+pMA=;
        b=HuiGKxnQzZpLlRxThfRTnOhCSU//LCi/puShODTGZ46B+LoY9thZL2n/lyYruh84Xy
         FzX7LqEVPAhmNdR9GoZwEnl0PWHhtCLSGKm76GYKq0wrcAc0UMQRfpsIAZoK+ENSX97w
         L1h7/Ulp7uzTMNjxF2k6j+NOMBz0XgFVRS85qp0jjWtvuhBOUOJUC1ariSviTZTXoxt4
         ILIcPg4Ty5znQQ80vRwKVkTXul8z2PcHwyal3RDtEREF6bFb0JdM/m+M5fqn4wA+Cp/K
         6hYOqUEnSQJqxBOLNHwvKPskeMprusRmjAMlkjJvebIH4d1L6klHbgyg/dh3z3IURGaD
         RDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LMkCbMP/fW3R0JY/uxUZEZ9R2osohzFUesMp17+pMA=;
        b=prx3gR0tIE8ZxwTkelnR94GlbWxylWhWxUPbl7RKk7541XF0dAVtdVEIkcIZFZpMx7
         9twgx/Eucvau4+I3g6PcpubezHYWyU+5Pmt6FVZzERARX2tT47Y3m45VPLeM2iO0ew5Z
         7xInK5veouaZzoYHERkPbnfxKea2hgAMlYYj6SifWqXlNNL04qHnm4qjLuBxNJHupJpX
         To5tdgJumKcCuwN1/yA5dTep6EDvjZraw9dn4duEkzGKBjCQDBszVZX9eSSDgPDe9IpV
         tMisAirzcP3Jvjh+IHVXbfxox/r5FDRGDyPv6gaN6wGghhdS6QnGnjs1t+lWcvBcw9Ja
         yZnw==
X-Gm-Message-State: AOAM533XEax+GxVo/4airfeczNi3lt0BLntGranAEonAHJc797HEY5Hj
        16+FHgWornkNdNjiFcjIxUQXrQ==
X-Google-Smtp-Source: ABdhPJzdxyb0nGawWBsr2xEb7LJdcuL1c2OsDnBTglQIDKTV8eA1yyQ0UVabx6iu+anzu0LLvTOukQ==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr26629285wmk.149.1593596764449;
        Wed, 01 Jul 2020 02:46:04 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f13sm6270472wmb.33.2020.07.01.02.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 02:46:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: odroid-n2: add jack audio output support
Date:   Wed,  1 Jul 2020 11:45:56 +0200
Message-Id: <20200701094556.194498-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200701094556.194498-1-jbrunet@baylibre.com>
References: <20200701094556.194498-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audio on jack socket of the odroid-n2

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 79 +++++++++++++++++--
 1 file changed, 74 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index d4421ad164bd..34fffa6d859d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -9,6 +9,7 @@
 #include "meson-g12b-s922x.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
@@ -20,6 +21,14 @@ aliases {
 		ethernet0 = &ethmac;
 	};
 
+	dioo2133: audio-amplifier-0 {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		VCC-supply = <&vcc_5v>;
+		sound-name-prefix = "U19";
+		status = "okay";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -209,16 +218,26 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "G12B-ODROID-N2";
-		audio-aux-devs = <&tdmout_b>, <&tdmin_a>, <&tdmin_b>,
-				 <&tdmin_c>, <&tdmin_lb>;
+		audio-widgets = "Line", "Lineout";
+		audio-aux-devs = <&tdmout_b>, <&tdmout_c>, <&tdmin_a>,
+				 <&tdmin_b>, <&tdmin_c>, <&tdmin_lb>,
+				 <&dioo2133>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
+				"TDM_C Playback", "TDMOUT_C OUT",
 				"TDMIN_A IN 4", "TDM_B Loopback",
 				"TDMIN_B IN 4", "TDM_B Loopback",
 				"TDMIN_C IN 4", "TDM_B Loopback",
 				"TDMIN_LB IN 1", "TDM_B Loopback",
+				"TDMIN_A IN 5", "TDM_C Loopback",
+				"TDMIN_B IN 5", "TDM_C Loopback",
+				"TDMIN_C IN 5", "TDM_C Loopback",
+				"TDMIN_LB IN 2", "TDM_C Loopback",
 				"TODDR_A IN 0", "TDMIN_A OUT",
 				"TODDR_B IN 0", "TDMIN_A OUT",
 				"TODDR_C IN 0", "TDMIN_A OUT",
@@ -230,7 +249,11 @@ sound {
 				"TODDR_C IN 2", "TDMIN_C OUT",
 				"TODDR_A IN 6", "TDMIN_LB OUT",
 				"TODDR_B IN 6", "TDMIN_LB OUT",
-				"TODDR_C IN 6", "TDMIN_LB OUT";
+				"TODDR_C IN 6", "TDMIN_LB OUT",
+				"U19 INL", "ACODEC LOLP",
+				"U19 INR", "ACODEC LORP",
+				"Lineout", "U19 OUTL",
+				"Lineout", "U19 OUTR";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -275,22 +298,56 @@ dai-link-6 {
 			dai-tdm-slot-tx-mask-3 = <1 1>;
 			mclk-fs = <256>;
 
-			codec {
+			codec-0 {
 				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
 			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_IN_B>;
+			};
 		};
 
-		/* hdmi glue */
+		/* i2s jack output interface */
 		dai-link-7 {
+			sound-dai = <&tdmif_c>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
+			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_IN_C>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-8 {
 			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
 
 			codec {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		/* acodec glue */
+		dai-link-9 {
+			sound-dai = <&toacodec TOACODEC_OUT>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
 	};
 };
 
+&acodec {
+	AVDD-supply = <&vddao_1v8>;
+	status = "okay";
+};
+
 &arb {
 	status = "okay";
 };
@@ -505,6 +562,10 @@ &tdmif_b {
 	status = "okay";
 };
 
+&tdmif_c {
+	status = "okay";
+};
+
 &tdmin_a {
 	status = "okay";
 };
@@ -525,6 +586,14 @@ &tdmout_b {
 	status = "okay";
 };
 
+&tdmout_c {
+	status = "okay";
+};
+
+&toacodec {
+	status = "okay";
+};
+
 &tohdmitx {
 	status = "okay";
 };
-- 
2.25.4

