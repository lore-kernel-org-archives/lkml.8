Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D286C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93F5206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKb8O+gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDEKt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id c7so13847145wrx.5;
        Sun, 05 Apr 2020 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf/zKaXETW/6458P4s0u4NU6tE49BufLG2XcDtV/oYY=;
        b=BKb8O+gruVcuzrvJ+jdE4CH0Kx7gHmxQkao3riTtUm5F/RkBe/gJO8ylyyPjDhUiOc
         pfvN+GFiJ1qgUlcGzTajqhFVefA9KLugJmEbLM8ZUDZxdQmIrf7rWptyP5GhhtpUPPLd
         sx9Xv9JnYsgoPuTESmDetFf63Cev90TiEd6uGH8ju8QAGGpfoJSPu7dJNmV96vcoaSr1
         ypDIC9+5Q3BpDVCY9MXYpmAlUgNe2zjTMTjW9dr0doerX1kUt4ynUup7FZTKd0f0HZIe
         ZMzmhmb3fSQQxq9nWVcauYe6H7A43o2rbfNTd5+L8IBX0OzZR8KwlyHNxCjyTPD/3ycv
         Gl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf/zKaXETW/6458P4s0u4NU6tE49BufLG2XcDtV/oYY=;
        b=rQowVs/+YcC1FZRO1P7KzscPnLCAuOyW53tu3TjbO7tW5PqLjCcWUPK4kTMtEA5hB+
         9maP30kxmoZqfLjFQNl/OmS2nIsRF73RCPhGHVA8V4/7pavKmKVtT3N5WLSLVSDwu0VK
         bKxmkC+PWcYko5UqmgeCdgSuKzppXtlhfLU03gGH6mE7wu39HcGQeov1rouhcYFhtuqI
         9rMXgsLz3rb5sDRCITE4aREvUvSE17uraN46np+cR4msu+FrDBU2MlePcuFKNs09d7ft
         1S464AVF59XNRXUMeqSFKkRrWa0rCFa14yFT7FIjY05a0Gq+EqLOMrJnQOAyomMhtXg7
         mYlA==
X-Gm-Message-State: AGi0PuaRMdS3/pzYsfWSGK+S0zoVXjaC+jN7+6zh2VbfC25U69u53XWT
        wSUBayg3Qwylh+0J8j7o4zw=
X-Google-Smtp-Source: APiQypKHu20FrbfSe0fDwBKWYRQzJF4KCRaS0O42RnvhISY1odqSGlpPzlujLCquM1gMQbnxl270vA==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr17526555wrx.320.1586083760663;
        Sun, 05 Apr 2020 03:49:20 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:19 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 4/7] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Sun,  5 Apr 2020 12:49:10 +0200
Message-Id: <20200405104913.22806-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add an Operating Performance Points table for the CPU cores to
enable Dynamic Voltage & Frequency Scaling on the H6.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
 2 files changed, 107 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
new file mode 100644
index 000000000000..b480c33f426b
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
+// Copyright (C) 2020 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "allwinner,sun50i-h6-operating-points";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		opp@480000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <480000000>;
+
+			opp-microvolt-speed0 = <880000>;
+			opp-microvolt-speed1 = <820000>;
+			opp-microvolt-speed2 = <820000>;
+		};
+
+		opp@720000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <720000000>;
+
+			opp-microvolt-speed0 = <880000>;
+			opp-microvolt-speed1 = <820000>;
+			opp-microvolt-speed2 = <820000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <880000>;
+			opp-microvolt-speed1 = <820000>;
+			opp-microvolt-speed2 = <820000>;
+		};
+
+		opp@888000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <888000000>;
+
+			opp-microvolt-speed0 = <880000>;
+			opp-microvolt-speed1 = <820000>;
+			opp-microvolt-speed2 = <820000>;
+		};
+
+		opp@1080000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1080000000>;
+
+			opp-microvolt-speed0 = <940000>;
+			opp-microvolt-speed1 = <880000>;
+			opp-microvolt-speed2 = <880000>;
+		};
+
+		opp@1320000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1320000000>;
+
+			opp-microvolt-speed0 = <1000000>;
+			opp-microvolt-speed1 = <940000>;
+			opp-microvolt-speed2 = <940000>;
+		};
+
+		opp@1488000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1488000000>;
+
+			opp-microvolt-speed0 = <1060000>;
+			opp-microvolt-speed1 = <1000000>;
+			opp-microvolt-speed2 = <1000000>;
+		};
+
+		opp@1800000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1800000000>;
+
+			opp-microvolt-speed0 = <1160000>;
+			opp-microvolt-speed1 = <1100000>;
+			opp-microvolt-speed2 = <1100000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu0_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu0_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu0_opp_table>;
+	#cooling-cells = <2>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c3e4f09f60ce..a9304fec245c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -253,6 +253,10 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			speedbin_efuse: speed@1c {
+				reg = <0x1c 0x4>;
+			};
+
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
-- 
2.20.1

