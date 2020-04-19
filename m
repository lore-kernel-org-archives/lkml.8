Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF19C38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5432078A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzhDfIBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDSFil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDSFig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:38:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA8C061A0F;
        Sat, 18 Apr 2020 22:38:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so5218550lfq.1;
        Sat, 18 Apr 2020 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYC0sRuA/TYJuw5oAwEPc/sM406ZLPi+JH8RytrM9Xo=;
        b=NzhDfIBcxQ9+BGr6tDprN7zGw5HKY4gX+mcL3G3z7uYLtCZtNHXP9yA348ho+833z1
         MwScwF7kHs438Yxx5LMQFkFMaMqDMIHYCJdee1HhclVCseFjPvmnH7InR2iC/jEjMOVf
         /sL8xEkdFho9mrF86Dl6WVxT0u7EqRtwgzSfkQkZt4xkscKomcn4B07b2N7XdDKsX2YJ
         20Ge+29mpe2DuFU5KchFkLsduui0eQ7upSinWBV3Y7tmvq+J0sgq32uDj8/RMxXxakmi
         xUp8ebHfDdp0hbBByacSwl2DWAdu5OZODSANMi1z9tquYKMTI3MZCUh0C+dmPC3Kg7ll
         JRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYC0sRuA/TYJuw5oAwEPc/sM406ZLPi+JH8RytrM9Xo=;
        b=h52c5dH4+c/O+uh0N0KUdynvTnfNVHqWuwV4lEStk9utI/6ByQr0TloXD5ffoOFByJ
         Jp60F9WzRih1Ruzr04aWLDgpYGOsuFO7HfH66fJL2CiPGBYpU+mZoFeH1waz8Y6gPy94
         Kn7ih5k/aZA/4TqZnwSl6PhYW53t/WllAETMS7KQBy2sPgl8utyPSQl8x5Qw/d1+f0Rc
         Z2A3j1s43wTXATpznw06QIEf8C7vJw7OxigolhpmSlzZ4neBpeQ/tzeQpafBtC009tBE
         an+JDYejX9/DTIliglfUTFGWX80I9hOAoQtJki5JaWzZA/7yl3AUl31buReakyrfYcLU
         ZvMg==
X-Gm-Message-State: AGi0PuZppKTESUt1jmvV8J8qm3vv6px8Wdjt4Z44dQr6XqEXgb5C2C9A
        LIfOoYOqXCGoAnffZldBNsrIRDJO
X-Google-Smtp-Source: APiQypJbGGSWUEbOeScJQPCu106dBdxhVhIfm+Fd+KW3uFwOL76qntlb4xO1N90B/fl+AQPJErEfbg==
X-Received: by 2002:a19:d3:: with SMTP id 202mr6530212lfa.24.1587274714755;
        Sat, 18 Apr 2020 22:38:34 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r23sm20416619ljh.34.2020.04.18.22.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:38:34 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 5/5] arm64: dts: meson: convert x96max to hdmi dtsi
Date:   Sun, 19 Apr 2020 05:38:15 +0000
Message-Id: <20200419053815.15731-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419053815.15731-1-christianshewitt@gmail.com>
References: <20200419053815.15731-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the X96-max dts by using meson-g12-audio-hdmi.dtsi

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 131 +-----------------
 1 file changed, 1 insertion(+), 130 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 1b07c8c06eac..3ede72fc8f53 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -6,9 +6,9 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include "meson-g12-audio-hdmi-spdif.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
-#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "amediatech,x96-max", "amlogic,g12a";
@@ -19,13 +19,6 @@
 		ethernet0 = &ethmac;
 	};
 
-	spdif_dit: audio-codec-1 {
-		#sound-dai-cells = <0>;
-		compatible = "linux,spdif-dit";
-		status = "okay";
-		sound-name-prefix = "DIT";
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -148,86 +141,6 @@
 		regulator-always-on;
 	};
 
-	sound {
-		compatible = "amlogic,axg-sound-card";
-		model = "G12A-X96-MAX";
-		audio-aux-devs = <&tdmout_b>;
-		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
-				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-				"TDM_B Playback", "TDMOUT_B OUT",
-				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
-				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
-
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-		status = "okay";
-
-		dai-link-0 {
-			sound-dai = <&frddr_a>;
-		};
-
-		dai-link-1 {
-			sound-dai = <&frddr_b>;
-		};
-
-		dai-link-2 {
-			sound-dai = <&frddr_c>;
-		};
-
-		/* 8ch hdmi interface */
-		dai-link-3 {
-			sound-dai = <&tdmif_b>;
-			dai-format = "i2s";
-			dai-tdm-slot-tx-mask-0 = <1 1>;
-			dai-tdm-slot-tx-mask-1 = <1 1>;
-			dai-tdm-slot-tx-mask-2 = <1 1>;
-			dai-tdm-slot-tx-mask-3 = <1 1>;
-			mclk-fs = <256>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
-			};
-		};
-
-		/* spdif hdmi or toslink interface */
-		dai-link-4 {
-			sound-dai = <&spdifout>;
-
-			codec-0 {
-				sound-dai = <&spdif_dit>;
-			};
-
-			codec-1 {
-				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
-			};
-		};
-
-		/* spdif hdmi interface */
-		dai-link-5 {
-			sound-dai = <&spdifout_b>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
-			};
-		};
-
-		/* hdmi glue */
-		dai-link-6 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-			codec {
-				sound-dai = <&hdmi_tx>;
-			};
-		};
-	};
-
 	wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
@@ -236,10 +149,6 @@
 	};
 };
 
-&arb {
-	status = "okay";
-};
-
 &cec_AO {
 	pinctrl-0 = <&cec_ao_a_h_pins>;
 	pinctrl-names = "default";
@@ -254,10 +163,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-&clkc_audio {
-	status = "okay";
-};
-
 &cpu0 {
 	cpu-supply = <&vddcpu>;
 	operating-points-v2 = <&cpu_opp_table>;
@@ -292,18 +197,6 @@
 	};
 };
 
-&frddr_a {
-	status = "okay";
-};
-
-&frddr_b {
-	status = "okay";
-};
-
-&frddr_c {
-	status = "okay";
-};
-
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
@@ -457,25 +350,3 @@
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&flash_1v8>;
 };
-
-&spdifout {
-	pinctrl-0 = <&spdif_out_h_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&spdifout_b {
-	status = "okay";
-};
-
-&tdmif_b {
-	status = "okay";
-};
-
-&tdmout_b {
-	status = "okay";
-};
-
-&tohdmitx {
-	status = "okay";
-};
-- 
2.17.1

