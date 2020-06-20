Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57791C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3186423ECE
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fo70egYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFTQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgFTQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:37:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D8C0613EE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:04 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x93so10177666ede.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeXIX4cL4JttaxyZztbyyc6gPAexWcRduvN8u8Of524=;
        b=fo70egYQi4mBdJdqmqluUFPtYiGSD6h3naKOeM4bW2cRV67/h1EwPiZj5F/8mJf0pM
         DG/JjCJ5Vft3kCJpXaD+GFS2JWe0Sd4JX2Vn4AG2xKefWgK9DtbsQZxpv+UPwiYGdGFI
         8q6FUrp8l5iMILI8I4r0mV9Bw7txC8+LbDjU09LC3Az9Byp/Ei6VC/d02OA8DjFAczM3
         DHz9txqK1IAjj5yeo+Yo8Z1gSUyHbyARn/O49ZsNBBbowwRAdV+i8CMFWAw6oS43Au+1
         TAKQFZYpHgiZ4ZiaZYv5E8vUFbn61YHqcvWmSAUmeKYdARqu2IiklZVtJQuooWXcX6tM
         j7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeXIX4cL4JttaxyZztbyyc6gPAexWcRduvN8u8Of524=;
        b=H0R7zGtwaYRUgigk6KynaXO8x3JTDWnsx4weVy1woSOPr7lvTk1BzscxNVp39D2CUW
         H6QmXukWSrRxQ6+igYHj3eMyQQldGLYolkovNIyAR2SAwcLTh01Dk89wK+R24DF+1Y0t
         QCTwHlPyfFJPgo1efoL+HyUd1ADFMhdwmI+9OxYzCVkircrB7u5ICs62ZVX70OhrV6Vs
         xk/ABjt8+x78MpXaSgoLO2ZmXDJOg0Iq2aGepZjFYDBmjVES1Z4PsTAS1XLnv0rE9y0l
         0nb32AxtV4eSIW4LP09etgtbNKukCLvV2V9KYnLMlwxfjpHEnCil8pHbQniAUkMSX0oJ
         awkg==
X-Gm-Message-State: AOAM531P3eJexcIn0DRTX4iIX3kiafrsbRMp8IMmV5h90+69NUZv2iV5
        2CRTde+5gcC6w61oxsb8Bhw=
X-Google-Smtp-Source: ABdhPJzDrh6d0sh+T/qt5F3roXDNZgw5kjhwH/j07o2a2OVligg/aY11BDFB+9LecHH5MFYs40V5OA==
X-Received: by 2002:a05:6402:128b:: with SMTP id w11mr8439854edv.377.1592671023487;
        Sat, 20 Jun 2020 09:37:03 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o90sm7839442edb.60.2020.06.20.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:37:02 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson: add the SDHC MMC controller
Date:   Sat, 20 Jun 2020 18:36:52 +0200
Message-Id: <20200620163654.37207-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson6, Meson8, Meson8b and Meson8m2 are using a similar SDHC controller
IP which typically connects to an eMMC chip (because unlike the SDIO
controller the SDHC controller has an 8-bit bus interface).

On Meson8, Meson8b and Meson8m2 the clock inputs are all the same.
However, Meson8m2 seems to have an improved version of the SHDC
controller IP which doesn't require the driver to wait manually for a
flush of a DMA transfer. Thus every SoC has it's own compatible string
so if more difference are discovered they can be implemented.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi    |  7 +++++++
 arch/arm/boot/dts/meson8.dtsi   | 19 +++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi |  4 ++++
 4 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index ae89deaa8c9c..464057989572 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -140,6 +140,13 @@ spifc: spi@8c80 {
 				status = "disabled";
 			};
 
+			sdhc: mmc@8e00 {
+				compatible = "amlogic,meson-mx-sdhc";
+				reg = <0x8e00 0x42>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
+
 			gpio_intc: interrupt-controller@9880 {
 				compatible = "amlogic,meson-gpio-intc";
 				reg = <0x9880 0x10>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 3d0ab2ac5332..04688e8abce2 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -384,6 +384,15 @@ mux {
 			};
 		};
 
+		sdxc_b_pins: sdxc-b {
+			mux {
+				groups = "sdxc_d0_b", "sdxc_d13_b",
+					 "sdxc_clk_b", "sdxc_cmd_b";
+				function = "sdxc_b";
+				bias-pull-up;
+			};
+		};
+
 		spi_nor_pins: nor {
 			mux {
 				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
@@ -558,6 +567,16 @@ &saradc {
 	nvmem-cell-names = "temperature_calib";
 };
 
+&sdhc {
+	compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>,
+		 <&clkc CLKID_FCLK_DIV5>,
+		 <&clkc CLKID_SDHC>;
+	clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk";
+};
+
 &sdio {
 	compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
 	clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 2069c57343e5..2401cdf5f751 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -363,6 +363,16 @@ mux {
 			};
 		};
 
+		sdxc_c_pins: sdxc-c {
+			mux {
+				groups = "sdxc_d0_c", "sdxc_d13_c",
+					 "sdxc_d47_c", "sdxc_clk_c",
+					 "sdxc_cmd_c";
+				function = "sdxc_c";
+				bias-pull-up;
+			};
+		};
+
 		pwm_c1_pins: pwm-c1 {
 			mux {
 				groups = "pwm_c1";
@@ -554,6 +564,16 @@ &saradc {
 	nvmem-cell-names = "temperature_calib";
 };
 
+&sdhc {
+	compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>,
+		 <&clkc CLKID_FCLK_DIV5>,
+		 <&clkc CLKID_SDHC>;
+	clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk";
+};
+
 &sdio {
 	compatible = "amlogic,meson8b-sdio", "amlogic,meson-mx-sdio";
 	clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index c7ddbb210366..6725dd9fd825 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -84,6 +84,10 @@ &saradc {
 	compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
 };
 
+&sdhc {
+	compatible = "amlogic,meson8m2-sdhc", "amlogic,meson-mx-sdhc";
+};
+
 &usb0_phy {
 	compatible = "amlogic,meson8m2-usb2-phy", "amlogic,meson-mx-usb2-phy";
 };
-- 
2.27.0

