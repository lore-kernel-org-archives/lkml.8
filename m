Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F13C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487E82063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466892;
	bh=KeslPzs2FwKFFStsmdDUOpCwJSKhh0sqZw9b8DtBhiU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0TEay5nrj2/VataQkIv4JsI3bTyjBMzzarRkYJAdw2KcgRrpwNGzF+AGZnSMHe6bl
	 tiOtROhJ9a+NSvrvaBUxZpeN/dfa1qT0b/Avs+odojnk1pWpT0Mv99teesgk3xjtGG
	 KiO7TxdWl/O/FuyyhF0ICPTsYTrAYYhYeYdREB5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbgF2Vla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbgF2SkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E5B23357;
        Mon, 29 Jun 2020 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418622;
        bh=KeslPzs2FwKFFStsmdDUOpCwJSKhh0sqZw9b8DtBhiU=;
        h=From:To:Cc:Subject:Date:From;
        b=NeJ7WG+ItBjf7pO79lKX3y0DBF0WCSw1rQ+rqodMN4hQttRdbH8pWR0g2vYqp83Lb
         3FHG9MMBXcSxDomFqIK9RRNqq4Ta5p8N6FD5xBKYpz4fE6yVkSGqn3duj/+v1RuAHk
         kGmKC6COpKYCcnvvllzVQ/ecuccwaPpVTMt44nxc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] arm64: dts: hisilicon: Use phandles for overriding nodes in hi6220
Date:   Mon, 29 Jun 2020 10:16:56 +0200
Message-Id: <20200629081657.13821-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When overriding nodes, usage of phandles instead of full paths reduces
possible mistakes (e.g.  in duplicated unit address) and removes
duplicate data.  The UART nodes were extended via full path and phandle
which makes it difficult to review and spot actual differences.

No functional change (no difference in dtx_diff).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../arm64/boot/dts/hisilicon/hi6220-hikey.dts | 426 +++++++++---------
 1 file changed, 210 insertions(+), 216 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index c14205cd6bf5..a41e0db8e71b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -122,222 +122,6 @@
 		power-off-delay-us = <10>;
 	};
 
-	soc {
-		spi0: spi@f7106000 {
-			status = "ok";
-		};
-
-		i2c0: i2c@f7100000 {
-			status = "ok";
-		};
-
-		i2c1: i2c@f7101000 {
-			status = "ok";
-		};
-
-		uart1: uart@f7111000 {
-			assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
-			assigned-clock-rates = <150000000>;
-			status = "ok";
-
-			bluetooth {
-				compatible = "ti,wl1835-st";
-				enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-				clocks = <&pmic>;
-				clock-names = "ext_clock";
-			};
-		};
-
-		uart2: uart@f7112000 {
-			status = "ok";
-		};
-
-		uart3: uart@f7113000 {
-			status = "ok";
-		};
-
-		/*
-		 * Legend: proper name = the GPIO line is used as GPIO
-		 *         NC = not connected (not routed from the SoC)
-		 *         "[PER]" = pin is muxed for peripheral (not GPIO)
-		 *         "" = no idea, schematic doesn't say, could be
-		 *              unrouted (not connected to any external pin)
-		 *         LSEC = Low Speed External Connector
-		 *         HSEC = High Speed External Connector
-		 *
-		 * Pin assignments taken from LeMaker and CircuitCo Schematics
-		 * Rev A1.
-		 *
-		 * For the lines routed to the external connectors the
-		 * lines are named after the 96Boards CE Specification 1.0,
-		 * Appendix "Expansion Connector Signal Description".
-		 *
-		 * When the 96Board naming of a line and the schematic name of
-		 * the same line are in conflict, the 96Board specification
-		 * takes precedence, which means that the external UART on the
-		 * LSEC is named UART0 while the schematic and SoC names this
-		 * UART2. This is only for the informational lines i.e. "[FOO]",
-		 * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
-		 * ones actually used for GPIO.
-		 */
-		gpio0: gpio@f8011000 {
-			gpio-line-names = "PWR_HOLD", "DSI_SEL",
-			"USB_HUB_RESET_N", "USB_SEL", "HDMI_PD", "WL_REG_ON",
-			"PWRON_DET", "5V_HUB_EN";
-		};
-
-		gpio1: gpio@f8012000 {
-			gpio-line-names = "SD_DET", "HDMI_INT", "PMU_IRQ_N",
-			"WL_HOST_WAKE", "NC", "NC", "NC", "BT_REG_ON";
-		};
-
-		gpio2: gpio@f8013000 {
-			gpio-line-names =
-				"GPIO-A", /* LSEC Pin 23: GPIO2_0 */
-				"GPIO-B", /* LSEC Pin 24: GPIO2_1 */
-				"GPIO-C", /* LSEC Pin 25: GPIO2_2 */
-				"GPIO-D", /* LSEC Pin 26: GPIO2_3 */
-				"GPIO-E", /* LSEC Pin 27: GPIO2_4 */
-				"USB_ID_DET", "USB_VBUS_DET",
-				"GPIO-H"; /* LSEC Pin 30: GPIO2_7 */
-		};
-
-		gpio3: gpio@f8014000 {
-			gpio-line-names = "GPIO3_0", "NC", "NC", "", "NC", "",
-			"WLAN_ACTIVE", "NC", "NC";
-		};
-
-		gpio4: gpio@f7020000 {
-			gpio-line-names = "USER_LED1", "USER_LED2", "USER_LED3",
-			"USER_LED4", "SD_SEL", "NC", "NC", "BT_ACTIVE";
-		};
-
-		gpio5: gpio@f7021000 {
-			gpio-line-names = "NC", "NC",
-			"[UART1_RxD]", /* LSEC Pin 11: UART3_RX */
-			"[UART1_TxD]", /* LSEC Pin 13: UART3_TX */
-			"[AUX_SSI1]", "NC",
-			"[PCM_CLK]", /* LSEC Pin 18: MODEM_PCM_XCLK */
-			"[PCM_FS]"; /* LSEC Pin 16: MODEM_PCM_XFS */
-		};
-
-		gpio6: gpio@f7022000 {
-			gpio-line-names =
-			"[SPI0_DIN]", /* Pin 10: SPI0_DI */
-			"[SPI0_DOUT]", /* Pin 14: SPI0_DO */
-			"[SPI0_CS]", /* Pin 12: SPI0_CS_N */
-			"[SPI0_SCLK]", /* Pin 8: SPI0_SCLK */
-			"NC", "NC", "NC",
-			"GPIO-G"; /* Pin 29: GPIO6_7_DSI_TE0 */
-		};
-
-		gpio7: gpio@f7023000 {
-			gpio-line-names = "NC", "NC", "NC", "NC",
-			"[PCM_DI]", /* Pin 22: MODEM_PCM_DI */
-			"[PCM_DO]", /* Pin 20: MODEM_PCM_DO */
-			"NC", "NC";
-		};
-
-		gpio8: gpio@f7024000 {
-			gpio-line-names = "NC", "[CEC_CLK_19_2MHZ]", "NC",
-			"", "", "", "", "", "";
-		};
-
-		gpio9: gpio@f7025000 {
-			gpio-line-names = "",
-			"GPIO-J", /* LSEC Pin 32: ISP_PWDN0_GPIO9_1 */
-			"GPIO-L", /* LSEC Pin 34: ISP_PWDN1_GPIO9_2 */
-			"NC", "NC", "NC", "NC", "[ISP_CCLK0]";
-		};
-
-		gpio10: gpio@f7026000 {
-			gpio-line-names = "BOOT_SEL",
-			"[ISP_CCLK1]",
-			"GPIO-I", /* LSEC Pin 31: ISP_RSTB0_GPIO10_2 */
-			"GPIO-K", /* LSEC Pin 33: ISP_RSTB1_GPIO10_3 */
-			"NC", "NC",
-			"[I2C2_SDA]", /* HSEC Pin 34: ISP0_SDA */
-			"[I2C2_SCL]"; /* HSEC Pin 32: ISP0_SCL */
-		};
-
-		gpio11: gpio@f7027000 {
-			gpio-line-names =
-			"[I2C3_SDA]", /* HSEC Pin 38: ISP1_SDA */
-			"[I2C3_SCL]", /* HSEC Pin 36: ISP1_SCL */
-			"", "NC", "NC", "NC", "", "";
-		};
-
-		gpio12: gpio@f7028000 {
-			gpio-line-names = "[BT_PCM_XFS]", "[BT_PCM_DI]",
-			"[BT_PCM_DO]",
-			"NC", "NC", "NC", "NC",
-			"GPIO-F"; /* LSEC Pin 28: BL_PWM_GPIO12_7 */
-		};
-
-		gpio13: gpio@f7029000 {
-			gpio-line-names = "[UART0_RX]", "[UART0_TX]",
-			"[BT_UART1_CTS]", "[BT_UART1_RTS]",
-			"[BT_UART1_RX]", "[BT_UART1_TX]",
-			"[UART0_CTS]", /* LSEC Pin 3: UART2_CTS_N */
-			"[UART0_RTS]"; /* LSEC Pin 9: UART2_RTS_N */
-		};
-
-		gpio14: gpio@f702a000 {
-			gpio-line-names =
-			"[UART0_RxD]", /* LSEC Pin 7: UART2_RX */
-			"[UART0_TxD]", /* LSEC Pin 5: UART2_TX */
-			"[I2C0_SCL]", /* LSEC Pin 15: I2C0_SCL */
-			"[I2C0_SDA]", /* LSEC Pin 17: I2C0_SDA */
-			"[I2C1_SCL]", /* LSEC Pin 19: I2C1_SCL */
-			"[I2C1_SDA]", /* LSEC Pin 21: I2C1_SDA */
-			"[I2C2_SCL]", "[I2C2_SDA]";
-		};
-
-		gpio15: gpio@f702b000 {
-			gpio-line-names = "", "", "", "", "", "", "NC", "";
-		};
-
-		/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
-
-		dwmmc_0: dwmmc0@f723d000 {
-			cap-mmc-highspeed;
-			non-removable;
-			bus-width = <0x8>;
-			vmmc-supply = <&ldo19>;
-		};
-
-		dwmmc_1: dwmmc1@f723e000 {
-			card-detect-delay = <200>;
-			cap-sd-highspeed;
-			sd-uhs-sdr12;
-			sd-uhs-sdr25;
-			sd-uhs-sdr50;
-			vqmmc-supply = <&ldo7>;
-			vmmc-supply = <&ldo10>;
-			bus-width = <0x4>;
-			disable-wp;
-			cd-gpios = <&gpio1 0 1>;
-		};
-
-		dwmmc_2: dwmmc2@f723f000 {
-			bus-width = <0x4>;
-			non-removable;
-			cap-power-off-card;
-			vmmc-supply = <&reg_vdd_3v3>;
-			mmc-pwrseq = <&wl1835_pwrseq>;
-
-			#address-cells = <0x1>;
-			#size-cells = <0x0>;
-			wlcore: wlcore@2 {
-				compatible = "ti,wl1835";
-				reg = <2>;	/* sdio func num */
-				/* WL_IRQ, WL_HOST_WAKE_GPIO1_3 */
-				interrupt-parent = <&gpio1>;
-				interrupts = <3 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -480,10 +264,26 @@
 	};
 };
 
+&uart1 {
+	assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
+	assigned-clock-rates = <150000000>;
+	status = "ok";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		clocks = <&pmic>;
+		clock-names = "ext_clock";
+	};
+};
+
 &uart2 {
+	status = "ok";
 	label = "LS-UART0";
 };
+
 &uart3 {
+	status = "ok";
 	label = "LS-UART1";
 };
 
@@ -506,6 +306,196 @@
 	};
 };
 
+&dwmmc_0 {
+	cap-mmc-highspeed;
+	non-removable;
+	bus-width = <0x8>;
+	vmmc-supply = <&ldo19>;
+};
+
+&dwmmc_1 {
+	card-detect-delay = <200>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	vqmmc-supply = <&ldo7>;
+	vmmc-supply = <&ldo10>;
+	bus-width = <0x4>;
+	disable-wp;
+	cd-gpios = <&gpio1 0 1>;
+};
+
+&dwmmc_2 {
+	bus-width = <0x4>;
+	non-removable;
+	cap-power-off-card;
+	vmmc-supply = <&reg_vdd_3v3>;
+	mmc-pwrseq = <&wl1835_pwrseq>;
+
+	#address-cells = <0x1>;
+	#size-cells = <0x0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;	/* sdio func num */
+		/* WL_IRQ, WL_HOST_WAKE_GPIO1_3 */
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
+/*
+ * Legend: proper name = the GPIO line is used as GPIO
+ *         NC = not connected (not routed from the SoC)
+ *         "[PER]" = pin is muxed for peripheral (not GPIO)
+ *         "" = no idea, schematic doesn't say, could be
+ *              unrouted (not connected to any external pin)
+ *         LSEC = Low Speed External Connector
+ *         HSEC = High Speed External Connector
+ *
+ * Pin assignments taken from LeMaker and CircuitCo Schematics
+ * Rev A1.
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence, which means that the external UART on the
+ * LSEC is named UART0 while the schematic and SoC names this
+ * UART2. This is only for the informational lines i.e. "[FOO]",
+ * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+ * ones actually used for GPIO.
+ */
+&gpio0 {
+	gpio-line-names = "PWR_HOLD", "DSI_SEL",
+	"USB_HUB_RESET_N", "USB_SEL", "HDMI_PD", "WL_REG_ON",
+	"PWRON_DET", "5V_HUB_EN";
+};
+
+&gpio1 {
+	gpio-line-names = "SD_DET", "HDMI_INT", "PMU_IRQ_N",
+	"WL_HOST_WAKE", "NC", "NC", "NC", "BT_REG_ON";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"GPIO-A", /* LSEC Pin 23: GPIO2_0 */
+		"GPIO-B", /* LSEC Pin 24: GPIO2_1 */
+		"GPIO-C", /* LSEC Pin 25: GPIO2_2 */
+		"GPIO-D", /* LSEC Pin 26: GPIO2_3 */
+		"GPIO-E", /* LSEC Pin 27: GPIO2_4 */
+		"USB_ID_DET", "USB_VBUS_DET",
+		"GPIO-H"; /* LSEC Pin 30: GPIO2_7 */
+};
+
+&gpio3 {
+	gpio-line-names = "GPIO3_0", "NC", "NC", "", "NC", "",
+	"WLAN_ACTIVE", "NC", "NC";
+};
+
+&gpio4 {
+	gpio-line-names = "USER_LED1", "USER_LED2", "USER_LED3",
+	"USER_LED4", "SD_SEL", "NC", "NC", "BT_ACTIVE";
+};
+
+&gpio5 {
+	gpio-line-names = "NC", "NC",
+	"[UART1_RxD]", /* LSEC Pin 11: UART3_RX */
+	"[UART1_TxD]", /* LSEC Pin 13: UART3_TX */
+	"[AUX_SSI1]", "NC",
+	"[PCM_CLK]", /* LSEC Pin 18: MODEM_PCM_XCLK */
+	"[PCM_FS]"; /* LSEC Pin 16: MODEM_PCM_XFS */
+};
+
+&gpio6 {
+	gpio-line-names =
+	"[SPI0_DIN]", /* Pin 10: SPI0_DI */
+	"[SPI0_DOUT]", /* Pin 14: SPI0_DO */
+	"[SPI0_CS]", /* Pin 12: SPI0_CS_N */
+	"[SPI0_SCLK]", /* Pin 8: SPI0_SCLK */
+	"NC", "NC", "NC",
+	"GPIO-G"; /* Pin 29: GPIO6_7_DSI_TE0 */
+};
+
+&gpio7 {
+	gpio-line-names = "NC", "NC", "NC", "NC",
+	"[PCM_DI]", /* Pin 22: MODEM_PCM_DI */
+	"[PCM_DO]", /* Pin 20: MODEM_PCM_DO */
+	"NC", "NC";
+};
+
+&gpio8 {
+	gpio-line-names = "NC", "[CEC_CLK_19_2MHZ]", "NC",
+	"", "", "", "", "", "";
+};
+
+&gpio9 {
+	gpio-line-names = "",
+	"GPIO-J", /* LSEC Pin 32: ISP_PWDN0_GPIO9_1 */
+	"GPIO-L", /* LSEC Pin 34: ISP_PWDN1_GPIO9_2 */
+	"NC", "NC", "NC", "NC", "[ISP_CCLK0]";
+};
+
+&gpio10 {
+	gpio-line-names = "BOOT_SEL",
+	"[ISP_CCLK1]",
+	"GPIO-I", /* LSEC Pin 31: ISP_RSTB0_GPIO10_2 */
+	"GPIO-K", /* LSEC Pin 33: ISP_RSTB1_GPIO10_3 */
+	"NC", "NC",
+	"[I2C2_SDA]", /* HSEC Pin 34: ISP0_SDA */
+	"[I2C2_SCL]"; /* HSEC Pin 32: ISP0_SCL */
+};
+
+&gpio11 {
+	gpio-line-names =
+	"[I2C3_SDA]", /* HSEC Pin 38: ISP1_SDA */
+	"[I2C3_SCL]", /* HSEC Pin 36: ISP1_SCL */
+	"", "NC", "NC", "NC", "", "";
+};
+
+&gpio12 {
+	gpio-line-names = "[BT_PCM_XFS]", "[BT_PCM_DI]",
+	"[BT_PCM_DO]",
+	"NC", "NC", "NC", "NC",
+	"GPIO-F"; /* LSEC Pin 28: BL_PWM_GPIO12_7 */
+};
+
+&gpio13 {
+	gpio-line-names = "[UART0_RX]", "[UART0_TX]",
+	"[BT_UART1_CTS]", "[BT_UART1_RTS]",
+	"[BT_UART1_RX]", "[BT_UART1_TX]",
+	"[UART0_CTS]", /* LSEC Pin 3: UART2_CTS_N */
+	"[UART0_RTS]"; /* LSEC Pin 9: UART2_RTS_N */
+};
+
+&gpio14 {
+	gpio-line-names =
+	"[UART0_RxD]", /* LSEC Pin 7: UART2_RX */
+	"[UART0_TxD]", /* LSEC Pin 5: UART2_TX */
+	"[I2C0_SCL]", /* LSEC Pin 15: I2C0_SCL */
+	"[I2C0_SDA]", /* LSEC Pin 17: I2C0_SDA */
+	"[I2C1_SCL]", /* LSEC Pin 19: I2C1_SCL */
+	"[I2C1_SDA]", /* LSEC Pin 21: I2C1_SDA */
+	"[I2C2_SCL]", "[I2C2_SDA]";
+};
+
+&gpio15 {
+	gpio-line-names = "", "", "", "", "", "", "NC", "";
+};
+
+/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
+
+
+&i2c0 {
+	status = "ok";
+};
+
+&i2c1 {
+	status = "ok";
+};
+
 &i2c2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -549,3 +539,7 @@
 		};
 	};
 };
+
+&spi0 {
+	status = "ok";
+};
-- 
2.17.1

