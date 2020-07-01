Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A7420773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JqCkgof1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgGAGRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgGAGRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:17:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01520C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so8219462pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH9E3L0O7L+w/GPGtGgup8mLd4eqGKkz57JBYB7Djo4=;
        b=JqCkgof1GPM8of6xotndryKdvMWmbPO8VB8gecQ2gLVp8EJlM5kpw8oyDvw9Zo/JEt
         SEFIm75yDAXC1WhO/FxcfizwMbyEKXchvVd2ak5FJR0GIGldAQUA1LPVbiYePLEIAzUv
         u5fK9FCYYE8ZBN1XUi3Ne580pPM7P8jWYE4U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH9E3L0O7L+w/GPGtGgup8mLd4eqGKkz57JBYB7Djo4=;
        b=iLzNX1oY49/Q9lyQ6QJgN0CvheZLTNvsWiFhzk//xtXWPd+LPsexj1l5tGbXrkiadF
         nRHwhTcWAN6+bePLtQe6qMiRQAm619u2Xssw+hDXJlMlOvne0jWzCKxgv+IZ2YqDro6H
         EcizJ/7Njtqwcn4quA4fzBDSnunvMyE270/9LqtU0c7R1ONOxP/HHaofRSP9f0ZJtVMy
         aEyjJlHEnFF1+SWGzoP6bxxV0an3Hjf3H1FHDR1R780djqD8qDpRS6BR/Mo4aBmUfJal
         NYDzYVASa2wkIujvFnFL5ZQMpFxK/VhrSFu/LGaJUyOi5ua382vsAOsStjmdoKKEj8Yp
         evUg==
X-Gm-Message-State: AOAM533OdvK9MC+3Ylj8fdXdoxYn8ooD5tEBgC6ASQTmrFF7rz4WGAhJ
        pPYLFK5PuM89yFH6hE2O/WEgEA==
X-Google-Smtp-Source: ABdhPJz8vrukzAApgOh47xiKDiXWTFlnlPed7QN2bu0BiQ5HiBy/I26LHP1QH+YbCiNB6WEzSKkp1A==
X-Received: by 2002:aa7:8e90:: with SMTP id a16mr21628391pfr.84.1593584257374;
        Tue, 30 Jun 2020 23:17:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:356d:fc3d:92ff:192e])
        by smtp.gmail.com with ESMTPSA id n189sm4555744pfn.108.2020.06.30.23.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 23:17:36 -0700 (PDT)
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
Subject: [PATCH v2 1/4] arm64: dts: rockchip: Trivial cleanups for RockPI N10
Date:   Wed,  1 Jul 2020 11:47:14 +0530
Message-Id: <20200701061717.143753-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701061717.143753-1-jagan@amarulasolutions.com>
References: <20200701061717.143753-1-jagan@amarulasolutions.com>
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
Changes for v2:
- updated commit message
- add more trivial changes

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 58 ++++++++++++-----
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  2 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 64 ++++++-------------
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index df3712aedf8a..8b0b03681667 100644
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
@@ -40,6 +71,14 @@ hym8563: hym8563@51 {
 	};
 };
 
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
+		};
+	};
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -52,10 +91,8 @@ &sdmmc {
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
@@ -70,12 +107,3 @@ &uart0 {
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
index 0a516334f15f..0b150881ab6c 100644
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
@@ -298,15 +266,23 @@ regulator-state-mem {
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
@@ -317,17 +293,13 @@ &sdhci {
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

