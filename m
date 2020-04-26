Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99326C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704E220700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnCjBbpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgDZMRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:17:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232DC061A0E;
        Sun, 26 Apr 2020 05:17:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so16374703wmc.2;
        Sun, 26 Apr 2020 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sxihwdh/vZTDlHhcfbgqZo1sbFRiOWINuc6LYLa6Dg=;
        b=cnCjBbpR8IGBWghzQy7pzJ79C3bQ+W8CN/6oL1B6ClMIyAYxc8q4NatU/ypJACIyAF
         nUiiRLDFkPvDhfqF+gW1n4Sk3BJ56RXR2KPPnzV4mMjkzmO45bYXzn/K7IxfK26znoqD
         yNSOUvW06hJZ8yhw1S3Bu1Ybqoh9xFzUu2AH9bNDs5m3ElFI6VOGk7rB7aUazCujD6vr
         4/wCM6E89GCyXGaigOyl2tVo21QCmjPVNw3WHpJMxI+hpwS6SgXzk/E2Ys2KCUNjBr8M
         RKlBUhWNizvIcEkQKjZhFp0UZjs9HGd4BYoKurQJ8HIqSRe6P+wsurYX+YuToQpKqEhq
         0VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sxihwdh/vZTDlHhcfbgqZo1sbFRiOWINuc6LYLa6Dg=;
        b=GAzvQS6Lp8HFnWb7xyARw8IjnkH4kGemXl3e89QsBOA2lGV8hm5kCsCePTg890zEXZ
         2KAjQYYql8ZNxdgzCr+I9XB8LYn1WdXzOfoHvTcUfN5w5Vy+C/0Crur9v3uz+3W8OJ+0
         WrG2VpvZtPZsFd/G/S9CLm1UxkymY42eSIGDF4aRUEHg8kv4zrUBavWTy/wuBAmQUcIZ
         o/sZdbUgY8RFzh23FAKW0EA3jgUHli0ColZDSyxcePodnJ5if+RxpbsuqOITGoxpYb8u
         Afc7wUaNRBe9CsWR8qeS2USrrtMpyudkj4D9/FQkgx2W43jAxtAzMASKSe9035yax4KH
         cfYg==
X-Gm-Message-State: AGi0Pua5khLvBwbN24wf1W3hFtz3+afQZp6e9ElQel8a5ITxff8N3t+K
        QFrHL+WQWwvHEVoTVtzJcCs=
X-Google-Smtp-Source: APiQypK1dC9vKN4ibJZj2tHhTaucdfNnnIpxgq4lcOaqXLjiJ04+E6zGPoHFH8Opirus+RdAEAwdSg==
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr20403256wmm.131.1587903431752;
        Sun, 26 Apr 2020 05:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id m8sm17899817wrx.54.2020.04.26.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:17:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Subject: [PATCH] arm64: dts: allwinner: h6: Use dedicated CPU OPP table for Tanix TX6
Date:   Sun, 26 Apr 2020 14:17:09 +0200
Message-Id: <20200426121709.1216-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has a fixed regulator. As DVFS is instructed to change
voltage to meet OPP table. The DVFS is not working as expected.

Introduce a dedicated OPP Table where voltage are equals to
the fixed regulator.

Reported-by: Piotr Oniszczuk <warpme@o2.pl>
Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../sun50i-h6-tanix-tx6-cpu-opp.dtsi          | 116 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |   2 +-
 2 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi
new file mode 100644
index 000000000000..062940115563
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-cpu-opp.dtsi
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@720000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <720000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <816000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@888000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <888000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1080000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1080000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1320000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1320000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1488000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1488000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1608000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1608000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1704000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1704000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+
+		opp@1800000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-hz = /bits/ 64 <1800000000>;
+
+			opp-microvolt-speed0 = <1135000>;
+			opp-microvolt-speed1 = <1135000>;
+			opp-microvolt-speed2 = <1135000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..3eaa4f49e3d3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -4,7 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
-#include "sun50i-h6-cpu-opp.dtsi"
+#inlcude "sun50i-h6-tanix-tx6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
-- 
2.20.1

