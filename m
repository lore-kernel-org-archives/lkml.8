Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC8C352BE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B824F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="HAaz1fmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgDMP22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:28:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40610 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgDMP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586791637; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tfml1XA1Zkg58G/4dh7l/ZYMeW4BWpH67C3VB3AQFbM=;
        b=HAaz1fmJQmZvP/6gYnLq88RwSfrG4DJlg7chaPTVx8hYIvLfu2Vcs/J7H1Na3xG2TF+89m
        i8f3tEwf3Ctp3dxpA0Fnz25wQuAnNbGBEoysIYD4wjcXQ3V8gbVVKB6igW77O180SEdLHB
        9VxBJG0F72nTxWcBcykLFgquq61wW28=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 09/13] MIPS: ingenic: DTS: Update JZ4770 support
Date:   Mon, 13 Apr 2020 17:26:29 +0200
Message-Id: <20200413152633.198301-9-paul@crapouillou.net>
In-Reply-To: <20200413152633.198301-1-paul@crapouillou.net>
References: <20200413152633.198301-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTC, AIC, CODEC, MMC 0/1/2, ADC, GPU, LCD,
USB OTG, USB PHY controllers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4770.dtsi | 177 ++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index 3024c360c3ca..fa11ac950499 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -38,13 +38,25 @@ osc32k: osc32k {
 	};
 
 	cgu: jz4770-cgu@10000000 {
-		compatible = "ingenic,jz4770-cgu";
+		compatible = "ingenic,jz4770-cgu", "simple-mfd";
 		reg = <0x10000000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10000000 0x100>;
 
 		clocks = <&ext>, <&osc32k>;
 		clock-names = "ext", "osc32k";
 
 		#clock-cells = <1>;
+
+		otg_phy: usb-phy@3c {
+			compatible = "ingenic,jz4770-phy";
+			reg = <0x3c 0x10>;
+
+			clocks = <&cgu JZ4770_CLK_OTG_PHY>;
+
+			#phy-cells = <0>;
+		};
 	};
 
 	tcu: timer@10002000 {
@@ -101,6 +113,14 @@ ost: timer@e0 {
 		};
 	};
 
+	rtc: rtc@10003000 {
+		compatible = "ingenic,jz4770-rtc", "ingenic,jz4760-rtc";
+		reg = <0x10003000 0x40>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <32>;
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4770-pinctrl";
 		reg = <0x10010000 0x600>;
@@ -199,6 +219,93 @@ gpf: gpio@5 {
 		};
 	};
 
+	aic: audio-controller@10020000 {
+		compatible = "ingenic,jz4770-i2s";
+		reg = <0x10020000 0x94>;
+
+		#sound-dai-cells = <0>;
+
+		clocks = <&cgu JZ4770_CLK_AIC>, <&cgu JZ4770_CLK_I2S>,
+			 <&cgu JZ4770_CLK_EXT>, <&cgu JZ4770_CLK_PLL0>;
+		clock-names = "aic", "i2s", "ext", "pll half";
+
+		interrupt-parent = <&intc>;
+		interrupts = <34>;
+
+		dmas = <&dmac0 25 0xffffffff>, <&dmac0 24 0xffffffff>;
+		dma-names = "rx", "tx";
+	};
+
+	codec: audio-codec@100200a0 {
+		compatible = "ingenic,jz4770-codec";
+		reg = <0x100200a4 0x8>;
+
+		#sound-dai-cells = <0>;
+
+		clocks = <&cgu JZ4770_CLK_AIC>;
+		clock-names = "aic";
+	};
+
+	mmc0: mmc@10021000 {
+		compatible = "ingenic,jz4770-mmc", "ingenic,jz4760-mmc";
+		reg = <0x10021000 0x1000>;
+
+		clocks = <&cgu JZ4770_CLK_MMC0>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <37>;
+
+		dmas = <&dmac1 27 0xffffffff>, <&dmac1 26 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+
+		status = "disabled";
+	};
+
+	mmc1: mmc@10022000 {
+		compatible = "ingenic,jz4770-mmc", "ingenic,jz4760-mmc";
+		reg = <0x10022000 0x1000>;
+
+		clocks = <&cgu JZ4770_CLK_MMC1>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <36>;
+
+		dmas = <&dmac1 31 0xffffffff>, <&dmac1 30 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+
+		status = "disabled";
+	};
+
+	mmc2: mmc@10023000 {
+		compatible = "ingenic,jz4770-mmc", "ingenic,jz4760-mmc";
+		reg = <0x10023000 0x1000>;
+
+		clocks = <&cgu JZ4770_CLK_MMC2>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <35>;
+
+		dmas = <&dmac1 37 0xffffffff>, <&dmac1 36 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+
+		status = "disabled";
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4770-uart";
 		reg = <0x10030000 0x100>;
@@ -251,6 +358,43 @@ uart3: serial@10033000 {
 		status = "disabled";
 	};
 
+	adc: adc@10070000 {
+		compatible = "ingenic,jz4770-adc";
+		reg = <0x10070000 0x30>;
+
+		#io-channel-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_ADC>;
+		clock-names = "adc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+	};
+
+	gpu: gpu@13040000 {
+		compatible = "vivante,gc";
+		reg = <0x13040000 0x10000>;
+
+		clocks = <&cgu JZ4770_CLK_GPU>,
+			 <&cgu JZ4770_CLK_GPU>,
+			 <&cgu JZ4770_CLK_GPU>;
+		clock-names = "bus", "core", "shader";
+
+		interrupt-parent = <&intc>;
+		interrupts = <6>;
+	};
+
+	lcd: lcd-controller@13050000 {
+		compatible = "ingenic,jz4770-lcd";
+		reg = <0x13050000 0x300>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <31>;
+
+		clocks = <&cgu JZ4770_CLK_LPCLK_MUX>;
+		clock-names = "lcd_pclk";
+	};
+
 	dmac0: dma-controller@13420000 {
 		compatible = "ingenic,jz4770-dma";
 		reg = <0x13420000 0xC0>, <0x13420300 0x20>;
@@ -260,9 +404,6 @@ dmac0: dma-controller@13420000 {
 		clocks = <&cgu JZ4770_CLK_DMA>;
 		interrupt-parent = <&intc>;
 		interrupts = <24>;
-
-		/* Disable dmac0 until we have something that uses it */
-		status = "disabled";
 	};
 
 	dmac1: dma-controller@13420100 {
@@ -274,9 +415,6 @@ dmac1: dma-controller@13420100 {
 		clocks = <&cgu JZ4770_CLK_DMA>;
 		interrupt-parent = <&intc>;
 		interrupts = <23>;
-
-		/* Disable dmac1 until we have something that uses it */
-		status = "disabled";
 	};
 
 	uhc: uhc@13430000 {
@@ -292,4 +430,29 @@ uhc: uhc@13430000 {
 
 		status = "disabled";
 	};
+
+	usb_otg: usb@13440000 {
+		compatible = "ingenic,jz4770-musb";
+		reg = <0x13440000 0x10000>;
+
+		clocks = <&cgu JZ4770_CLK_OTG>;
+		clock-names = "udc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <21>;
+		interrupt-names = "mc";
+
+		phys = <&otg_phy>;
+
+		usb-role-switch;
+	};
+
+	rom: memory@1fc00000 {
+		compatible = "mtd-rom";
+		probe-type = "map_rom";
+		reg = <0x1fc00000 0x2000>;
+
+		bank-width = <4>;
+		device-width = <1>;
+	};
 };
-- 
2.25.1

