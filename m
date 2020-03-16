Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44742C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A9E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW38tUsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCPDVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:21:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33152 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgCPDVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 23:21:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id c20so12743946lfb.0;
        Sun, 15 Mar 2020 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zmu7fMFsBJeCOMbIn8KvGMIAfmFUwzCAJ0zed+mhTIc=;
        b=lW38tUscI8Cr57K/8jLVPga8bz2Vy1Da6VcvpVrSxv71C0aZVtT7ujMxN7vmYOOjwy
         tjOcXbc3REwOUgg6Tc9MuNA3q1gnH5fPOVoQrU0aiZ2nzwGDPqt3Qn4O9woFP8LDmXkE
         WGhBF1CvRcBZn4/4KgN4RgY5WIokSWuvnICaMWMUzvxxOzrlsOETn7sT172okQp91W6x
         3wV2Hrdg1nASCBbpn7On+3BkgAm+hFdh7UUtFYIgHS25xMROC6Ug49YwdbfeIhux9/xb
         xBrhYKn9JfrEutxJhRKN4Nb2xi0LrXAm5t/mAj3fAoFKIYy1na46+PuJmHpGPI1hi1fs
         MpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zmu7fMFsBJeCOMbIn8KvGMIAfmFUwzCAJ0zed+mhTIc=;
        b=CIe939oZ3495xFzEtiTFDyWvlQedRzuUGInqcZ4blJDVhofN2VeV5u9MVWZQ1dC1Gp
         eyPHdwpYzMkHJQc+VO2bWPu9/n34tFb1L6h7OIEoYjD8QlUVq0OOspXvB+dUqoaOVWsr
         czcWlLr+EbVRbStHy12BqIxxyz3GpTSDFOavOAeBsKUc/KLFPo5aADzpXLrX9DTJdcZE
         zAkraR8r0HbYVwbTcK19xpRr+103mNg2zotEUPZ+VslHaZRlxw6d7Zc+wBDCyaPBo+it
         s9Y9fuXsIoNmIjzFFa4Kd4MhEhxwHTXtFZuTK5ULgXYKJGrJ6HwOeuKtTMRB84GBd6g6
         +4zQ==
X-Gm-Message-State: ANhLgQ3LfUSI21k35bUp9p/qvptvbYEdF0sGwaDVWFvn4CIKjNNVTqA5
        CgSAGqHjCnaPoHP1eVPRCz0=
X-Google-Smtp-Source: ADFU+vsigaHdqYexv0SuvEa+ZVrt/q/vKfMTxI9Oe14bDKFD8lVWv7y1TxjP0PXQy5RF2ZOmwBStng==
X-Received: by 2002:ac2:5605:: with SMTP id v5mr16010995lfd.184.1584328908713;
        Sun, 15 Mar 2020 20:21:48 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s7sm17092677lfp.51.2020.03.15.20.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2020 20:21:48 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Nick Xie <nick@khadas.com>
Subject: [PATCH] arm64: dts: meson: add thermal zones to meson gx devices
Date:   Mon, 16 Mar 2020 07:20:54 +0400
Message-Id: <1584328854-28575-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt and update current VIM2 thermal zones support so that zones are
available on all meson GXBB/GXL/GXM devices - similar to changes made
for G12A/G12B/SM1 devices.

Suggested-by: Nick Xie <nick@khadas.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 52 +++++++++++++
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 87 ++++------------------
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         | 28 +++++++
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 40db06e..03f79fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -83,6 +84,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -92,6 +94,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -101,6 +104,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -110,6 +114,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -117,6 +122,53 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&scpi_sensors 0>;
+
+			trips {
+				cpu_passive: cpu-passive {
+					temperature = <80000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+
+				cpu_hot: cpu-hot {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "hot";
+				};
+
+				cpu_critical: cpu-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cpu_cooling_maps: cooling-maps {
+				map0 {
+					trip = <&cpu_passive>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	arm-pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index d5dc128..27eeab7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -8,7 +8,6 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/thermal/thermal.h>
 
 #include "meson-gxm.dtsi"
 
@@ -100,49 +99,6 @@
 		clock-names = "ext_clock";
 	};
 
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>; /* milliseconds */
-			polling-delay = <1000>; /* milliseconds */
-
-			thermal-sensors = <&scpi_sensors 0>;
-
-			trips {
-				cpu_alert0: cpu-alert0 {
-					temperature = <70000>; /* millicelsius */
-					hysteresis = <2000>; /* millicelsius */
-					type = "active";
-				};
-
-				cpu_alert1: cpu-alert1 {
-					temperature = <80000>; /* millicelsius */
-					hysteresis = <2000>; /* millicelsius */
-					type = "passive";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert0>;
-					cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
-				};
-
-				map1 {
-					trip = <&cpu_alert1>;
-					cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>,
-							 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
 	hdmi_5v: regulator-hdmi-5v {
 		compatible = "regulator-fixed";
 
@@ -198,36 +154,23 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-&cpu0 {
-	#cooling-cells = <2>;
-};
-
-&cpu1 {
-	#cooling-cells = <2>;
-};
-
-&cpu2 {
-	#cooling-cells = <2>;
-};
-
-&cpu3 {
-	#cooling-cells = <2>;
-};
-
-&cpu4 {
-	#cooling-cells = <2>;
-};
 
-&cpu5 {
-	#cooling-cells = <2>;
-};
-
-&cpu6 {
-	#cooling-cells = <2>;
-};
+&cpu_cooling_maps {
+	map0 {
+		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
+	};
 
-&cpu7 {
-	#cooling-cells = <2>;
+	map1 {
+		cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>,
+				 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+	};
 };
 
 &ethmac {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 5ff64a0..b6f89f1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -49,6 +49,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@101 {
@@ -58,6 +59,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@102 {
@@ -67,6 +69,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@103 {
@@ -76,6 +79,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
+			#cooling-cells = <2>;
 		};
 	};
 };
@@ -124,6 +128,30 @@
 	compatible = "amlogic,meson-gxm-aoclkc", "amlogic,meson-gx-aoclkc";
 };
 
+&cpu_cooling_maps {
+	map0 {
+		cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+	};
+
+	map1 {
+		cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+	};
+};
+
 &saradc {
 	compatible = "amlogic,meson-gxm-saradc", "amlogic,meson-saradc";
 };
-- 
2.7.4

