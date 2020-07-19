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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEEBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BDC20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB/p6r90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGSCp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGSCp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:45:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FCC0619D2;
        Sat, 18 Jul 2020 19:45:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so14647998wrw.5;
        Sat, 18 Jul 2020 19:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keAVpGfsQcEDqnbHUMyN/ynnpJsp1LvUpjA6RoHC1Co=;
        b=GB/p6r90sAJgHXEEV7QpiFlvwmXSlJw0OtYyzSJPZyId1OjKBkqkcuPl3AbyVGLoyW
         EXsP2Tk+VC/iF9bMG2rZUpYN/90XpHhDelJwE+sM4i+zGpnQwP9SqpiOZuphXNHoXOAP
         OQS5VY1Kvw6xCaeGBFWPzBN0v3cONA30DLx14y5qkQOuCTnMvTrYwv9F7mjm952WDLUX
         kfXCm+7xaIzHVJO8t3lI2vnn+PwkZGxCGSWAasQvvo8gtd7ToEY3OPvVSAT+zPPNUsXw
         O+yrRHVsAUKFBvz0ExVv56wEHfOiJ6KMyL51vkfonxXqC35hMdghD91eO8N0xB0/sE/S
         oYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keAVpGfsQcEDqnbHUMyN/ynnpJsp1LvUpjA6RoHC1Co=;
        b=YhmX51d/5L7aMl+fP8Rk5a59suZUoVc+4PKkpOBv9ECpkBb3S35gOfRI3idiCDObI/
         TLN+LB0ZtmU19aU51XcDiwHILbrag81HG1ghp3C1uYABzjmoQSmI/X9ssEOIzikEqMpM
         Gw2B+7ZVPLZGNXSbvPBSOh+qufR0njLKLrMRNRxHdIqWr5jMPMotRZokK31YFhJ+oFnL
         lhF7iAleJKgv6D3vxcVlkVlaf1R8WDz2NpaLPb7FaWhc0dfc5gxbccChStSY/AVSL9PU
         pjPUH3xvubs7Y56uriy36zRjvH843HDsOLedQEkZ7vaDVxGk+xOuq8HSjac663XpR+XX
         oIXw==
X-Gm-Message-State: AOAM533Ui3yN1mZJO0wooaL05qHFoGH00rdcc1viyxZA7LCUBiaN5fqU
        iJbpvHHymQnr8hB1LEuYhPU=
X-Google-Smtp-Source: ABdhPJyaMEwSnwK/6OKFvL9g3D3y1T1zk4zp3fsUqT9d20r+5NvIMPQk1HfZLkXziE0Qtwmm/ttVdw==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr16036425wrw.242.1595126757149;
        Sat, 18 Jul 2020 19:45:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e5sm5176242wrc.37.2020.07.18.19.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:45:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: meson: add audio playback to khadas-vim3l
Date:   Sun, 19 Jul 2020 02:45:47 +0000
Message-Id: <20200719024548.8940-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719024548.8940-1-christianshewitt@gmail.com>
References: <20200719024548.8940-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s, copying the config
from the existing VIM3 device-tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6..b104967dbef1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -8,6 +8,7 @@
 
 #include "meson-sm1.dtsi"
 #include "meson-khadas-vim3.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "khadas,vim3l", "amlogic,sm1";
@@ -31,6 +32,69 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "SM1-KHADAS-VIM3L";
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
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
 };
 
 &cpu0 {
@@ -61,6 +125,18 @@
 	clock-latency = <50000>;
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
 &pwm_AO_cd {
 	pinctrl-0 = <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
@@ -93,3 +169,15 @@
 	phy-names = "usb2-phy0", "usb2-phy1";
 };
  */
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
-- 
2.17.1

