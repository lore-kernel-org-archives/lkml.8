Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E7C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40AB24684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wELgubAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgAWLpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51816 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgAWLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:45:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00NBj2AK098693;
        Thu, 23 Jan 2020 05:45:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579779902;
        bh=sUxfh7+xTFULpvEdiX+NQwvAhZEl7MFGUlzVf7lyaEc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wELgubAW1q2J2LKIgDvKNhCM3OxVv/iLCXHy461cQsApFsNiC5fJ+x7lD1L6QZLMN
         J/0fpSJB46JBQKR8DAqcerdu7mQE58BaaX0NVcbFsfhi92QTavDe+brTsbxhZtkTYb
         qxaGY6wMskmFlS2LALwfJ57Fe8XjJaumPWOuUPG4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00NBj25B017240
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 05:45:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 05:45:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 05:45:01 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NBijBJ114078;
        Thu, 23 Jan 2020 05:44:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <lokeshvutla@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/9] arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under main_navss
Date:   Thu, 23 Jan 2020 13:45:25 +0200
Message-ID: <20200123114528.26552-7-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123114528.26552-1-peter.ujfalusi@ti.com>
References: <20200123114528.26552-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure proxy (NAVSS0_SEC_PROXY0) and smmu (NAVSS0_TCU) is part of the
Navigator Subsystem.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 43 +++++++++++------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 6a805be4513a..97b194e0bcba 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -40,17 +40,6 @@ gic_its: gic-its@1820000 {
 		};
 	};
 
-	smmu0: smmu@36600000 {
-		compatible = "arm,smmu-v3";
-		reg = <0x0 0x36600000 0x0 0x100000>;
-		power-domains = <&k3_pds 229 TI_SCI_PD_EXCLUSIVE>;
-		interrupt-parent = <&gic500>;
-		interrupts = <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "eventq", "gerror";
-		#iommu-cells = <1>;
-	};
-
 	main_gpio_intr: interrupt-controller0 {
 		compatible = "ti,sci-intr";
 		ti,intr-trigger-type = <1>;
@@ -91,6 +80,27 @@ main_udmass_inta: interrupt-controller@33d00000 {
 			ti,sci-rm-range-global-event = <0xd>;
 		};
 
+		secure_proxy_main: mailbox@32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		smmu0: smmu@36600000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x0 0x36600000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror";
+			#iommu-cells = <1>;
+		};
+
 		hwspinlock: spinlock@30e00000 {
 			compatible = "ti,am654-hwspinlock";
 			reg = <0x00 0x30e00000 0x00 0x1000>;
@@ -206,17 +216,6 @@ mailbox0_cluster11: mailbox@31f8b000 {
 		};
 	};
 
-	secure_proxy_main: mailbox@32c00000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x00 0x32c00000 0x00 0x100000>,
-		      <0x00 0x32400000 0x00 0x100000>,
-		      <0x00 0x32800000 0x00 0x100000>;
-		interrupt-names = "rx_011";
-		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
 	main_pmx0: pinmux@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

