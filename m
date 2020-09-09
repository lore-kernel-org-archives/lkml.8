Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272D1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A912087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HVAOveRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgIIQu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:50:27 -0400
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:46336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730604AbgIIQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:06:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChIplXw/C1TqrlVMSQO9QmtEccvJ28PjlNCk7owYVTvj8xOQ6CwrPAMvG6gmdfkPGbhSTnXUJbEFk7IYsC22NDwUnBO5Zc2/aXncyAB6sg+5JajG+buhTA29eBb9zqhV8TMzlz+S14J0OI031hIUKNBzaDEm1K5ZcMTVUHKbTukg5C9p3yKeag6rkfrSPiN5fbEof/SuaP9x3iXU8e36BpXu1KCzxJpG/uIQeEBmlyg51uqVmwNr9XNYVDVccyA7O4EWgT/UbGWF6Xlz1Nz4SZbnay1GLx7TvLKAJOi+903uNhxZ3si5WCUduAA/DnjokFcvLS8aOCyz5p2TF7BbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYR5tq+lUMx60NpWI9ucLHBXRANLGNqmbZQttaWQXMI=;
 b=BUZC80MDJa+XA3TXfd5eh4VMU0MhoFXj8TIfEJFUMwUToEaAc5tYLvo7SHmeIpoCELUpXRy9kE0ZGRtKaixOHoVwIE5jlwqCA2h2q+IIiFhE7E2IGJezC6Ro+4ysjz96u+fHi/jhWb9d/JGBMgL0YzY0PyfRPtDqJ/Q1Z8/RYOSeu3paMSh0hCmc5EV62L89whR5BxqzGczvfsyAKPDB90AJm51NUPK5HT/xmUl6SAzyW/uI9nldKmlrAFYKAs9JXsvQ+H+w7x9RS8t7fH/8PE4hlvlJIOy1Eywi7sqSNNqRlkWB6Y2vT5mzmehjcHwAj318X1/kimpdsmr6lcAfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYR5tq+lUMx60NpWI9ucLHBXRANLGNqmbZQttaWQXMI=;
 b=HVAOveRktA+qHjlEQSok0IciXXh30gcBE/EMF/QMmQQjbZvHyYBwa45jWuJBfv3CGq/aTrR8qTrBcRIB4Fj+6b2hB+VOYxhkdvMl9bznYgLEmYV05OB/8jzt7j/ZGJjM+ydD8EHnnKqvItv6h1JTyBd1T+SACq89GAJS/7h0JHc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB3967.eurprd04.prod.outlook.com (2603:10a6:803:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:07 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:07 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 4/6] arm64: dts: ls1046a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:34 +0530
Message-Id: <1599659076-28121-5-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:45:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 904202a4-9679-4015-3ce4-08d854c69062
X-MS-TrafficTypeDiagnostic: VI1PR04MB3967:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3967425E6C05EB2B8094D075D1260@VI1PR04MB3967.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5dTWspZxVYilyd4qWZPTWWJ+NEoqIKTwut+LvOsn5sFGr3snffACYADfZCgvt3+QL91Y2OvOnVeyoal/Q8E3kgzOXkQjvGPHoO0Gh0TYV+dW+rAiludi4n1oQXQtDaR1JxbM3HdnI9WdWDHOQQhdEjJP9Fdaf7z7RXrmWDIiUuWo/ykAu0JlxGpDrDffWjppqR3Q80SpTXW3YpopltCiMKaetkvNDw9PN9OA8iLDyVymsJ/GwNXejyR+WYQ9LGdJIDeGyxEYMlwCqSQ/Y7SL2mJ1Cwzx66G6lIdtOJpX5FDknWsbMKD09ag/nu+/cGrjXEZGMzb4LGhW6YqHD1CS4hKE98gTnp8sTPdDhE52KuM37i/xszTgygd1HEkBbyk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(55236004)(16526019)(478600001)(186003)(26005)(6506007)(52116002)(83380400001)(6512007)(4326008)(5660300002)(2906002)(316002)(86362001)(66556008)(66946007)(6666004)(1006002)(44832011)(2616005)(956004)(66476007)(8936002)(8676002)(6486002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EmwADCPofb+uu1Twr3VhK1KZsIayQyHE5EU/HamV/WazgRyh/GUGQkGfnpLxAeiyot+5Omp8fpQh1q2a7mLhhp2LyEDyJLYKDEyF6xxj3L2XLx2S5k2X6mxOc9M+9FbaHCp8+NVfpstyaP+M0c2uiCtgyS8HxDJm6aHmOivTJAijcUomvF+yHj7/l0UReMn5vsDR/2tTI8RlLUUNd7/mdiXsqDVVqwbYFgdsSjSju1NRSNw2bhzpM3YeAuNgNHq2XGdcJKGBCHKvpspiUTRs6fA8SFGbTIXivcYS9n7X2cOWVlcLy5BwbCNycrnTia28k1VGTiJ81yUyofSGcH8GwMjnj9rSonc9CRds7j5GTpeniWTrwFdzizkHtY/h5Ps4tQxE/OFdCdh/1gaVA2clLXIoilF3n660JDBK8pBZE09CuU+PYkaPenN+mq6ibMvJnz/AYh04HvjZPFRYvjHdQcCvqEP+wPcQ26ftyRziaFa+q15jusDta0YWBSjh3K4LK61J0Z01j6F6UZSRKvjB56X0iVNIhjYHNM5BNWd4zKYamxlYxQL84m6FUmlLc6M5l2vQlXg7cw5gtjZygkmmXS1N1TyDdtWkk/maotfOd3ceMb91f7A3v/s/2jtqCj4S3y3ojYZVG8irkz+kv5QNSg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904202a4-9679-4015-3ce4-08d854c69062
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:07.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmjiNgem0WWJn0ru90cew9pErtz4sYK2v3AaKtUnWDKxhy6Qk4jBW7QwUiLE/bIWQa5cWBl/d7MRzWuiWmU/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0246d97..1fa39ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1046A family SoC.
+ * Device Tree Include file for NXP Layerscape-1046A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018, 2020 NXP
  *
  * Mingkai Hu <mingkai.hu@nxp.com>
  */
@@ -718,7 +718,7 @@
 				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -744,7 +744,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3400000 {
+		pcie_ep1: pcie_ep@3400000 {
 			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000
 				0x40 0x00000000 0x8 0x00000000>;
@@ -754,7 +754,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -780,7 +780,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3500000 {
+		pcie_ep2: pcie_ep@3500000 {
 			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000
 				0x48 0x00000000 0x8 0x00000000>;
@@ -790,7 +790,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -816,7 +816,7 @@
 			status = "disabled";
 		};
 
-		pcie_ep@3600000 {
+		pcie_ep3: pcie_ep@3600000 {
 			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000
 				0x50 0x00000000 0x8 0x00000000>;
-- 
2.7.4

