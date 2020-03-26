Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95920714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCZWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:03:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49687 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgCZWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:03:00 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaR-0006GJ-WE; Thu, 26 Mar 2020 23:02:52 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaR-0008Ff-LJ; Thu, 26 Mar 2020 23:02:51 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] ARM: dts: stm32: use uniform node names for sleep pinctrl groups
Date:   Thu, 26 Mar 2020 23:02:09 +0100
Message-Id: <20200326220213.28632-5-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200326220213.28632-1-a.fatoum@pengutronix.de>
References: <20200326220213.28632-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While all sleep pinctrl group labels now follow a fixed naming scheme,
node _names_ for these groups don't:

- Some use ${dev}-[0-9], where the suffix is the normal group suffix + 1
- Some use ${dev}-sleep-[0-9], where suffix is the normal group suffix
- The &ltdc node uses ${dev}-[a-z]-[0-9], where the letter matches the
  phandle and the number suffix is the normal group's suffix + 1

For uniformity, standardize on using ${dev}-[0-9]+ for all normal
pinctrl groups and ${dev}-sleep-[0-9]+ for all sleep pinctrl groups.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  - New Patch
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 50 ++++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 1971a9603ba6..377a8b2b3a3a 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -6,7 +6,7 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
-	adc1_in6_pins_a: adc1-in6 {
+	adc1_in6_pins_a: adc1-in6-0 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
 		};
@@ -58,13 +58,13 @@ pins {
 		};
 	};
 
-	dac_ch1_pins_a: dac-ch1 {
+	dac_ch1_pins_a: dac-ch1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 4, ANALOG)>;
 		};
 	};
 
-	dac_ch2_pins_a: dac-ch2 {
+	dac_ch2_pins_a: dac-ch2-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
 		};
@@ -250,14 +250,14 @@ pins {
 		};
 	};
 
-	i2c1_sleep_pins_a: i2c1-1 {
+	i2c1_sleep_pins_a: i2c1-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
 				 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
 		};
 	};
 
-	i2c1_pins_b: i2c1-2 {
+	i2c1_pins_b: i2c1-1 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
 				 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
@@ -267,7 +267,7 @@ pins {
 		};
 	};
 
-	i2c1_sleep_pins_b: i2c1-3 {
+	i2c1_sleep_pins_b: i2c1-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
 				 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
@@ -284,14 +284,14 @@ pins {
 		};
 	};
 
-	i2c2_sleep_pins_a: i2c2-1 {
+	i2c2_sleep_pins_a: i2c2-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('H', 4, ANALOG)>, /* I2C2_SCL */
 				 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
 		};
 	};
 
-	i2c2_pins_b1: i2c2-2 {
+	i2c2_pins_b1: i2c2-1 {
 		pins {
 			pinmux = <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
 			bias-disable;
@@ -300,7 +300,7 @@ pins {
 		};
 	};
 
-	i2c2_sleep_pins_b1: i2c2-3 {
+	i2c2_sleep_pins_b1: i2c2-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
 		};
@@ -316,7 +316,7 @@ pins {
 		};
 	};
 
-	i2c5_sleep_pins_a: i2c5-1 {
+	i2c5_sleep_pins_a: i2c5-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* I2C5_SCL */
 				 <STM32_PINMUX('A', 12, ANALOG)>; /* I2C5_SDA */
@@ -335,7 +335,7 @@ pins {
 		};
 	};
 
-	i2s2_sleep_pins_a: i2s2-1 {
+	i2s2_sleep_pins_a: i2s2-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 3, ANALOG)>, /* I2S2_SDO */
 				 <STM32_PINMUX('B', 9, ANALOG)>, /* I2S2_WS */
@@ -343,7 +343,7 @@ pins {
 		};
 	};
 
-	ltdc_pins_a: ltdc-a-0 {
+	ltdc_pins_a: ltdc-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
 				 <STM32_PINMUX('I', 10, AF14)>, /* LCD_HSYNC */
@@ -379,7 +379,7 @@ pins {
 		};
 	};
 
-	ltdc_sleep_pins_a: ltdc-a-1 {
+	ltdc_sleep_pins_a: ltdc-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_CLK */
 				 <STM32_PINMUX('I', 10, ANALOG)>, /* LCD_HSYNC */
@@ -412,7 +412,7 @@ pins {
 		};
 	};
 
-	ltdc_pins_b: ltdc-b-0 {
+	ltdc_pins_b: ltdc-1 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 14, AF14)>, /* LCD_CLK */
 				 <STM32_PINMUX('I', 12, AF14)>, /* LCD_HSYNC */
@@ -448,7 +448,7 @@ pins {
 		};
 	};
 
-	ltdc_sleep_pins_b: ltdc-b-1 {
+	ltdc_sleep_pins_b: ltdc-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 14, ANALOG)>, /* LCD_CLK */
 				 <STM32_PINMUX('I', 12, ANALOG)>, /* LCD_HSYNC */
@@ -710,7 +710,7 @@ pins {
 		};
 	};
 
-	sai2a_sleep_pins_a: sai2a-1 {
+	sai2a_sleep_pins_a: sai2a-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* SAI2_SCK_A */
 				 <STM32_PINMUX('I', 6, ANALOG)>, /* SAI2_SD_A */
@@ -720,7 +720,7 @@ pins {
 	};
 
 
-	sai2a_pins_b: sai2a-2 {
+	sai2a_pins_b: sai2a-1 {
 		pins1 {
 			pinmux = <STM32_PINMUX('I', 6, AF10)>,	/* SAI2_SD_A */
 				 <STM32_PINMUX('I', 7, AF10)>,	/* SAI2_FS_A */
@@ -731,7 +731,7 @@ pins1 {
 		};
 	};
 
-	sai2a_sleep_pins_b: sai2a-sleep-3 {
+	sai2a_sleep_pins_b: sai2a-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 6, ANALOG)>,  /* SAI2_SD_A */
 				 <STM32_PINMUX('I', 7, ANALOG)>,  /* SAI2_FS_A */
@@ -754,7 +754,7 @@ pins2 {
 		};
 	};
 
-	sai2b_sleep_pins_a: sai2b-1 {
+	sai2b_sleep_pins_a: sai2b-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* SAI2_SD_B */
 				 <STM32_PINMUX('E', 12, ANALOG)>, /* SAI2_SCK_B */
@@ -763,14 +763,14 @@ pins {
 		};
 	};
 
-	sai2b_pins_b: sai2b-2 {
+	sai2b_pins_b: sai2b-1 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
 			bias-disable;
 		};
 	};
 
-	sai2b_sleep_pins_b: sai2b-3 {
+	sai2b_sleep_pins_b: sai2b-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
 		};
@@ -785,7 +785,7 @@ pins {
 		};
 	};
 
-	sai4a_sleep_pins_a: sai4a-1 {
+	sai4a_sleep_pins_a: sai4a-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* SAI4_SD_A */
 		};
@@ -1048,7 +1048,7 @@ pins {
 		};
 	};
 
-	spdifrx_sleep_pins_a: spdifrx-1 {
+	spdifrx_sleep_pins_a: spdifrx-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 12, ANALOG)>; /* SPDIF_IN1 */
 		};
@@ -1145,7 +1145,7 @@ pins {
 		};
 	};
 
-	i2c2_sleep_pins_b2: i2c2-1 {
+	i2c2_sleep_pins_b2: i2c2-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>; /* I2C2_SCL */
 		};
@@ -1161,7 +1161,7 @@ pins {
 		};
 	};
 
-	i2c4_sleep_pins_a: i2c4-1 {
+	i2c4_sleep_pins_a: i2c4-sleep-0 {
 		pins {
 			pinmux = <STM32_PINMUX('Z', 4, ANALOG)>, /* I2C4_SCL */
 				 <STM32_PINMUX('Z', 5, ANALOG)>; /* I2C4_SDA */
-- 
2.26.0.rc2

