Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E9C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6412076A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lhagn9ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXF4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:56:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50018 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgGXF4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:56:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06O5uFXR088243;
        Fri, 24 Jul 2020 00:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595570175;
        bh=k4XT/ag3y89G2xERAKuPRDve/n7of+kXftcTCTVuRQM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Lhagn9ri1QJbWaGkcSOPXniFFsWSYgzMAjBvykj0HSYf4VMBpDTtYXmwQILz5T6VU
         wDkr/pwnjF1lQaxU8osh4DM+HC50dvJ/vCkFW/Y8uXHr0EZKva+8MMqWjK32bHrBUv
         YiYxRcO/xdTOm3kTkoqD9bPKoTVI1Kmi92rc87iw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06O5uFLZ001436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 00:56:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Jul 2020 00:56:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Jul 2020 00:56:12 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06O5u437005411;
        Fri, 24 Jul 2020 00:56:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances
Date:   Fri, 24 Jul 2020 11:26:04 +0530
Message-ID: <20200724055604.31498-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724055604.31498-1-kishon@ti.com>
References: <20200724055604.31498-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E Common Processor Board has PCIe connectors for the 1st three PCIe
instances. Configure the three PCIe instances in RC mode and disable the
4th PCIe instance.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bc1e6ecc50e..29be88811132 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -651,3 +651,83 @@
 
 	status = "okay";
 };
+
+&serdes0 {
+	serdes0_pcie_link: link@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes1 {
+	serdes1_pcie_link: link@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+	};
+};
+
+&serdes2 {
+	serdes2_pcie_link: link@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz2 1>, <&serdes_wiz2 2>;
+	};
+};
+
+&pcie0_rc {
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+};
+
+&pcie1_rc {
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+};
+
+&pcie2_rc {
+	reset-gpios = <&exp2 20 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes2_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+};
+
+&pcie0_ep {
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "disabled";
+};
+
+&pcie1_ep {
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+	status = "disabled";
+};
+
+&pcie2_ep {
+	phys = <&serdes2_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+	status = "disabled";
+};
+
+&pcie3_rc {
+	status = "disabled";
+};
+
+&pcie3_ep {
+	status = "disabled";
+};
-- 
2.17.1

