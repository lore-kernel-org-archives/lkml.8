Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498DCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ED322B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NyMYhyLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgCBDeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 22:34:20 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:20480
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbgCBDeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 22:34:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj/kOe4EDE1y86wF5Wmru9K/yesGJwVAbMKOStprW6HsaTNVUWjQN/nb5u9WmVh54SG2PBR7EJy8/Ajfp9/weZZxTSVjIvBQ1CYyhiFDgLrfov2F55XwIJXNmqBEDKcbqMlZqK1oYiU3fNE2wR01exFuTHet0Lkuq+J8KR608RArbV1WZQXcOxskDbRGom3oMLJMHZuRUi9eXuenEfR64wPZkIHIycmq87PTp9AbunD1OfzMm8OC2y0/8T3rEJ+Dsv7iNktRIEtyoy/ccL+zQdv+cRmw7BOfgWGQFz59ihgu9JFuYkUie+NdiVCWU7xx8+6HCsfwZGqp23/KnniDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Boq0/u49rDYl9rffTweCwdu0ZfgrliVj4uYzuL/M8=;
 b=jQ721a5M0v8BnyunK94yNtrLurVFVz0dpAGqsiN40GAdGhB84gEIrKWmzU+dE2RIz5IQuh8rT0Ret9FCCNRapETl7cqBdMZO8O4ectPMo8EPzrqGtnWLI5oONeXAIBoiDg9L6Kz9QvPtVAjWHVfuIFlAKo3SsiMhpbVEiiUfETQP65HM080tUF8AvIGg3GLW2xPv1vXtSavS9sN+htNdIGCuxzYnX+lsJxqvx15PLYO66/k4aVAeoUcLApHC+kPK0kN8TUt73GrdlGOnjYgkpUKvGryaA1EeaKTNLosEm0lrsT17NmaKyqblDs4B1AONN6ktoy1fNWRFLZs/J9PByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Boq0/u49rDYl9rffTweCwdu0ZfgrliVj4uYzuL/M8=;
 b=NyMYhyLylJfpvRV/aXTHTLsk6lnmcTYKtJRmMdnmGu0F96wXgYoJBPDSFMyY5wTRTf01uLydnyl3Hf0laDnovExpeDaWns5RqQ+lsO7iItMwuKQgEpMXDDUAPWbFW3t4CMDMnneFZDLfj7TyhIOzk9QNmVNFh7D+ttLCVeAxvSs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6876.eurprd04.prod.outlook.com (52.133.241.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 03:34:14 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 03:34:13 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, laurentiu.tudor@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] arm64: dts: layerscape: add iommu-map property to pci nodes
Date:   Mon,  2 Mar 2020 11:31:04 +0800
Message-Id: <20200302033104.19681-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR02CA0114.apcprd02.prod.outlook.com (2603:1096:4:92::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 03:34:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b89d7940-a7f6-4ea2-7d68-08d7be5a9400
X-MS-TrafficTypeDiagnostic: DB8PR04MB6876:|DB8PR04MB6876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6876C334F899020F40D0C05D84E70@DB8PR04MB6876.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(36756003)(1076003)(956004)(2616005)(5660300002)(316002)(6506007)(26005)(186003)(6486002)(6512007)(2906002)(66556008)(66476007)(478600001)(16526019)(66946007)(4326008)(86362001)(6666004)(8936002)(81156014)(81166006)(8676002)(52116002)(69590400007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6876;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2uKRc6UXAerWXwrxnnWFN083VLeojb2nyJ+VdWzAG+3Yxg2xRgQZrOF3tYWG9qzkar4aevIACvo4+rxp23xZVC82iPiZox6zExP2i+UlQKB2GFG/n1eg37bP27sN+5IWHZg5L9uZLsMv0IMyZTHaKNftMZ1Udc/2iyM5P2mSzIrn0AkORLwqHVoLEuY3MaLiWIFcsuFe8qtH/TlTRJc96os1tTiL6ueabMwgRw8Pdng74s73jYYk0P7GGIAfWiVoqVKCd9SUzP4w+lHBFbtlERdNZyU1ehEypxPt4P2ahPsycnznM+GBoCMz0QK4E3BzbPPFL0P+8K3quQN4fsH35Tkze2ReOaafNxz+ZfHHnJWlioy7msh3rk2BnfzHGzMC3knaAqXh4egFbu7ABI4/md74iRr7xz1wfzKmtvQfi++tVkLDq9kCdPpXgabu0BiEWunPphr/y6eMyoKNVSFQhKTa9eOGXAUSQIFNM/L3vjjaiSSJzgJ1vPZAjR3SoqT
X-MS-Exchange-AntiSpam-MessageData: 6atbGI65SoKshkCoM6ad2e4Oexw0knREC7LO/KDkCaOKhBYooQhqXrGZyAhQpeZmmKMMm+GoN2js63SZ3WognFXGNAdVKPVAwZwD7MUi/iLUfXnu9heCztVw2737Y858woRSSAzCEFkORDmI+ThwoQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d7940-a7f6-4ea2-7d68-08d7be5a9400
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 03:34:13.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dMuHBylZU2yoGM6YDzkTo53M85pLnh2TpKzX2HwBRuV0M3HKbvI1Weqy4S8MEgbF3Qui37KCccVdIQNleeFlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the iommu-map property to the pci nodes so that the firmware
fixes it up with the required values thus enabling iommu for
devices connected over pci.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 6 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 337919366dc8..fe992d1982d1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -497,6 +497,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index c084c7a4b6a6..e5a8773fd02c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -688,6 +688,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -714,6 +715,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -740,6 +742,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index d4c1da3d4bde..697d7387a3a3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -660,6 +660,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -696,6 +697,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -732,6 +734,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index ec6013a8137d..36a799554620 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -494,6 +494,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -519,6 +520,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -544,6 +546,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f96d06da96be..3944ef16ec60 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -648,6 +648,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 4>,
 					<0000 0 0 3 &gic 0 0 0 111 4>,
 					<0000 0 0 4 &gic 0 0 0 112 4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -669,6 +670,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 4>,
 					<0000 0 0 3 &gic 0 0 0 116 4>,
 					<0000 0 0 4 &gic 0 0 0 117 4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -690,6 +692,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 4>,
 					<0000 0 0 3 &gic 0 0 0 121 4>,
 					<0000 0 0 4 &gic 0 0 0 122 4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -711,6 +714,7 @@
 					<0000 0 0 2 &gic 0 0 0 125 4>,
 					<0000 0 0 3 &gic 0 0 0 126 4>,
 					<0000 0 0 4 &gic 0 0 0 127 4>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 98a8f6def55e..ae1b113ab162 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -858,6 +858,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -885,6 +886,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -912,6 +914,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -939,6 +942,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -966,6 +970,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
@@ -993,6 +998,7 @@
 					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
-- 
2.17.1

