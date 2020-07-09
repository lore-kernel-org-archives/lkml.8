Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B218C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550C02076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZgxOC2Nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGIKJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGIKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:09:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306EC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:09:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so826023pfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GlKmsDfajxoEQByZOU5laddM+m8R3hyzOJ5BtugjyA=;
        b=ZgxOC2Nd/ApA88je5yBcpc9Ofy0XTv1qaOqaM2LgoF5nrY2gQIyEUloi3cuXzoKTkU
         FgZCXrLLmdMtz7cetjP8E9GUgTC6/46za5unv8FS8whvyB4r2U4oflBHp7WFxZu3o4mH
         05RPcQXMGA+gjPbxSMRHCTpsF1F5YDVEfdcjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GlKmsDfajxoEQByZOU5laddM+m8R3hyzOJ5BtugjyA=;
        b=KIQRoH+xylrlPUgsusNzOWA6Ivhk7tjnvvDB9Fz1On3l5CbFsHggmVTQn9IEFIEEZz
         Bw/HH036aPcCO80fXzS8MucFTo0pOYWES+CjKnsVPQ0F4ItR7KUUYKNmYqJNB6l8d/iP
         MGi9fneAKHGMpKCszdTdrc1mM9noBVb/jQXikJD2ZpX5OL7rzQYNCiYFVux2cR8hk5nS
         O3h07/b/ERnKKaCfCUlMzhtaRIPKlKxIBylucSurjnhT09dFeqL+380WQGP0IKy/R3Fv
         xfRxYovPtmY9GpPGSC2jJ/uleJeleEvRSbcVT4hNgkEdGvbzS2HEItU3mhEe+x8IbGWX
         55/w==
X-Gm-Message-State: AOAM5331NQU1tFwVrg6u0gs52eDPM5dHq1+mIB8yLz4+4Bauv31kcU2i
        VYmYvgs6WW6v9PMfqmBf1jNsoQ==
X-Google-Smtp-Source: ABdhPJx98eePyp9PISK9UGdM3tfv7KmgA1FG9qO8+7Uv+P/rZJ3Sa3hBy4G4Sb2+7iIPmzVrMzKPHQ==
X-Received: by 2002:a63:2d44:: with SMTP id t65mr43760200pgt.257.1594289349091;
        Thu, 09 Jul 2020 03:09:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:24b9:69b0:e917:1d11])
        by smtp.gmail.com with ESMTPSA id ji2sm2076527pjb.1.2020.07.09.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:09:08 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/4] arm64: dts: rockchip: Trivial cleanups for RockPI N10
Date:   Thu,  9 Jul 2020 15:37:53 +0530
Message-Id: <20200709100756.42384-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709100756.42384-1-jagan@amarulasolutions.com>
References: <20200709100756.42384-1-jagan@amarulasolutions.com>
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
Changes for v5:
- drop redundent hym8563_int pin
Changes for v4:
- move i2c2 into rk3399pro dtsi
Changes for v3:
- move hym8563_int into rk3399pro dtsi
Changes for v2:
- updated commit message
- add more trivial changes

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 67 +++++++------
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  2 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 93 ++++++++++---------
 3 files changed, 80 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index df3712aedf8a..450e5bb5af0b 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -8,36 +8,44 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	chosen {
-		stdout-path = "serial2:1500000n8";
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
 	};
-};
 
-&gmac {
-	status = "okay";
-};
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
 
-&i2c1 {
-	status = "okay";
-	i2c-scl-rising-time-ns = <140>;
-	i2c-scl-falling-time-ns = <30>;
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
 };
 
-&i2c2 {
+&gmac {
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
-	clock-frequency = <400000>;
-
-	hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&hym8563_int>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
-	};
 };
 
 &pwm0 {
@@ -52,10 +60,8 @@ &sdmmc {
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
@@ -70,12 +76,3 @@ &uart0 {
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
index 0a516334f15f..9ed5b27d715c 100644
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
 
@@ -61,17 +38,8 @@ &emmc_phy {
 
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
 };
 
 &i2c0 {
@@ -297,16 +265,53 @@ regulator-state-mem {
 	};
 };
 
-&io_domains {
+&i2c1 {
+	i2c-scl-rising-time-ns = <140>;
+	i2c-scl-falling-time-ns = <30>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
 	status = "okay";
+
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&io_domains {
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
@@ -317,17 +322,13 @@ &sdhci {
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

