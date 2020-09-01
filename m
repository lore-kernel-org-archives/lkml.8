Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92304C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D976206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MrajOkT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIAWbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:31:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47146 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIAWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:31:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081MV7LV011965;
        Tue, 1 Sep 2020 17:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598999467;
        bh=04+GnMoK8hlGtHSIIzlyCnFCaKennRCrCAxeob56iNM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MrajOkT34roQhuFGkjrw12ZA4+HVSd8GVXr/zLxnCua+CdqomfmJfau8Mn65N15t8
         ppCluRILViBHG3rs+dLFYhNnCWDOO2tXBpawy8l1rLc0cZFLdBFkCYfpQbftis+iVw
         H1bJjaIVF59UUvHR73hSZoAY+67E0/WN2+o2R648=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081MV7gJ029254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 17:31:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 17:31:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 17:31:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081MV69d060429;
        Tue, 1 Sep 2020 17:31:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/7] arm64: dts: ti: k3-*: Use generic adc for node names
Date:   Tue, 1 Sep 2020 17:30:58 -0500
Message-ID: <20200901223059.14801-7-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use adc@ naming for nodes following standard conventions of device
tree (section 2.2.2 Generic Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 51ca4b4d4c21..6dfec68ac865 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -80,7 +80,7 @@
 		#size-cells = <0>;
 	};
 
-	tscadc0: tscadc@40200000 {
+	tscadc0: adc@40200000 {
 		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
 		reg = <0x0 0x40200000 0x0 0x1000>;
 		interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
@@ -98,7 +98,7 @@
 		};
 	};
 
-	tscadc1: tscadc@40210000 {
+	tscadc1: adc@40210000 {
 		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
 		reg = <0x0 0x40210000 0x0 0x1000>;
 		interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 9ad0266598ad..81801f519a61 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -211,7 +211,7 @@
 		};
 	};
 
-	tscadc0: tscadc@40200000 {
+	tscadc0: adc@40200000 {
 		compatible = "ti,am3359-tscadc";
 		reg = <0x0 0x40200000 0x0 0x1000>;
 		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
@@ -230,7 +230,7 @@
 		};
 	};
 
-	tscadc1: tscadc@40210000 {
+	tscadc1: adc@40210000 {
 		compatible = "ti,am3359-tscadc";
 		reg = <0x0 0x40210000 0x0 0x1000>;
 		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

