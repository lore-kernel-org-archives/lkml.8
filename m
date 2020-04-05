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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6EC2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4342063A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJNeFjzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgDERgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53018 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgDERgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id t203so3816231wmt.2;
        Sun, 05 Apr 2020 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0DunLPluftak3iWs4RwKKsIlFm/wwMME3GIYNozwG4=;
        b=vJNeFjzqnEge1LdAzSJNbFLcawhL3QT0wKLY7vMTu7Ihu/WIl2IHLPmvtp6Qlmmjjd
         t2bWkjwnu20yWLdVzQk5tnQDEwsMRcgNqnJ6hMRxIYDqK1IYX0cWiz/j7xZg5ahn2QND
         fpcp/3A7Cj1J6T73XkTprCLph57tkSe9HEHfGGl7dL1V/QnawYSLCDVj0YYTd5iFqoe/
         SSA2wANrtUVjHHfT+IuU6A7wZKm+zeheIbBcF4sRIzvEnRRRm0v2OcAGS/Z3C0u80xdF
         pypDpMk8eAO/RFJr8RyhW5+1+uHoDHPnKMb3EEvtcetDy0UitYZ/8GF5Ufy1s4pdsPbB
         JUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0DunLPluftak3iWs4RwKKsIlFm/wwMME3GIYNozwG4=;
        b=c6/cRh068XDCbtwIpb28dlCDHqfGQWn2Ch1NQNYRWRMuKavNsuCXVF8o8LO08aHc8z
         H1PnstFFAroJ0/ev4ftkj//FQtkwDKWPy0XZPV0M3thiqUaQgLH0pa7mV1zHGEkcAYcP
         qosEs3gdmwdTKPJmHKLQ8l/Hw0GmzlCfGjOtX+AXQv6JU1L8lDbdFgCDSUKo5GN4WnNr
         FjvYmhHsmvTclBjmixABqJ3Sx3pg/8qe67Y3XVFsyEHMcJZkW0+9GqhsYCnkADuhrr6v
         sTdcUUG99dJe6h64spbXRPDKmPFxQpJSCa4CswZBQ3hRA+SthTjPcaDpkyUuUvyJU6R8
         Uf8g==
X-Gm-Message-State: AGi0Pua3WHlvuxLU9oQOA7cN0yoPwOMmM0xoS32f5Lepn8edeKegsrcS
        NX7gZT7fDQFEDmDtbDbLXC8=
X-Google-Smtp-Source: APiQypKie1AjmHji8uxru4+YXf87oVzJ+RI9Jw89I55qcDvT3plodytSUZYLll13f39VHu89IXLLVQ==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr17828409wmc.129.1586108168281;
        Sun, 05 Apr 2020 10:36:08 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:07 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/7] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Sun,  5 Apr 2020 19:35:57 +0200
Message-Id: <20200405173601.24331-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405173601.24331-1-peron.clem@gmail.com>
References: <20200405173601.24331-1-peron.clem@gmail.com>
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
index 000000000000..8c1e413c6af9
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
@@ -0,0 +1,121 @@
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
index e0dd0757be0b..6b7af858614a 100644
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

