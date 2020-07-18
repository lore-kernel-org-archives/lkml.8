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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54181C433F1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317B6207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPJpR4r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgGRG6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGRG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992B6C0619D2;
        Fri, 17 Jul 2020 23:57:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so13255592wrm.4;
        Fri, 17 Jul 2020 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylzKfvJHgekxjZxp4VQuW17EoD7pYVoukf8XeW0SJg8=;
        b=nPJpR4r8aWcg21Jci2wdL9PPFkYkK3SovheA8oW0iOctEWsGMb0hoqZl+PgWgygYsP
         nRTxIFBSNRQnROHrwxaLbjoZsSUCN7tJdtXwnjBlvOVPZt3Hp3wX2Qu2hB8lysDU75bS
         xSH/snWzBSXRzNlso6CBnscdWqfTEt+I5PbrSZIrrwy796oFW/4YHNF2f13nVsKyAK/H
         6MYXZPUE8sVEeagfZ0HDsh9ejhHT8EwiAnI3jbVGAoRraDc2swQjFDZAVoV4G0GCkh9Y
         2CpawS7R03MKzyzqTfNwUac/1IH+XeT/Jo2X9gw995k6cGQkbvDCOGQuRnjQX4Yl2560
         Pggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylzKfvJHgekxjZxp4VQuW17EoD7pYVoukf8XeW0SJg8=;
        b=IV4zu+KiDwSf7InDPR1/4yO739+D35Zt+6pRB3t1v4rJXqCJFwMlqmTiSyw3R1CUM1
         N8e1xv+ZWFJ2Pz0xQDgQISLdmCY77qVKdTvabx7bk0XqTi4eoIFOLGxtfs6cVktpHMOe
         FIqlg62aNMNYnVn/7/4VIlXh5QfDZRwxuiQEjcEGBiMp6MaHZGoYTxophlp/Iv3ARlWg
         ir69U7htDFd4/GP+MqTIOXjRx0cjazLbUGosMEg2cWsfrRcJn1hsMZ9xXguBL2me0Nzk
         P4Cp3ZzSeEXiFLexlCr+Abnrh0DEpch0LpnA5D7VuZYqbICBv2kYQycxXzSB//GR2WQM
         wv+A==
X-Gm-Message-State: AOAM530nWytKVVgoa0Ech1o6tDofKsZ3ArShA6BOolzXIt/d0A5CZb4W
        85A1X0vMlKbLnhhBSpFb6SjwxG4g
X-Google-Smtp-Source: ABdhPJyAQvdVb5lV8Tc2ia6rNx22vRUUaGpgY2GDkA2oJxe8zKwjgMj/Ha9H9SDMRqmQO0JsLaPyJA==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr14528884wra.150.1595055477364;
        Fri, 17 Jul 2020 23:57:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 06/12] arm64: dts: meson: add audio playback to p201
Date:   Sat, 18 Jul 2020 06:57:33 +0000
Message-Id: <20200718065739.7802-7-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 150a82f3b2d7..2e2bccbcfd43 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -8,10 +8,50 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-P201";
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
 
 &ethmac {
-- 
2.17.1

