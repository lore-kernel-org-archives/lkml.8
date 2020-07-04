Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23019C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E817B208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kCsTO3lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgGDUQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgGDUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:16:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8587C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:16:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so9709537pgm.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LJ8XZzAMnwatcyvnEIkzckG/GwAtPASUgyz1CJ13Rc=;
        b=kCsTO3lA3ieOUq9zeqMMeexmoUdpZs009CatJCQw5nNaNfKjEU77VxiBfZBDINQNlO
         W9MMK/liGnpYYuqk9lIlE5aUGeyTMz5+IuX7uXeWlbvOe4DF3ccRCcpdGsaC/fH3ysy3
         jGDiFem26/91MQ9R+5Tq4JI7uxDEZTChVafJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LJ8XZzAMnwatcyvnEIkzckG/GwAtPASUgyz1CJ13Rc=;
        b=kuwFgqpSluiQw3JuQecWPKLU/f9fLf9G1OkEXaO9cX5UMMZZEwrNS1avb8LJpoY9Di
         FbS6r1DfNYBxhiqljEWtd3iqazgIjhY4VnOA4JCpigNzbGp2VN12J+6tpyIULI2MNuOa
         lo5pPJxDh4N/40dkXO3WFhiMwp3eln49N2Z3yp5HaoSmsG1ARceETy7n6JRthzZOe/LX
         cX9SPBb7aUVKsEU/JzwKaiKtSzT7YB+yS08WHmHjsfyu+3piYyJUNW30JLKrCAhSbELe
         z9d1iTgjvLjW7A7ZnE8kaCGqjxUAQBYYCuq49D1kUCz6idBLRWIqAsPVU6p/dL72a6DH
         x1xA==
X-Gm-Message-State: AOAM533yjUFeqrXSjZyCqwa+8BfQZw4Sm5H/L3JmA1m9axeb4cNX4X3/
        ic69hYMxAN4NeCanSPPhJTgg0WozR6aY8A==
X-Google-Smtp-Source: ABdhPJxuHHJR9PBLuVbrjR+paZuoQ20kMmZLHfZzgrzc44z1KLL2EIhBALqYDdJgR1WG5q+ibaBMpg==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr35090427pge.131.1593893780036;
        Sat, 04 Jul 2020 13:16:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:bdf4:3289:4b66:dcc0])
        by smtp.gmail.com with ESMTPSA id d16sm14960791pfo.156.2020.07.04.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 13:16:19 -0700 (PDT)
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
Subject: [PATCH v3 1/4] arm64: dts: rockchip: Trivial cleanups for RockPI N10
Date:   Sun,  5 Jul 2020 01:46:01 +0530
Message-Id: <20200704201604.85343-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704201604.85343-1-jagan@amarulasolutions.com>
References: <20200704201604.85343-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa dalang carrier boards are used to mount vmarc SoM's
of rk3399pro and rk3288 to make complete SBC.

So, this patch adds trivial changes to properties.
- move common properties into radxa dalang carrier dtsi.
- maintain ascending order for nodes, properties.
- change the order of dtsi include so-that common properties
  will reflect in main dts.
- drop unnecessary header includes.

No functionally changes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- move hym8563_int into rk3399pro dtsi
Changes for v2:
- updated commit message
- add more trivial changes

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 60 ++++++++++-----
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  2 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 75 +++++++------------
 3 files changed, 73 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index df3712aedf8a..6330ede90e35 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -8,24 +8,55 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	chosen {
-		stdout-path = "serial2:1500000n8";
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 };
 
 &gmac {
+	assigned-clock-parents = <&clkin_gmac>;
+	clock_in_out = "input";
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
 	status = "okay";
 };
 
 &i2c1 {
-	status = "okay";
 	i2c-scl-rising-time-ns = <140>;
 	i2c-scl-falling-time-ns = <30>;
+	status = "okay";
 };
 
 &i2c2 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
 
 	hym8563: hym8563@51 {
 		compatible = "haoyu,hym8563";
@@ -35,8 +66,14 @@ hym8563: hym8563@51 {
 		clock-output-names = "hym8563";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
+		};
 	};
 };
 
@@ -52,10 +89,8 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vqmmc-supply = <&vccio_sd>;
-	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
@@ -70,12 +105,3 @@ &uart0 {
 &uart2 {
 	status = "okay";
 };
-
-&pinctrl {
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins =
-				<4 RK_PD6 0 &pcfg_pull_up>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
index a1783e7f769a..539f4005386d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -8,8 +8,8 @@
 /dts-v1/;
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
-#include "rk3399pro-vmarc-som.dtsi"
 #include <arm/rockchip-radxa-dalang-carrier.dtsi>
+#include "rk3399pro-vmarc-som.dtsi"
 
 / {
 	model = "Radxa ROCK Pi N10";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 0a516334f15f..9d1dadb94380 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -7,35 +7,12 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/pwm/pwm.h>
 
 / {
 	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
 
-	clkin_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "clkin_gmac";
-		#clock-cells = <0>;
-	};
-
-	vcc12v_dcin: vcc12v-dcin-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
-	vcc5v0_sys: vcc5v0-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
+	chosen {
+		stdout-path = "serial2:1500000n8";
 	};
 };
 
@@ -61,17 +38,13 @@ &emmc_phy {
 
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
-	assigned-clock-parents = <&clkin_gmac>;
-	clock_in_out = "input";
 	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
 	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 50000>;
-	tx_delay = <0x28>;
-	rx_delay = <0x11>;
+};
+
+&hym8563 {
+	interrupt-parent = <&gpio4>;
+	interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &i2c0 {
@@ -298,15 +271,29 @@ regulator-state-mem {
 };
 
 &io_domains {
-	status = "okay";
 	bt656-supply = <&vcca_1v8>;
 	sdmmc-supply = <&vccio_sd>;
 	gpio1830-supply = <&vccio_3v0>;
+	status = "okay";
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
+		};
+	};
 };
 
 &pmu_io_domains {
-	status = "okay";
 	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
 };
 
 &sdhci {
@@ -317,17 +304,13 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	max-frequency = <150000000>;
+};
+
 &tsadc {
-	status = "okay";
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <1>;
-};
-
-&pinctrl {
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins =
-				<1 RK_PC2 0 &pcfg_pull_up>;
-		};
-	};
+	status = "okay";
 };
-- 
2.25.1

