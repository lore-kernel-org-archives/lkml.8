Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E9722CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wqBUHvS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHGMoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:44:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHGMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:44:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 077CiJPA062485;
        Fri, 7 Aug 2020 07:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596804259;
        bh=lDv+rz9EfFabGbg1monOFONKn2sVmApnjb4a5bSPdRQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wqBUHvS6WUvCFmJcMWAzsna5CdEiZUBITLhl49HyyJVTtagbTZPGEewUzcV3YScsZ
         ABf2I4LuX3DFhn4P8ZiF4YMVESZIKHu/M1w4MFZPoIw/vMoyKamPKBI8tTf5hM4CoW
         ZC7DTzXauinAwDVbpgOs8wvFCT0JTKzwzObO57SM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 077CiJkn000401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Aug 2020 07:44:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 7 Aug
 2020 07:44:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 7 Aug 2020 07:44:19 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 077CiCeG072818;
        Fri, 7 Aug 2020 07:44:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j7200: Add HyperBus node
Date:   Fri, 7 Aug 2020 18:14:06 +0530
Message-ID: <20200807124407.12604-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807124407.12604-1-vigneshr@ti.com>
References: <20200807124407.12604-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 has a Flash SubSystem that has one OSPI and one HyperBus.. Add
DT nodes for HyperBus controller for now.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  8 ++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 94a797bbcdaf0..106c774dc224a 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -114,4 +114,31 @@ wkup_i2c0: i2c@42120000 {
 		clocks = <&k3_clks 197 1>;
 		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
 	};
+
+	fss: system-controller@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x47000000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hbmc_mux: hbmc-mux {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+		};
+
+		hbmc: hyperbus@47034000 {
+			compatible = "ti,am654-hbmc";
+			reg = <0x0 0x47034000 0x0 0x100>,
+				<0x5 0x00000000 0x1 0x0000000>;
+			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+			clocks = <&k3_clks 102 0>;
+			assigned-clocks = <&k3_clks 102 5>;
+			assigned-clock-rates = <333333333>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			mux-controls = <&hbmc_mux 0>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index aadf707f25f5c..ba27f6641137e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -139,7 +139,9 @@ cbass_main: bus@100000 {
 			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
-			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>;
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
 			compatible = "simple-bus";
@@ -155,7 +157,9 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>; /* FSS OSPI0/1 data region 0 */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
+				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
+				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
 };
-- 
2.28.0

