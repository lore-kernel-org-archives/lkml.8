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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615CC433FC
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE69207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9DFora6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGRG6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgGRG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC5C0619D2;
        Fri, 17 Jul 2020 23:58:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so13242540wru.6;
        Fri, 17 Jul 2020 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDvI8JDwLjhA5jkV3AvGA6unyQL/mwAeBeK74iYRYOY=;
        b=X9DFora6PLpolmzde1+vkKm3Xlx6DbggTZ8o5nYtKAcsql3ir4ARZbrW5AXMiiVh/7
         uNzvMs80abrDTsEUYxESMVCllcUNylfduzeov5At5F+Da3Ae9Ba8WCM2aDxASsuJ8tmS
         sLhQirwBv7zQNOr6BeXP3d/P3IoC04FDVPpaejfmil0JvtN+meoWIgvW1XYkx0psjJE7
         sByosWshlP7xaCM61yHkVwrnblJ9Qg12lEfa6j4KxFR7Lu6uNBlpZGEc0hc8AAI5Y5Tt
         EaiqcVJGLM00+JfEvbrP8ZO0myGISuv0Qy1Wi8Mx03RRO8jmJxVrZWNM692L0SLnLo1A
         HBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDvI8JDwLjhA5jkV3AvGA6unyQL/mwAeBeK74iYRYOY=;
        b=ZXP3q0310tB7vzylZypYA0bzeKl6v8CY/qhl1QiRgFYFgoBoixo9KR2Hnp/Kamp4++
         K0TEhvapyTw7EPKns0/fhCQ9+Zcj2A8qDmq+BoW3ZRIuNjELrwr8NuaGpjW5SxNlf2qJ
         WFPrisB+kNLYVgYRjckOHuBZTzIcee9aZ5n0Kxebdjjya1EBoIq46gun5wK/z00q3RxM
         aZy3W/avJDJYDQ2rYLsNvL2LNbqbgnLKcO9mCA0fedxyHcVSrK9O+sBJ7DK24DUjMdRZ
         QoFOaXh+A1hvqfSZTz01IKh4Y642bWGZJ/53tOIrCez2wwGquMqwHd8vPoOm96/M52FZ
         LFAA==
X-Gm-Message-State: AOAM533oA+yMjPLYt8u1r8U0u9Uz9QuJuPTt8yvxYsjdn2XUEN+H4Dav
        634cO75adqXT28GLAimImQg=
X-Google-Smtp-Source: ABdhPJwwBSyTTXbuFejDMCxNajPVQD1NVbIaGwfvqV05fGed1WqCOEHAb9iviWWS+Z+yQV1jb0vUjA==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr14660567wrq.56.1595055486100;
        Fri, 17 Jul 2020 23:58:06 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:58:05 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 10/12] arm64: dts: meson: add audio playback to vega-s95 dtsi
Date:   Sat, 18 Jul 2020 06:57:37 +0000
Message-Id: <20200718065739.7802-11-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 222ee8069cfa..1300585a1ec7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
@@ -17,6 +18,13 @@
 		stdout-path = "serial0:115200n8";
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
 
@@ -97,6 +105,59 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-VEGA-S95";
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
 
 &cec_AO {
-- 
2.17.1

