Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152DC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E107206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gHU8fJRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgDVJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:16:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35120 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:16:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03M9FuWX039623;
        Wed, 22 Apr 2020 04:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587546956;
        bh=dNvSGT1wK7FqmmMIv0DXJvpt/K/XiMrcfZIuQNKMZoU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gHU8fJRlkVioBD5ocF1v6qnpuItA3nabYtjFOtvTPAWbjMADwvHMRWGGcRmjFQxAg
         C8KhKobVFY0eD6ca4mopKc5D3QhgYTNPt7MCit/nJ4gCH5cohMXiV+PEqYneOG+AV2
         7wyygqfU5E+6bVnTDp2FXKDNyhvTPKPgvmRGZoyQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03M9FuUc057570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 04:15:56 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Apr 2020 04:15:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Apr 2020 04:15:55 -0500
Received: from deskari.lan (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M9FpLL050948;
        Wed, 22 Apr 2020 04:15:54 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j721e-main.dtsi: Add DSS node
Date:   Wed, 22 Apr 2020 12:15:11 +0300
Message-ID: <20200422091512.950-2-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422091512.950-1-tomi.valkeinen@ti.com>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSS node for J721E SoC.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 57 +++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0b9d14b838a1..21c362042ecf 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -736,6 +736,63 @@
 		};
 	};
 
+	dss: dss@04a00000 {
+		compatible = "ti,j721e-dss";
+		reg =
+			<0x00 0x04a00000 0x00 0x10000>, /* common_m */
+			<0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
+			<0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
+			<0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
+
+			<0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
+			<0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
+			<0x00 0x04a50000 0x00 0x10000>, /* vid1 */
+			<0x00 0x04a60000 0x00 0x10000>, /* vid2 */
+
+			<0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
+			<0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
+			<0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
+			<0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
+
+			<0x00 0x04a80000 0x00 0x10000>, /* vp1 */
+			<0x00 0x04aa0000 0x00 0x10000>, /* vp2 */
+			<0x00 0x04ac0000 0x00 0x10000>, /* vp3 */
+			<0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+			<0x00 0x04af0000 0x00 0x10000>; /* wb */
+
+		reg-names = "common_m", "common_s0",
+			"common_s1", "common_s2",
+			"vidl1", "vidl2","vid1","vid2",
+			"ovr1", "ovr2", "ovr3", "ovr4",
+			"vp1", "vp2", "vp3", "vp4",
+			"wb";
+
+		clocks =	<&k3_clks 152 0>,
+				<&k3_clks 152 1>,
+				<&k3_clks 152 4>,
+				<&k3_clks 152 9>,
+				<&k3_clks 152 13>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+
+		status = "disabled";
+
+		dss_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	mcasp0: mcasp@2b00000 {
 		compatible = "ti,am33xx-mcasp-audio";
 		reg = <0x0 0x02b00000 0x0 0x2000>,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

