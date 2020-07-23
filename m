Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E70E20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pN1Fdy8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGWSth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:37 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10102 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgGWStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530171; x=1627066171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQ4wWOdIKVge/cPSYMb3D9ty6S2PPK3wNKVv4CCqRH8=;
  b=pN1Fdy8dANwQga2ubEy1mxICBN+vV1Mwgsb1WcGEkYxYKWUbyzRQYAV1
   NLqjE8y5wMTXKHOduEQsPoYme+2zauXBW+W5JstweFmiyWQ8B0AxeBkAX
   83AJ4pK3RTCCzRoR5KlZSEU1pv5LBARikzc7opur6z7Wc2VanA5ltTp/X
   tgJTEKRnGDjO7ZtJucl6RzcX193NjZd+3C1YQW1FVFud1J1Ko5n9LssNr
   AK2s+axoDtWw4q9kutgW+7fZmzuL5DQ2VXJNbeDOY1FmVwa4dOvNp/aOc
   Mwqjer9W0vgH8cyC//K1zbmgLwYB25/uckSNzUA5bIDPbDaMDYVR+0cxc
   Q==;
IronPort-SDR: AknoA4nJgGPw2/qOV9+YdphM4AjkYFphUHb4J3gNAxDTvR9kOJtGqKbPbDe5R9/Z5F/t1xlSoM
 Ot4gecwg9aLUaTNOGYRyvKgxAcaXBb6o/zzDq8s0FNEKjADYrxZvH0rXqg/G9Y19txZSDnrfRr
 HPFhGM/oupWzH7pYUKVQKLwnArBtvF81bYJc1pEycPguJltK9lA4ksmaT7fuW+wMYJijY8oesP
 nMPMvoLoLPuoDf5JUium4AmA4LJXTWQK43t1mQsbOU1pVb8ydEruOyVlvswXcbYHAbCc9+F1Wg
 xcg=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="20343958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:49:31 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:48 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v4 6/6] ARM: dts: at91: sam9x60ek: enable usb device
Date:   Thu, 23 Jul 2020 21:49:02 +0300
Message-ID: <20200723184902.416705-7-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723184902.416705-1-cristian.birsan@microchip.com>
References: <20200723184902.416705-1-cristian.birsan@microchip.com>
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

