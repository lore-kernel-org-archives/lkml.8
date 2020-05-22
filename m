Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C56C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C882070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPa3zQjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgEVPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbgEVPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:47:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEFC061A0E;
        Fri, 22 May 2020 08:47:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k19so9587149edv.9;
        Fri, 22 May 2020 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qwlZdKUtG9hIaYKjrN5RMCIPKH2TLwxT9v7URTVXs9Y=;
        b=qPa3zQjSEi9a/EsgmMgPl4eA4N+ULhTJsySmjTkW284WWZwDU8Hoc7oKcm9mqGvcms
         Fd7xcHQTzV20f+keATE3oqg1xBlF6SOpc20FDvbGv6G+dCLgQAftHQoUyxQl1CwVP4T/
         Uz35pWmgXnLm348oQp+3M7iKeWKlVYhkYnVogG9Sbs0bPOBLlNmtRFGTVcY7UPnVWovq
         FjtA8LTJt1DrVyqoUI7X5qJxu1lYBvwgXJGCEuCh1OqVVXxW4Gfq316NYhUj4RCHoLl5
         mKriNIM5K2SttvOxpNA9doeGGr4+4agF4PDkuUL1KSdgu5M6Bd//ZY8i6TNdvNyfi7My
         wIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qwlZdKUtG9hIaYKjrN5RMCIPKH2TLwxT9v7URTVXs9Y=;
        b=nBEU2B5YLOg25/1yFOysczpwjOqPLgPYzBUU4qEr6rQIS9xXTuV4LH1C9ZvSRWhVrM
         jnvAhd/CJ4Y78ZwNAqwGMTxYSwwqB/AtaltVd97wWDs3WJG+27V0fEdJWUla1ouse0S6
         bEmC8xgXBlsFbGTYFd73dbBx/SpLAfvZUN4tY6iI5oD2ANdvqrwnjm1RpskziGrSfpVF
         3s5qrDrbSGrbIdjDfrZUsFpbZLYP+4pGZIq9//HjPezoDIkKSTZKQ4gUqT/Ramb9Qz1G
         8PA5bWHKGDCeaPdZGknQC95gJMdsOEL1t0kn5Wqbgf+jGLSYgipLGqVUU4stMhmxDvWD
         ppfg==
X-Gm-Message-State: AOAM532AQ0UxkoTaezbCzTdjr4iQNO6d8/wfOD6bekDiZDm7aP3URy8i
        7+S12/GvH0Z9MxyliVCvbB0=
X-Google-Smtp-Source: ABdhPJzGBHW0gaivOWBdJo79fO66DCHU8peg1XEfk/2EohqKyJyFcXoPlPEhaigApWokLbxCCqly4A==
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr3313931edp.155.1590162424129;
        Fri, 22 May 2020 08:47:04 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x5sm7283055eds.8.2020.05.22.08.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 08:47:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rename and label gpio-led subnodes part 2
Date:   Fri, 22 May 2020 17:46:57 +0200
Message-Id: <20200522154657.9472-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'gpio-led' nodes were manually verified.
In order to automate this process leds-gpio.txt
has been converted to yaml. With this conversion a check
for pattern properties was added. In part 2 rename and label
gpio-led subnodes that passed the regex, but still don't have
the preferred form. Any pin subnode that ends with '-gpio'
in the pinctrl node generates a warning.

Fix with help of the following rules:

1: Add nodename in the preferred form.

2: Always add a label that ends with '_led' to prevent conflicts
   with other labels such as 'power' and 'mmc'

3: If leds need pinctrl add a label that ends with '_led_pin'
   also to prevent conflicts with other labels.

patternProperties:
  # The first form is preferred, but fall back to just 'led'
  # anywhere in the node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/
leds-gpio.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/gpio/gpio.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts  |  6 +++---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi        |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi     |  6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts  |  6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi        |  6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi      | 14 +++++++-------
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi   | 10 +++++-----
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index cbde279ae..e8774347b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -25,9 +25,9 @@
 	};
 
 	leds {
-		pinctrl-0 = <&led_pins_module>, <&led_sd_haikou>;
+		pinctrl-0 = <&module_led_pins>, <&sd_card_led_pin>;
 
-		sd-card-led {
+		sd_card_led: led-3 {
 			label = "sd_card_led";
 			gpios = <&gpio0 RK_PD2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
@@ -118,7 +118,7 @@
 	};
 
 	leds {
-		led_sd_haikou: led-sd-gpio {
+		sd_card_led_pin: sd-card-led-pin {
 			rockchip,pins =
 				<0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index e17311e09..eeef64e35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -76,16 +76,16 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_module>;
+		pinctrl-0 = <&module_led_pins>;
 
-		module_led1 {
+		module_led1: led-1 {
 			label = "module_led1";
 			gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			panic-indicator;
 		};
 
-		module_led2 {
+		module_led2: led-2 {
 			label = "module_led2";
 			gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
@@ -270,7 +270,7 @@
 
 &pinctrl {
 	leds {
-		led_pins_module: led-module-gpio {
+		module_led_pins: module-led-pins {
 			rockchip,pins =
 				<2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>,
 				<3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index e87a04477..e36837c04 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -141,15 +141,15 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&sys_led_gpio>, <&user_led_gpio>;
+		pinctrl-0 = <&sys_led_pin>, <&user_led_pin>;
 
-		sys-led {
+		sys_led: led-0 {
 			label = "sys_led";
 			linux,default-trigger = "heartbeat";
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		};
 
-		user-led {
+		user_led: led-1 {
 			label = "user_led";
 			default-state = "off";
 			gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_HIGH>;
@@ -586,11 +586,11 @@
 	};
 
 	leds {
-		sys_led_gpio: sys_led-gpio {
+		sys_led_pin: sys-led-pin {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		user_led_gpio: user_led-gpio {
+		user_led_pin: user-led-pin {
 			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index c88018a0e..b24d54570 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -117,9 +117,9 @@
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&leds_gpio>;
+		pinctrl-0 = <&status_led_pin>;
 
-		status {
+		status_led: led-0 {
 			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 			label = "status_led";
 			linux,default-trigger = "heartbeat";
@@ -520,7 +520,7 @@
 	};
 
 	gpio-leds {
-		leds_gpio: leds-gpio {
+		status_led_pin: status-led-pin {
 			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index d80d6b726..a8d363568 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -15,9 +15,9 @@
 	};
 
 	leds {
-		pinctrl-0 = <&led_pin_module>, <&led_sd_haikou>;
+		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
 
-		sd-card-led {
+		sd_card_led: led-1 {
 			label = "sd_card_led";
 			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
@@ -179,7 +179,7 @@
 	};
 
 	leds {
-		led_sd_haikou: led-sd-gpio {
+		sd_card_led_pin: sd-card-led-pin {
 			rockchip,pins =
 			  <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 07694b196..ae31299cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -11,9 +11,9 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pin_module>;
+		pinctrl-0 = <&module_led_pin>;
 
-		module-led {
+		module_led: led-0 {
 			label = "module_led";
 			gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
@@ -450,7 +450,7 @@
 	};
 
 	leds {
-		led_pin_module: led-module-gpio {
+		module_led_pin: module-led-pin {
 			rockchip,pins =
 			  <2 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 9f225e9c3..cec70f2bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -61,23 +61,23 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&work_led_gpio>, <&diy_led_gpio>, <&yellow_led_gpio>;
+		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>, <&yellow_led_pin>;
 
-		work-led {
+		work_led: led-0 {
 			label = "green:work";
 			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		diy-led {
+		diy_led: led-1 {
 			label = "red:diy";
 			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc1";
 		};
 
-		yellow-led {
+		yellow_led: led-2 {
 			label = "yellow:yellow-led";
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
@@ -595,15 +595,15 @@
 	};
 
 	leds {
-		diy_led_gpio: diy_led-gpio {
+		diy_led_pin: diy-led-pin {
 			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		work_led_gpio: work_led-gpio {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		yellow_led_gpio: yellow_led-gpio {
+		yellow_led_pin: yellow-led-pin {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6788ab28f..c39d0f411 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -39,15 +39,15 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&work_led_gpio>, <&diy_led_gpio>;
+		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>;
 
-		work-led {
+		work_led: led-0 {
 			label = "work";
 			default-state = "on";
 			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		};
 
-		diy-led {
+		diy_led: led-1 {
 			label = "diy";
 			default-state = "off";
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
@@ -588,11 +588,11 @@
 	};
 
 	leds {
-		work_led_gpio: work_led-gpio {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		diy_led_gpio: diy_led-gpio {
+		diy_led_pin: diy-led-pin {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.11.0

