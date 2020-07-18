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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE0EC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A551920775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osXXqc2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgGRHZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:25:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE8C0619D2;
        Sat, 18 Jul 2020 00:25:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so17791875wmj.2;
        Sat, 18 Jul 2020 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a0raR8kuawAw4Zwd1EY7iQ1XE5SS8HIOS1kFKtesceU=;
        b=osXXqc2/JMbxEZ8YQ66p//TaQKMxArFfVN9KBSLB+qBwhJf6oEYVzvJN7oiZBsSkUm
         3OxN7PXwnU19KmOmGYtda/bmnBycBbyth+YKiRctCk7HJ1fpFcEsoQ45WpNF+SYfQHId
         1M7uc3uNwehl25pm+3SPkLeVVJVnqsY3R01Bo0sELxDeXwOzuT2N8TltSix/9BwS/T8D
         +vBDNMcbwHmA5enOCYqFI3l7XjidAgUqzVcQZumcRI4nOMYFp8UxeNw9fcRFhkpgrTQL
         fHYuNnZBY7o4Cxs7y/Xdrn/8tJcMX6kMY5uTYBt/zYlq6Dvf2013q1FQl17eQAuldlfA
         uBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a0raR8kuawAw4Zwd1EY7iQ1XE5SS8HIOS1kFKtesceU=;
        b=GVHhvnnvR0fjW7DYVslGgd5RRDNvjZvhofJTIWvEVNH3m/F4DPXugXyLFuXaFXsSEY
         YOt1McRmjLkCKmVM1bfB9NnWflwEbj6PB1fbpVe4zZf6HnoKqWmc+Q0iEtDNYMpyDScR
         loYF3L5/2yydoct0Bd+mFufCxjMOebNkl1PK/o5v4TdG9pn8eADnaekWOsn1MX7rYtX1
         oaeeHwCOxZjFiL9PVOcXj4L3S3QkxoSFzgC1lV3EBCWs4WW/7JyxOcCxoiX+L4RK4Uuu
         9Mpovk8GhpmE0BpqK29PMWifysUGijj/IGCJluFtJgc/vCZ2UWYPs3XLb+2YmY49kRFD
         zrYQ==
X-Gm-Message-State: AOAM531Wr6N8mAo/KFqckuOAg9xsq7wJ2QELUHSDbDqYfwos0CY364cG
        wVVTj1Nvo71sgZSKDHJpG5bKSILl
X-Google-Smtp-Source: ABdhPJxXJyJmP8Z5mILVzyKSOieQ5aqjprunD2SgBsMnxhd4PVg/62w+pERres4AaKLLNX7LdKTE6A==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr12425037wml.82.1595057138822;
        Sat, 18 Jul 2020 00:25:38 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c7sm19550192wrq.58.2020.07.18.00.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:25:38 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] arm64: dts: meson: add audio playback to odroid-c4
Date:   Sat, 18 Jul 2020 07:25:31 +0000
Message-Id: <20200718072532.8427-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718072532.8427-1-christianshewitt@gmail.com>
References: <20200718072532.8427-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 00d90b30f8b4..cf5a98f0e47c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -8,6 +8,7 @@
 #include "meson-sm1.dtsi"
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "hardkernel,odroid-c4", "amlogic,sm1";
@@ -186,6 +187,69 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "SM1-ODROID-C4";
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
@@ -237,6 +301,18 @@
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
 &gpio {
 	gpio-line-names =
 		/* GPIOZ */
@@ -381,6 +457,18 @@
 	vqmmc-supply = <&flash_1v8>;
 };
 
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
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.17.1

