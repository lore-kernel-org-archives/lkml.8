Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E45C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF09A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHh8An/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgDTNAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729809AbgDTNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56848C061A0C;
        Mon, 20 Apr 2020 06:00:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so10908331wmb.4;
        Mon, 20 Apr 2020 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vgd6dfjp6nCI+xgQ8mfqiGKeHRAidwVE6+NkPB9dyqo=;
        b=MHh8An/jJbmu06oPdxU3vbyYeSkZ6nK4TmBkyUo5RjOcq0uiPqALpMiCqGElcrbIXB
         adFntsiOtqTlaGSNevjvxrKKsMXAIcu4bU7BqmMK/ZfMR/7PuozYaw8dJlUJiLuE1oae
         OTyVySXUWJoo9JpNWF9AnrSkyNKYd5Kwz/6h7cYoWZlyqggDqrAyEoz1toUP2HzgPf92
         UnUi8ADqylwSUtovmBuf3HkSTWrPgqur17FmIa8ANWV1ImlLJtWNlCpeIUQlKPE5qmr9
         ZPxtiyII3+B1+O8xQ2XrS5hEZUjdz1TLVsEmdBoG+u/Fy5w3K74Iv3D+tAluEAVaaZ8i
         PGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vgd6dfjp6nCI+xgQ8mfqiGKeHRAidwVE6+NkPB9dyqo=;
        b=kt1nmL+FIjw7zAptGaI7wiXNVwuJIbF6jovZbfaG1CFmA4IFjA/DIm+rTqjtlPuuuH
         wgbRZumgKFPoivsOPl4WvqojKBjHBcyFUPZRySz3e70Z9oKi1TcrLkx9SBFGc2+tHLWs
         Qcbr2+T69aeXY0UxJ38qcmOiFXxWe10lOyfqrwdxjiCDeisq0Lyzr3y9ojAvOJOKzEGR
         5Zf1gveKUS61RXl1DXH+6RPi/v0aUOO1jdHS5WOkWhmxKXmtDLGPNHprFlJl3Jxiir1j
         axxmUY+MwlbnKsjyJDFzjrGg54xL/etVZNVMgYkwnnbP0ZFrjyUvBd6LCbybGfJJaSTo
         vnHw==
X-Gm-Message-State: AGi0Puaq/TWFuvA+yxNgMdCHYN5PF84heRXgHaFOl0zlAzbhTVLKr24R
        E2aZ7ATjcvBM3hJtsMdXQJbLKB/pyAc=
X-Google-Smtp-Source: APiQypI/8x9hL2UdtaDvh+QjznzGiOG4rspbWIfpA7WCOe6aQXH9bKCB1Q1rc0DXui25cmLcgQjYNQ==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr18128969wmm.48.1587387627925;
        Mon, 20 Apr 2020 06:00:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 3/9] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Mon, 20 Apr 2020 15:00:15 +0200
Message-Id: <20200420130021.3841-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
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

