Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E36206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nrhqPqHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgGHGg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgGHGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:36:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F2C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:36:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so742935pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqXQRBtFUvoVchZPgi3sQ7HBGlGFCLxiz0gQ606yhhc=;
        b=nrhqPqHU8Ew1tem+ET900N0rAZ8037gM4UK1X3nvg7/cA5v1h1iiOBENu1pfdw5V42
         u6yMDSls9X3GvE43cHYGCC4unrO6DQe+8lf8TNjv1pi/fr7/7bKbkeewN0iy0ga6uccc
         2Bj6/A0ETKr5cnBGAuvZBGDFXb6KIzkSQwu9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqXQRBtFUvoVchZPgi3sQ7HBGlGFCLxiz0gQ606yhhc=;
        b=DbLhYaOuqyz+vYcp7JHIMIvOEZVfy2zUe02PObSl6WEo8z/zJr3qsiOw1SLkvNvxDa
         ADXAzL6uMWTC36CcXyFeuVemFi5aAMH7w9A7RGHhTLJhMzY1qtLVAqfdoL4ggJhtzcY/
         +zv3fBLgI8UlaXqU3I6eXuDEfRG/5fcIngDW6ZgUtP0Dl7b7AVTWwvRluy70cBQjgUqd
         +riJZEPjuSuCSxB+luhb/7W3kPTsirTgLfLQw5hdeYto9IoqAM2myYfjxx/VIZPxSYDm
         s99VCQ1DUCgWuWMx/HEDH9VqQLJsTthCO1Y1nUwuYTfqLSBRS/TzZq2P5PBC1AKNQmOk
         qTrw==
X-Gm-Message-State: AOAM532idw2Y3Y5Zr5SpqLLfFtDLdrsD+j/wdYTL759AcvKXbo1p7xtZ
        bvDq+gB3tMiMjsEWaFBa5b0bZA==
X-Google-Smtp-Source: ABdhPJy1LA3H25DWZn/gbrhWKT5bnEmbHU4iAKQFPYT8o+u1BLrLSlLjDc+ftkaQa4kZSh6Ggea1bQ==
X-Received: by 2002:a17:90a:eaca:: with SMTP id ev10mr7772734pjb.151.1594190217851;
        Tue, 07 Jul 2020 23:36:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:ade2:f5f3:8cc0:52f9])
        by smtp.gmail.com with ESMTPSA id c12sm24587898pfn.162.2020.07.07.23.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:36:57 -0700 (PDT)
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
Subject: [PATCH v4 3/4] ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
Date:   Wed,  8 Jul 2020 12:06:26 +0530
Message-Id: <20200708063627.8365-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708063627.8365-1-jagan@amarulasolutions.com>
References: <20200708063627.8365-1-jagan@amarulasolutions.com>
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
Changes for v4, v3:
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

