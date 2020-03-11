Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbgCKQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:25:34 -0400
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: swap clocks and clock-names values for i2s nodes
Date: Wed, 11 Mar 2020 17:25:23 +0100
Message-Id: <20200311162524.19748-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current dts files with 'i2s' nodes are manually verified.
In order to automate this process rockchip-i2s.txt
has to be converted to yaml. In the new setup dtbs_check with
rockchip-i2s.yaml expect clocks and clock-names values
in the same order. Fix this for some older Rockchip models.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-i2s.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 12 ++++++------
 arch/arm/boot/dts/rk3188.dtsi  |  4 ++--
 arch/arm/boot/dts/rk3288.dtsi  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 3d1b02f45..f3fc92e57 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -160,10 +160,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 4>, <&dmac1_s 5>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		rockchip,playback-channels = <8>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
@@ -178,10 +178,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S1>, <&cru SCLK_I2S1>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
@@ -196,10 +196,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
+		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 9>, <&dmac1_s 10>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S2>, <&cru SCLK_I2S2>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 10ede65d9..651ea4e15 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -170,10 +170,10 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		rockchip,playback-channels = <2>;
 		rockchip,capture-channels = <2>;
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8bcb4a516..f68dcde6c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -964,10 +964,10 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
 		dma-names = "tx", "rx";
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		rockchip,playback-channels = <8>;
-- 
2.11.0

