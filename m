Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86265C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AEB207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="A3Hyr7jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIBH6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:58:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45886 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgIBH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:57:42 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0827m8Q8032288;
        Wed, 2 Sep 2020 09:57:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=YojwehfIro8lj5y1pZczwwtLSghgdQ9RZAhgH6eo2q0=;
 b=A3Hyr7jrIBqHyVoK/6pHoW915zKJr6aPWtNeeL6V+iBPdiEhjIIO7jw5bwh5mpniUXic
 UlOF61BjAV+9kNTvdMNjJr3rxZXbHO42GbZc1fzT6RRjMc2bnab8yK4FU0f9LEnhSodf
 Mg3wSW7NPwYXSb5ftwN/U0FLVvpnp9xHoR9Hy/XIRQ8A3w1NJYr01HoYD5jXILPqLjmP
 +jAlT2QwL+ZX2Tpm59xIPHFjYbxPwMNWw5r+We+hUZfFuIrqDDJBYpfWigCs00LRLbED
 14UiZOLcphuH39AaId3ixai4stSD5ftSSjbEx6i6eP9fwNaCQLGN4NYMM1C0P6QOIDtJ wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337dwhc0fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 09:57:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24C0D10002A;
        Wed,  2 Sep 2020 09:57:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13CF4212FBA;
        Wed,  2 Sep 2020 09:57:22 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep 2020 09:57:21
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v2 5/6] ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
Date:   Wed, 2 Sep 2020 09:57:06 +0200
Message-ID: <20200902075707.9052-6-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902075707.9052-1-amelie.delaunay@st.com>
References: <20200902075707.9052-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for STUSB1600 USB Type-C port controller, used on
I2C4 on stm32mp15xx-dkx.
The default configuration on this board, on Type-C connector, is:
- Dual Power Role (DRP), so set power-role to "dual";
- Vbus limited to 500mA, so set power-opmode to "default" (it means 500mA
  in USB 2.0).
power-opmode is used to reconfigure the STUSB1600 advertising of current
capability when its NVM is not in line with the board layout.
On stm32mp15xx-dkx, Vbus power source of STUSB1600 is 5V_VIN (so add the
vin fixed 5V regulator too). So power operation mode depends on the power
supply used. To avoid any power issues, it is better to limit Vbus to 500mA
on this board.
ALERT# is the interrupt pin of STUSB1600. It needs an external pull-up, and
signal is active low.

USB OTG controller ID and Vbus signals are not connected on stm32mp15xx-dkx
boards, so disconnection are not detected.
Without DWC2 usb-role-switch:
- if you unplug the USB cable from the Type-C port, you have to manually
disconnect the USB gadget:
echo disconnect > /sys/devices/platform/soc/49000000.usb-otg/udc/49000000.usb-otg/soft_connect
- Then you can plug the USB cable again in the Type-C port, and manually
reconnect the USB gadget:
echo connect > /sys/devices/platform/soc/49000000.usb-otg/udc/49000000.usb-otg/soft_connect
With DWC2 usb-role-switch, USB gadget is dynamically disconnected or connected.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
No changes in v2.
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |  7 +++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   | 38 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index b5a66429670c..fe782afaf010 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1573,6 +1573,13 @@
 		};
 	};
 
+	stusb1600_pins_a: stusb1600-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 11, ANALOG)>;
+			bias-pull-up;
+		};
+	};
+
 	uart4_pins_a: uart4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index a5307745719a..589065223bf0 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -80,6 +80,14 @@
 		dais = <&sai2a_port &sai2b_port &i2s2_port>;
 		status = "okay";
 	};
+
+	vin: vin {
+		compatible = "regulator-fixed";
+		regulator-name = "vin";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -230,6 +238,30 @@
 	/delete-property/dmas;
 	/delete-property/dma-names;
 
+	stusb1600@28 {
+		compatible = "st,stusb1600";
+		reg = <0x28>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpioi>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&stusb1600_pins_a>;
+		status = "okay";
+		vdd-supply = <&vin>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			power-opmode = "default";
+
+			port {
+				con_usbotg_hs_ep: endpoint {
+					remote-endpoint = <&usbotg_hs_ep>;
+				};
+			};
+		};
+	};
+
 	pmic: stpmic@33 {
 		compatible = "st,stpmic1";
 		reg = <0x33>;
@@ -631,6 +663,12 @@
 	phy-names = "usb2-phy";
 	usb-role-switch;
 	status = "okay";
+
+	port {
+		usbotg_hs_ep: endpoint {
+			remote-endpoint = <&con_usbotg_hs_ep>;
+		};
+	};
 };
 
 &usbphyc {
-- 
2.17.1

