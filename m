Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C74AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33B7206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Wv1taZH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH2QAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgH2P6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C9C06123E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p15so1040546pli.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFWUvI1g88Xmv/vy89tzSMyNzoqDNXz7MdWqYQPONoQ=;
        b=Wv1taZH5KukCMM5bS0WeeABEvaBMzMc8CkN4a71i+rKLy68Zi/mHeWsZmzyrYd9wL5
         vdFRt/JqLjatwQMNDetZAwnZB130t1Xea7CID4NPkUgM0DxHeEVvRL9AX4QgFAbt4KfV
         aliaJ3yi8aiQi5qEgAwuVkf5wBqfjknHDT1Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFWUvI1g88Xmv/vy89tzSMyNzoqDNXz7MdWqYQPONoQ=;
        b=RFmkOcXOaso1FtK87LlmCHEpcj4YvAjzMPA68peChTJJG1Ie9S9buqhIt2Q2AVOLw8
         4Fih3mckWYk0vUybFHfC5AfQQ4l0+4isxvFKzfiTcw8RpmXG3d4wtnmke/vBhr4vD+rw
         DYs+ufoABNTrxWaMc62ostNv3NX5jo8SDl69wfSNYtFHf+hv1rnXt7+vIkhvmwheYCxy
         hFPvJhmG2MUmX6uDM1iRsW6pHBzwH63DQ78sCrD3b+kE0XYz53WaaCtDX2rT4vLPX7dc
         kYcz50WmcgFrZL8M7qMUwcucRhIdhVCzBUlmpyjykVB7t3t4IsH5Fy4epZ0S8X22fgog
         PUuw==
X-Gm-Message-State: AOAM532kGpI3VQXHqlTiFNFaE9+APh8pBV8quAATctn5vwTVpcJ4ujr1
        LokfxU3YkzzShX65JzUmhEEWIA==
X-Google-Smtp-Source: ABdhPJwAO5enZazZzwOOIDj2wo3gJj0jbGoMLFuTyOjc2T2bF4Wu8tXM2m3daQIz1CAo88u8+0fnew==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr3023204pln.279.1598716726408;
        Sat, 29 Aug 2020 08:58:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:45 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/7] arm64: dts: rockchip: Add Engicam PX30.Core SOM
Date:   Sat, 29 Aug 2020 21:28:19 +0530
Message-Id: <20200829155823.247360-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

General features:
- Rockchip PX30
- Up to 2GB DDR4
- eMMC 4 GB expandible
- rest of PX30 features

PX30.Core needs to mount on top of Engicam baseboards for creating
complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 .../boot/dts/rockchip/px30-px30-core.dtsi     | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi b/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
new file mode 100644
index 000000000000..05d9a801d7cf
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/ {
+	compatible = "engicam,px30-px30-core", "rockchip,px30";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <950000>;
+				regulator-name = "vdd_log";
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <950000>;
+				regulator-name = "vdd_arm";
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_ddr";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v3: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "vcc_3v3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc3v3_sys: DCDC_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_sys";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vcc_1v0";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_1v0: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd_1v0";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc3v0_pmu: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v0_pmu";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc5v0_host: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc5v0_host";
+			};
+		};
+	};
+};
+
+&io_domains {
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vcc_3v3>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc_3v3>;
+	pmuio2-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
-- 
2.25.1

