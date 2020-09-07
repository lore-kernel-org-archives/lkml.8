Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AA52087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503638;
	bh=onAKa5CjT21fFPK1lJhrP23odcNpdwzPlsOxjVyUonc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+NIrT4Houz8NKR/vD9eozQxBni6LdcjrEpHQ3K+AcRCfHk/k+WJvDyjbcoiaPJeC
	 FM//gGkNhSeF0GaEkTWyX1uzWpyGrdCPdkrq8qnHb1JzMelEDNoZHqkxJ5bPKhLbL3
	 D1SD47gZI6uZqMLtprPHATxmgUXsYtY5NH1mhckY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgIGSd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730119AbgIGSdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:49 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2400D2145D;
        Mon,  7 Sep 2020 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503628;
        bh=onAKa5CjT21fFPK1lJhrP23odcNpdwzPlsOxjVyUonc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S06H8aVS0/F1pz7jUvRUie3LfNBZUJyCHP+KAdds0FCEyQTpS3Yaaqn7qvy5lI5zd
         CF0ofh1YF0i9A3m5uegk1lIokHyJ8K7g3kud0W1nr68qBYfl85QwXX02OWYtqriV46
         SFDyJw5yjOu1Fs8oSjqlSzJJEpxlmyTsvY1QSljo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 08/11] ARM: dts: s3c24xx: override nods by label
Date:   Mon,  7 Sep 2020 20:33:10 +0200
Message-Id: <20200907183313.29234-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using full paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416.dtsi | 104 ++++++++++++++++-----------------
 arch/arm/boot/dts/s3c24xx.dtsi |  22 +++----
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 6adf64ea3ff2..d1dec9f52f69 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -23,49 +23,12 @@
 		};
 	};
 
-	interrupt-controller@4a000000 {
-		compatible = "samsung,s3c2416-irq";
-	};
-
 	clocks: clock-controller@4c000000 {
 		compatible = "samsung,s3c2416-clock";
 		reg = <0x4c000000 0x40>;
 		#clock-cells = <1>;
 	};
 
-	pinctrl@56000000 {
-		compatible = "samsung,s3c2416-pinctrl";
-	};
-
-	timer@51000000 {
-		clocks = <&clocks PCLK_PWM>;
-		clock-names = "timers";
-	};
-
-	uart_0: serial@50000000 {
-		compatible = "samsung,s3c2440-uart";
-		clock-names = "uart", "clk_uart_baud2",
-				"clk_uart_baud3";
-		clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
-				<&clocks SCLK_UART>;
-	};
-
-	uart_1: serial@50004000 {
-		compatible = "samsung,s3c2440-uart";
-		clock-names = "uart", "clk_uart_baud2",
-				"clk_uart_baud3";
-		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
-				<&clocks SCLK_UART>;
-	};
-
-	uart_2: serial@50008000 {
-		compatible = "samsung,s3c2440-uart";
-		clock-names = "uart", "clk_uart_baud2",
-				"clk_uart_baud3";
-		clocks = <&clocks PCLK_UART2>, <&clocks PCLK_UART2>,
-				<&clocks SCLK_UART>;
-	};
-
 	uart_3: serial@5000c000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
@@ -98,22 +61,59 @@
 				<&clocks MUX_HSMMC1>;
 		status = "disabled";
 	};
+};
 
-	watchdog: watchdog@53000000 {
-		interrupts = <1 9 27 3>;
-		clocks = <&clocks PCLK_WDT>;
-		clock-names = "watchdog";
-	};
+&i2c {
+	compatible = "samsung,s3c2440-i2c";
+	clocks = <&clocks PCLK_I2C0>;
+	clock-names = "i2c";
+};
 
-	rtc: rtc@57000000 {
-		compatible = "samsung,s3c2416-rtc";
-		clocks = <&clocks PCLK_RTC>;
-		clock-names = "rtc";
-	};
+&intc {
+	compatible = "samsung,s3c2416-irq";
+};
 
-	i2c@54000000 {
-		compatible = "samsung,s3c2440-i2c";
-		clocks = <&clocks PCLK_I2C0>;
-		clock-names = "i2c";
-	};
+&pinctrl_0 {
+	compatible = "samsung,s3c2416-pinctrl";
+};
+
+&rtc {
+	compatible = "samsung,s3c2416-rtc";
+	clocks = <&clocks PCLK_RTC>;
+	clock-names = "rtc";
+};
+
+&timer {
+	clocks = <&clocks PCLK_PWM>;
+	clock-names = "timers";
+};
+
+&uart_0 {
+	compatible = "samsung,s3c2440-uart";
+	clock-names = "uart", "clk_uart_baud2",
+			"clk_uart_baud3";
+	clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
+			<&clocks SCLK_UART>;
+};
+
+&uart_1 {
+	compatible = "samsung,s3c2440-uart";
+	clock-names = "uart", "clk_uart_baud2",
+			"clk_uart_baud3";
+	clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
+			<&clocks SCLK_UART>;
+};
+
+&uart_2 {
+	compatible = "samsung,s3c2440-uart";
+	clock-names = "uart", "clk_uart_baud2",
+			"clk_uart_baud3";
+	clocks = <&clocks PCLK_UART2>, <&clocks PCLK_UART2>,
+			<&clocks SCLK_UART>;
+};
+
+&watchdog {
+	interrupts = <1 9 27 3>;
+	clocks = <&clocks PCLK_WDT>;
+	clock-names = "watchdog";
 };
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 0d49d7680e72..80d4ce79be55 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -13,12 +13,12 @@
 
 	aliases {
 		pinctrl0 = &pinctrl_0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
+		serial0 = &uart_0;
+		serial1 = &uart_1;
+		serial2 = &uart_2;
 	};
 
-	intc:interrupt-controller@4a000000 {
+	intc: interrupt-controller@4a000000 {
 		compatible = "samsung,s3c2410-irq";
 		reg = <0x4a000000 0x100>;
 		interrupt-controller;
@@ -39,49 +39,49 @@
 		};
 	};
 
-	timer@51000000 {
+	timer: timer@51000000 {
 		compatible = "samsung,s3c2410-pwm";
 		reg = <0x51000000 0x1000>;
 		interrupts = <0 0 10 3>, <0 0 11 3>, <0 0 12 3>, <0 0 13 3>, <0 0 14 3>;
 		#pwm-cells = <3>;
 	};
 
-	uart0: serial@50000000 {
+	uart_0: serial@50000000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50000000 0x4000>;
 		interrupts = <1 28 0 4>, <1 28 1 4>;
 		status = "disabled";
 	};
 
-	uart1: serial@50004000 {
+	uart_1: serial@50004000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50004000 0x4000>;
 		interrupts = <1 23 3 4>, <1 23 4 4>;
 		status = "disabled";
 	};
 
-	uart2: serial@50008000 {
+	uart_2: serial@50008000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50008000 0x4000>;
 		interrupts = <1 15 6 4>, <1 15 7 4>;
 		status = "disabled";
 	};
 
-	watchdog@53000000 {
+	watchdog: watchdog@53000000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x53000000 0x100>;
 		interrupts = <0 0 9 3>;
 		status = "disabled";
 	};
 
-	rtc@57000000 {
+	rtc: rtc@57000000 {
 		compatible = "samsung,s3c2410-rtc";
 		reg = <0x57000000 0x100>;
 		interrupts = <0 0 30 3>, <0 0 8 3>;
 		status = "disabled";
 	};
 
-	i2c@54000000 {
+	i2c: i2c@54000000 {
 		compatible = "samsung,s3c2410-i2c";
 		reg = <0x54000000 0x100>;
 		interrupts = <0 0 27 3>;
-- 
2.17.1

