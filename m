Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40297 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgCKQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:25:36 -0400
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: remove #address-cells and #size-cells from i2s nodes
Date: Wed, 11 Mar 2020 17:25:24 +0100
Message-Id: <20200311162524.19748-2-jbx6244@gmail.com>
In-Reply-To: <20200311162524.19748-1-jbx6244@gmail.com>
References: <20200311162524.19748-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

An experimental test with the command below gives
for example this error:

arch/arm/boot/dts/rk3036-evb.dt.yaml: i2s@10220000:
'#address-cells', '#size-cells'
do not match any of the regexes: 'pinctrl-[0-9]+'

'#address-cells' and '#size-cells' are not a valid property
for i2s nodes, so remove them.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-i2s.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi  | 2 --
 arch/arm/boot/dts/rk3066a.dtsi | 6 ------
 arch/arm/boot/dts/rk3188.dtsi  | 2 --
 arch/arm/boot/dts/rk322x.dtsi  | 6 ------
 arch/arm/boot/dts/rk3288.dtsi  | 2 --
 5 files changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 2226f0d70..781ac7583 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -281,8 +281,6 @@
 		compatible = "rockchip,rk3036-i2s", "rockchip,rk3066-i2s";
 		reg = <0x10220000 0x4000>;
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>;
 		dmas = <&pdma 0>, <&pdma 1>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index f3fc92e57..b599394d1 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -156,8 +156,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x10118000 0x2000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
@@ -174,8 +172,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x1011a000 0x2000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
 		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
@@ -192,8 +188,6 @@
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x1011c000 0x2000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
 		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 651ea4e15..24abf214a 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -166,8 +166,6 @@
 		compatible = "rockchip,rk3188-i2s", "rockchip,rk3066-i2s";
 		reg = <0x1011a000 0x2000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 8ad44213f..a0acf2ef8 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -152,8 +152,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100b0000 0x4000>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
 		dmas = <&pdma 14>, <&pdma 15>;
@@ -167,8 +165,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100c0000 0x4000>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
 		dmas = <&pdma 11>, <&pdma 12>;
@@ -193,8 +189,6 @@
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100e0000 0x4000>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
 		dmas = <&pdma 0>, <&pdma 1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f68dcde6c..4745be518 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -962,8 +962,6 @@
 		reg = <0x0 0xff890000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
 		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
-- 
2.11.0

