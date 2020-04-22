Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6718C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12C820735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nj229JH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDVJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:15:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35122 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDVJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:15:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03M9Fsj0039617;
        Wed, 22 Apr 2020 04:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587546954;
        bh=2nTyf4kIFJt1q2fpNAVmctL88e8DgCyZPbnv1uC0QKM=;
        h=From:To:CC:Subject:Date;
        b=nj229JH9/FDtiZuz7PZXz7If5DBlo+jc6hxxvbwhgxefBo7wLffKX+qx0vao8s1iI
         KTAx8uFazigzlP4Yx0Ui6vcSUNPeQPk+VL7obaTpkp9wpsCCdL2QIoyNAT09HBdRsq
         2mvkvlEDOsI7QF/gTLQqSAIjfM1SsDQLEQ3lxVok=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03M9FsSU057556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 04:15:54 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Apr 2020 04:15:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Apr 2020 04:15:53 -0500
Received: from deskari.lan (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M9FpLK050948;
        Wed, 22 Apr 2020 04:15:52 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: am654: Add DSS node
Date:   Wed, 22 Apr 2020 12:15:10 +0300
Message-ID: <20200422091512.950-1-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jyri Sarha <jsarha@ti.com>

Add DSS node to k3-am65-main.dtsi with labels for board specific
support and syscon node for oldi-io-ctrl.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 11887c72f23a..7d1bc991708e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -287,6 +287,11 @@
 			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
 					<0x4090 0x3>; /* SERDES1 lane select */
 		};
+
+		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
+			compatible = "syscon";
+			reg = <0x0000041E0 0x14>;
+		};
 	};
 
 	dwc3_0: dwc3@4000000 {
@@ -746,4 +751,43 @@
 			};
 		};
 	};
+
+	dss: dss@04a00000 {
+		compatible = "ti,am65x-dss";
+		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
+			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
+			<0x0 0x04a06000 0x0 0x1000>, /* vid */
+			<0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
+			<0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
+			<0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
+			<0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+		reg-names = "common", "vidl1", "vid",
+			"ovr1", "ovr2", "vp1", "vp2";
+
+		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+
+		clocks =	<&k3_clks 67 1>,
+				<&k3_clks 216 1>,
+				<&k3_clks 67 2>;
+		clock-names = "fck", "vp1", "vp2";
+
+		/*
+		 * Set vp2 clk (DPI_1_IN_CLK) mux to PLL4 via
+		 * DIV1. See "Figure 12-3365. DSS Integration"
+		 * in AM65x TRM for details.
+		 */
+		assigned-clocks = <&k3_clks 67 2>;
+		assigned-clock-parents = <&k3_clks 67 5>;
+
+		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
+
+		status = "disabled";
+
+		dss_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

