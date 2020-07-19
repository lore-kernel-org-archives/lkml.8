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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F48CC433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141C121744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mmhnMc5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgGSRhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGSRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:37:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5DC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:35 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so11180037edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atFB64GMftmxCJqSX3W1/fEQ8GEvmP5dj65WEvyj6Ig=;
        b=mmhnMc5vvkBqUY0g5HcVQnVGha99Zfdec61Tou2dUibaW5JUS7JO9bNNfvtYpwJ+vq
         hnoVjYPmydDsLmq2ALE42DKGR3bCPjARORiV7FSS+BttYbwKdcIHN5kJb+2Avo0AU7eO
         6Q2VNbvcEPxmwf7G6l8fAdYXA5S7If0nePOAR+x3oRKZnfiodDqaCTqbAXarJnJau+IU
         liE1f2UxDZ4yboz/a8PT2RrYcu7J/NFKwxquV1VwOs55EvTXEk9N6F3s2/0A+Y/iwm5K
         B7iYlhvt7AQOcN2Dw5HTnZgjitOyBQ26kvG95FU1Sip5FseFlyGD8HdPNk7aTs8hGIS4
         AlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atFB64GMftmxCJqSX3W1/fEQ8GEvmP5dj65WEvyj6Ig=;
        b=nIRrYHwsKtzPU0uyfT9oawFzCex8C9SafYmY9+J2ysSm9vxjmm+NQvhaQCfWa8+nYf
         dMV54tTiXjkPxw1HEZ3nSCC8R6T9y7bgnVbSLVtQfYgV19HxPSYntliKnQXxuLP4lkbe
         EgWRpstv2SVsmZiEJ+LHT/XlLEhB1bRXx4QfAWvsUbCFhaoFUZt6UgmSUCtkBbQKa7e7
         5lTRjKRW1tLFjnx5KtLN7Q03zWZQ8RI6v0Bu+uQyBFJFuaLDD8s05CwHiu6NBdLmFwHT
         g/9KRrIudSmZrV5WgI1un1c+NlfPPPGctupog51qaCx76xg5zwKIF3PgvlqV/bhN79lS
         rCzA==
X-Gm-Message-State: AOAM532SkI8T1WJC0Mijf/WMYKojDe10ONaNQx29eop+l75deIjATmRV
        4/stmD7bADOwfUg6YZn/Dgg=
X-Google-Smtp-Source: ABdhPJysERv/Ac35vflCRyqxg9bHk1hc90cB8jVuB1DDa9obY0Stkk9WaOiezLCZdgLsjY8QLx8EUw==
X-Received: by 2002:a50:8186:: with SMTP id 6mr18611601ede.45.1595180254322;
        Sun, 19 Jul 2020 10:37:34 -0700 (PDT)
Received: from localhost.localdomain (p200300f13716be00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3716:be00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id bc23sm13563208edb.90.2020.07.19.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 10:37:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/3] arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
Date:   Sun, 19 Jul 2020 19:32:12 +0200
Message-Id: <20200719173213.639540-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
References: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
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
index 40e3e123e05b..fe4145112295 100644
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
2.27.0

