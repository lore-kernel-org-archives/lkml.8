Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4C7C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1AD207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nlLzWBUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbgGVNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:48 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56907 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732528AbgGVNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595425485; x=1626961485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQ4wWOdIKVge/cPSYMb3D9ty6S2PPK3wNKVv4CCqRH8=;
  b=nlLzWBUDRwgIDh8+POxeg543AT3HANGaEFx4nLx7x+TJIkFukrdgBvka
   dMK/Ic91FNsK556fW7yeot43WYbVP8FZSKz+yBiOzh6Q9ES7vSxvxn8pF
   dqba0m2USMAwDO1es+WNEenvvstdQP5cxyfXVu0Ksy7QMc0CWf5nrJtDQ
   GgCyCGbbjQgM+senwEXoTwpnH53YYsGDmgueSKzV+oFGXQmxFVjpHobPJ
   Qh/HJxiF1VHSATMBWe8ayOqTai8Tc6P96YujjXrAYyPaUjSlJKPdtk5XQ
   jBLa3kG3zOLPqX0jXZtodiZvijOHOcs/4WU+v2HCIGxPqfpl6QbaHG2Yb
   g==;
IronPort-SDR: i+HSXrkki1DPvbMVjDVRBXRvxME0nWWWV776wU6w/EzuTmJ2XRr9NT6vx54gRpARLB6RHVJZ1L
 UtH8q8aqNmsUR8tlu3aHyJ15q8zW49rvXA4rxYQ/XxY5aaJDiRn703LPXhasKYM84kcij/fZLN
 eK0kk4LWYtTqHLa7r5N4NFL6AfGcbmCkCdU6DzqFjDiYkzRI76LlUyODkaETEWN3ICRQ9IIlXW
 z/SmAMbYSUJzCl3xGL/0ykT68CBngqoPRDg9qo+c+3IP+MkDB/+Rug6tROcMBOy+jClfilgyz3
 BzU=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="82819506"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 06:44:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 06:44:44 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 06:44:02 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v3 6/6] ARM: dts: at91: sam9x60ek: enable usb device
Date:   Wed, 22 Jul 2020 16:44:21 +0300
Message-ID: <20200722134421.190741-7-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722134421.190741-1-cristian.birsan@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Enable usb device for sam9x60ek board.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 13 +++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi       | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index a5f5718c711a..984cf596dfe9 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -559,6 +559,12 @@ pinctrl_key_gpio_default: pinctrl_key_gpio {
 			atmel,pins = <AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 		};
 	};
+
+	usb0 {
+		pinctrl_usba_vbus: usba_vbus {
+			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
 }; /* pinctrl */
 
 &pmc {
@@ -657,6 +663,13 @@ timer1: timer@1 {
 	};
 };
 
+&usb0 {
+	atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 6763423d64b8..ef0ef8625f25 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -69,6 +69,20 @@ ahb {
 		#size-cells = <1>;
 		ranges;
 
+		usb0: gadget@500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "microchip,sam9x60-udc";
+			reg = <0x00500000 0x100000
+				0xf803c000 0x400>;
+			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
+			clock-names = "pclk", "hclk";
+			assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>;
+			assigned-clock-rates = <480000000>;
+			status = "disabled";
+		};
+
 		usb1: ohci@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
-- 
2.25.1

