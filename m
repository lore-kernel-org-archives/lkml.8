Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC0B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838262;
	bh=+UhVBmbMj6lt2RenvveVdDhvKup+dtdi1C8Rlc5YXQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H7oD2wQYXmnLquMmwPclnKgFzRBW2o1TPlPeuyKLkLV3q8bxTeeG2n2cUeUvocc9x
	 o+z/5lqT3ueYMu8MFntdu1amWB3B7VBvAO95KtSIxifb7fO1e23KaKYc8kZI/Mw0GH
	 +/guor429n8MeRFR4u1MzJPMIZbffuaFJF7lZLL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHSL5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgHSLtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:49:25 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72762312D;
        Wed, 19 Aug 2020 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837583;
        bh=+UhVBmbMj6lt2RenvveVdDhvKup+dtdi1C8Rlc5YXQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn3Rncg45FO46KGjrWfViln7lPI6scjaw6Qi6P1iGD4a5UGpsXydDEzVtlW1Xnnea
         sAjfuFU3NP3g/vxFtalAyXJqGAO4dWPjJVL/MCkcpbCJJ3PwcXBVpZvcpMsBs7JeGg
         GQuKo+Tp58wJSDZOU3q+Fl1D7NltMAf5XLGeEnUI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXt-00EucA-LD; Wed, 19 Aug 2020 13:46:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 46/49] dt: hisilicon: add support for the PMIC found on Hikey 970
Date:   Wed, 19 Aug 2020 13:46:14 +0200
Message-Id: <9df854e76bedc8726c634dee213f4520b6449b1e.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
on HiKey970 board.

As we now have support for it, change the fixed regulators
used by the SD I/O to use the proper LDO supplies.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  22 +-
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 197 ++++++++++++++++++
 2 files changed, 200 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 01234a175dcd..a9ad90e769ad 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -12,6 +12,7 @@
 
 #include "hi3670.dtsi"
 #include "hikey970-pinctrl.dtsi"
+#include "hikey970-pmic.dtsi"
 
 / {
 	model = "HiKey970";
@@ -39,23 +40,6 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
-	sd_1v8: regulator-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	sd_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	wlan_en: wlan-en-1-8v {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan-en-regulator";
@@ -402,8 +386,8 @@ &dwmmc1 {
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
 		     &sd_cfg_func>;
-	vmmc-supply = <&sd_3v3>;
-	vqmmc-supply = <&sd_1v8>;
+	vmmc-supply = <&ldo16>;
+	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
new file mode 100644
index 000000000000..843e841c7371
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
+ *
+ * Copyright (C) 2020, Huawei Tech. Co., Ltd.
+ */
+
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	spmi: spmi@fff24000 {
+		compatible = "hisilicon,kirin970-spmi-controller";
+		#address-cells = <2>;
+		#size-cells = <0>;
+		status = "ok";
+		reg = <0x0 0xfff24000 0x0 0x1000>;
+		spmi-channel = <2>;
+
+		pmic: pmic@0 {
+			compatible = "hisilicon,hi6421-spmi";
+			reg = <0 SPMI_USID>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpios = <&gpio28 0 0>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ldo3: ldo3@16 {
+					reg = <0x16>;
+					vsel-reg = <0x51>;
+
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <1500000>, <1550000>,
+							<1600000>, <1650000>,
+							<1700000>, <1725000>,
+							<1750000>, <1775000>,
+							<1800000>, <1825000>,
+							<1850000>, <1875000>,
+							<1900000>, <1925000>,
+							<1950000>, <2000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo4: ldo4@17 { /* 40 PIN */
+					reg = <0x17>;
+					vsel-reg = <0x52>;
+
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1900000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					hi6421-vsel = <0x52 0x07>;
+					voltage-table = <1725000>, <1750000>,
+							<1775000>, <1800000>,
+							<1825000>, <1850000>,
+							<1875000>, <1900000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo9: ldo9@1C { /* SDCARD I/O */
+					reg = <0x1C>;
+					vsel-reg = <0x57>;
+
+					regulator-name = "ldo9";
+					regulator-min-microvolt = <1750000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1750000>, <1800000>,
+							<1825000>, <2800000>,
+							<2850000>, <2950000>,
+							<3000000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <360>;
+				};
+
+				ldo15: ldo15@21 { /* UFS */
+					reg = <0x21>;
+					vsel-reg = <0x5c>;
+
+					regulator-name = "ldo15";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1800000>, <1850000>,
+							<2400000>, <2600000>,
+							<2700000>, <2850000>,
+							<2950000>, <3000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo16: ldo16@22 { /* SD */
+					reg = <0x22>;
+					vsel-reg = <0x5d>;
+
+					regulator-name = "ldo16";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <1800000>, <1850000>,
+							<2400000>, <2600000>,
+							<2700000>, <2850000>,
+							<2950000>, <3000000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <360>;
+				};
+
+				ldo17: ldo17@23 {
+					reg = <0x23>;
+					vsel-reg = <0x5e>;
+
+					regulator-name = "ldo17";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+
+					enable-mask = <0x01>;
+					idle-mode-mask = <0x10>;
+					eco-microamp = <10000>;
+
+					voltage-table = <2500000>, <2600000>,
+							<2700000>, <2800000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo33: ldo33@32 { /* PEX8606 */
+					reg = <0x32>;
+					vsel-reg = <0x6d>;
+					regulator-name = "ldo33";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <2500000>, <2600000>,
+							<2700000>, <2800000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+
+				ldo34: ldo34@33 { /* GPS AUX IN VDD */
+					reg = <0x33>;
+					vsel-reg = <0x6e>;
+
+					regulator-name = "ldo34";
+					regulator-min-microvolt = <2600000>;
+					regulator-max-microvolt = <3300000>;
+
+					enable-mask = <0x01>;
+
+					voltage-table = <2600000>, <2700000>,
+							<2800000>, <2900000>,
+							<3000000>, <3100000>,
+							<3200000>, <3300000>;
+					off-on-delay-us = <20000>;
+					startup-delay-us = <120>;
+				};
+			};
+		};
+	};
+};
-- 
2.26.2

