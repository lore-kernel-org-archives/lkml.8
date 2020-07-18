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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48130C433F8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4422BEB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpG1hof2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgGRG6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgGRG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A284C0619D2;
        Fri, 17 Jul 2020 23:58:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so13242509wru.6;
        Fri, 17 Jul 2020 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ErSCHcHzIsW6dIDBmuhPbxBHo15N9XHrkYPsBItQXg=;
        b=NpG1hof2UuA8uOhIZVzRSzgmpKseK3rVcoP/nS6cW9E4Uvr3YzrvkNChzT88/F2/0O
         3hmuaJJGaQJ6qrop0qxOzYDQHwnb0Xof/TFogslwZzkdOVn2pmXBow8gw1gem49LckHK
         1bDvB92jF8nEMr2/DXjWm15V5idJx554gFcbWLqv9g6h4F+G3x3jm+qjxs4JQZhWS5dW
         QItDxeg34g1tdhtpEQn/79sxiDY3WZrSgAoqqDAAQ83QD6WyD17O6Pc/4GGOGLKrg1n2
         OvSjA/NXVf9O88oEWO6wT2/HeoRlmVgJaG/Var3r29EYmAXlGu+Ix8+Kz5sCeIOaQdMK
         bOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ErSCHcHzIsW6dIDBmuhPbxBHo15N9XHrkYPsBItQXg=;
        b=ED9x+VJt75PTJR5woDu0jghDrHDnKrbByG2UdVvgfBYb4IU2MlYxHu4eI0poUYzl4G
         JaM2yQYA3BTGiZGwo9ozRZm8m4IltfhqetTK9qKrVja7iRS+VOZzhiYkFUe72rMT2hiC
         1Ie1BCjfUNjljXt6HkhMfEtEcNDlpLaXGnU+/FqUH7rfZc6lyZmBdZu1aq8iocNnQuza
         jYzX3tqFNmizaFwkXf43aN+NOvqQ2fE06yGLwwFbDV3maJzt7qgmXEXpHNMa/kc3VhO+
         ogNvkSrD91/h38SqHc9jUMkOufn3/cr2jfb1I7ctsmC2D0Iu08Tqk5Pu9eh+jT+WRAik
         DRDg==
X-Gm-Message-State: AOAM530+qN/pks98cI5c/o88mC/v8VlIwNIsDmkfd/j2wgYDu+i8Ew/V
        O7XGYNzRUer2k3f8NGeO8gQ=
X-Google-Smtp-Source: ABdhPJwiBHU86HzVfaoGD0RkxLOOV9NbiNE/ASSoYy6mAhnB4uUbH9sHF3oqDPumKSV/KsiuT9Yy1Q==
X-Received: by 2002:adf:e850:: with SMTP id d16mr13997770wrn.426.1595055483838;
        Fri, 17 Jul 2020 23:58:03 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:58:03 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 09/12] arm64: dts: meson: add audio playback to rbox-pro
Date:   Sat, 18 Jul 2020 06:57:36 +0000
Message-Id: <20200718065739.7802-10-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index c89c9f846fb1..7b23b3da27ff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "meson-gxm.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "kingnovel,r-box-pro", "amlogic,s912", "amlogic,meson-gxm";
@@ -33,6 +34,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -51,6 +59,25 @@
 		};
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
@@ -90,6 +117,59 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-RBOX-PRO";
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
 
 &ethmac {
-- 
2.17.1

