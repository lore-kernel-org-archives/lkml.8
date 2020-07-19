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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E3BC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C032176B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QhvqeFhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGSRhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:37:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7996C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a1so15770107ejg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svBQ48FtEnymjEIEsIW4yq0ZVQW2iN3RktvuKlr5ugY=;
        b=QhvqeFhNUX3vLvzt9JVW8guBZMKIMLD+KyBKhJW9IqZxZ694qqzfwKxjXiB0aPEnzp
         iEfVa9bF1truGVUNYFRQ27dS7guNBErSgBPO3hkoPuGS/SQ2MIV2nMZOz9Yvl6E+e6LG
         B/9Sn5p0jMpyfaVZvVl+EXqPgCvFjvo4PWOBPW3dAHLuQyIzBwEz3Nth4XfynTZHtN9Z
         ggrJ3+57MdQCdTZ3Uwd+DUP7YREfzRGKOJghP/WZBVSZXkDXSXnCVHV/yRPDNX52yN+e
         K1LrCDkQJFW9RNgQTPEy9N/CWt1Ywy56JYpcakBoANPGlh8eT65gGAz9toDXNfn3fjST
         clAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svBQ48FtEnymjEIEsIW4yq0ZVQW2iN3RktvuKlr5ugY=;
        b=Hqj9TluXm8HFUrO9sURGATR4dORtlUV6my5mh8CrmxW7VINr0TeTmbnB37A0beoSLC
         s82eFXLN0pbNSqkanvUikbuFmZqLFzyjXwAzMkuGZdUScJSqt5bdfPdFGQy5bvYY3MzU
         tBvVHtc0xyL6tTkkKibajxYZSPL9sivTarBY8sK6UJmwCEEEgld44U6+3QNVxpBGKesF
         opPk4lUFcJXwoR+JN9CJzXgY1+1RtLZfP/P+b+zkeSBg7OIw5rH7aXlBWq+QGjFhkIn8
         FzsUK60LlfF8D+oTthLcTf4jy6RmlHnUKBi20hja/fGLqJUvBUI6WPY8QadHhuyFVIfv
         /NmQ==
X-Gm-Message-State: AOAM531S3OcozFoSTvRctwnEfh8hqWNCPjD/WVc2pwv45VYoj9rQGwml
        G39/Ju25+rruh+fha5sWM+Q=
X-Google-Smtp-Source: ABdhPJy7/IVYkZ2KV3q8/4zJ5tfp9P7YFMYauWis/C0570Yxr2ABjYO24fK6l9CSUG8KVuZjFAJwGg==
X-Received: by 2002:a17:906:7709:: with SMTP id q9mr17111096ejm.123.1595180255290;
        Sun, 19 Jul 2020 10:37:35 -0700 (PDT)
Received: from localhost.localdomain (p200300f13716be00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3716:be00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id bc23sm13563208edb.90.2020.07.19.10.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 10:37:34 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS
Date:   Sun, 19 Jul 2020 19:32:13 +0200
Message-Id: <20200719173213.639540-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
References: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
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

Set the GP0_PLL clock to 744MHz (which is the only frequency which
cannot be derived from the FCLK dividers) as the clock driver avoids
setting the parent clock rates so the HIFI PLL clock isn't changed (as
that's reserved for audio).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 41805f2ed8fc..1e83ec5b8c91 100644
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
@@ -2362,21 +2395,7 @@ mali: gpu@ffe40000 {
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
2.27.0

