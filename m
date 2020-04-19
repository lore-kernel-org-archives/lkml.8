Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CDCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8880C22202
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzgs+36w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDSNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB000C061A0F;
        Sun, 19 Apr 2020 06:50:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so6667808wrb.8;
        Sun, 19 Apr 2020 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vgd6dfjp6nCI+xgQ8mfqiGKeHRAidwVE6+NkPB9dyqo=;
        b=Vzgs+36wcBSfrIfjkZ2QR/iZI8Yuu1qVfX1mqTg1cUnT4wGAz91/PPt5sefhQ9w8hT
         so7EHeMP+zu1WN2Dzux/QvEiV5aw+NoAN68WzwFVMz4KZFLzbrSwieeJlcb7BJJQ2aj5
         2V8D7TxddLfHv1Bx9pGyU/pLk+euxwSJTD9HnetbWYhyOL3fxHDxM/2ThVMLWVO+5RVy
         aYQt/fdulfpCTzxrw1EmZABZR+pjl09B2SkPStx/oc1VRPQDxgOkpan+MwdEH0sxZGC2
         UARPnon67jXit1jnipQbIOBrh2vhVJfRpXQLCj2yf9BcpgEHRlDzbrNdoi86rzDsXikC
         H6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vgd6dfjp6nCI+xgQ8mfqiGKeHRAidwVE6+NkPB9dyqo=;
        b=qpWvXo7yMFFIyCFRVBB4L1HFX2hxbZq37dYPRPTUr5LfzAwD91XYFpKRNGEiUkYvaG
         vewRnHWSQN6hm9Erm7LThQcQ+8A2Y5dAbGfQeZ1ZTa4EXD49+g5mT5D/5BBNKqZM/EIT
         MJm+77UqSDfQJcoAhWh3dSsAEZ9MLemZtatFPgz1dznUwMfI7Hs+UQ7qH1be6gVKidTY
         ti/Ips2wbpgwhMUQuTkXrpK2mwFzv7KAe919s0u92cWRWZHjqUsFZanAWiB7fevybTrx
         xOrIPLqfTZ4vBDqDeMKwOkAPg+424QRBULvuM+q7IY0U4RiWqhsl8yY+LBFYfdT8mU2A
         dQ8A==
X-Gm-Message-State: AGi0Pub/C6r7I5HiLRdWm97PYKLznEm6KUkXnsI6N4DK3Bx6OkxI8s4f
        r6Ht22lRqvgYINR7Gjoo0Fc=
X-Google-Smtp-Source: APiQypKUPz7MPSTvVPqVKl5r5Z5uT+AcmwnxRenC8+O0zbkDoIOdqmKSX4vGwuS1l5t/IRSXgqsdwA==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr13309828wrw.373.1587304214427;
        Sun, 19 Apr 2020 06:50:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:13 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/7] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Sun, 19 Apr 2020 15:50:05 +0200
Message-Id: <20200419135011.18010-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
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
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
 2 files changed, 125 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
new file mode 100644
index 000000000000..9ebd97b04b1a
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
+// Copyright (C) 2020 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	cpu_opp_table: cpu-opp-table {
+		compatible = "allwinner,sun50i-h6-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
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
+		opp@1608000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1608000000>;
+
+			opp-microvolt-speed0 = <1090000>;
+			opp-microvolt-speed1 = <1030000>;
+			opp-microvolt-speed2 = <1030000>;
+		};
+
+		opp@1704000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1704000000>;
+
+			opp-microvolt-speed0 = <1120000>;
+			opp-microvolt-speed1 = <1060000>;
+			opp-microvolt-speed2 = <1060000>;
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
+	operating-points-v2 = <&cpu_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+	#cooling-cells = <2>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 60da1627772b..83e32f9c4977 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -258,6 +258,10 @@
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@1c {
+				reg = <0x1c 0x4>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
-- 
2.20.1

