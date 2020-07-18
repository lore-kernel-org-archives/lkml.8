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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB9C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1CB2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke+wmC2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGRHZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgGRHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:25:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887BC0619D2;
        Sat, 18 Jul 2020 00:25:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so17766825wme.5;
        Sat, 18 Jul 2020 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keAVpGfsQcEDqnbHUMyN/ynnpJsp1LvUpjA6RoHC1Co=;
        b=Ke+wmC2/T6ELScDbLkHP0eIT7W6dGZGXFAgyiQ/tHK+3jjRYLPqVh9oVmc1nhbz1to
         t2Gt2E6s2AHP/wcmbsvvCuinTIs2EzumrzEYS7Gb+OTqR8sWS7BTh99PJ79znsf2f129
         TsmhbcN+xnGHHJOrW6POeg3eR1xrYLIrGwg737I0ssgn2aPxXvJjg8+t6rwvxOJA+uRE
         eCbsaJ/ZvqCyt7YULkfoZFfKJwFGQuTmnL7lN+/3QqS67IPYXl+62/HX9GeOw9reGJ5i
         TbsA2uAEqBgKKsNFEGgKkgYAFIalYrwLXZgcGtFwFqzg5ZNt+wjkpfIGJNq29/x0SPho
         YA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keAVpGfsQcEDqnbHUMyN/ynnpJsp1LvUpjA6RoHC1Co=;
        b=Wo+AUZEbIOVlk/2rGDFaosQGdQc4mgjaX5gipojGHksmhqtyQvlkNhPvKv16QYNKKT
         qZau0rKJfZrmEtVW6QJFfDXuPlC7GnO7dCA7b+Xv7xzcHxbLX5a8dCe8GMsHW4HesYp5
         z7jlc2sIgEl/XOgi13dp7Qc9E2XgfBm+QOsXZZD46bjLYWnBOZQe81u9hgZcT+gYzmMB
         WELTlfmTfGqEgn1iu0uDAZdUs83HrxEwpBNPQKYBg9gwj34cYSawAYiDhdBebb0ivrUG
         ghbiwtf3MkCyx3/OEUEnG6AMolLFkg98aq1T0r3pJorAkP3vGWX9AI9+zM9zm1tr3wG0
         oLwg==
X-Gm-Message-State: AOAM533I/TXHXrt7RIkxY2Lbp9QWeFtux8o6sI/YtbuFcLaMOmEDc5Oq
        dGISG0PVpjx5syI7mmDd0e0=
X-Google-Smtp-Source: ABdhPJwRIuNiryqRIXEdnd8PCtYBUxhPz4wLgti+0y9CRAHUV42vcSY23IDGC39u1ZoKBGL9EYxFUQ==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr13033409wma.46.1595057140962;
        Sat, 18 Jul 2020 00:25:40 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c7sm19550192wrq.58.2020.07.18.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:25:40 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add audio playback to khadas-vim3l
Date:   Sat, 18 Jul 2020 07:25:32 +0000
Message-Id: <20200718072532.8427-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718072532.8427-1-christianshewitt@gmail.com>
References: <20200718072532.8427-1-christianshewitt@gmail.com>
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

