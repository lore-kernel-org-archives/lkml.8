Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D6C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E910D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="dLIt+PT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBXQyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:54:50 -0500
Received: from vps.xff.cz ([195.181.215.36]:59702 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582563288; bh=FwaS6CxBkt9Bed13hZj3FhQm0Xpmwou2Qyewryzy0rk=;
        h=From:To:Cc:Subject:Date:From;
        b=dLIt+PT21mzhB7bkMaBmqfbreoWoLbajY+BfxLlK58bhKOKcNJBo66sTIKJmHNXA5
         v2kxp/PZ7fJ59SGkrQqc7pUq8+Xa+MXH0zWFAX+3baHL9aNAHL4D9EisHbeqzkZPjc
         o3s4M5YcZ68sh5SAahz0MC19nZhe/ByRrpJD8Cmc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ARM: dts: sun8i-h3: Add thermal trip points/cooling maps
Date:   Mon, 24 Feb 2020 17:54:46 +0100
Message-Id: <20200224165446.334712-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables passive cooling by down-regulating CPU voltage
and frequency.

For trip points, I used a slightly lowered values from the BSP
code. The critical temperature of 110°C from BSP code seemed
like a lot, so I rounded it off to 100°C.

The critical trip point value is 30°C above the maximum recommended
ambient temperature (70°C) for the SoC from the datasheet, so there's
some headroom even at such a high ambient temperature.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

v2:
- added more detail to the commit description

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 20217e2ca4d3a..e83aa6866e7ea 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -41,6 +41,7 @@
  */
 
 #include "sunxi-h3-h5.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	cpu0_opp_table: opp_table0 {
@@ -227,6 +228,30 @@ cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_hot_trip: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.25.1

