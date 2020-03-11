Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E53E21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rSWD6OLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCKKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:07:01 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:4041
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgCKKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:07:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZf/wdi7qoZQPcy3EVbaw/aQCOBdXD5czC5WD1fsU2ymUYvD/dmqvkssbiS/34WyPYOrRzFLG0RBzIykiGh9i8YFbxoVXQ+YO3wcx3JQ9uudagTOW2Ik22CqIxKdAEiwFAVSGFdbgdM94Kzl1QwF7fe5f3tYFPk2BGAko7Ns9+3Gapj8JRGdakAb38MQDxQ5uJ8kysba3tPcQqoDD4hRmrgC6J5H+6x8J3CePUJu1+7fnSjBZ7N+OydyeD2/USG0+JcnUJ1DRHE8LzaTsBnlwbCEAwGjpeykHcCzWo1a2H58SCEfzOWxFViBGwOjbNcOIE28JX0iCXPJvGOndsdVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOr8iiLDe73ARUQTGnibI1cGM533vKHA6ibzmA3X/Xc=;
 b=D63doJ/gJ25Fi1VS3j9roBCEuzqTwoCHMmmNycFJdG9JlU5CNEQXRuRWGn18kjACFAaoc2kVR6TBFD41wEzuS7yaq4Qw+5zWSkfLIOacC9DxgdQn2NUnrxl/vpZTSdIhrIQudkI1Gb22ekoxSebFhXFKxZii9E1s38AIvq9dIFhVTA1vRfjQvuEGpzj4m4rj7NFM8PMGlts+a6mgPYl+y3WfYoDMZ5OOjwn1FRybcDxLYfDrr5yO4DORm1j1DmQnRy33go8//+rqgkS4WOvaGQzhXz8hmc7HuA0FYIcGkm5SSx2c0RcYL3dVbn0K8yFOj+/0k+pgh3tm9Yp+RcurlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOr8iiLDe73ARUQTGnibI1cGM533vKHA6ibzmA3X/Xc=;
 b=rSWD6OLY4ci0rYPfUqmJeq3h5jQxaGORyd83tK/ziXvuy2P//zDgG6hW6pPtB7ljmgSMNi4fO+65AISciYdtH2oro2MpTFpZSJnPcukbmFHCVF6Ltu1iSZv7fal35HbNYb4bdqc+sSOD8Rx86zNgtK5kEe43lZL+TeB5RoiZNY4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6860.eurprd04.prod.outlook.com (52.133.240.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 10:06:56 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 10:06:56 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, michael@walle.cc
Cc:     leoyang.li@nxp.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei.Bao@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv8] arm64: dts: ls1028a: Add PCIe controller DT nodes
Date:   Wed, 11 Mar 2020 18:03:39 +0800
Message-Id: <20200311100339.46122-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0111.apcprd06.prod.outlook.com (2603:1096:1:1d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 10:06:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4aa02c1d-09de-409f-b841-08d7c5a3ee43
X-MS-TrafficTypeDiagnostic: DB8PR04MB6860:|DB8PR04MB6860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68604B7B70224E161E56F62F84FC0@DB8PR04MB6860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(186003)(6506007)(26005)(956004)(6486002)(52116002)(16526019)(2616005)(36756003)(6512007)(4326008)(478600001)(54906003)(81166006)(8936002)(8676002)(81156014)(316002)(2906002)(66476007)(6666004)(1076003)(66946007)(66556008)(86362001)(5660300002)(69590400007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6860;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR6LocDkw0AQQWR5Nwfht28UApKJMc8XGIluVlZY0D0Us9HDBJjoLSHCJG3fMK7RE1KH//e4Phci8An0eunkOCAn0RhK1zb/+p9leYQZNSjgG74xHWs5E6RhXlW0aU+QjTrQ9M2bCXCLBulyi3qNYm26OzlqsNAcY7gsHqxiHwP7DYEUuYtXij1/fCi5Njjn+1SfGIeUAJrKImUYf6TYgW2BhhZsQ2XrCcOcs0z8u1nWNGxHHttjVvEW8GmX8cBDaA9fdsre/J7L1IsSU8rP3V/dysgJ1x9zhJuzp8odvZQ5meJXPgErDmzMxWfvMOEP0Mo3mo86lXmrfigsiQMw6O+C2t2j3Dxlddqg6E2t97SGW+SKAQ1pfAUIUsIbfph/qa3vT3cmSjHM2QaBuFTIxogb6EP4Nrw1h5NV9mt1idvnDhbl2Hb0v9VNgr5TLjwV4uyd8RjXLwpQtlXgFJF5/Wd1tBTBh17JPx9jvkh7cq5R3hl8Z+CmuPxKQNFGcvpo
X-MS-Exchange-AntiSpam-MessageData: SQBm2q02uzMQ60Fl+hnMWHdJ8t2tIo/Cl6Z5hlsPRJ7tGCJA9uDrSLrB7X71MeO6JO3dZgrS93oSD2MefpJYB0XXjhqWsTC1d211kasXrvCVxZWaVK5Z3zD24N0dgMK5KcxsSz7J18DU2QHVykXydg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa02c1d-09de-409f-b841-08d7c5a3ee43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 10:06:56.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAjTEkm3Ij6Ax3qRs/55W/YiuaYdOewbWeQb5025BhswNReqRVCfFGL4BsVA7c7kE3M6hkaco3fYXOSEPkoq3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

LS1028a implements 2 PCIe 3.0 controllers.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Tested-by: Michael Walle <michael@walle.cc>
---
V8:
 - Moved the PCIe nodes forward according to the unit-address.

 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 41c9633293fb..388aefcdacfc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -450,6 +450,60 @@
 			status = "disabled";
 		};
 
+		pcie@3400000 {
+			compatible = "fsl,ls1028a-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-viewport = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+			status = "disabled";
+		};
+
+		pcie@3500000 {
+			compatible = "fsl,ls1028a-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pme", "aer";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-viewport = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.17.1

