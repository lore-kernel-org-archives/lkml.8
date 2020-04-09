Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAEFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C426921473
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSUeT22q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgDIEko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:40:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34118 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDIEkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:40:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so1818484lji.1;
        Wed, 08 Apr 2020 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV7vj17vcdQJ+jVfwxKNxZrPKUkrDS7t9FLm47yDnRw=;
        b=FSUeT22qW1aU2jRkIMS6j4cmQaUF633zAJzAcAz/QsRHHMjsOzkhj/7Q5iPEkbzQK2
         MKGCJyznLt+U9EN3OS8osdghXo2ga5lx9ISXcWMR4YKgyG7G1p9UqoiEUFROfjIrtOky
         rbyvc0NrIrsReCg9d8XBe3+t91Ni9IR4KzWzh/f0fS38JCsBDMkkWqi/WBQGFHDpxp3I
         aXbS+8fogKKujvx6N5QQhoZyORkG3I0Z19CN39/i6S+7b4HqM6ii/6PC7suxZGf+4/9y
         Tj2uZKH0gIvmwAuk85YAKn2aJ0D0bIEQGotdG3NF1ZMkXliqa8FqMIK9T2F0P35WZpA4
         td0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV7vj17vcdQJ+jVfwxKNxZrPKUkrDS7t9FLm47yDnRw=;
        b=YygFZ7T71RBsHXTjMDbpOjRmjE0480i2z4oqLlqt8fbx4bLaMQzaDFi6pOvn/jgUkC
         9LEuq4nOa2/dCS1J5YPaCyxNQAJem85sLImWvhpBO2HJvAGVk1fZihbU5XmkwNBNYfIP
         232bvQ3TbDTrYrBD5z46lgQif4yreG3rJ2aFkxZNBpWjWSRtY0GDopNXsX7Zon3YWuqA
         HZLDfXCDInulhaEzHWKyM9rr4ccky2LCzBHFijq8z9Id3rY1hEZwMhFVcJ82PbCQvJUv
         BXOTDDOcpgSTMgwf5Zic995XLybYY9a2EYFtEu1aFqTidfiQTf8HJnHJWAXSoFXKAPvl
         2ucQ==
X-Gm-Message-State: AGi0PubKmZk+7pN1nvr0jSchtGABlXNKijYjMPCamw2Di5eqYJPnByap
        0dXWZ3KF11hxcRlVu7PRvdx478WDSY0=
X-Google-Smtp-Source: APiQypJXknoq1mPgYK7B1fYLwzQQYuUWCdGN//zm2+ld19+GAJe00FzWgFzCtRM4Y6hXf4tpPpeX5A==
X-Received: by 2002:a2e:b8c1:: with SMTP id s1mr7323307ljp.0.1586407239863;
        Wed, 08 Apr 2020 21:40:39 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id h23sm12887893ljg.13.2020.04.08.21.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 21:40:39 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: kirkwood: Add Check Point L-50 board
Date:   Thu,  9 Apr 2020 06:38:48 +0200
Message-Id: <20200409043851.31217-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409043851.31217-1-paweldembicki@gmail.com>
References: <20200409043851.31217-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dts for the Check Point L-50 from 600/1100 series
routers.

Specification:
-CPU: Marvell Kirkwood 88F6821 1200MHz
-RAM: 512MB
-Flash: NAND 512MB
-WiFi: mPCIe card based on Atheros AR9287 b/g/n
-WAN: 1 Gigabit Port (Marvell 88E1116R PHY)
-LAN: 9 Gigabit Ports (2x Marvell 88E6171(5+3))
-USB: 2x USB2.0
-Express card slot
-SD card slot
-Serial console: RJ-45 115200 8n1
-Unsupported DSL

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/kirkwood-l-50.dts | 441 ++++++++++++++++++++++++++++
 2 files changed, 442 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-l-50.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..eba030b3ba69 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -279,6 +279,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-iomega_ix2_200.dtb \
 	kirkwood-is2.dtb \
 	kirkwood-km_kirkwood.dtb \
+	kirkwood-l-50.dtb \
 	kirkwood-laplug.dtb \
 	kirkwood-linkstation-lsqvl.dtb \
 	kirkwood-linkstation-lsvl.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-l-50.dts b/arch/arm/boot/dts/kirkwood-l-50.dts
new file mode 100644
index 000000000000..ab3a90287260
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-l-50.dts
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check Point L-50 Board Description
+ * Copyright 2020 Pawel Dembicki <paweldembicki@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+	model = "Check Point L-50";
+	compatible = "checkpoint,l-50", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = &uart0;
+	};
+
+	ocp@f1000000 {
+		pinctrl: pin-controller@10000 {
+			pinctrl-0 = <&pmx_led38 &pmx_sysrst &pmx_button29>;
+			pinctrl-names = "default";
+
+			pmx_sysrst: pmx-sysrst {
+				marvell,pins = "mpp6";
+				marvell,function = "sysrst";
+			};
+
+			pmx_button29: pmx_button29 {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_led38: pmx_led38 {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+
+			pmx_sdio_cd: pmx-sdio-cd {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+		};
+
+		serial@12000 {
+			status = "okay";
+		};
+
+		mvsdio@90000 {
+			status = "okay";
+			cd-gpios = <&gpio1 14 9>;
+		};
+
+		i2c@11000 {
+			status = "okay";
+			clock-frequency = <400000>;
+
+			gpio2: gpio-expander@20{
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "semtech,sx1505q";
+				reg = <0x20>;
+
+				gpio-controller;
+			};
+
+			/* Three GPIOs from 0x21 exp. are undescribed in dts:
+			 * 1: DSL module reset (active low)
+			 * 5: mPCIE reset (active low)
+			 * 6: Express card reset (active low)
+			 */
+			gpio3: gpio-expander@21{
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "semtech,sx1505q";
+				reg = <0x21>;
+
+				gpio-controller;
+			};
+
+			rtc@30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status_green {
+			label = "l-50:green:status";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+
+		status_orange {
+			label = "l-50:orange:status";
+			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+		};
+
+		wifi {
+			label = "l-50:green:wifi";
+			gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "phy0tpt";
+		};
+
+		internet_green {
+			label = "l-50:green:internet";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+		};
+
+		internet_red {
+			label = "l-50:red:internet";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+		};
+
+		usb1_green {
+			label = "l-50:green:usb1";
+			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port3>;
+		};
+
+		usb1_red {
+			label = "l-50:red:usb1";
+			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		};
+
+		usb2_green {
+			label = "l-50:green:usb2";
+			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port1>;
+		};
+
+		usb2_red {
+			label = "l-50:red:usb2";
+			gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	usb2_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "usb2_pwr";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 3 GPIO_ACTIVE_LOW>;
+		enable-active-low;
+		regulator-always-on;
+	};
+
+	usb1_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_pwr";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 4 GPIO_ACTIVE_LOW>;
+		enable-active-low;
+		regulator-always-on;
+	};
+
+	mpcie_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "mpcie_pwr";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	express_card_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "express_card_pwr";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	keys {
+		compatible = "gpio-keys-polled";
+		poll-interval = <20>;
+
+		factory_defaults {
+			label = "factory_defaults";
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy@8 {
+		reg = <0x08>;
+	};
+
+	switch0: switch@10 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10>;
+		dsa,member = <0 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "lan5";
+			};
+
+			port@1 {
+			       reg = <1>;
+			       label = "lan1";
+			};
+
+			port@2 {
+			       reg = <2>;
+			       label = "lan6";
+			};
+
+			port@3 {
+			       reg = <3>;
+			       label = "lan2";
+			};
+
+			port@4 {
+				reg = <4>;
+				label = "lan7";
+			};
+
+			switch0port5: port@5 {
+				reg = <5>;
+				phy-mode = "rgmii-txid";
+				link = <&switch1port5>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				label = "cpu";
+				phy-mode = "rgmii-id";
+				ethernet = <&eth1port>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+	switch@11 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x11>;
+		dsa,member = <0 1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "lan3";
+			};
+
+			port@1 {
+			       reg = <1>;
+			       label = "lan8";
+			};
+
+			port@2 {
+			       reg = <2>;
+			       label = "lan4";
+			};
+
+			port@3 {
+			       reg = <3>;
+			       label = "dmz";
+			};
+
+			switch1port5: port@5 {
+				reg = <5>;
+				phy-mode = "rgmii-txid";
+				link = <&switch0port5>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				label = "dsl";
+				fixed-link {
+					speed = <100>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port@0 {
+		phy-handle = <&ethphy0>;
+	};
+};
+
+&eth1 {
+	status = "okay";
+	ethernet1-port@0 {
+		speed = <1000>;
+		duplex = <1>;
+	};
+};
+
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition@0 {
+		label = "u-boot";
+		reg = <0x0000000 0xc0000>;
+	};
+
+	partition@a0000 {
+		label = "bootldr-env";
+		reg = <0x000c0000 0x40000>;
+	};
+
+	partition@100000 {
+		label = "kernel-1";
+		reg = <0x00100000 0x800000>;
+	};
+
+	partition@900000 {
+		label = "rootfs-1";
+		reg = <0x08200000 0x7100000>;
+	};
+
+	partition@7a00000 {
+		label = "kernel-2";
+		reg = <0x07a00000 0x800000>;
+	};
+
+	partition@8200000 {
+		label = "rootfs-2";
+		reg = <0x08200000 0x7100000>;
+	};
+
+	partition@f300000 {
+		label = "default_sw";
+		reg = <0x0f300000 0x7900000>;
+	};
+
+	partition@16c00000 {
+		label = "logs";
+		reg = <0x16c00000 0x1800000>;
+	};
+
+	partition@18400000 {
+		label = "preset_cfg";
+		reg = <0x18400000 0x100000>;
+	};
+
+	partition@18500000 {
+		label = "adsl";
+		reg = <0x18500000 0x100000>;
+	};
+
+	partition@18600000 {
+		label = "storage";
+		reg = <0x18600000 0x7A00000>;
+	};
+};
+
+&rtc {
+	status = "disabled";
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&sata_phy0 {
+	status = "disabled";
+};
+
+&sata_phy1 {
+	status = "disabled";
+};
+
+&usb0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	port@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+		#trigger-source-cells = <0>;
+
+		hub_port1: port@1 {
+			reg = <1>;
+			#trigger-source-cells = <0>;
+		};
+
+		hub_port3: port@3 {
+			reg = <3>;
+			#trigger-source-cells = <0>;
+		};
+	};
+};
-- 
2.20.1

