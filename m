Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1FC433ED
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0B92076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neHTgbqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgGRG6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgGRG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41BC0619D2;
        Fri, 17 Jul 2020 23:58:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so13280100wrp.2;
        Fri, 17 Jul 2020 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IIVS7MhfURH0UVnp76zcUfKlv8hfdezuu29h1qTO9Q=;
        b=neHTgbqfGpClsL0gQHB67RRXau6lnk7fbLn9xgBy3PbSToJl1m5N4Z3HP05r7yFwiv
         +FPXZgtCdnDtY/9lx51m4vVBJXvPhBj9W/BUsnDRCHVm1a3dTNtVViXysW2aL/uHorYp
         6mJSJyfgpxfwbkRUVvnUPAzQDzrflpv73pXKg9R5Vtuiv6g42DRzxw5e0X1HmesTM+4O
         J988NtRNnW+ea1shLNC9e0xMmIR2aTPnNKT5pfZh8vKZ4cRVK0Yp0PNs1nL/ZcyIzbru
         aAiIwppV2XgbKPm71NusWFxxSPUFSYM5XBt/iEYcS2JHd5/AICUVeQVMGsn8LVFhhyAp
         9t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3IIVS7MhfURH0UVnp76zcUfKlv8hfdezuu29h1qTO9Q=;
        b=npS4+fs/RWCGydtK5Bp9BMmscFiotTRUA0Z5dN+hcfQQ69gNBa+CharhSieMCb9zmH
         Q9vnMB7zhtT0ijqIXAyh31k8rTDfOICXByxzZDCgkZ+JDZIYYnXh/SGaORBCHvEx2d8c
         Q6SCNyRSqx/1f9dgh5WGfh4NdbxdtZzSMW1tAoruV39nIs/UkRZa/VNFFaiR8MzstBJ8
         PutV/pBioAwmb+GR3oprxYDSJ5dj6b3TfQpo39EN8oeVuT95et6r9yi71g6679gt32a7
         UHsOPqm7W9Mtrui3i274Kmng3sXAJXo5+Sg/ly+QBIXgtCthHARcmUqNAM8o41Car3+9
         ydpg==
X-Gm-Message-State: AOAM531yUGwTVzt4fm2qiLfpH/l5iLWfeL/0t2M4MVzRbj1D5KX5nMGp
        bExn/h+9+0Oe6HfBlVMt8SY=
X-Google-Smtp-Source: ABdhPJxENi3dgreYnZ/rBF9Fp1/H2p/cBJM+q9VtdrscIG6c3xfl5obsf4gBCK3S/TGY2xHmPM4rsA==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr643263wru.372.1595055479486;
        Fri, 17 Jul 2020 23:57:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 07/12] arm64: dts: meson: add audio playback to p200
Date:   Sat, 18 Jul 2020 06:57:34 +0000
Message-Id: <20200718065739.7802-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718065739.7802-1-christianshewitt@gmail.com>
References: <20200718065739.7802-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 3c93d1898b40..a16dac72600d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -9,11 +9,19 @@
 
 #include "meson-gxbb-p20x.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P200 Development Board";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	avdd18_usb_adc: regulator-avdd18_usb_adc {
 		compatible = "regulator-fixed";
 		regulator-name = "AVDD18_USB_ADC";
@@ -57,6 +65,59 @@
 			press-threshold-microvolt = <0>; /* 0% */
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-P200";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &ethmac {
-- 
2.17.1

