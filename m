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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7637C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E5D2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKEVxq8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGRG5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035CC0619D2;
        Fri, 17 Jul 2020 23:57:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o11so13239795wrv.9;
        Fri, 17 Jul 2020 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=nKEVxq8xAgb3BSHbys0l9zq2gcV8D7HhIfslhM/xLae2SyJP+Sg0JAaB6eGnECz8DT
         RXca2F5O/JilwetdteyW/89mjPpFvb4BxpqWPNhNKjmckmEWfzbxMDLE2gugFREWvUK3
         PHWgG+u445q55dd1KAsu1Vp22zN3kHuPVG2fm7Fd5gzZ9qZpVNWfBWDq1qKW0uAm0LeC
         uRUSca4zJ++vK2WxSXib9cWMQzjR9+3YuF7wlJFAl7G5GlqE1Z1qvembQBd638C0NoFt
         sHd3lH64y+OalOu7bnvroC9NEFZbJWQCn45XCGRkFb7o3verprQfuWNGgqSlXcYTJk2n
         02vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrTzQqJfmOE3wc4LgtWfzvjavE1CxqA487snNOvdDF4=;
        b=Xtev2ef4rF/e6OZhE3kWNbuQYSQwJx/pW6gFIEHSGg3g/ssyJH8MlhPaiqa7JKxprY
         5PzM5m2pbo/4kbCOQ5clZgn19rK9k3kLq5BZvJU8OF+2MtyZajgwYC/yHDzso5J5nSrr
         IQ4HipVwslww885989HsWzHMifcKE/N0X4xMMyNlQmOI89qTNcAhvYzP0Y0KiXxxGFTH
         Sn1HRjKHD6Xgqag4ryVZxWAoPNwv0yB/qvGS3OsYrcreKcb+WKHc0WfMoTKrdf8fV7KE
         I6JQbuH3rw5d0S1KRY6thU0whPOzIyTH4oU4k3CcLaECAqw5W6stUXvoxs4aL52hY6Ws
         k0DA==
X-Gm-Message-State: AOAM532C3R5nsjbWXTig82MxFffVE9XXLbR6kpMWxuFpCAWP7UGoDZuq
        9qyP3Z3fgHiR9Y9A5op0fZM=
X-Google-Smtp-Source: ABdhPJxT+zWK7JQj0ZP6zsmrAOMrSNN5TIxi/onMGo7pglJq/uFAcC4q4lZL3vH6T/yRTz7ae2lnWg==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr14400539wru.410.1595055466673;
        Fri, 17 Jul 2020 23:57:46 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:46 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 01/12] arm64: dts: meson: add audio playback to a95x
Date:   Sat, 18 Jul 2020 06:57:28 +0000
Message-Id: <20200718065739.7802-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718065739.7802-1-christianshewitt@gmail.com>
References: <20200718065739.7802-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 67d901ed2fa3..b5b11cb9f393 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -10,6 +10,7 @@
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
@@ -139,6 +140,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NEXBOX-A95X";
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
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
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
 };
 
 &cvbs_vdac_port {
-- 
2.17.1

