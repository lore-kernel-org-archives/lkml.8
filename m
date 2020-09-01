Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4177AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967C20FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O/ijain6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgIAONe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:13:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIAOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:12:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081E6nQY059182;
        Tue, 1 Sep 2020 09:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598969209;
        bh=RixAWEvCOs5TI6IoAywsdosmAxAkvKzfEAycZgP8sUM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O/ijain6PDeOatHWv00hghgs347uxtwuBcIuuR+fAy7Ha25GfzHTLsy6vBM2BwOud
         kkO1sp5sQprOxNCjfcWuElMy1710Ibe+d4N5M58LKqU36+RCk74yNW3i+vCViivkHc
         w+Xf7t2QsHRjJ0kAPdL7uRnMLpBQHF2iCGfCpp/0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081E6ndi072961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 09:06:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 09:06:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 09:06:49 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081E6Zlh034944;
        Tue, 1 Sep 2020 09:06:46 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 2/2] arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances
Date:   Tue, 1 Sep 2020 19:36:28 +0530
Message-ID: <20200901140628.8800-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901140628.8800-1-kishon@ti.com>
References: <20200901140628.8800-1-kishon@ti.com>
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
index c355692796a9..8b57d22ca3cc 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -558,3 +558,83 @@
 
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

