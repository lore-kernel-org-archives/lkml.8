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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4711C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CDF2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caYg/F1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgGRG5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgGRG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B63C0619D2;
        Fri, 17 Jul 2020 23:57:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so20467373wml.3;
        Fri, 17 Jul 2020 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=caYg/F1CiwwGkHeQR/B4qjCLeL6H2OxPLCrC64xVRKZ5qK692K0AEr6GJgBw6r16zd
         9n1fNjzLqULafFSRpHgpPBmvwQ1xWACjR7Ml10/v6S+2XTAJ7bok15B/jllJYgmL2PLi
         NiAl0QriTi6R5ak+hJaTtj45aMicNAJP8WQaWNaLNm4T00Q0ZXuFfvNcu6/eRGQYD37i
         XsMR7dQ5SHUKS2GfXlK8lE0p3Xrynm4nxpt2cYvKs2118gAWngDJVdOhmDk8vaEX4hxz
         /0pO8GfJiXUed2NNCcdpaWUBXjkhuqTAdn27VpUygM8J6az8Wx3QpyTtcx9oJ/Vx3aZz
         rPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=oeDGaaQn/gwOK1qnqQx2rh3AYHi/lqulHqPronNJR4B8dtFKzLt0MjOLiu0DrlEHLr
         UTpg443TbimnGprZJOgNnogTUFN1niw3DlaAmfLYohyEJdS7w21stIuKso3w++lFI5y0
         Jy+8QZ8qhsQEyT6tmveXTj7sfQepBaIU8a3qw6MjT7E6lHJlpfG6TQKV16x50OpvQ90G
         DWulqAfEVUSjcL8WPXTUH4AH/ouWzWK4URgQE+LZETJ3Y1hFJXLaQXVqzlUwhMiXpvcN
         gdUUdt8DQcc1y7Hu9aX71crgPSKmCFsd4ORPiAOcpIm0LCCn+kZ5A9ZQF/fBnq0erPBx
         pQBg==
X-Gm-Message-State: AOAM533ekVULKIay4rgWgw/7DaufKR7GKJhH1ZUO7ftTgcKbpWm4qv6t
        cumgeSpaA2s3YPD0d8mvBVg=
X-Google-Smtp-Source: ABdhPJx+0bXWdJ5NE92Hqa5rIB9eDMnmi3al+CVIzyGEaTEXb1ufuNsWoDnDnbQDUATAG7sFuy5bVg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr13218592wml.95.1595055471013;
        Fri, 17 Jul 2020 23:57:51 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:50 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 03/12] arm64: dts: meson: add audio playback to nanopi-k2
Date:   Sat, 18 Jul 2020 06:57:30 +0000
Message-Id: <20200718065739.7802-4-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7be3e354093b..8e5df00b06a2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -7,6 +7,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
@@ -130,6 +131,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NANOPI-K2";
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
-- 
2.17.1

