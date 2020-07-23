Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62849C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407552080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="e/Dg+LR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGWMHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:07:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59703 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728436AbgGWMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:06:54 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NC5NHJ007521;
        Thu, 23 Jul 2020 14:06:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=nAXLB7m1msCYVcwfm/hTe40ubO9ITm6M7ic6gn2Tz54=;
 b=e/Dg+LR6g4QLg+SkLs29gNOYDmTLYc/IHC3O5Rgt5Q90PYL0GFGa09V7cb529M0lD9pL
 ngsH6Cbg0mq6+1n45LE+iI9dQjzHDWboNHd5kgj7GifT0N+g5KIIIUEVnhB0LuzXR2y4
 GpKETEOjlcmcs/kzB4ZxoKCRE2OGVAVQ9aq6hJm9zguAYVqNm3nLIeqHBJJyKHn7I2PF
 evIMZSBi1w6fVipAP4nke0NiPEuXaZZcuOnEFdY5/Ou3vaxITWmLa4xNkaW0PBtDcadr
 tAUrTpazGAx4lpFlWxGYOR4TYUx1SsMTQMS6M98YKP2yKfstCLVi3BxCV/yQxDbj85j6 bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bs6vabn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 14:06:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88DE7100034;
        Thu, 23 Jul 2020 14:06:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 770092AF314;
        Thu, 23 Jul 2020 14:06:38 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 14:06:38
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
Subject: [PATCH v2 5/6] ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
Date:   Thu, 23 Jul 2020 14:06:23 +0200
Message-ID: <20200723120624.26291-6-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723120624.26291-1-amelie.delaunay@st.com>
References: <20200723120624.26291-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_05:2020-07-23,2020-07-23 signatures=0
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
index 7eb858732d6d..55deaa52c3ee 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1574,6 +1574,13 @@
 		};
 	};
 
+	stusb1600_pins_a: stusb1600-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 11, ANALOG)>;
+			bias-pull-up;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 70db923a45f7..8d55f3fd06b3 100644
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
@@ -599,6 +631,12 @@
 	phys = <&usbphyc_port1 0>;
 	phy-names = "usb2-phy";
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

