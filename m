Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD1C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2467E206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392046AbgDPO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:56:12 -0400
Received: from mail.manjaro.org ([176.9.38.148]:33370 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394833AbgDPO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:56:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 735653702995;
        Thu, 16 Apr 2020 16:55:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Erx_frVr7CfS; Thu, 16 Apr 2020 16:55:57 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] arm64: dts: rockchip: add micro SD card regulator to rockpro64
Date:   Thu, 16 Apr 2020 16:55:34 +0200
Message-Id: <20200416145534.1263575-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the RockPro64's micro SD card regulator to the
RockPro64 dtsi. The regulator is present on all revisions of the
device.
Previously the regular was missing, resulting in unreliable boot
behaviour when booting from SD card.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 9bca25801260..6788ab28f89a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -96,6 +96,24 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};
 
+	/* micro SD card power */
+	vcc3v0_sd: vcc3v0-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc0_pwr_h>;
+		regulator-name = "vcc3v0_sd";
+		regulator-always-on;
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		vin-supply = <&vcc3v3_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -603,6 +621,13 @@ vsel2_gpio: vsel2-gpio {
 		};
 	};
 
+	sdcard {
+		sdmmc0_pwr_h: sdmmc0-pwr-h {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+	};
+
 	sdio-pwrseq {
 		wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -661,6 +686,8 @@ &sdmmc {
 	max-frequency = <150000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+	vmmc-supply = <&vcc3v0_sd>;
+	vqmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
-- 
2.26.0

