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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A1C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7142076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxnpCgiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGRG56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgGRG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61102C0619D2;
        Fri, 17 Jul 2020 23:57:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so17758976wmj.2;
        Fri, 17 Jul 2020 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1krktBPS100MfXZ+pc+c++ZJjlsjSR2xUu8yCpuZMDY=;
        b=MxnpCgiutKDScYhaBSLciizrJAJTJFBr/z8JYY0P+RZ9GzgwghrgNFNaK07MDeEVIO
         go4TQe+V7RxkyR8z14sUvYAvDojXvhpsKSm9bCl01e305F4dSK2ORKh4vT781h5YU9cj
         fbQgwezKw96kyZ2O+6mrFEh/UgB1rW1NM8ioBXzfbtxQrE59TCdrcR2A5YN/QOWx/6hL
         fDDWUPFnWETz9S1Anlrno57q/ch+Bef82ry89P26ZxR8ZWiZvz7jTdy+xyPA8eWqSQQd
         mneR/5ai/AVUPC3PDw2PZEg95Fuo6fOeCmrhq6+lXSbXGTI9J/qAN96LnBS+nXKmJQCo
         XKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1krktBPS100MfXZ+pc+c++ZJjlsjSR2xUu8yCpuZMDY=;
        b=MB12HM0lmqgtWkiO2anh0NKzpZA4+lkU13VXY0K8K6VtDNW0p9QSUHXMYEIrrrEjft
         Mj6gd2Ux8MZ+BpWvzp2oJNYPGc2UfQVHWPH7l2B3Q5xxbkWx5w+7s7JxkrHJ5+u+D8Cq
         wboib8ZaDIRGDnnI10+Qw/LGm1X2wXlABRNDlVJaVlTjTmRZUZC7nJfD0nKJRBilYvgi
         2sDfbOSMQyeHOdbFaWviaN/furfuIszOiq3/gDO1xwdVMwpinlJ1xFsWNMrM8bi6uir+
         ahCK4g17PTBHbdAuvxfOXrxiscbpET3FvWIkuzglTN88Fh+OzxxIP9QWBw/1rKAz2xIC
         jk9g==
X-Gm-Message-State: AOAM531Gq9kMZwjQnkTYCGIPNX99Y0PX5Z99B74csC1r69xJ8nJVlwm2
        Urj7YMNnzpbK6IVPxVd0FpKhs1Fn
X-Google-Smtp-Source: ABdhPJynB0P8pI+h9iCmq/dMiqpiyDbX2abpYL1dqoXORL7MYzIRgWhjk8zdE4npMk9SNvrzyP4JWQ==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr12857564wmc.187.1595055473119;
        Fri, 17 Jul 2020 23:57:53 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:52 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 04/12] arm64: dts: meson: add audio playback to nexbox-a1
Date:   Sat, 18 Jul 2020 06:57:31 +0000
Message-Id: <20200718065739.7802-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718065739.7802-1-christianshewitt@gmail.com>
References: <20200718065739.7802-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support is limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 83eca3af44ce..faca6fafc164 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "meson-gxm.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a1", "amlogic,s912", "amlogic,meson-gxm";
@@ -24,11 +25,37 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	hdmi_5v: regulator-hdmi-5v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "HDMI_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio GPIOH_3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	vddio_boot: regulator-vddio-boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
@@ -75,6 +102,59 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-NEXBOX-A1";
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
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
-- 
2.17.1

