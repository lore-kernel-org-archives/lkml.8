Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB52C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9092074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vIs0Yc4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEOLQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19651 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgEOLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541406; x=1621077406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bZ2JnU0EXObNl5L5pPijjp9Xg73ORZBTgLZoGKU0TPk=;
  b=vIs0Yc4y3Tmd4D7Xh8iOXvq8/Evh3/WLQmcIsJOBCrO9cRCp8APw4UuC
   gmGGCBTmU98C1AVl3kpfjvk0TCI4mEvqsX2hzDvIJpgFLOTA8wiu/jKla
   uhDr4/V0jcLFSC15IYCu7KoDAES7sS3Qgd8bVN+uX9nEzkNk8JqpxTjLI
   qWFY6TmKn4+MhMCTyhFmUTd9/JrmsvvKoy3hM6NUQU4SHMShZJIwxcl6A
   JxQDuudlsjkUDI8gjxp5QJFx9+P13dFu+Lw5KSgs0vfHLzlGbxqPqO6hS
   esXKSyAAnyAGmvT87dBhAssR42jQHk+64n+ig4phqRUH565vXTpoVCiuV
   Q==;
IronPort-SDR: XltXjzs+GU6yt//0omU6PmdLk2jQP5ZYtU64eC6H8VCmkAjLS49NYR8MzOiI46Jnogrfof4qVt
 ehDiHryI2RxBu5y7pXRfpiQPWJBnFDpYRG92vcKXEM5JWrOcnvnC6Z4oDH+2GVYHUXcrSsiJs7
 6ECz0+hv5J7AG9MVaAUeKLhbYxDbJp7uAhFfwWiWt97uVdFLfVxnTVQmSrNqj/F76fDcOfVVI4
 mPlaJXJY/asv87Ot5dBe+1VwcJPoQn1+vYOmGxAyMTh98NkWYB14wTJ+AmSy78BM1BNP8Y6fBm
 ERY=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="73566907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:45 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:42 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 7/7] ARM: dts: at91: sam9x60ek: enable usb device
Date:   Fri, 15 May 2020 14:16:31 +0300
Message-ID: <20200515111631.31210-8-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515111631.31210-1-cristian.birsan@microchip.com>
References: <20200515111631.31210-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Enable usb device for sam9x60ek board.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 13 +++++
 arch/arm/boot/dts/sam9x60.dtsi       | 74 ++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index b484745bf2d4..325d0fc8674f 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -547,6 +547,12 @@
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
@@ -634,6 +640,13 @@
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
index 6763423d64b8..5cd2b9054762 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -69,6 +69,80 @@
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
+
+			ep@0 {
+				reg = <0>;
+				atmel,fifo-size = <64>;
+				atmel,nb-banks = <1>;
+			};
+
+			ep@1 {
+				reg = <1>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+			};
+
+			ep@2 {
+				reg = <2>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <2>;
+				atmel,can-dma;
+			};
+
+			ep@3 {
+				reg = <3>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep@4 {
+				reg = <4>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep@5 {
+				reg = <5>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep@6 {
+				reg = <6>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+
+			ep@7 {
+				reg = <7>;
+				atmel,fifo-size = <1024>;
+				atmel,nb-banks = <3>;
+				atmel,can-dma;
+				atmel,can-isoc;
+			};
+		};
+
 		usb1: ohci@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
-- 
2.17.1

