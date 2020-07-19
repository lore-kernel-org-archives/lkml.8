Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B58C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B920738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBkm5yZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgGSCqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGSCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:46:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91883C0619D2;
        Sat, 18 Jul 2020 19:46:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so19144726wmg.1;
        Sat, 18 Jul 2020 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDlMbyjXbF67HGTAUvI4dBM3JFAclGFOXiFtjc3PP5g=;
        b=OBkm5yZBxqZNX3JWP/0xtIJqilNQ+sQ2OdaYW+DSf3sWEl0Z7wRdxDy7MnGyTaECup
         yrHW041kNMOsICMTd1OcBvFNlW7L8osiYeRd3DTObPZE2Yl7tVYa9+FQKwT6BrMxVGxZ
         tcKiPwtGFIHZmTyhvgZIoUqRUHTbV2cEgEMfP+u1oyzCHvI+wWbL+FlOe++xqZibPMnX
         OooeApTErxNeJ3o5jrlxIs8vi/rlRkONnu+IN/gTBe4uWXD12SMF+3A9w/LKTk7dbqcQ
         3GJaJdlbE31wcBclN3C2e9JLsGmSOMzf+qKmxjldli7bxG/NDeXCJKLuMH5cWXyx1tVl
         S9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDlMbyjXbF67HGTAUvI4dBM3JFAclGFOXiFtjc3PP5g=;
        b=gmV0ffpng8G483DtzkgFQC4+u8NdaxVdOlpSy0rpau4eJSWATx/GQfE4g+jbiEah1/
         vGidSnWvM4vJRcqNls4wH4MZKTy8LqI46XWZ9Gr7Av5vm996Mg8eYGynctsRyF7SvMTC
         DDDZcqWQEBHPnY2LPYEmMU8zkyTvBkQ8cc8nli38WKBvd6cct0pR5ee3V7WN3TcqPMbs
         RPdkncquPgKokcnhpZR9Ht6xSr2MiQzVnVC+Am1AR3u5zf0Q80PUbEDFBE0yO8io7RzW
         qLQukRzs9uQDSkaT9OiOkhnaduggoo0zUbut2BoLzzQE8w5jkw2rlz7Pw/kawKCwbumQ
         xT4w==
X-Gm-Message-State: AOAM533T6u6oyZP46RPk5Y7Fyy2X5BLlMl3hJr8/USTnwbI+eMqR32Va
        XEa0oIeat8iZ6fM5sVTA+DNIX4Ri
X-Google-Smtp-Source: ABdhPJyYLXrdLbPXFHWT/nFJ2Ld9X7eWl9Ks4YZeNZaMwCthZKPlmXCGnUBHku/1InWBePW4oDCUTg==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr15953197wmc.117.1595126759292;
        Sat, 18 Jul 2020 19:45:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e5sm5176242wrc.37.2020.07.18.19.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:45:58 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add audio playback to u200
Date:   Sun, 19 Jul 2020 02:45:48 +0000
Message-Id: <20200719024548.8940-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719024548.8940-1-christianshewitt@gmail.com>
References: <20200719024548.8940-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and S/PDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index a26bfe72550f..dde7e258a184 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -8,6 +8,7 @@
 #include "meson-g12a.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "amlogic,u200", "amlogic,g12a";
@@ -18,6 +19,13 @@
 		ethernet0 = &ethmac;
 	};
 
+	spdif_dit: audio-codec-1 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -147,6 +155,91 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12A-U200";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* spdif hdmi or toslink interface */
+		dai-link-4 {
+			sound-dai = <&spdifout>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
+			};
+		};
+
+		/* spdif hdmi interface */
+		dai-link-5 {
+			sound-dai = <&spdifout_b>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-6 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
 };
 
 &cec_AO {
@@ -163,6 +256,10 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vddcpu>;
 	operating-points-v2 = <&cpu_opp_table>;
@@ -203,6 +300,18 @@
 	phy-mode = "rmii";
 };
 
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
@@ -288,6 +397,28 @@
 	vqmmc-supply = <&flash_1v8>;
 };
 
+&spdifout {
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spdifout_b {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.17.1

