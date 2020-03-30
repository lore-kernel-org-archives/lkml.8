Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9216C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBAF20776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgC3MGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:06:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgC3MGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:06:53 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jItBj-0001ON-Sp; Mon, 30 Mar 2020 14:06:43 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jItBi-0002a0-PG; Mon, 30 Mar 2020 14:06:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 5/5] ARM: dts: add Protonic RVT board
Date:   Mon, 30 Mar 2020 14:06:40 +0200
Message-Id: <20200330120640.9810-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330120640.9810-1-o.rempel@pengutronix.de>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protonic RVT is an internal development platform for a wireless ISObus
Virtual Terminal based on COTS tablets, and the predecessor of the WD2
platform.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts           | 203 ++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 424be1edf005..2e8a03ef5c95 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -168,6 +168,7 @@ properties:
               - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - prt,prtrvt                # Protonic RVT board
               - prt,prtvt7                # Protonic VT7 board
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e53abe1de259..afaccc9bc645 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -446,6 +446,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-mira-rdk-nand.dtb \
 	imx6dl-phytec-pbab01.dtb \
+	imx6dl-prtrvt.dtb \
 	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
new file mode 100644
index 000000000000..cf097437b276
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2014 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Protonic RVT board";
+	compatible = "prt,prtrvt", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x10000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-debug0 {
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-0 = <&pinctrl_can1 &pinctrl_can1phy>;
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "winbond,w25q64", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "boot";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "env";
+				reg = <0x80000 0x10000>;
+			};
+
+			partition@90000 {
+				label = "spare";
+				reg = <0x90000 0x370000>;
+			};
+		};
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	nfc@0 {
+		compatible = "ti,trf7970a";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nfc>;
+		spi-max-frequency = <2000000>;
+		interrupts-extended = <&gpio5 14 IRQ_TYPE_LEVEL_LOW>;
+		ti,enable-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>,
+				  <&gpio5 11 GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_3v3>;
+		vin-voltage-override = <3100000>;
+		autosuspend-delay = <30000>;
+		irq-status-read-quirk;
+		en2-rf-quirk;
+		t5t-rmb-extra-byte-quirk;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* nc */
+		channel@4 {
+			reg = <4>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* nc */
+		channel@5 {
+			reg = <5>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* can1_l */
+		channel@6 {
+			reg = <6>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* can1_h */
+		channel@7 {
+			reg = <7>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "disabled";
+};
+
+&vpu {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_can1phy: can1phy {
+		fsl,pins = <
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12	0x13070
+			/* CAN1_TERM */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+			/* CS */
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x000b1
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
+			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
+			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x000b1
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x1b0b0
+		>;
+	};
+
+	pinctrl_nfc: nfcgrp {
+		fsl,pins = <
+			/* NFC_ASK_OOK */
+			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09	0x100b1
+			/* NFC_PWR_EN */
+			MX6QDL_PAD_DISP0_DAT16__GPIO5_IO10	0x100b1
+			/* NFC_EN2 */
+			MX6QDL_PAD_DISP0_DAT17__GPIO5_IO11	0x100b1
+			/* NFC_EN */
+			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x100b1
+			/* NFC_MOD */
+			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x100b1
+			/* NFC_IRQ */
+			MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x100b1
+		>;
+	};
+};
-- 
2.26.0.rc2

