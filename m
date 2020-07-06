Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00363C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD83620656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b436+BJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgGFRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:35:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA86C061755;
        Mon,  6 Jul 2020 10:35:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so35835326edm.10;
        Mon, 06 Jul 2020 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75wBNRUQlyoyn+et0eU0+R20gtwFMvzcUg5dnes97w8=;
        b=b436+BJjPpxWmCR8JXphYQVDLtrpH8n41zszz/SyLjkWSy0lZCIGS2YJc+8CNWW4Q2
         Qwr99M/RF0GfjtwcaLZldiUHN2lFjUqhVn2H5ppKh5hF+Zk72xP96+PLQ7FM/7UX2A+p
         cSA9XSS48BTrfKlMu40XPdCdGziaCOZpO5H1c53s3ueOqjw57GuAETPy76JCaI1+LNJM
         FuNEETAKgbwQzwjX1V1IBk9W3l3O7kK+C13srzPkjhOZBlR+QQTyzNWnmO/h048B5hph
         aQmUjDoJJuIuWJk7ayhHpcoQ1OO9docbI/J/7n7DAyXt11fS3B3rnouME728fYHHma5X
         WJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75wBNRUQlyoyn+et0eU0+R20gtwFMvzcUg5dnes97w8=;
        b=dx+JqHQxcVSIjxCr2eUkY+qPzhsEt/uUy+9PyQLmFPCe76oA6/sNNt9KHOgDqe9zms
         DcpYh9gUQDmp2HPr8DXsb77J10r2b5aTl/K+tI660fffdh2wlCZ8u4mf6P9LVL1RNTyC
         Kqt3HbddgB73MGREed7fdxih8ygyIHqqH0e5F84cSIOnanUSFPzQyjfCyJ18xeuI0aJ0
         GoYMbDlvQtEbTKwlZ5gIEQsCt3GVk8XYodzy/qytgGyNO3KdwJOqNM+2PeqWdjvJibCN
         DqEGk+0B6nSu/tvXf4P3aOIX0+heGGTT6soYdAjx5m9BUq4jbGgDnpUELenooAZOKIpK
         WlnA==
X-Gm-Message-State: AOAM532n8Hr6Uk2cACU689D6ZoU0vfMvI5eljP4vS2wEOvH3N1z8GcVf
        2AoeJU/44XIML7srIKz3yOI=
X-Google-Smtp-Source: ABdhPJyCJFXO9xaxw9ncO2GC3OnA558JL1s7k3OB93Cat1pRLBrxdBl1vyOpd+PK56vlbOT2CRnFsA==
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr41940858edb.262.1594056913572;
        Mon, 06 Jul 2020 10:35:13 -0700 (PDT)
Received: from localhost.localdomain (asp78.neoplus.adsl.tpnet.pl. [83.26.227.78])
        by smtp.gmail.com with ESMTPSA id y22sm16556258ejj.67.2020.07.06.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:35:13 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: stm32: add initial support for stm32mp157-odyssey board
Date:   Mon,  6 Jul 2020 19:33:49 +0200
Message-Id: <20200706173353.20525-3-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
References: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Seeed Studio's stm32mp157c odyssey board.
Board consists of SoM with stm32mp157c with 4GB eMMC and 512 MB DDR3 RAM
and carrier board with USB and ETH interfaces, SD card connector,
wifi and BT chip AP6236.

In this patch only basic kernel boot is supported and interfacing
SD card and on-board eMMC.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
---
 .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 276 ++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  72 +++++
 2 files changed, 348 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey.dts

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
new file mode 100644
index 000000000000..620ff9e7f370
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
+ */
+
+/dts-v1/;
+
+#include "stm32mp157.dtsi"
+#include "stm32mp15xc.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+/ {
+	model = "Seeed Studio Odyssey-STM32MP157C SOM";
+	compatible = "seeed,stm32mp157c-odyssey-som", "st,stm32mp157";
+
+	memory@c0000000 {
+		reg = <0xc0000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mcuram2: mcuram2@10000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10000000 0x40000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@10040000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10040000 0x1000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@10041000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10041000 0x1000>;
+			no-map;
+		};
+
+		vdev0buffer: vdev0buffer@10042000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10042000 0x4000>;
+			no-map;
+		};
+
+		mcuram: mcuram@30000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x30000000 0x40000>;
+			no-map;
+		};
+
+		retram: retram@38000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x38000000 0x10000>;
+			no-map;
+		};
+
+		gpu_reserved: gpu@d4000000 {
+			reg = <0xd4000000 0x4000000>;
+			no-map;
+		};
+	};
+
+	led {
+		compatible = "gpio-leds";
+		blue {
+			label = "heartbeat";
+			gpios = <&gpiog 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
+};
+
+&gpu {
+	contiguous-area = <&gpu_reserved>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pmic: stpmic@33 {
+		compatible = "st,stpmic1";
+		reg = <0x33>;
+		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		status = "okay";
+
+		regulators {
+			compatible = "st,stpmic1-regulators";
+			ldo1-supply = <&v3v3>;
+			ldo3-supply = <&vdd_ddr>;
+			ldo6-supply = <&v3v3>;
+			pwr_sw1-supply = <&bst_out>;
+			pwr_sw2-supply = <&bst_out>;
+
+			vddcore: buck1 {
+				regulator-name = "vddcore";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd_ddr: buck2 {
+				regulator-name = "vdd_ddr";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd: buck3 {
+				regulator-name = "vdd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				st,mask-reset;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			v3v3: buck4 {
+				regulator-name = "v3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+				regulator-initial-mode = <0>;
+			};
+
+			v1v8_audio: ldo1 {
+				regulator-name = "v1v8_audio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO1 0>;
+			};
+
+			v3v3_hdmi: ldo2 {
+				regulator-name = "v3v3_hdmi";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO2 0>;
+			};
+
+			vtt_ddr: ldo3 {
+				regulator-name = "vtt_ddr";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <750000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			vdd_usb: ldo4 {
+				regulator-name = "vdd_usb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				interrupts = <IT_CURLIM_LDO4 0>;
+			};
+
+			vdda: ldo5 {
+				regulator-name = "vdda";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <2900000>;
+				interrupts = <IT_CURLIM_LDO5 0>;
+				regulator-boot-on;
+			};
+
+			v1v2_hdmi: ldo6 {
+				regulator-name = "v1v2_hdmi";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO6 0>;
+			};
+
+			vref_ddr: vref_ddr {
+				regulator-name = "vref_ddr";
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			 bst_out: boost {
+				regulator-name = "bst_out";
+				interrupts = <IT_OCP_BOOST 0>;
+			 };
+
+			vbus_otg: pwr_sw1 {
+				regulator-name = "vbus_otg";
+				interrupts = <IT_OCP_OTG 0>;
+			 };
+
+			 vbus_sw: pwr_sw2 {
+				regulator-name = "vbus_sw";
+				interrupts = <IT_OCP_SWOUT 0>;
+				regulator-active-discharge;
+			 };
+		};
+
+		onkey {
+			compatible = "st,stpmic1-onkey";
+			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
+			interrupt-names = "onkey-falling", "onkey-rising";
+			power-off-time-sec = <10>;
+			status = "okay";
+		};
+
+		watchdog {
+			compatible = "st,stpmic1-wdt";
+			status = "disabled";
+		};
+	};
+};
+
+&ipcc {
+	status = "okay";
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&m4_rproc {
+	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+			<&vdev0vring1>, <&vdev0buffer>;
+	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
+	mbox-names = "vq0", "vq1", "shutdown";
+	interrupt-parent = <&exti>;
+	interrupts = <68 1>;
+	status = "okay";
+};
+
+&rng1 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	vqmmc-supply = <&v3v3>;
+	mmc-ddr-3_3v;
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
new file mode 100644
index 000000000000..6c1b091af14f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
+ */
+
+/dts-v1/;
+
+#include "stm32mp157c-odyssey-som.dtsi"
+
+/ {
+	model = "Seeed Studio Odyssey-STM32MP157C Board";
+	compatible = "seeed,stm32mp157c-odyssey", "st,stm32mp157";
+
+	aliases {
+		ethernet0 = &ethernet0;
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rgmii-id";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_pins_sleep_a>;
+	i2c-scl-rising-time-ns = <100>;
+	i2c-scl-falling-time-ns = <7>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+	status = "okay";
+};
+
-- 
2.26.2

