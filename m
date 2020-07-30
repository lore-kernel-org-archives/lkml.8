Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDEDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BC32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YARnas2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgG3T01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:26:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50628 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgG3T0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:26:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UJQJm0071187;
        Thu, 30 Jul 2020 14:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596137179;
        bh=dICZaxW7nAg7yU8SCtRm8369DoZ5oZuasg4IjX9S+Yo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YARnas2hcYX3zq728rhEilM12keQGwt/mMSLjng3BNLGOE2fAx6PxCwOKeqabe/PX
         ABn7hIFefVNxWVDV6RMjAy6LttLq1pRihWVqfn5TOHl/CHmjhxI3fCRFYZL169jVJm
         ElBJBXfPiHruHwNE+kqHuCu4DCmMBVQQZMTUAj8o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UJQI40044612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 14:26:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 14:26:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 14:26:18 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UJQCpA052740;
        Thu, 30 Jul 2020 14:26:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: j7200: Add I2C nodes
Date:   Fri, 31 Jul 2020 00:55:59 +0530
Message-ID: <20200730192600.1872-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730192600.1872-1-vigneshr@ti.com>
References: <20200730192600.1872-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 has 7 I2Cs main domain, 2 I2Cs in MCU and one in wakeup domain.
Add DT nodes of the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 77 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 ++++++++
 2 files changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 70c8f7e941fbf..0a87fa3ea5f0c 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -196,4 +196,81 @@ main_uart9: serial@2890000 {
 		clocks = <&k3_clks 286 2>;
 		clock-names = "fclk";
 	};
+
+	main_i2c0: i2c@2000000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2000000 0x0 0x100>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 187 1>;
+		power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
+	};
+
+	main_i2c1: i2c@2010000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2010000 0x0 0x100>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 188 1>;
+		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c2: i2c@2020000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2020000 0x0 0x100>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 189 1>;
+		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c3: i2c@2030000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2030000 0x0 0x100>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 190 1>;
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c4: i2c@2040000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2040000 0x0 0x100>;
+		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 191 1>;
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c5: i2c@2050000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2050000 0x0 0x100>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 192 1>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c6: i2c@2060000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2060000 0x0 0x100>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 193 1>;
+		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 670e4c7cd9fed..94a797bbcdaf0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -81,4 +81,37 @@ mcu_uart0: serial@40a00000 {
 		clocks = <&k3_clks 149 2>;
 		clock-names = "fclk";
 	};
+
+	mcu_i2c0: i2c@40b00000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x40b00000 0x0 0x100>;
+		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 194 1>;
+		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcu_i2c1: i2c@40b10000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x40b10000 0x0 0x100>;
+		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 195 1>;
+		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	wkup_i2c0: i2c@42120000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x42120000 0x0 0x100>;
+		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 197 1>;
+		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
+	};
 };
-- 
2.28.0

