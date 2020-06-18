Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59694C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAB521534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448214;
	bh=MYYcJRFJPTB06V+ucjirZVyjIZQZP5RMckIncZ00mjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alJWl1yOPA4Xjqbb/1EDIJluyGDZ+/s8wEJXoQ+oo1XbMQBHBxcGIR290qBnvQJVl
	 MACvDR/pRv3X6UgvJo3qCqKCtlCII4py+VVmjBCfWrjF1HkdZP0LQ5VXAjeoHI7p9K
	 y3Sg8YmFaZ83ICqA8NIwBQxMdt7dPtsJ17KsJa5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgFRCnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgFRBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE6F214DB;
        Thu, 18 Jun 2020 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442695;
        bh=MYYcJRFJPTB06V+ucjirZVyjIZQZP5RMckIncZ00mjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYKmRgzQDA1Su8UNz95DfumaK2EjDgvbNUWZcpXBdU4tPywoj4za++4v4copBvfA3
         j+jQb76dc8d24fg76iMvKRutg7H6ri+IVBR3WUikv8z8hl02QQkhObdoNydbppKOHM
         vMOaankdj1YxIabGUxfUpmxux/fyZozzSED+dGuw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 159/388] arm64: dts: meson: fix leds subnodes name
Date:   Wed, 17 Jun 2020 21:04:16 -0400
Message-Id: <20200618010805.600873-159-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 08dc0e5dd9aabd52cff9e94febe6b282d29deca4 ]

Fix the leds subnode names to match (^led-[0-9a-f]$|led)

It fixes:
meson-g12b-a311d-khadas-vim3.dt.yaml: leds: 'red', 'white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-g12b-s922x-khadas-vim3.dt.yaml: leds: 'red', 'white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-g12b-odroid-n2.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-nanopi-k2.dt.yaml: leds: 'stat' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-nexbox-a95x.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-odroidc2.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-vega-s95-pro.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-vega-s95-meta.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-vega-s95-telos.dt.yaml: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-wetek-hub.dt.yaml: leds: 'system' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxbb-wetek-play2.dt.yaml: leds: 'ethernet', 'system', 'wifi' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxl-s905x-libretech-cc.dt.yaml: leds: 'blue', 'system' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxl-s905d-libretech-pc.dt.yaml: leds: 'blue', 'green' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxm-rbox-pro.dt.yaml: leds: 'blue', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-gxm-s912-libretech-pc.dt.yaml: leds: 'blue', 'green' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-sm1-sei610.dt.yaml: leds: 'bluetooth' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
meson-sm1-khadas-vim3l.dt.yaml: leds: 'red', 'white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20200326165958.19274-6-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi       | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts       | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts           | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi           | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts             | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index 248b018c83d5..b1da36fdeac6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -96,14 +96,14 @@ dc_in: regulator-dc_in {
 	leds {
 		compatible = "gpio-leds";
 
-		green {
+		led-green {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK_ACTIVITY;
 			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 		};
 
-		blue {
+		led-blue {
 			color = <LED_COLOR_ID_BLUE>;
 			function = LED_FUNCTION_STATUS;
 			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index d6ca684e0e61..7be3e354093b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -29,7 +29,7 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		stat {
+		led-stat {
 			label = "nanopi-k2:blue:stat";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 65ec7dea828c..67d901ed2fa3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -31,7 +31,7 @@ memory@0 {
 
 	leds {
 		compatible = "gpio-leds";
-		blue {
+		led-blue {
 			label = "a95x:system-status";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index b46ef985bb44..70fcfb7b0683 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -49,7 +49,7 @@ usb_otg_pwr: regulator-usb-pwrs {
 
 	leds {
 		compatible = "gpio-leds";
-		blue {
+		led-blue {
 			label = "c2:blue:alive";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 45cb83625951..222ee8069cfa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -20,7 +20,7 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		blue {
+		led-blue {
 			label = "vega-s95:blue:on";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 1d32d1f6d032..2ab8a3d10079 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -14,13 +14,13 @@ / {
 	model = "WeTek Play 2";
 
 	leds {
-		wifi {
+		led-wifi {
 			label = "wetek-play:wifi-status";
 			gpios = <&gpio GPIODV_26 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		ethernet {
+		led-ethernet {
 			label = "wetek-play:ethernet-status";
 			gpios = <&gpio GPIODV_27 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index dee51cf95223..d6133af09d64 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -25,7 +25,7 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		system {
+		led-system {
 			label = "wetek-play:system-status";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index e8348b2728db..a4a71c13891b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -54,14 +54,14 @@ hdmi_connector_in: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		system {
+		led-system {
 			label = "librecomputer:system-status";
 			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			panic-indicator;
 		};
 
-		blue {
+		led-blue {
 			label = "librecomputer:blue";
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 420a88e9a195..c89c9f846fb1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -36,13 +36,13 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		blue {
+		led-blue {
 			label = "rbox-pro:blue:on";
 			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		red {
+		led-red {
 			label = "rbox-pro:red:standby";
 			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 094ecf2222bb..1ef1e3672b96 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -39,13 +39,13 @@ button-function {
 	leds {
 		compatible = "gpio-leds";
 
-		white {
+		led-white {
 			label = "vim3:white:sys";
 			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		red {
+		led-red {
 			label = "vim3:red";
 			gpios = <&gpio_expander 5 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index dfb2438851c0..5ab139a34c01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -104,7 +104,7 @@ hdmi_connector_in: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		bluetooth {
+		led-bluetooth {
 			label = "sei610:blue:bt";
 			gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
 			default-state = "off";
-- 
2.25.1

