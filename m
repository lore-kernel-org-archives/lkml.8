Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA06C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11017206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0sO6lRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgD1Ott (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbgD1Otn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:49:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9EC03C1AB;
        Tue, 28 Apr 2020 07:49:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so3099746wmj.3;
        Tue, 28 Apr 2020 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J3QFlJHQxyblSAKFcby4n2BdhC/OIDlr14v3xcvEKMs=;
        b=c0sO6lRtAuqtBjZRSNQfRm/Pzp1kIsKdjOE+HlZN/+k2huybqplV1iSiEkeQ74EoC4
         sGRnJWZS1DqceFsoKKHaG5yzy00cT+HtC8kiCUAZEY0gJo+LKtQ8r8nRFnkM83x5x1bm
         SQYILQcYd/F3Ch4pLEUl/nybxigfWDhIOF+BjVDUr1btPNUkFztaUssreBnNg+1+4NDh
         QXTkXnL1+S/x5Sz6S+gqHGtvG6b7EgaqMB3wTU5xq4JeKv/62uDpAMSx+KSZ2hUAkMU6
         1r7TgZp8HCIRpevF3+UhrJnJjXQ8TdS/z+JRTXjgdvOoGaV87XMixJjHZ4PH4DRwnCLU
         lRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J3QFlJHQxyblSAKFcby4n2BdhC/OIDlr14v3xcvEKMs=;
        b=rHKAjW58bIn7GEiG6oC0FdXRh/zJUVtaEA10gbtk4RlAaEzBSvU83OC0zyo7l8shN6
         T72VTE6j1BgRAHyMqTPt1DkhNnd75QBSw6muuZLHIFDtdnVX/U4fZ/fy4HkVv93oH63K
         QBam+kFR1RPOy/pqjPqw3oQSPKy2DGN9Z/zORqSpDCGKEQCZu7KdR/kUDW9T9VrIQC25
         ITRSRWf2pT8D4x08twSgRQZ91eA2eYqlotbQkFp4sGJMA9PzxyWTEfDIUvLyH3HSK6an
         iCrY7RRSqu+M4ncEeuYPznye6Z7nwvGzSLdfJBkwAxX/syD3aNVOzkzw3U08Ho9w71OT
         jd+Q==
X-Gm-Message-State: AGi0PuZflegBLLZu+joebb+odP4+eKphDRJsnHu4Cbtgx90pIKpqUNT9
        B5KU0Ou+ik4cu0X4eh6pTmLclovV
X-Google-Smtp-Source: APiQypJAKyJqf2PrCUMAYFRdSOzlF+gZWRuzX6TH1+FLVLdS5km6gvLw0fFUb2v9zmrI5Pw3scoQfw==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr5041718wmf.77.1588085381239;
        Tue, 28 Apr 2020 07:49:41 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l9sm25458592wrq.83.2020.04.28.07.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:49:40 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: rockchip: rename and label gpio-led subnodes
Date:   Tue, 28 Apr 2020 16:49:32 +0200
Message-Id: <20200428144933.10953-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'gpio-led' nodes were manually verified.
In order to automate this process leds-gpio.txt
has been converted to yaml. With this conversion a check
for pattern properties was added. A test with the command
below gives a screen full of warnings like:

arch/arm/boot/dts/rk3188-radxarock.dt.yaml: gpio-leds:
'blue', 'green', 'sleep'
do not match any of the regexes:
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Fix these errors with help of the following rules:

1: Add nodename in the preferred form.

2: Always add a label that ends with '_led' to prevent conflicts
   with other labels such as 'power' and 'mmc'

3: If leds need pinctrl add a label that ends with '_led_pin'
   also to prevent conflicts with other labels.

patternProperties:
  # The first form is preferred, but fall back to just 'led'
  # anywhere in the node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/
leds-gpio.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts          |  2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts         |  2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts      |  6 +++---
 arch/arm/boot/dts/rk3229-xms6.dts           |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 12 ++++++------
 arch/arm/boot/dts/rk3288-firefly.dtsi       | 12 ++++++------
 arch/arm/boot/dts/rk3288-miqi.dts           |  2 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi   |  6 +++---
 arch/arm/boot/dts/rk3288-rock2-square.dts   |  4 ++--
 arch/arm/boot/dts/rk3288-tinker.dtsi        |  6 +++---
 10 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 2ff9f152d..7154b827e 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -16,7 +16,7 @@
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 
-		work {
+		work_led: led-0 {
 			gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
 			label = "kylin:red:led";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 365eff621..eed9e60cf 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -22,7 +22,7 @@
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		blue {
+		blue_led: led-0 {
 			label = "mk808:blue:power";
 			gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index c9a7f5409..b0fef82c0 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -33,19 +33,19 @@
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		green {
+		green_led: led-0 {
 			label = "rock:green:user1";
 			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		blue {
+		blue_led: led-1 {
 			label = "rock:blue:user2";
 			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		sleep {
+		sleep_led: led-2 {
 			label = "rock:red:power";
 			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
index 933ef69da..637245324 100644
--- a/arch/arm/boot/dts/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -33,7 +33,7 @@
 	power-led {
 		compatible = "gpio-leds";
 
-		blue {
+		blue_led: led-0 {
 			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 8c38bda21..9a4a9749c 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -45,20 +45,20 @@
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		power_led: led-0 {
 			gpios = <&gpio8 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:power";
 			pinctrl-names = "default";
-			pinctrl-0 = <&power_led>;
+			pinctrl-0 = <&power_led_pin>;
 			panic-indicator;
 		};
 
-		work {
+		work_led: led-1 {
 			gpios = <&gpio8 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:user";
 			linux,default-trigger = "rc-feedback";
 			pinctrl-names = "default";
-			pinctrl-0 = <&work_led>;
+			pinctrl-0 = <&work_led_pin>;
 		};
 	};
 
@@ -334,11 +334,11 @@
 	};
 
 	leds {
-		power_led: power-led {
+		power_led_pin: power-led-pin {
 			rockchip,pins = <8 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		work_led: work-led {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <8 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 5e0a19004..e5c4fd4ea 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -62,20 +62,20 @@
 	leds {
 		compatible = "gpio-leds";
 
-		work {
+		work_led: led-0 {
 			gpios = <&gpio8 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:user";
 			linux,default-trigger = "rc-feedback";
 			pinctrl-names = "default";
-			pinctrl-0 = <&work_led>;
+			pinctrl-0 = <&work_led_pin>;
 		};
 
-		power {
+		power_led: led-1 {
 			gpios = <&gpio8 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "firefly:green:power";
 			linux,default-trigger = "default-on";
 			pinctrl-names = "default";
-			pinctrl-0 = <&power_led>;
+			pinctrl-0 = <&power_led_pin>;
 		};
 	};
 
@@ -429,11 +429,11 @@
 	};
 
 	leds {
-		power_led: power-led {
+		power_led_pin: power-led-pin {
 			rockchip,pins = <8 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		work_led: work-led {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <8 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index c41d012c8..213c9eb84 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -30,7 +30,7 @@
 	leds {
 		compatible = "gpio-leds";
 
-		work {
+		work_led: led-0 {
 			gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 			label = "miqi:green:user";
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 77a47b9b7..e43887c96 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -36,9 +36,9 @@
 	leds: user-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_led>;
+		pinctrl-0 = <&user_led_pin>;
 
-		user {
+		user_led: led-0 {
 			label = "green_led";
 			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
@@ -372,7 +372,7 @@
 	};
 
 	leds {
-		user_led: user-led {
+		user_led_pin: user-led-pin {
 			rockchip,pins = <7 RK_PA2 RK_FUNC_GPIO &pcfg_output_high>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index cdcdc921e..3cca4d0f9 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -41,13 +41,13 @@
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		heartbeat {
+		heartbeat_led: led-0 {
 			gpios = <&gpio7 RK_PB7 GPIO_ACTIVE_LOW>;
 			label = "rock2:green:state1";
 			linux,default-trigger = "heartbeat";
 		};
 
-		mmc {
+		mmc_led: led-1 {
 			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
 			label = "rock2:blue:state2";
 			linux,default-trigger = "mmc0";
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index acfaa12ec..90e9be443 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -46,17 +46,17 @@
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		act-led {
+		act_led: led-0 {
 			gpios = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 
-		heartbeat-led {
+		heartbeat_led: led-1 {
 			gpios = <&gpio1 RK_PD1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		pwr-led {
+		pwr_led: led-2 {
 			gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
-- 
2.11.0

