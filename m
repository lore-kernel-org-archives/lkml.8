Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A08F20759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MHDjPGtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEOOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:00:16 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46806 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589551215; x=1621087215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RYuYk2nK0gUCJ/sXARflJpI6XX3QksJ6uNvKcChd4mw=;
  b=MHDjPGtzUEwlEnB7MUuEFW6dC8H+K1ujN40Ih7cV9fJgxfL+8WLwFvms
   mz8qREtgU/AQeiikkIgVpC6r2KvVjbthg5t/5cN/eUclmDom9sv1DvfdD
   66fSl3HW6xaqI8avGAKgLiUtjrwDFiRjeGz4I/EYisQnrBrDCR7d1IoDa
   5TM7VdkzW2s8A7I/lY6XJrHgalHn8gA0wCgNCro7CVvc8G4dtB14Wce5y
   cw1e4InQ9dn7Qjkw3xfFlPRxSnd0yUsdhPVOMcpD1LP4p6ylho4s95BwA
   Wxn8aOC3pfQo7Svtpm9v52pffociRb7PaoJnJfos7rv5sEh0/5mIe0fJK
   g==;
IronPort-SDR: 7HCBGe2GHURrpUUzzZh6clIGKaIGH3sdDknjInDYLJJfq2nkGRUBKHW/oJQ2VAgNaHMchLJzsl
 xRTeBJ0mS6SKwyZh3ZYSgIVnbtIxdTP+HVzqldccjaKp0jltGJXIiotOHcEnJR5Bw3FjKVZSwG
 g77MnHQUi6SLJ69j/wz7nsuE1WLNClK23BpdSkwGZBylDAiR9PsGHG3CiF2Xcuih7Bhuspm9BN
 jC6AbSo56NQLIIdtYhG/FY81VklLgXZQMbca+cLmZ+2AOQuEg6/PHO4L2blx6YkhyT0/u+2M+E
 OrU=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="73579432"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 07:00:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 07:00:13 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 15 May 2020 07:00:05 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: dts: at91: Configure I2C SCL gpio as open drain
Date:   Fri, 15 May 2020 17:00:01 +0300
Message-ID: <20200515140001.287932-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCL gpio pin used by I2C bus for recovery needs to be configured as
open drain.

Fixes: 455fec938bbb ("ARM: dts: at91: sama5d2: add i2c gpio pinctrl")
Fixes: a4bd8da893a3 ("ARM: dts: at91: sama5d3: add i2c gpio pinctrl")
Fixes: 8fb82f050cf6 ("ARM: dts: at91: sama5d4: add i2c gpio pinctrl")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 6 +++---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 6 +++---
 arch/arm/boot/dts/sama5d3.dtsi              | 6 +++---
 arch/arm/boot/dts/sama5d4.dtsi              | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 32435ce1dab2..be33483013e7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -182,7 +182,7 @@ i2c0: i2c@f8028000 {
 				pinctrl-0 = <&pinctrl_i2c0_default>;
 				pinctrl-1 = <&pinctrl_i2c0_gpio>;
 				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 			};
 
@@ -203,7 +203,7 @@ i2c2: i2c@600 {
 					pinctrl-0 = <&pinctrl_flx0_default>;
 					pinctrl-1 = <&pinctrl_flx0_gpio>;
 					sda-gpios = <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
-					scl-gpios = <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PB29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 					atmel,fifo-size = <16>;
 					status = "okay";
 				};
@@ -234,7 +234,7 @@ i2c1: i2c@fc028000 {
 				pinctrl-0 = <&pinctrl_i2c1_default>;
 				pinctrl-1 = <&pinctrl_i2c1_gpio>;
 				sda-gpios = <&pioA PIN_PC6 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA PIN_PC7 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PC7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
 				at24@50 {
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e0c6cff1a312..862bf54376f1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -185,7 +185,7 @@ i2c0: i2c@f8028000 {
 				pinctrl-0 = <&pinctrl_i2c0_default>;
 				pinctrl-1 = <&pinctrl_i2c0_gpio>;
 				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				i2c-sda-hold-time-ns = <350>;
 				status = "okay";
 
@@ -390,7 +390,7 @@ i2c2: i2c@600 {
 					pinctrl-0 = <&pinctrl_flx4_default>;
 					pinctrl-1 = <&pinctrl_flx4_gpio>;
 					sda-gpios = <&pioA PIN_PD12 GPIO_ACTIVE_HIGH>;
-					scl-gpios = <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PD13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 					atmel,fifo-size = <16>;
 					i2c-analog-filter;
 					i2c-digital-filter;
@@ -408,7 +408,7 @@ i2c1: i2c@fc028000 {
 				i2c-digital-filter-width-ns = <35>;
 				pinctrl-1 = <&pinctrl_i2c1_gpio>;
 				sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA PIN_PD5 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
 				at24@54 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index f3ce561b46ab..c53e48445e4d 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -163,7 +163,7 @@ i2c0: i2c@f0014000 {
 				pinctrl-0 = <&pinctrl_i2c0>;
 				pinctrl-1 = <&pinctrl_i2c0_gpio>;
 				sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
@@ -181,7 +181,7 @@ i2c1: i2c@f0018000 {
 				pinctrl-0 = <&pinctrl_i2c1>;
 				pinctrl-1 = <&pinctrl_i2c1_gpio>;
 				sda-gpios = <&pioC 26 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioC 27 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioC 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
@@ -367,7 +367,7 @@ i2c2: i2c@f801c000 {
 				pinctrl-0 = <&pinctrl_i2c2>;
 				pinctrl-1 = <&pinctrl_i2c2_gpio>;
 				sda-gpios = <&pioA 18 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA 19 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index c9c0316b5b0e..fff679734c9c 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -462,7 +462,7 @@ i2c0: i2c@f8014000 {
 				pinctrl-0 = <&pinctrl_i2c0>;
 				pinctrl-1 = <&pinctrl_i2c0_gpio>;
 				sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
@@ -484,7 +484,7 @@ i2c1: i2c@f8018000 {
 				pinctrl-0 = <&pinctrl_i2c1>;
 				pinctrl-1 = <&pinctrl_i2c1_gpio>;
 				sda-gpios = <&pioE 29 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioE 30 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioE 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
@@ -529,7 +529,7 @@ i2c2: i2c@f8024000 {
 				pinctrl-0 = <&pinctrl_i2c2>;
 				pinctrl-1 = <&pinctrl_i2c2_gpio>;
 				sda-gpios = <&pioB 29 GPIO_ACTIVE_HIGH>;
-				scl-gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioB 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
-- 
2.25.1

