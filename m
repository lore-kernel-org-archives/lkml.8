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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989EAC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D03C20809
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIZEdH/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgGRG5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgGRG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E2C0619D2;
        Fri, 17 Jul 2020 23:57:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so20529968wmf.0;
        Fri, 17 Jul 2020 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=oIZEdH/uh1TtykZuv0ukEQCuPEVWNo4glkJgnskWVrWqZbBySTf3C1iuxSIa/lPFl0
         v7Jds4ptBemj8bLOAjXDMjvKEigG5o0B5q9GcYZzpCH/deoFab07POBkE1UPCK3yp1kr
         0tSUJ7vtVYq20TSiWldnLyFEkKTdyiGjF6TFLrCNRqcfqYfGFqigTBFlg1GDqMHtmdeM
         EYKRLEv1ivQErEBvEOTFlM9L47yBSHMbCXyVnyOJVmB+wjfUqviKWTUcWm0X9xr4LM2V
         VMoqNU5caMrZV7xp0dEyfjpE7FmP9tNpDlojKJlqVIuHCFBldlmYLp3miy80l15tWeJ0
         ldXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d988cBXnFVQ/GWsV54ibiM2GROtIFfDIzMG48hK8mIw=;
        b=ifJX4Dm2o+zZd/Ap0jJiri/rHpE/NW1yXxqFQ+9qqJKN/smUKtVIoDXe/lGxKs+wOS
         +FpCmtAJ9S/kEgcFKPl0fJfXFMy4VG4oh7mg044Iq4hd3rogmkXOABKx6qcYSzgeyj+T
         1/mPVfYibOPhFvBYGm3r13aeuD5gaPq0vt9bQp7j/59eGUlGpkF1crX/k5xu9a7kSqBE
         omprWg/vM2dhl3bwnfOVt9qG7Zp99S8LifmBJW1/2A0yuMZBf4XV8AlQy5JtsZPAEbc2
         0w400eS+k9KQn1o0RXy4epG1WM69d6gRYfxxF3/zCBTVWv8AD8NFZpAFuckYTQ6gsN9f
         RKYQ==
X-Gm-Message-State: AOAM532JYfu5rnGGFVgXNgr33pCJV2gNV8kLN6gCtXDXIiD6hgLLl9eJ
        05vEhnrsjj1sW93eAyzvoAY=
X-Google-Smtp-Source: ABdhPJw8ufDkdQQhKOK9vRr515PVBi+xsM5aKv/nI0+7N1b5f0/EJP+DP89FJdxMmeJoVO5i9bSfGw==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr13315589wmu.52.1595055468849;
        Fri, 17 Jul 2020 23:57:48 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:48 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 02/12] arm64: dts: meson: add audio playback to khadas-vim2
Date:   Sat, 18 Jul 2020 06:57:29 +0000
Message-Id: <20200718065739.7802-3-christianshewitt@gmail.com>
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
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c70..d4734220443c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -7,9 +7,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxm.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
@@ -145,6 +145,45 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXM-KHADAS-VIM2";
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
 
 &cec_AO {
@@ -154,7 +193,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-
 &cpu_cooling_maps {
 	map0 {
 		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
-- 
2.17.1

