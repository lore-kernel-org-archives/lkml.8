Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D45C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12820207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="Jz5eH0q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:21:04 -0400
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:34075 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgFAPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:21:03 -0400
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 0EBD2140B0C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:59:21 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id fluIj0Hsb1EW3fluKjqZtY; Mon, 01 Jun 2020 08:59:21 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A7RCwZeG c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=nTHF0DUjJn0A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=tc3lRw1TNdAtvppHo30A:9 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uGpPtGD5guWyECwZUeBfjXBAvd5ClJYPl0nP9lYGbZ4=; b=Jz5eH0q3EFaj5DLbKCDIR3RUao
        9ezFc7HytHeVurNN1as0vq4vpkxDes4DLGAFaq5GcdUqsjwzcfFsJyXyzxCZukUy7xTXetVYeYHiD
        ZWMwMU0QO4mu88IDbYf7avipiuMB00ljnO+npgrF4OfdwmaZ61dVNlojKetiwUbE/1hcZKvZd9+oS
        pxsEqbzNtlspnGLRW8Z3epv6C/vhJb671Hh1GiQ8YzijKcu5pOMKpLBxfhBnMZyaQOqP/rnOT6eWM
        qF7U/EFlEy/uNblGZQBSJgDA0koWgqC9rspkcipoQsL50uDLfeG5M5DrxR3nZleMBpjNJdFc261gB
        70fdslrQ==;
Received: from dslb-002-205-073-081.002.205.pools.vodafone-ip.de ([2.205.73.81]:57650 helo=arch.fritz.box)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <parthiban@linumiz.com>)
        id 1jfluH-0007Bg-Gz; Mon, 01 Jun 2020 14:59:17 +0000
From:   Parthiban Nallathambi <parthiban@linumiz.com>
To:     m.felsch@pengutronix.de, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH v2 2/2] ARM: dts: imx6ull: add MYiR MYS-6ULX SBC
Date:   Mon,  1 Jun 2020 16:58:57 +0200
Message-Id: <20200601145857.5658-2-parthiban@linumiz.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601145857.5658-1-parthiban@linumiz.com>
References: <20200601145857.5658-1-parthiban@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 2.205.73.81
X-Source-L: No
X-Exim-ID: 1jfluH-0007Bg-Gz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: dslb-002-205-073-081.002.205.pools.vodafone-ip.de (arch.fritz.box) [2.205.73.81]:57650
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 31
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MYiR imx6ULL based single board computer
equipped with on board 256MB NAND & RAM. The board also
provides expansion header for expansion board, but this
commit adds only support for SBC.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---

Notes:
    Changelog v2:
    - moved regulator under root node
    - status property removed

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/imx6ull-myir-mys-6ulx-nand.dts   |  19 ++
 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi  | 238 ++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..eab86051d782 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -612,6 +612,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ull-myir-mys-6ulx-nand.dtb \
 	imx6ull-opos6uldev.dtb \
 	imx6ull-phytec-segin-ff-rdk-nand.dtb \
 	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
new file mode 100644
index 000000000000..43e072671ca4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linumiz
+ * Author: Parthiban Nallathambi <parthiban@linumiz.com>
+ */
+
+/dts-v1/;
+#include "imx6ull.dtsi"
+#include "imx6ull-myir-mys-6ulx.dtsi"
+
+/ {
+	model = "MYiR i.MX6ULL MYS-6ULX Single Board Computer with NAND";
+	compatible = "myir,imx6ull-mys-6ulx-nand", "myir,imx6ull-mys-6ulx",
+		     "fsl,imx6ull";
+};
+
+&gpmi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
new file mode 100644
index 000000000000..03365a1ca8e6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linumiz
+ * Author: Parthiban Nallathambi <parthiban@linumiz.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "MYiR MYS-6ULX Single Board Computer";
+	compatible = "myir,imx6ull-mys-6ulx", "fsl,imx6ull";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	reg_vdd_5v: regulator-vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_vdd_3v3: regulator-vdd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vdd_5v>;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	phy-supply = <&reg_vdd_3v3>;
+	status = "okay";
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			interrupt-parent = <&gpio5>;
+			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	keep-power-in-suspend;
+	vmmc-supply = <&reg_vdd_3v3>;
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x0b0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x0b0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0x0b0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x0b000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x0b0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x0b0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x0b0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x0b0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x0b0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x0b0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x0b0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x0b0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x0b0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0x0b0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usbotg1idgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
+		>;
+	};
+};
-- 
2.26.2

