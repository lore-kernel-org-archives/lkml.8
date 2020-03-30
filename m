Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB31DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD77320784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B1Yi4hJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgC3WLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:11:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbgC3WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:11:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id i19so539145wmb.0;
        Mon, 30 Mar 2020 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzCUFuMkzWlLXqOmVXLBXxeE6kPrzuWsI5J2b3JrmKY=;
        b=B1Yi4hJe9+jP1oYxumDlnQbGxnGbQdeD6mr579nVjX9OZZyUZ8ZLyJ6jYNz9MBj1bx
         7maTetDDohQQUmSd5H3Bo71qQkiExseTWyE69vSfxXUpIQkBoYOVsVLlHvz2160L3s55
         QaLzK0+XdB+D2QBN7ymd6vDgY6yu1wRmxSHDMRiSB9Nnqd4vMeAB7BovKAoK7v5uVF5M
         F65EwRTVh0KZvIv/uND1prJXmqY3a7Gvnhv3sdr4QtyqwhfGlfGtEqPjiwzXgfzWyby5
         CovMn2lfBAf/Nte7H15w0e2jvI0kcYNhtrItVakqPwm7VHgAG/xsERYOQRHXXpeCZUOW
         ytfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzCUFuMkzWlLXqOmVXLBXxeE6kPrzuWsI5J2b3JrmKY=;
        b=eF9u2Q/iLFl3NM8TKDV8vYeZDuFmOKHFTj4C5eiU1dmcIWtgbUbo4jLqOqN77oDbNv
         ilFEdvv/eXaU1qchhNpt1VgEbmIJp36gvtCUK/xI0/dnq3GY/mbPOvKGx4n1tmNjWiV5
         G1bKGB6ip6CK6rc7/3NKlbpNXW0JjNGJS4CrljlRzPANZYd0g9PvOdPJvWowqsHlMxjP
         aY8AOAc5wDZ3OWOt8wPzjuPtbki/vG+z9ZcMSBLN4Xo3ZH2gzFVBDDrltEqclfyhWD7y
         jpyjcyLbWqnioWeM/AfRKGD6pvquoRirLYNM7NMHR+lwPN45oKJRfQ/IyXdnedLszIAF
         ewnA==
X-Gm-Message-State: ANhLgQ0JsOw7FXHartU83Ur9fHBqVEtrHgC7Hh6wVHuT5PUOGlDceqI5
        qJA6FKJCyjs4haJe8cgMluE=
X-Google-Smtp-Source: ADFU+vv9tfk0eQLYelRcKNSFwd6CAWgH4qjrJ4Aiglq2T0D+CdLr1vDM+HDBUlMkqJzRgb5BkDwq+g==
X-Received: by 2002:a1c:e203:: with SMTP id z3mr216866wmg.71.1585606293721;
        Mon, 30 Mar 2020 15:11:33 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b187sm1260509wmc.14.2020.03.30.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:11:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 5/5] arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS
Date:   Tue, 31 Mar 2020 00:11:04 +0200
Message-Id: <20200330221104.3163788-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
References: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP table for the Mali Bifrost GPU and drop the hardcoded
initial clock configuration. This enables GPU DVFS and thus saves power
when the GPU is not in use while still being able switch to a higher
clock on demand.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0882ea215b88..3f2c7d0802af 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -52,6 +52,39 @@ efuse: efuse {
 		secure-monitor = <&sm>;
 	};
 
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-124999998 {
+			opp-hz = /bits/ 64 <124999998>;
+			opp-microvolt = <800000>;
+		};
+		opp-249999996 {
+			opp-hz = /bits/ 64 <249999996>;
+			opp-microvolt = <800000>;
+		};
+		opp-285714281 {
+			opp-hz = /bits/ 64 <285714281>;
+			opp-microvolt = <800000>;
+		};
+		opp-399999994 {
+			opp-hz = /bits/ 64 <399999994>;
+			opp-microvolt = <800000>;
+		};
+		opp-499999992 {
+			opp-hz = /bits/ 64 <499999992>;
+			opp-microvolt = <800000>;
+		};
+		opp-666666656 {
+			opp-hz = /bits/ 64 <666666656>;
+			opp-microvolt = <800000>;
+		};
+		opp-799999987 {
+			opp-hz = /bits/ 64 <799999987>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -2349,21 +2382,7 @@ mali: gpu@ffe40000 {
 			interrupt-names = "job", "mmu", "gpu";
 			clocks = <&clkc CLKID_MALI>;
 			resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
-
-			/*
-			 * Mali clocking is provided by two identical clock paths
-			 * MALI_0 and MALI_1 muxed to a single clock by a glitch
-			 * free mux to safely change frequency while running.
-			 */
-			assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
-					  <&clkc CLKID_MALI_0>,
-					  <&clkc CLKID_MALI>; /* Glitch free mux */
-			assigned-clock-parents = <&clkc CLKID_FCLK_DIV2P5>,
-						 <0>, /* Do Nothing */
-						 <&clkc CLKID_MALI_0>;
-			assigned-clock-rates = <0>, /* Do Nothing */
-					       <800000000>,
-					       <0>; /* Do Nothing */
+			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>;
 		};
 	};
-- 
2.26.0

