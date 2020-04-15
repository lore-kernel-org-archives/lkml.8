Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5DE20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0aNUsA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896539AbgDOKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896490AbgDOKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:23:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633EC03C1AE;
        Wed, 15 Apr 2020 03:23:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so2209755lfc.5;
        Wed, 15 Apr 2020 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jKeaCgFpnmK28M7xOrZHtgGEs75wSDfctsMr7/8EUQ4=;
        b=u0aNUsA/ajvK6mw+4oTArTjesmheWK9IOjPXwcTInScU0ziIdquqPvAoRZ7JWHtU3e
         azgL3J3mFyNQ45f8l01s2gr+SSy3qihJSborjmg4ASd2rSEMBbhq0/ELiC+24ngeR37Z
         QOOOJn6nml0YT4MCSCwiFivQdSppsMUYq4y3blVHh9Vdtd4vgzVEAdm+DZnZ4EqT8mZC
         qEwXBMqVmVuBQeOkxPUkeg+I3OXA7KgWg1mHwKplqBn1diR32MgW/e2JzccROABQ6H5h
         5kcu1b0A0piOrKPAnsFZD9qUeMfzuMRVoUEJiC6TlLbm6ENviT5U66hzt5bR4JngrtJL
         91Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jKeaCgFpnmK28M7xOrZHtgGEs75wSDfctsMr7/8EUQ4=;
        b=CIGjjRbY5C3nwUsFzGp1c/+WTP6puPVI8PlkfEj17GJwI1RkntVg1PA/YZkudxcEja
         zQEjUP/VQVOnfqbqICwWC6FE7LzeYouMowml4bsMZlzqYEpddEW1DsCE6bib/2r19/hI
         Nx+Zs0Wt3LY+ysZIJzU2RIuqXwj850cBLzDDCgvDTayzvU37hAZFRyGxMYRFGMovW1JW
         gr9N6SddCAaqFgea//oQwmmZSRStXgcMoOiJRHvSkET6omVOxFKxO8eCT/JXPyRabf4Z
         fLLp9B5RpVdDqR6g28U6GyoKQI+ZriPz+8FsDVyIBnKIO73ZYglu7mZ0WuOJgLVsFo6l
         Popg==
X-Gm-Message-State: AGi0PuYWli4sHWBxjPl6C3N+efKb+MTcnBtCps7PcEIZvzFvTb7hWDFL
        ODoTFJakNFlEPsJCPFdEqTPYwHGi
X-Google-Smtp-Source: APiQypINp9dsLX1m+G4LnnN392ZDggMCz6RWVuPhP53iuSY5f9+1hGDl1lDNmn3boXKr/63qJ5pMqg==
X-Received: by 2002:a19:c8cf:: with SMTP id y198mr2545251lff.197.1586946205638;
        Wed, 15 Apr 2020 03:23:25 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x23sm12442810lfe.51.2020.04.15.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:23:24 -0700 (PDT)
From:   chewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: sm1-khadas-vim3l: add audio playback to vim3l
Date:   Wed, 15 Apr 2020 10:23:20 +0000
Message-Id: <20200415102320.4606-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Add the sound and related audio nodes to the VIM3L board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6..b900a433ef7a 100644
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
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
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
-- 
2.17.1

