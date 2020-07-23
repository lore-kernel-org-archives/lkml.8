Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B315C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64A420792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CfsOzLVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgGWM1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:27:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36630 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgGWM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:26:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NCQtOx077159;
        Thu, 23 Jul 2020 07:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595507215;
        bh=0g2LMZT0IkwakLVVQj3IU02g5BOW4OVtcUOnGw6CFyw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CfsOzLVNaA/i6Pod2arPD7lCANIL02H9HHFhuKJl9rC/IlXmaf+fHR0Da+octU9Nt
         OcGgFHOm7G5m2rX+0r2jZdJ45m+CLPROYIW5QbtzB7SOnSFb+7hAm9Pqk4qlkk7boL
         Vd+OaGfV2JO65YsRWd1Io64dH2J3yoXv6xHibycg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06NCQtAd043037
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 07:26:55 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 07:26:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 07:26:55 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NCQooW024814;
        Thu, 23 Jul 2020 07:26:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
Date:   Thu, 23 Jul 2020 17:56:48 +0530
Message-ID: <20200723122649.24676-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723122649.24676-1-kishon@ti.com>
References: <20200723122649.24676-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe device tree node (both RC and EP) for the four
PCIe instances here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 218 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d14060207f00..2090fcf667a3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -28,6 +28,26 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_ctrl: pcie-ctrl@4070 {
+			compatible = "syscon";
+			reg = <0x00004070 0x4>;
+		};
+
+		pcie1_ctrl: pcie-ctrl@4074 {
+			compatible = "syscon";
+			reg = <0x00004074 0x4>;
+		};
+
+		pcie2_ctrl: pcie-ctrl@4078 {
+			compatible = "syscon";
+			reg = <0x00004078 0x4>;
+		};
+
+		pcie3_ctrl: pcie-ctrl@407c {
+			compatible = "syscon";
+			reg = <0x0000407c 0x4>;
+		};
+
 		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
@@ -552,6 +572,204 @@
 		};
 	};
 
+	pcie0_rc: pcie@2900000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 239 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie0_ep: pcie-ep@2900000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 239 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000 0x0 0x18001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000 0x0 0x18011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie2_rc: pcie@2920000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 241 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x20000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie2_ep: pcie-ep@2920000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 241 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie3_rc: pcie@2930000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 242 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x30000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie3_ep: pcie-ep@2930000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 242 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+		#address-cells = <2>;
+		#size-cells = <2>;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index d035b61e0e16..a934159d86a7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -132,9 +132,12 @@
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
-			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* PCIe Core*/
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* PCIe Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71 */
+			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT */
+			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT */
 			 <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
 			 <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>, /* C66_1 */
 			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
-- 
2.17.1

