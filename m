Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5CB217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtXMobp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgFRJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgFRJwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:52:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B845C06174E;
        Thu, 18 Jun 2020 02:52:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so2662754pge.12;
        Thu, 18 Jun 2020 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rlTaG4vEHV6obr/G85MD+Ik1qzQppM95dWbM2mQ30No=;
        b=XtXMobp1DssYwYeOkZQeegBQpybQHz6LYBfWFI/gC6jPaWEtCcHLm3SBm7d7l5QOTd
         sJjI4oNVfdezgxwoD7ebdbVqmFUJvleHwbrT99mP4y56Il/Ckp7z1p3ciPiEiAsj+3kT
         DQIR1nQJidTkiy3DYumYEOojMX08Giz8wF3Hf6odDCcNkVm+HY8776ExTFg9rfRDKG52
         pCUjJ40t9LwJ2fKXVW/9YGtS5DNRyTcQxNZFRFMTQaVjf38FhnFU51h0RsSbZ9xx9o8m
         Gp8boKfUoJtcL2gMOCgB4lZfsK0Bkh27YV6nv7CJ1q3JleSVIfcf9M7OrAxPKSWG67Ld
         24gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rlTaG4vEHV6obr/G85MD+Ik1qzQppM95dWbM2mQ30No=;
        b=BUyMArRuVEUmEEusOB0z2pYGBstv/qUeSPqyYrpMKBbbMBayEGBcrdVaqD5tvr1AQl
         H3zcJVvXcPNIOPUyIazV9/lvHR6CZmABQB7nsydg8xeGiDJmHmFtkqgJQlgdLr/t0Ugr
         HYovY36boKnL2lg9nC1pgR+80NCmjnI8jpKlO6iHsSfaJi23ntOHmgd1d7jKkdZlU1wH
         4flAwn6BrgC9Fh5CcpfCVA7Su5lCmiaKTTI0GHc7cvGciJfWXlV47VpGAYF7q/Pj7GMk
         VhYAFXmRE4c19kXPvV6kTJ/VEOEj7p90WJmf9cNieRYlCmAU7dm66VaDQuxOM0qUkyeJ
         laEg==
X-Gm-Message-State: AOAM53027K/RCyC6OZ6MTCcF6NvXaJ2sq7jBjCC0UCPP/qCCCT9ckQT1
        HR0NsFUOzjqTdK+l7EPxgpM=
X-Google-Smtp-Source: ABdhPJyDgvg6arfypbKJjGrfCEVPwrJXeBR3QGkGNPtYZc4CCDRysB90RjiOBS4/5HzvwK83G4SfGQ==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr2954274pfb.0.1592473921435;
        Thu, 18 Jun 2020 02:52:01 -0700 (PDT)
Received: from home-desktop ([114.204.138.55])
        by smtp.gmail.com with ESMTPSA id s26sm2045206pga.80.2020.06.18.02.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 02:52:00 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:51:55 +0900
From:   Hyeonki Hong <hhk7734@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: odroid: add spicc0 controller node
Message-ID: <20200618095150.GA9713@home-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enabled spicc0 controller node with annotations describing the
physical SPI0 pin number based on the 40 pin header on the Odroid
board.

Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 26 +++++++++++++++++--
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 24 ++++++++++++++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 169ea283d4ee..ec6d345caaae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -16,8 +16,9 @@
 	model = "Hardkernel ODROID-N2";
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
+		spi0 = &spicc0
 	};
 
 	chosen {
@@ -328,7 +329,7 @@
 
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
-		/* Realtek RTL8211F (0x001cc916) */	
+		/* Realtek RTL8211F (0x001cc916) */
 		reg = <0>;
 		max-speed = <1000>;
 
@@ -451,6 +452,27 @@
 	vqmmc-supply = <&flash_1v8>;
 };
 
+&spicc0 {
+	status = "okay";
+
+	/*
+	 * 40 Pin Header : MOSI(GPIOX.8->19 Pin),
+	 *		   MISO(GPIOX.9->21 Pin),
+	 *		   SPI0_CLK(GPIOX.11->23 Pin)
+	 *		   SPI_CE0(GPIOX.10->24 Pin),
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&spicc0_x_pins>, <&spicc0_ss0_x_pins>;
+
+	spidev@0 {
+		compatible = "spidev";
+		status = "okay";
+		/* spi default max clock 100Mhz */
+		spi-max-frequency = <100000000>;
+		reg = <0>;
+	};
+};
+
 /*
  * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR pins
  * and eMMC Data 4 to 7 pins.
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 00d90b30f8b4..f809b2ba6b15 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -14,8 +14,9 @@
 	model = "Hardkernel ODROID-C4";
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
+		spi0 = &spicc0;
 	};
 
 	chosen {
@@ -381,6 +382,27 @@
 	vqmmc-supply = <&flash_1v8>;
 };
 
+&spicc0 {
+	status = "okay";
+
+	/*
+	 * 40 Pin Header : MOSI(GPIOX.8->19 Pin),
+	 *		   MISO(GPIOX.9->21 Pin),
+	 *		   SPI0_CLK(GPIOX.11->23 Pin)
+	 *		   SPI_CE0(GPIOX.10->24 Pin),
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&spicc0_x_pins>, <&spicc0_ss0_x_pins>;
+
+	spidev@0 {
+		compatible = "spidev";
+		status = "okay";
+		/* spi default max clock 100Mhz */
+		spi-max-frequency = <100000000>;
+		reg = <0>;
+	};
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.17.1

