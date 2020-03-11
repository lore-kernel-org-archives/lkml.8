Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC7AC18E5C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3878821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yu5/OhSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgCKMfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:35:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgCKMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:35:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so1915400wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtTX7EM1d6h/uC42my2sgJ8i9nRiLu7iFeIbg2tcgXs=;
        b=yu5/OhSa/aCJePUy90xslVuooEX+/2dj6XTUQ9x7U9JYlXGW+WfmKPxMCS+RWVjuvR
         6kNhPVOzM20irZoWcPIXC5Sz6nFgJWXfHIIHVRNnOQ+CH2QjGYOxVwDqdMnemSdu8UWu
         SS3RnmzWsAfwCUmEQn1YG7/P8rH/Xcq/nM+rxlzrM9E5L5fIzCumYWqigHRV30BHW4wu
         oXqKF365o8dY95kRIy87qF6Jqa2obcnwRb1Rs14OigKZxHiqxsYCcNo61A/I2XNDJl40
         QDzt54WS9MeV0GKTgCOFB9RO5P2iRPr+RUbfDZ0R6g6pUn6mMcrUHSHxmM5H589w5PRC
         Xxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtTX7EM1d6h/uC42my2sgJ8i9nRiLu7iFeIbg2tcgXs=;
        b=etAQuw1cq0x5ulliDzgPs9BtZ7WDh7D0xw2kgFuSQ5LiJLy8UCjVfRgSktcS/byVrK
         yZUtmbkvNh/9iJgFT+spc1TrTF3N3ArcFQ8AkHyHzNofTvYU6Nk+N6nRpy9hAR09vyro
         lrNiquBzktZkZ3nhZ61imzSmH+2nFFoMIRsOebw7NaZkWRsnzWcr42PoWPzKsH6NtpZD
         i66wxSsDfLndl4XAqg9fxs1v9KR1xiz6Tgi9vsrlq8dJ6DaSfevEmUwP09PatFXcwSQ1
         oUlyoBlvMRj/hG1hD6X5rxb3n1jhuGaffVN6/1j95kAVw3HBJrgeNawVXY4ZELezJ6+3
         mhkg==
X-Gm-Message-State: ANhLgQ3/bon+0as4jPsMAH+YuZFU2D9gLFsu6wgzIl6zCGBaJuNfMOxW
        TKbX0fcLF6/ij8+HaDoTEGWOaQ==
X-Google-Smtp-Source: ADFU+vtnvILyF3Zc67x9wUJYRN0XGPqBQlx8RvzSHeYOfi2xFeqCC0M6n6wEo9V7OBH9XYdtbFiQWw==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr3596215wma.124.1583930110019;
        Wed, 11 Mar 2020 05:35:10 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:9087:3e80:4ebc:ae7b])
        by smtp.gmail.com with ESMTPSA id m25sm7822732wml.35.2020.03.11.05.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:35:09 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v1 3/6] arm64: dts: sdm845: Add i2c-qcom-cci node
Date:   Wed, 11 Mar 2020 13:34:58 +0100
Message-Id: <20200311123501.18202-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311123501.18202-1-robert.foss@linaro.org>
References: <20200311123501.18202-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdm845 SOC ships with a CCI controller, which
has two CCI/I2C buses.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts |   4 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 110 +++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index eb77aaa6a819..a6b6837c3d68 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -583,3 +583,7 @@
 		bias-pull-up;
 	};
 };
+
+&cci {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d42302b8889b..b7f5c0b0f6af 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,camcc-sdm845.h>
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gpucc-sdm845.h>
@@ -717,6 +718,14 @@
 			#power-domain-cells = <1>;
 		};
 
+		clock_camcc: clock-controller@ad00000 {
+			compatible = "qcom,sdm845-camcc";
+			reg = <0 0xad00000 0 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		qfprom@784000 {
 			compatible = "qcom,qfprom";
 			reg = <0 0x00784000 0 0x8ff>;
@@ -1451,6 +1460,60 @@
 			gpio-ranges = <&tlmm 0 0 150>;
 			wakeup-parent = <&pdc_intc>;
 
+			cci0_default: cci0_default {
+				/* SDA, SCL */
+				pinmux {
+					function = "cci_i2c";
+					pins = "gpio17", "gpio18";
+				};
+				pinconf {
+					pins = "gpio17", "gpio18";
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci0_sleep: cci0_sleep {
+				/* SDA, SCL */
+				mux {
+					pins = "gpio17", "gpio18";
+					function = "cci_i2c";
+				};
+
+				config {
+					pins = "gpio17", "gpio18";
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+			};
+
+			cci1_default: cci1_default {
+				/* SDA, SCL */
+				pinmux {
+					function = "cci_i2c";
+					pins = "gpio19", "gpio20";
+				};
+				pinconf {
+					pins = "gpio19", "gpio20";
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci1_sleep: cci1_sleep {
+				/* SDA, SCL */
+				mux {
+					pins = "gpio19", "gpio20";
+					function = "cci_i2c";
+				};
+
+				config {
+					pins = "gpio19", "gpio20";
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+			};
+
 			qspi_clk: qspi-clk {
 				pinmux {
 					pins = "gpio95";
@@ -2608,6 +2671,53 @@
 			#reset-cells = <1>;
 		};
 
+		cci: cci@ac4a000 {
+			compatible = "qcom,sdm845-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0xac4a000 0 0x4000>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&clock_camcc TITAN_TOP_GDSC>;
+
+			clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_SOC_AHB_CLK>,
+				<&clock_camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&clock_camcc CAM_CC_CPAS_AHB_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK_SRC>;
+			clock-names = "camnoc_axi_clk",
+				"soc_ahb_clk",
+				"slow_ahb_src_clk",
+				"cpas_ahb_clk",
+				"cci",
+				"cci_clk_src";
+
+			assigned-clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_CCI_CLK>;
+			assigned-clock-rates = <80000000>, <37500000>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			pinctrl-1 = <&cci0_sleep &cci1_sleep>;
+
+			status = "disabled";
+
+			i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sdm845-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.20.1

