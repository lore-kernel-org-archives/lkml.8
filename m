Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F69C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC520771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gSjEgukU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgC3WLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:11:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38833 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbgC3WLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:11:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so523331wmj.3;
        Mon, 30 Mar 2020 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cKp3v348vmyZeRheT+gdcc+gPdXRTpNkP+LQYIKnRY=;
        b=gSjEgukUqEEFV5PGf6eqXlNOdSmlijDI9Trne9JLdp++Q3i8ZTE8F9E1nWyxJs87+s
         2aJapUm5GSI1GekjpCVqG/KT0baw06lJdLtJgesPGw6ljriLeEpfup3I0dm+pbvL7jn/
         xZ27MfgHxZ7b8TiFWchs6Wv/hG27na7pRzCnM7ngQkKA8QgAItsu5rMd4g/aH69NzpkD
         UVyFqzPYcE6drMPOoGh6qk+fRLpE06IG4CVR0cnMM3YqmTRDtNQNIeP4Wc97L79/+A3d
         0z6D4+pKtBh+8MlYKFMtQxa6w+r21JMn0HfSIvk0UuuHYHqGdvKhImwKbdP9MbdnvOLz
         jz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cKp3v348vmyZeRheT+gdcc+gPdXRTpNkP+LQYIKnRY=;
        b=MJxlNahoVMamMuUIZ+P/hyHYCbof+JCnG60Y3Gx8QwW5ZBWfXfB6Eeu6wKMIQqpIuk
         5I5Su7qaMSXyYzihfy6tfDzzfdTE+dVgc0mgPdAacn77x1QqNFxhtO3QZYU8bJRWkRG/
         ltaj1TthqbwdfYOavwR7oZs9R4GGDH6vVH7h092Ku9nPQV+wHkEz6jdNYr4hQoPil4mi
         lD6OdKP6FiNxNkWvUon4c/QC7r5HtuciFn54buqDqjg+WqGAZxAi3peyOJka3seEothW
         icAJvdwdBkbpz7OipV+PzmrqSkCDSVJp1kVNRmSnQXyGEh17h4H+ru+KXEpKdrj1FGGQ
         ZsqA==
X-Gm-Message-State: ANhLgQ06TksvbaXLxR6loeueBbjqfyIGFSPQCVfbIZ18gMLAN8KwUUEs
        eUNekDoum7tRYfBKt9iJ+eDbld0f
X-Google-Smtp-Source: ADFU+vvjxSgdZSTx/q1zOs3QcY6XqTZOQEjlrmxJJzC3LdIEuRPhuZATHElr4P4u3rb8X9N0RauShw==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr212421wmi.55.1585606292625;
        Mon, 30 Mar 2020 15:11:32 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b187sm1260509wmc.14.2020.03.30.15.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:11:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 4/5] arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
Date:   Tue, 31 Mar 2020 00:11:03 +0200
Message-Id: <20200330221104.3163788-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
References: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP table for the Mali-T820 GPU and drop the hardcoded initial
clock configuration. This enables GPU DVFS and thus saves power when the
GPU is not in use while still being able switch to a higher clock on
demand.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 45 ++++++++++++++--------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index b6f89f108e28..0f1d1cf4248f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -82,6 +82,35 @@ cpu7: cpu@103 {
 			#cooling-cells = <2>;
 		};
 	};
+
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-125000000 {
+			opp-hz = /bits/ 64 <125000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-285714285 {
+			opp-hz = /bits/ 64 <285714285>;
+			opp-microvolt = <950000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-666666666 {
+			opp-hz = /bits/ 64 <666666666>;
+			opp-microvolt = <950000>;
+		};
+	};
 };
 
 &apb {
@@ -106,21 +135,7 @@ mali: gpu@c0000 {
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&clkc CLKID_MALI>;
 		resets = <&reset RESET_MALI_CAPB3>, <&reset RESET_MALI>;
-
-		/*
-		 * Mali clocking is provided by two identical clock paths
-		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
-		 * free mux to safely change frequency while running.
-		 */
-		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
-				  <&clkc CLKID_MALI_0>,
-				  <&clkc CLKID_MALI>; /* Glitch free mux */
-		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
-					 <0>, /* Do Nothing */
-					 <&clkc CLKID_MALI_0>;
-		assigned-clock-rates = <0>, /* Do Nothing */
-				       <666666666>,
-				       <0>; /* Do Nothing */
+		operating-points-v2 = <&gpu_opp_table>;
 	};
 };
 
-- 
2.26.0

