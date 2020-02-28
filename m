Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCCC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86492468A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsxo5mfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1GNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:13:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34130 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1GNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:13:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so2049012ljc.1;
        Thu, 27 Feb 2020 22:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7dy/Kujh8oupW/pVHgPs57WktyNPAbW19eFPb391nVY=;
        b=fsxo5mfKJg6j7cF0VkdAc/Hf3t4sJlFk33XPf59uRYualOkUrk/UJzxZ7KWH04ia5n
         xj09T9DCmsQsThEtDPqXm6TCNRL/V0/Lo5ep2lfIavLQJo3HYvJKrTSzdqx/Yzf5mO00
         VF7rP+MEuKyBGOJkzXioIcKPm3D4Bd/8L7gC18p0gjCpv47SQ7fmbsA7MChCo3obBPzc
         cZHCMZpRZKtIIDnVpEcx/ZiwPUmgcs//DbDVz7kuc/Fsh19/Pip/fLXsvHsw4p91DTD4
         JHfZNCChQdQ5o0KyQF7A4LgJmrUTZZks0/rLgCEwkJERmzE26+Ey7oxRSzBYMq74e4ae
         u+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7dy/Kujh8oupW/pVHgPs57WktyNPAbW19eFPb391nVY=;
        b=Bj3SXKYXHSdFaMnYbat2KP4+3qR4N/AxWC3if7FmWMCzjGBTS+3Xf2SufybpWNjp/T
         IoM9CmdBSl+e41SiIe0Se4dTTtApt+fzqrPwix0TfEA4iO8jKYR7qaL6HPEqxvRnNBD3
         0Bx7KFi2Mfqc0e85iGJfVQxfnsu93P8MP3L29sh3jXsld/9f/OdCU+gt600kmOMmZmLa
         +357FzULS+nLDrCLmI9zsZr+z2UvphaDkIHPDEU3ws/0zXYsVqNZzF6KKhNuM87CQOjW
         aFAQSUtQc6LsVHU6ygZkBDetQ7JtaDBTwHK3tbSzwlkc7Bgo/X97ewQseOvRGl3t6HEW
         NIPg==
X-Gm-Message-State: ANhLgQ2VUveI7sHNUIKFhjd+0MJXzLRuMB07jd9FyYBV2nk8MIjzb6J/
        ZmMabyYR5mWgCTxv148iI3U=
X-Google-Smtp-Source: ADFU+vu9lkUYGTP4dyLaBRdQUY25f/Yt3QOACVP1pzgNmvrwnRgocQ5ZZOd/qLXvw4ZmQ/Mhq32Jtg==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr1812515lji.177.1582870397017;
        Thu, 27 Feb 2020 22:13:17 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f14sm4149299lfh.40.2020.02.27.22.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Feb 2020 22:13:16 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Nick Xie <nick@khadas.com>
Subject: [PATCH] arm64: dts: meson: add thermal zones to gxl-s905x-khadas-vim
Date:   Fri, 28 Feb 2020 10:12:26 +0400
Message-Id: <1582870346-74145-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zones to the VIM1 board, copying the zone config from the
existing VIM2 board.

Suggested-by: Nick Xie <nick@khadas.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 440bc23..2c198c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "meson-gxl-s905x-p212.dtsi"
 
@@ -63,6 +64,39 @@
 			};
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&scpi_sensors 0>;
+
+			trips {
+				cpu_alert0: cpu-alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "active";
+				};
+
+				cpu_alert1: cpu-alert1 {
+					temperature = <80000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 &cec_AO {
@@ -72,6 +106,22 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu0 {
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	#cooling-cells = <2>;
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
-- 
2.7.4

