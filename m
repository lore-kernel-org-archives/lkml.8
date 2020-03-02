Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCAF24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OoDKDM29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCBEXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:23:33 -0500
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:28893
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgCBEXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:23:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6MOPB0/CLxlg8zum9zhklVdGiyCtsMmwpO72ZNpP3YDq5gZz2wRbEei7Nro72QPE04mv0PxNBB9raqFFmdbmTaI5mw/v3eV8HdygOPlf/lSmLDS/EynOxlCm3Yh8AeRKQVZlI4TG95oKxKw1fBmSpl2TsaJp04+0aGaCKCBEal3fwNumZkZMChujAVgqLbZusz9cnMrd7haBkimsR+wxjwpYcV9ETmKFH3puPNaFXfgWn0/UY7uGr0KpAMhdO81oDea+1RaGIBSSft/SVArQ+Z2qEZrFUzH5JPQyMBKwdhxQgf1NZv4clvQuOidePq6XhtastOnv8DP5OYsAHzDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIT5S1vi1eXu2LprjWbHJlmBiSDLmFELvL6go9yU6P8=;
 b=oQ4iovunAJ81oz6KKmeoR3zxTJohwirje1hAoyXHO0EH44VhJRY9Yg89vrkq9yQWqPgGywd9nDoSXnlVFCM38ZPD38bPlDxAaUig9AHuGzvJ4lvMEZxDl/lPDp8OKg1JbeI9QKB7wlTWLPEK/S90xnmgCvHAnKIN0tSSJtI72OKnQgnff6PkqZMOEfjgP5b64ArqUYd/0FGsWpANVy8nnNxkMYUU4tUPuiaSSaWh4a+yRxP4EHlCSCTceYnkgLKW63Q/MJiyK1sjkIL/N686RxOB5k0osIVzhs10DNMufTm5M8hMHN1BIyj0GdIciHtb/Zyf1p9FpFdnLcwlo1H+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIT5S1vi1eXu2LprjWbHJlmBiSDLmFELvL6go9yU6P8=;
 b=OoDKDM29IG1Cnu4tKuRHMC+qC/ru0KvVJigrJWvnGdYcmfYrACeXt6ekwuxmHE4LiVZXif6DHxSXOCkAq5ptxfI5aJ3JGCdq9jsYHDjB1Eol+f+tyydlb3ygmaVefhF/OSTkkPQWHkUam3GUt5WBh2cz5k1yjfnUMKLn0TwxRxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7180.eurprd04.prod.outlook.com (52.135.62.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 04:23:29 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 04:23:29 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, laurentiu.tudor@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2] arm64: dts: layerscape: add iommu-map property to pci nodes
Date:   Mon,  2 Mar 2020 12:20:27 +0800
Message-Id: <20200302042027.15589-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR02CA0044.apcprd02.prod.outlook.com (2603:1096:3:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Mon, 2 Mar 2020 04:23:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 605f0f23-2da0-4713-0e1a-08d7be617586
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:|DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7180AD195BA21E793D6E5A1184E70@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(6512007)(2906002)(66476007)(66556008)(52116002)(316002)(66946007)(69590400007)(6506007)(956004)(86362001)(5660300002)(6486002)(2616005)(1076003)(478600001)(16526019)(26005)(186003)(36756003)(4326008)(81156014)(81166006)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7180;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9UZuYQoqozSRIhhk55cwJKe4RCc2KwIW6asHpA41/f6nvYwsMobu6x8nVa/H1AOoaUxkdVOdXz7d9dlnbtLuTfELNZnT5SIRU5t8aNHEKGf3nRe79gy17/PpiL3+OGbung4N2JU5m/0pRHEbpKR+90UWJmvqQ2oGK1dGyLCEOtfVqgqFL3+P497dMpJ4QeBWIAduLK4OLEqP/iiZxTAZid4z3kGcsq7G/jpquQGZmHnFAQ0Fn1ve/mfAAvx0KJV90F8/nyOLO6ehW9Jli+ckA4mb2h/RM98d6pmfYoK0XU4iOjS8mtOpeATlh6+2ycFMLp86srP9PZjNvlSUFhY9DDXBuqkE3j0zhuMJ/UmW/8ebt/JELESK/p4ZgrF0gigBdH4GPzTw+t8wElUY0q9cu/FMnaLLYbyMeuYAQP63EcD90JzIJ9wJ78Nzb4dsrZENXU6kZIYt+FqZ5bLJJ0CVVLPrzRkvsJg3vKVMENpcUzPi1CN913rrB9g/WPb2VGV
X-MS-Exchange-AntiSpam-MessageData: E9Wu+NaZIjdXq3b0ap22QLY6sOOABJ7TEbckVcz4jn3u1oKXtCpcJAiysgk37uoAaU3cMKBWKDOiRmrsJ9RX4eo9LA5ioTbrASnTB2cP+d+7a5u8C9andzPA0SlNnSMO9iTyT+t0LtaDkY978AIcug==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605f0f23-2da0-4713-0e1a-08d7be617586
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 04:23:29.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0BEvW4LMZ7fNwnMGVON/XiPqp2g5Ntsy7kcG/9y4F4yqIlqNcH7m2zpKv3jwpbV+qYktYEOM2wy6WZIi0VnPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
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
V2:
 - Removed the 'iommu-map' from ls1012a/ls1043a/ls1046a due to
   lack of SMMU node in upstream currently.

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 3 files changed, 13 insertions(+)

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

