Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841EA206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNurkOT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgEXQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgEXQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:06:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D080C061A0E;
        Sun, 24 May 2020 09:06:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so18168085ejb.10;
        Sun, 24 May 2020 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sxEJyU9TaXEIp1/fo5xw/QmL2ngVwpIdCduUvrBnplM=;
        b=sNurkOT5nUX7mei8dVVCD9bx5S0mCWH7rHU9DVn0oa3Vx7AfqWTBIx0aarjsKH5eju
         L4gExWaOHiGlROrm30c1VnApfd0vAWtc5qimIIAZsDHjzHLWjzm5RQokNDXvE8pOGenZ
         B+JUKwXawsHXzLtmOvSQ84qWp/YCXb5XRIlW7Bfxie73D3Xyow8yji/3+HMOwYxyCF6w
         LCslZhGni3ZvD6GVNoA2uDUJWC8DBYJ5U39amRMg2WimQFI+a3wyaJfoN4aIQYFENPiB
         3TtM+RBVySGuQlz63QjE6coT9Wh1aanRw5u/3toxXPvulECFDGpjDiLw2McDWlPaJGnV
         g/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sxEJyU9TaXEIp1/fo5xw/QmL2ngVwpIdCduUvrBnplM=;
        b=d8ChdSXnB22hL1jst7krdfGpqotAch7EzBDNUmtNZHL2wcZC19e5WtX7qytuuBr8NF
         RU/9cc3EdD/pjcG3sCNXR6vGxcdqKf33VsjKgj522Fwg+6zt5TwF0OkcpFlZrlFP95d2
         BuhV34gYZtNThO4z3YVXbKqkBVIWeEQJIrE1Z2/UpOAT46VFIaC+RTbyRuK22ihSILSB
         Np5mAYWIKghvET3bc/PCBq7mSLBDCG9KRboVq3+cvgmUDDw/upvkscCckNJI6+Y+30l9
         JaiYsHpvojHfadND6r+ZgquwwoLPo4OSUCUA8ZZvDi2BvrXyn4dvb/Vej/6GXzx3MA0D
         EmyA==
X-Gm-Message-State: AOAM532isD7D5+ahxgZR7TsqUTVg1qR69xCC6fk1CHq3TuByV9yjNirG
        TqhkojvetJy7OhEaSo1L5vkq93haILk=
X-Google-Smtp-Source: ABdhPJzppSARRKRiOw707Bp1+PJaCjNmzltSjjaQgRwiUuFBPOVi5G7Fh6mBA5jXNi2qvpZvG8bZSA==
X-Received: by 2002:a17:906:c943:: with SMTP id fw3mr15404257ejb.288.1590336404894;
        Sun, 24 May 2020 09:06:44 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qn17sm13252855ejb.125.2020.05.24.09.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 09:06:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio
Date:   Sun, 24 May 2020 18:06:35 +0200
Message-Id: <20200524160636.16547-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3288-tinker.dt.yaml: tsadc: otp-gpio:
{'phandle': [[54]], 'rockchip,pins': [[0, 10, 0, 118]]}
is not of type 'array'

'gpio' is a sort of reserved nodename and should not be used
for pinctrl in combination with 'rockchip,pins', so change
nodes that end with 'gpio' to end with 'pin' or 'pins'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/
dtschema/schemas/gpio/gpio.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi              |  6 +++---
 arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts  |  2 +-
 arch/arm/boot/dts/rk3288-veyron-mighty.dts |  6 +++---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts  |  6 +++---
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi |  2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts |  2 +-
 arch/arm/boot/dts/rk3288.dtsi              |  6 +++---
 arch/arm/boot/dts/rv1108.dtsi              | 12 ++++++------
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 7a1a69183..3590ce15a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -522,9 +522,9 @@
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
 		pinctrl-names = "init", "default", "sleep";
-		pinctrl-0 = <&otp_gpio>;
+		pinctrl-0 = <&otp_pin>;
 		pinctrl-1 = <&otp_out>;
-		pinctrl-2 = <&otp_gpio>;
+		pinctrl-2 = <&otp_pin>;
 		#thermal-sensor-cells = <0>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
@@ -1103,7 +1103,7 @@
 		};
 
 		tsadc {
-			otp_gpio: otp-gpio {
+			otp_pin: otp-pin {
 				rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 171ba6185..8efba9dea 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -47,7 +47,7 @@
 &sdmmc {
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
 			&sdmmc_bus4>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 66f00d288..2c916c50d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -192,7 +192,7 @@
 &sdmmc {
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
 			&sdmmc_bus4>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-mighty.dts b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
index 27fbc0747..fa695a88f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mighty.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
@@ -18,8 +18,8 @@
 };
 
 &sdmmc {
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
-			&sdmmc_wp_gpio &sdmmc_bus4>;
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
+			&sdmmc_wp_pin &sdmmc_bus4>;
 	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
 
 	/delete-property/ disable-wp;
@@ -27,7 +27,7 @@
 
 &pinctrl {
 	sdmmc {
-		sdmmc_wp_gpio: sdmmc-wp-gpio {
+		sdmmc_wp_pin: sdmmc-wp-pin {
 			rockchip,pins = <7 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 383fad1a8..f8b69e0a1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -114,7 +114,7 @@
 &sdmmc {
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
 			&sdmmc_bus4>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 71e6629cc..4e9fdb0f7 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -105,7 +105,7 @@
 	};
 
 	sdmmc {
-		sdmmc_wp_gpio: sdmmc-wp-gpio {
+		sdmmc_wp_pin: sdmmc-wp-pin {
 			rockchip,pins = <7 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
@@ -126,8 +126,8 @@
 
 &sdmmc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
-		     &sdmmc_wp_gpio &sdmmc_bus4>;
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
+		     &sdmmc_wp_pin &sdmmc_bus4>;
 	wp-gpios = <&gpio7 RK_PB2 GPIO_ACTIVE_HIGH>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
index fe950f986..27fb06ce9 100644
--- a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
@@ -41,7 +41,7 @@
 		};
 
 		/* This is where we actually hook up CD */
-		sdmmc_cd_gpio: sdmmc-cd-gpio {
+		sdmmc_cd_pin: sdmmc-cd-pin {
 			rockchip,pins = <7 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index e354c61a4..4a3ea934d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -54,7 +54,7 @@
 &sdmmc {
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_pin
 			&sdmmc_bus4>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 0cd88774d..d052a4758 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -575,9 +575,9 @@
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
 		pinctrl-names = "init", "default", "sleep";
-		pinctrl-0 = <&otp_gpio>;
+		pinctrl-0 = <&otp_pin>;
 		pinctrl-1 = <&otp_out>;
-		pinctrl-2 = <&otp_gpio>;
+		pinctrl-2 = <&otp_pin>;
 		#thermal-sensor-cells = <1>;
 		rockchip,grf = <&grf>;
 		rockchip,hw-tshut-temp = <95000>;
@@ -1930,7 +1930,7 @@
 		};
 
 		tsadc {
-			otp_gpio: otp-gpio {
+			otp_pin: otp-pin {
 				rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index b453f8d0f..f3ff54753 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -352,9 +352,9 @@
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
 		pinctrl-names = "init", "default", "sleep";
-		pinctrl-0 = <&otp_gpio>;
+		pinctrl-0 = <&otp_pin>;
 		pinctrl-1 = <&otp_out>;
-		pinctrl-2 = <&otp_gpio>;
+		pinctrl-2 = <&otp_pin>;
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
 		rockchip,hw-tshut-temp = <120000>;
@@ -729,7 +729,7 @@
 						<0 RK_PC6 3 &pcfg_pull_none>;
 			};
 
-			i2c2m1_gpio: i2c2m1-gpio {
+			i2c2m1_pins: i2c2m1-pins {
 				rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>,
 						<0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
@@ -741,7 +741,7 @@
 						<1 RK_PD4 2 &pcfg_pull_none>;
 			};
 
-			i2c2m05v_gpio: i2c2m05v-gpio {
+			i2c2m05v_pins: i2c2m05v-pins {
 				rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>,
 						<1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
@@ -868,7 +868,7 @@
 				rockchip,pins = <0 RK_PB7 1 &pcfg_pull_none>;
 			};
 
-			otp_gpio: otp-gpio {
+			otp_pin: otp-pin {
 				rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 		};
@@ -887,7 +887,7 @@
 				rockchip,pins = <3 RK_PA3 1 &pcfg_pull_none>;
 			};
 
-			uart0_rts_gpio: uart0-rts-gpio {
+			uart0_rts_pin: uart0-rts-pin {
 				rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 		};
-- 
2.11.0

