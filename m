Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5994F208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jQCfdmTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGDUQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGDUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:16:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF8C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:16:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so15326436pjc.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stgYGI05GMpLc1dby1HK3//+vvGghHGDspfaIVM0Hak=;
        b=jQCfdmTzeXwtADCl4lxTpNLHDh389qV8NNteF6tUVWvyeN69iAbygDki6BQdEghSkI
         JDluDEPAm/kYUmEnnyP44iDU/3cGMOzdinAJyMfbZ6SPLiAZZiICkipyQt9o0TXQIogY
         2J7VJKWdak1W1Q79llWfe7DECT2wUOV8KN4zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stgYGI05GMpLc1dby1HK3//+vvGghHGDspfaIVM0Hak=;
        b=mzmDjCkPjOaLPO1YcxSsab+kkon63QQmJPW+NJg1irLneDK3/uPMWwLBnuSyjs5RVO
         KHziNGliciHeTt8g9tVOqxQf8X5d++Qkis7Hi+utRXVGcQHpqsrY/nemPMgKi9Uzj8sd
         /ux/bnQZjrxPv81xrj4t6bkt86Mq+/WpS9keiFo4wUUk9MJcUhRStq7iKUsj25vq3N83
         a6O1om4axA6frPKBq6t6XfUEtmFrje7BzkWZmFnH6dGVZX/F9DmcL34NwKTktlPtLRpl
         WTifh2zJ1ox8cef5P/c/KaidC8MPnegoDg3VilID8jSSEdHLz7RuGOJy6e0uOZOpdaUt
         vZ0A==
X-Gm-Message-State: AOAM530RKdD7pIBV+CNWH6J28BDtDF9pmsDbPp1cMjoUjJjcew6IuxWf
        JSYs9Zc4dqaNooQWPPiZNkN9bg==
X-Google-Smtp-Source: ABdhPJzqQOwy8Un7ua1ZvaOFltBKpO2Elm7xIazzNRCRKeYizUFayIZBHzrIdapS4dlYECCqHh07Fg==
X-Received: by 2002:a17:90a:c915:: with SMTP id v21mr7975668pjt.48.1593893789294;
        Sat, 04 Jul 2020 13:16:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:bdf4:3289:4b66:dcc0])
        by smtp.gmail.com with ESMTPSA id d16sm14960791pfo.156.2020.07.04.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 13:16:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 3/4] ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
Date:   Sun,  5 Jul 2020 01:46:03 +0530
Message-Id: <20200704201604.85343-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704201604.85343-1-jagan@amarulasolutions.com>
References: <20200704201604.85343-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMARC RK3288 SOM is a standard SMARC SOM design with
Rockchip RK3288 SoC, which is designed by Vamrs.

Specification:
- Rockchip RK3288
- PMIC: RK808
- eMMC: 16GB/32GB/64GB
- SD slot
- 2xUSB-2.0, 1xUSB3.0
- USB-C for power supply
- Ethernet
- HDMI, MIPI-DSI/CSI, eDP

Add initial support for VMARC RK3288 SOM, this would use
with associated carrier board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- drop pwm include
- adjust dtsi based on trivial changes in 1/4

 arch/arm/boot/dts/rk3288-vmarc-som.dtsi | 270 ++++++++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-vmarc-som.dtsi

diff --git a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
new file mode 100644
index 000000000000..0bcb9f067d66
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Vamrs Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/ {
+	compatible = "vamrs,rk3288-vmarc-som", "rockchip,rk3288";
+
+	vccio_flash: vccio-flash-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_flash";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vccio_flash>;
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	phy-supply = <&vcc_io>;
+	snps,reset-gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int &global_pwroff>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc_io>;
+		vcc9-supply = <&vcc_io>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc5v0_sys>;
+		vcc12-supply = <&vcc_io>;
+		vddio-supply = <&vcc_io>;
+
+		regulators {
+			vdd_cpu: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-name = "vdd_arm";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-name = "vdd_gpu";
+				regulator-ramp-delay = <6000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_io";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_tp: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_tp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_codec: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcca_codec";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd_10: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd_10";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_wl: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_wl";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd10_lcd: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd10_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_18: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_18";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc18_lcd: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_sd: SWITCH_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_lcd: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&io_domains {
+	bb-supply = <&vcc_io>;
+	flash0-supply = <&vccio_flash>;
+	gpio1830-supply = <&vcc_18>;
+	gpio30-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&pinctrl {
+	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
+		drive-strength = <8>;
+	};
+
+	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
+		bias-pull-up;
+		drive-strength = <8>;
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_bus4: sdmmc-bus4 {
+			rockchip,pins =
+				<6 RK_PC0 1 &pcfg_pull_up_drv_8ma>,
+				<6 RK_PC1 1 &pcfg_pull_up_drv_8ma>,
+				<6 RK_PC2 1 &pcfg_pull_up_drv_8ma>,
+				<6 RK_PC3 1 &pcfg_pull_up_drv_8ma>;
+		};
+
+		sdmmc_clk: sdmmc-clk {
+			rockchip,pins = <6 RK_PC4 1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		sdmmc_cmd: sdmmc-cmd {
+			rockchip,pins = <6 RK_PC5 1 &pcfg_pull_up_drv_8ma>;
+		};
+	};
+};
-- 
2.25.1

