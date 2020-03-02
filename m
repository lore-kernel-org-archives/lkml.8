Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15AFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84F24699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MoRo31/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCBE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:26:18 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:30383
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgCBE0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:26:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgF5PTku1iGO/WTWwrHZDw3c7odJ5r5b84XTioPoFyjq4vKMlLvjL1qYkO+Xm2bgPPBWYfJFnbRthxCsmCerBI87cfBjMV1A1djjLbaaRNGgnYZy9liRUnAgt+Sf541kUzg0g40P6d36i1ibGUiOFKywiki/kcwmyF1N6cZnvytZ83dIAaJ3ks3mNTUJhTEUORUh+XErUlH1PquA5MaqkTD2YyDJefIGNR58QjZGY/nVnJh7Go5AdHtAV886/3TzWK0DVHRIsfoAeywCaeqxK4sd+Sep9HSRcbHou+4tZG8ENN1K2CYUXkPrZFXtTxDuHavx0WP4TVgDFdWhB/KcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi/v6lfBQmh7mMZb0k5C2DstJCr6BNW5d2MePOBBfwU=;
 b=kPAPCpuUr/4ixoq5z1CQ039Ngy3DfFKhsdCWhCJP4hDG5oz8KUEngtNWL1uY9eREqtuP/GbhZre4gFIE8VP9Te3VNxF6W0U9Xb9+r3p6JRWUwCVcrKsFglHwQA9CgryzfV3FQLjJsCYyO4mr8xOm1M9hbDuBi7H12b6bu2XSUaE/sT8c3t/lpdT1HTtmnBOH4QX1QGyRM0xIAB00p1In8iZ5nfOWRfOnBifF/0pCzgSOqP/US1/fG/VZ6pDUw+wRoPLUhQ/bBNosoOmSwswcy/uoepuShPWG1QhOa5R1ArxyLuT/9/EPY4/Ax/E8PuNWqPfXR6DNYGxZM0D551FWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi/v6lfBQmh7mMZb0k5C2DstJCr6BNW5d2MePOBBfwU=;
 b=MoRo31/2fZCIztLJlfUd8231FGZPB6cmdtq/ZW/2wXPNLfQ7wXGXzHvq/H87cWKl9az+EjiSmOEdIL2QiYTrQ1xxIWPx52q0Dy5dc7yZ9PWx57eGPtOtvC3E/iXq3ae17lbX/WXALGKDbPQKQ6cEy9ys8otfmO6m+HKJdKsylM0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7180.eurprd04.prod.outlook.com (52.135.62.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 04:26:15 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 04:26:15 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, michael@walle.cc
Cc:     leoyang.li@nxp.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv7] arm64: dts: ls1028a: Add PCIe controller DT nodes
Date:   Mon,  2 Mar 2020 12:23:05 +0800
Message-Id: <20200302042305.15639-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To DB8PR04MB6747.eurprd04.prod.outlook.com (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 04:26:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22ed3974-396c-4486-0e6d-08d7be61d869
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:|DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7180EFED43BD851E85FF6F6284E70@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(6512007)(2906002)(66476007)(66556008)(52116002)(316002)(6666004)(66946007)(69590400007)(6506007)(956004)(86362001)(5660300002)(6486002)(2616005)(1076003)(54906003)(478600001)(16526019)(26005)(186003)(36756003)(4326008)(81156014)(81166006)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7180;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PS/llBZdO/0gCLZkWbNgKB31HIzlSL/0gYuTOf76G2+Wa/TeGIMxZ+vIMaL0qmUvoGOO7Fb3tu6Q+/7bDLY1NSjK1YPpZ+VLPaMAYA+DOo8gSCzlUJ0jSh9IkGLjghwTFget5gt504ZkeSGr5V0odyPLf5IUcLaoLQ1Z+JeXEi8xypWU5Vx///+1sPPqeE/zeplJKHd15bqtn93zryJt1coZK/TjxNdQ5v67sgAmotNQRoKleByqAhExLGkb46n3Nge1HTyUSx7GM4jGWLXvI+nTZibEZtcyQt4CKB1X66RFIlEhzF2tmTigf68+cX9jOk9lKGISXUrggxOXxgDGcyZvr3+PDHNLqG+tUYmXICnx/QSYDXSuNwUq0Hk0fW1msWzareGno8wn5bm11TR1xzGX7ISqcQsrBspyCfinOoJs3j1GOWHJhe4y1W2HKvKqB3U/FSrCTGIeNOw5/K73caB+ILXByGB1nkJ4DMQVebPXma+LsaPMXTr/IH7NO8Cq
X-MS-Exchange-AntiSpam-MessageData: +m0M8OSx4C038AV992mxyamnZFNJlzYaHxZZ4HLmHf4QRu3DXKjXTICuoHjZTKJRkR7ZerlI3VNe/hAd8n94QyxVj3JvciQP2Y301GwZQ+EFtxx2mMhe7Ea0XBv4LkNWvJET22alDG6KvNXN4qwrdA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ed3974-396c-4486-0e6d-08d7be61d869
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 04:26:15.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xdr93/sVZtRjjh1zTAFV8VOiofGLCkN3q979k1nxW+QQxm7LxIzpIVG9bHmO4390GBR2rZvg+UBdhJlxX900UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
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
V7:
 - Rebased the patch to the latest code base.
 - Added property 'iommu-map'.

 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 41c9633293fb..3f31641dcced 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -717,6 +717,60 @@
 			#thermal-sensor-cells = <1>;
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
 		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 			compatible = "pci-host-ecam-generic";
 			reg = <0x01 0xf0000000 0x0 0x100000>;
-- 
2.17.1

