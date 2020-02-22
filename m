Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C161C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD401208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCeJQWqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgBVQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:25:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgBVQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:25:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so2941599pfh.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ToHubF4KECCMrwSTfQauUnB07RA2vKU+QmGUx0zj7dk=;
        b=DCeJQWqMYEktzqwzYPWXrCtBjxlTN8VoLK6rTnVSJ+DyThaYmZG4zMy3J0uAcv5Xl6
         NTFZV5I50yPOniS5gf0xWJH2PZ+CmoCgCyT0RGbxaOHZBpXWkLCoD58p/vpgq9wR7s6r
         vJwrEd4Qdlr+awqgO1zD6srjSxbvwRSNN/oYR4kEz8evxlBLsVi5CeOULy/e5DkSgF/b
         1wrr6XV6qrvNLX4R699w4FgeGpTYIIqQoIEH34dlqPzw2pbaP9tiidjLStIO1d5eAO3d
         KUlN4/nws3fNhI+lLEsiGP+3hu+n5gtOQgjkxmo4yB6uOAVRNUDoMnlaqrhHzsLUZXSk
         QVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ToHubF4KECCMrwSTfQauUnB07RA2vKU+QmGUx0zj7dk=;
        b=EY0/XqLlzQ5O8WoN1nfyRKDzx+Ek7TtVLAO8hqQ+HigZHbRDTgj8vYYc/R0mo+/v2/
         zPSBze3/W3OYMNCv+e0D2r8va2AbShIH7V41T8OEQ1rLNWROOwWfr5qkg0lfH53f+eT0
         oL+LlLB6YdgT1QuXOtnwbPjGpUdkVdISPSiMV0Oe9/wWc6SyJ+vFHBLi7C2qCvvzl1Mk
         x85ahM5MizvKbgcEKRwTPziKgLcStYyHHqjk3gU4co66zirfBuigcTGJY5jWnQG0L//3
         UoBn6Hq7VI2MJJw5uhEQESvuq9S+cewt1thHRZs6D07nyccRv7Zw5tu4nt34HbxWxKSx
         PUcg==
X-Gm-Message-State: APjAAAUYX1TTm2UFOgB/5A7HrK+z5I2Kyvr4fK8VAwfRcUWqgSGhfwsM
        Pt182M8C3RDR3PXTHm56+J0p
X-Google-Smtp-Source: APXvYqxqECy1swcSUk5Q/XFynMYjNqC7uwTEp6QMHAMY0oAVrNhg714YYtW+z6ull/nvzMusU+x6RQ==
X-Received: by 2002:a63:120f:: with SMTP id h15mr45746851pgl.235.1582388712857;
        Sat, 22 Feb 2020 08:25:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:801:b38c:89e8:305c:23c4:b77f])
        by smtp.gmail.com with ESMTPSA id q17sm6851296pfg.123.2020.02.22.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:25:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: mediatek: Add I2C support for MT6797 SoC
Date:   Sat, 22 Feb 2020 21:54:42 +0530
Message-Id: <20200222162444.11590-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C support for Mediatek MT6797 SoC. There are a total of 8 I2C
controllers in this SoC (2 being shared) and they are same as the
controllers present in MT6577 SoC. Hence, the driver support is added with
DT fallback method.

As per the datasheet, there are controllers with _imm prefix like i2c2_imm
and i2c3_imm. These appears to be in different memory regions but sharing
the same pins with i2c2 and i2c3 respectively. Since there is no clear
evidence of what they really are, I've adapted the numbering/naming scheme
from the downstream code by Mediatek.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 220 +++++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 2b2a69c7567f..22f093960d27 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -155,6 +155,62 @@
 					 <MT6797_GPIO233__FUNC_UTXD1>;
 			};
 		};
+
+		i2c0_pins_a: i2c0 {
+			pins0 {
+				pinmux = <MT6797_GPIO37__FUNC_SCL0_0>,
+					 <MT6797_GPIO38__FUNC_SDA0_0>;
+			};
+		};
+
+		i2c1_pins_a: i2c1 {
+			pins1 {
+				pinmux = <MT6797_GPIO55__FUNC_SCL1_0>,
+					 <MT6797_GPIO56__FUNC_SDA1_0>;
+			};
+		};
+
+		i2c2_pins_a: i2c2 {
+			pins2 {
+				pinmux = <MT6797_GPIO96__FUNC_SCL2_0>,
+					 <MT6797_GPIO95__FUNC_SDA2_0>;
+			};
+		};
+
+		i2c3_pins_a: i2c3 {
+			pins3 {
+				pinmux = <MT6797_GPIO75__FUNC_SDA3_0>,
+					 <MT6797_GPIO74__FUNC_SCL3_0>;
+			};
+		};
+
+		i2c4_pins_a: i2c4 {
+			pins4 {
+				pinmux = <MT6797_GPIO238__FUNC_SDA4_0>,
+					 <MT6797_GPIO239__FUNC_SCL4_0>;
+			};
+		};
+
+		i2c5_pins_a: i2c5 {
+			pins5 {
+				pinmux = <MT6797_GPIO240__FUNC_SDA5_0>,
+					 <MT6797_GPIO241__FUNC_SCL5_0>;
+			};
+		};
+
+		i2c6_pins_a: i2c6 {
+			pins6 {
+				pinmux = <MT6797_GPIO152__FUNC_SDA6_0>,
+					 <MT6797_GPIO151__FUNC_SCL6_0>;
+			};
+		};
+
+		i2c7_pins_a: i2c7 {
+			pins7 {
+				pinmux = <MT6797_GPIO154__FUNC_SDA7_0>,
+					 <MT6797_GPIO153__FUNC_SCL7_0>;
+			};
+		};
 	};
 
 	scpsys: scpsys@10006000 {
@@ -233,6 +289,170 @@
 		status = "disabled";
 	};
 
+	i2c0: i2c@11007000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <0>;
+		reg = <0 0x11007000 0 0x1000>,
+		      <0 0x11000100 0 0x80>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C0>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@11008000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <1>;
+		reg = <0 0x11008000 0 0x1000>,
+		      <0 0x11000180 0 0x80>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C1>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c8: i2c@11009000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <8>;
+		reg = <0 0x11009000 0 0x1000>,
+		      <0 0x11000200 0 0x80>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C2>,
+			 <&infrasys CLK_INFRA_AP_DMA>,
+			 <&infrasys CLK_INFRA_I2C2_ARB>;
+		clock-names = "main", "dma", "arb";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c9: i2c@1100d000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <9>;
+		reg = <0 0x1100d000 0 0x1000>,
+		      <0 0x11000280 0 0x80>;
+		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C3>,
+			 <&infrasys CLK_INFRA_AP_DMA>,
+			 <&infrasys CLK_INFRA_I2C3_ARB>;
+		clock-names = "main", "dma", "arb";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c6: i2c@1100e000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <6>;
+		reg = <0 0x1100e000 0 0x1000>,
+		      <0 0x11000500 0 0x80>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C_APPM>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c7: i2c@11010000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <7>;
+		reg = <0 0x11010000 0 0x1000>,
+		      <0 0x11000580 0 0x80>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C_GPUPM>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c4: i2c@11011000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <4>;
+		reg = <0 0x11011000 0 0x1000>,
+		      <0 0x11000300 0 0x80>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C4>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@11013000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <2>;
+		reg = <0 0x11013000 0 0x1000>,
+		      <0 0x11000400 0 0x80>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C2_IMM>,
+			 <&infrasys CLK_INFRA_AP_DMA>,
+			 <&infrasys CLK_INFRA_I2C2_ARB>;
+		clock-names = "main", "dma", "arb";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@11014000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <3>;
+		reg = <0 0x11014000 0 0x1000>,
+		      <0 0x11000480 0 0x80>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C3_IMM>,
+			 <&infrasys CLK_INFRA_AP_DMA>,
+			 <&infrasys CLK_INFRA_I2C3_ARB>;
+		clock-names = "main", "dma", "arb";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c@1101c000 {
+		compatible = "mediatek,mt6797-i2c",
+			     "mediatek,mt6577-i2c";
+		id = <5>;
+		reg = <0 0x1101c000 0 0x1000>,
+		      <0 0x11000380 0 0x80>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infrasys CLK_INFRA_I2C5>,
+			 <&infrasys CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		clock-div = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	mmsys: mmsys_config@14000000 {
 		compatible = "mediatek,mt6797-mmsys", "syscon";
 		reg = <0 0x14000000 0 0x1000>;
-- 
2.17.1

