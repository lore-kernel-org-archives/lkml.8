Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5185C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AAB2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bkX5r1WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHCOWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:22:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA0C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:22:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so34415398wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIgx/HWjFDj4MNVMQkg/plO9eAmsTA2XmhwNF6CYKl4=;
        b=bkX5r1WKOmEW9wHJaRW535/oKEsaWV7/PaVslkpJu1WV2Yrp7DtlgV1Xl47hk8gwHW
         duNlV/aC11YaooI8Uv98c4L3iC/hHs+fys4ej6Uai3YzjLmNDEU0LUsFcBRGJbjxiGke
         BxW0L12mzayM6tdSIWfzxy7XjO/WhuAXLcG5IVNLqkjDLyw5DIpYSHeHpKCvpUlu05s0
         LpXPoOFybR8DtxulzgcV7qP7JLxCMMhFgpE81k8QJLD6HffNhttD8PIxUUa/gz18f9JF
         rJjPDlDbsSYXDYE3MD0nO4h9YIvxRaiD+F9PgH4ZvApRMr1K3u4B7oY8XCWn5OYQM4Ck
         q9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIgx/HWjFDj4MNVMQkg/plO9eAmsTA2XmhwNF6CYKl4=;
        b=hOr/XACCYL6dJLvHebubdrw/J9wY+6c6ikFnYjnEq5pyuMaaTccQYalAVvlhQk0fRX
         UFIAiFOC5HfQaax+pk1dEAyhggzvd1cqghTWUIge26wbruicyq/39cJzoCZYgWX3hWdt
         UEM3OVdPaxdcr2wcuc2rj8Qij1fx/DaLhfOzECaNyiu5btXhOTosqvLilwe3v2s88rsK
         pNUNbVWKvy2XmFW+YNNz34w0uXeTFt9fhuAzSfap1J4+0kc2BcMZ+Kzp4qTvxCbgyGAC
         d6NijjYmp90gWMAiEohECFGRFrtvh9r7niszNm96JxtzF9B7qX/eMWWsCxoTVLlNhp9w
         aKeg==
X-Gm-Message-State: AOAM531pVwgHNlLWDugqHrE5KnltpmYKF+215SpjB4D6Usfn4jTjpLeA
        q/GQs7v7urLIkfRFG1KhYGbYJw==
X-Google-Smtp-Source: ABdhPJxZ3QUkNQ9OtGk4mAkzLrUMsMeIgU0Kqs19up3kC3j9rS1ycAy5nzFiqDD2NgmX/x8Hy2q/gA==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr15188109wrr.299.1596464526995;
        Mon, 03 Aug 2020 07:22:06 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d14sm25309563wre.44.2020.08.03.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:22:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: vim3: make sound card common to all variants
Date:   Mon,  3 Aug 2020 16:21:58 +0200
Message-Id: <20200803142158.173402-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vim3 sound card definition should be same all the vim3 variants
Move the definition to the appropriate device tree file.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 88 ------------------
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 224c890d32d3..f42cf4b8af2d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -5,8 +5,6 @@
  * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
  */
 
-#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
-
 / {
 	model = "Khadas VIM3";
 
@@ -47,69 +45,6 @@ vddcpu_b: regulator-vddcpu-b {
 		regulator-boot-on;
 		regulator-always-on;
 	};
-
-	sound {
-		compatible = "amlogic,axg-sound-card";
-		model = "G12B-KHADAS-VIM3";
-		audio-aux-devs = <&tdmout_a>;
-		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
-				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
-				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
-				"TDM_A Playback", "TDMOUT_A OUT";
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
-			sound-dai = <&tdmif_a>;
-			dai-format = "i2s";
-			dai-tdm-slot-tx-mask-0 = <1 1>;
-			dai-tdm-slot-tx-mask-1 = <1 1>;
-			dai-tdm-slot-tx-mask-2 = <1 1>;
-			dai-tdm-slot-tx-mask-3 = <1 1>;
-			mclk-fs = <256>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
-			};
-		};
-
-		/* hdmi glue */
-		dai-link-4 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-			codec {
-				sound-dai = <&hdmi_tx>;
-			};
-		};
-	};
-};
-
-&arb {
-	status = "okay";
-};
-
-&clkc_audio {
-	status = "okay";
 };
 
 &cpu0 {
@@ -154,18 +89,6 @@ &cpu103 {
 	clock-latency = <50000>;
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
 &pwm_ab {
 	pinctrl-0 = <&pwm_a_e_pins>;
 	pinctrl-names = "default";
@@ -182,14 +105,3 @@ &pwm_AO_cd {
 	status = "okay";
 };
 
-&tdmif_a {
-	status = "okay";
-};
-
-&tdmout_a {
-	status = "okay";
-};
-
-&tohdmitx {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 6b75157265e1..3738dfd9eb06 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	aliases {
@@ -161,6 +162,62 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12B-KHADAS-VIM3";
+		audio-aux-devs = <&tdmout_a>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT";
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
+			sound-dai = <&tdmif_a>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+
 	wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
@@ -169,6 +226,14 @@ wifi32k: wifi32k {
 	};
 };
 
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
 &cec_AO {
 	pinctrl-0 = <&cec_ao_a_h_pins>;
 	pinctrl-names = "default";
@@ -221,6 +286,18 @@ &ethmac {
         amlogic,tx-delay-ns = <2>;
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
@@ -369,6 +446,19 @@ w25q128: spi-flash@0 {
 	};
 };
 
+
+&tdmif_a {
+	status = "okay";
+};
+
+&tdmout_a {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.25.4

