Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BCC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304D2208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OZO8R7FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEHI35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:29:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgEHI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:29:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488TqOe023311;
        Fri, 8 May 2020 03:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926592;
        bh=jcALnYcXc5HLiGeqGLSuje+R1aeUc2Rm5kp1+8sNXV0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OZO8R7FOwJpFCLeaHL0PiGLKCT1iMfT0oxmnbTn3oURgt+e8gCMA1b9N3X4ohNZHG
         H4dJIn92nkpf8c+XgVmBlq5cY6S2n9i8tGEMIEAS0VtCNNaoEiS4/UgE7GYqgb69qR
         hj3IDVzlkQPQ0c7Ft5fdXCehWWbBMOKvgcFKauDQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0488TqAW103060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 03:29:52 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:51 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TdnD073953;
        Fri, 8 May 2020 03:29:49 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/7] arm64: dts: ti: k3-j721e-main: Add system controller node and SERDES lane mux
Date:   Fri, 8 May 2020 11:29:34 +0300
Message-ID: <20200508082937.14171-5-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508082937.14171-1-rogerq@ti.com>
References: <20200508082937.14171-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

The system controller node manages the CTRL_MMR0 region.
Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
 include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index cbaadee5bfdc..b8b68951771b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -5,6 +5,8 @@
  * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
  */
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/mux/mux.h>
+#include <dt-bindings/mux/mux-j721e-wiz.h>
 
 &cbass_main {
 	msmc_ram: sram@70000000 {
@@ -19,6 +21,31 @@
 		};
 	};
 
+	scm_conf: scm-conf@100000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0 0x00100000 0 0x1c000>; /* excludes pinctrl region */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x00100000 0x1c000>;
+
+		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+			compatible = "mmio-mux";
+			reg = <0x00004080 0x50>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
+					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
+					/* SERDES4 lane0/1/2/3 select */
+			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
+				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
+				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
+				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
+				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
new file mode 100644
index 000000000000..fd1c4ea9fc7f
--- /dev/null
+++ b/include/dt-bindings/mux/mux-j721e-wiz.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for J721E WIZ.
+ */
+
+#ifndef _DT_BINDINGS_J721E_WIZ
+#define _DT_BINDINGS_J721E_WIZ
+
+#define SERDES0_LANE0_QSGMII_LANE1	0x0
+#define SERDES0_LANE0_PCIE0_LANE0	0x1
+#define SERDES0_LANE0_USB3_0_SWAP	0x2
+
+#define SERDES0_LANE1_QSGMII_LANE2	0x0
+#define SERDES0_LANE1_PCIE0_LANE1	0x1
+#define SERDES0_LANE1_USB3_0		0x2
+
+#define SERDES1_LANE0_QSGMII_LANE3	0x0
+#define SERDES1_LANE0_PCIE1_LANE0	0x1
+#define SERDES1_LANE0_USB3_1_SWAP	0x2
+#define SERDES1_LANE0_SGMII_LANE0	0x3
+
+#define SERDES1_LANE1_QSGMII_LANE4	0x0
+#define SERDES1_LANE1_PCIE1_LANE1	0x1
+#define SERDES1_LANE1_USB3_1		0x2
+#define SERDES1_LANE1_SGMII_LANE1	0x3
+
+#define SERDES2_LANE0_PCIE2_LANE0	0x1
+#define SERDES2_LANE0_SGMII_LANE0	0x3
+#define SERDES2_LANE0_USB3_1_SWAP	0x2
+
+#define SERDES2_LANE1_PCIE2_LANE1	0x1
+#define SERDES2_LANE1_USB3_1		0x2
+#define SERDES2_LANE1_SGMII_LANE1	0x3
+
+#define SERDES3_LANE0_PCIE3_LANE0	0x1
+#define SERDES3_LANE0_USB3_0_SWAP	0x2
+
+#define SERDES3_LANE1_PCIE3_LANE1	0x1
+#define SERDES3_LANE1_USB3_0		0x2
+
+#define SERDES4_LANE0_EDP_LANE0		0x0
+#define SERDES4_LANE0_QSGMII_LANE5	0x2
+
+#define SERDES4_LANE1_EDP_LANE1		0x0
+#define SERDES4_LANE1_QSGMII_LANE6	0x2
+
+#define SERDES4_LANE2_EDP_LANE2		0x0
+#define SERDES4_LANE2_QSGMII_LANE7	0x2
+
+#define SERDES4_LANE3_EDP_LANE3		0x0
+#define SERDES4_LANE3_QSGMII_LANE8	0x2
+
+#endif /* _DT_BINDINGS_J721E_WIZ */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

