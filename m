Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E69C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B2A20768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G5LT1B7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgIIQKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:10:08 -0400
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:46336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730885AbgIIQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDlOjhN5xJrLSV4bF9ROPBpgGk87NoWA8IQ1Smy1BqmI3XAUKllRGTTusY1bT8ssFRQurToz+eBCz9eHVQKOIllNiF+ygylc1t9FQZVei+6Uj6lCGsaHUVt6q0YOqxUtYOmEM58ESeOGKB/+7B2EA7TmxTMI//jbGcx5qpMqA5pI39lxJj4bXVdtS+4Y8u2O7AlZx1x24564hC8fu1jNiv8AB59VrWwKiKg1fJClRLpxXufsVvbt2dgIrIAI7/yoVNCAKH72kh0iqheDSCV4nlm1ZyF+Uaqr0VhW9bFL6tFpsw9eqA52+lvv+FNyIhXRJOly0Kzgen524C6Bxx6jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNArHF5/JjXnG9XYK6zyg7+rZBRP0aq/7v+NCX0GXl8=;
 b=OpeKvIXzlZlWOWZgu93Z0nbb4k/A6E5vZljDbTbYQoNVtJWazO6gGMPHGZgHah+uJV1Unu6gwVFEWXP7kVQ+OLdEvSQqge47dmmKcSkwPkBPzPb1q90H4qW96/u1+WN3GaqFCTocn80F3HY0kqYE2ll9ayH/v7ojoJlF5qpjJciEE4e4FbLWCnxzGDR1zHU9atWED6NhV+N+MtZ/3uJFRsey9t7k/ji8ELUjVECZEGQBoUAnTOEEDN4zBwUHhBIAniU64eadt5i7HsE9/uRZ8UujfgK6XgiZ+MO+jFNaPem9pR581J3BHQfEH41eRnxcep0SCzQFyytCjc3mqGKylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNArHF5/JjXnG9XYK6zyg7+rZBRP0aq/7v+NCX0GXl8=;
 b=G5LT1B7cKyvpBKzcyK1XV/j8k4/+scXc2i8mAZSvdbUIiGiI3j4wqwvlZY2NXFlhk60eTuMn5qVWEs9RuoFrg5LR2+peLWiD0s3y7k9x3MHGDfose933BgjNa4mffUU9iwQuImXuhWb7WK5Ic1XhzDdFlZwf9iZRQWwYKHa+V2A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB3967.eurprd04.prod.outlook.com (2603:10a6:803:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:13 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:13 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 6/6] arm64: dts: ls1088a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:36 +0530
Message-Id: <1599659076-28121-7-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:45:10 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 241aa67e-8ffb-4ab2-eed0-08d854c6939c
X-MS-TrafficTypeDiagnostic: VI1PR04MB3967:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3967359A75D4A32D4C448CB3D1260@VI1PR04MB3967.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph78GlAiz+iAOjGeRrR69p3h+XCO0uOv1ygKZTcmNjh/I1FYH/bX2+e8C2xK6nvTB+vflZ6NSyx9TEK+g0ttejo5j3LPO3/gbAezaNCnutj3Qac5ZUCArZZc5PeqF7hCpTcCza9Io6HWwRWemA+//pnrpwFkn35srqZqbS4gmdkWN8Yl20BJsyNvupByb8KRRBSpBSNxRGdddcAHUtNctId0WR/CJCfATCPuiRrKXspcqS2YHOPxs0dP33b+mlqIBe/XkkxAQeINBLXbu0QLI0AhgHaMfgDns+bQRtHT//1qTdBDx6YoZKaBbgNKDxKd4yW9hr/0nMm4JB8Elt+JUcC14MZlZYQjjgnWd4IIJS8aDYanjwtYqeUKMe3w0Q0e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(55236004)(16526019)(478600001)(186003)(26005)(6506007)(52116002)(83380400001)(6512007)(4326008)(5660300002)(2906002)(316002)(86362001)(66556008)(66946007)(6666004)(1006002)(44832011)(2616005)(956004)(66476007)(8936002)(8676002)(6486002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wpBrCXi9AG95ii7UPVyt+vmK3yProJuQzO8FaV3Zg5peiQYViGVD/YmzwAdPoP4+h9mhcEEUYXEn17VS1MiT1g96eOhb9kLsSHQqzofUY5hyUHiKyBTcM0MAuDJWOf4rtRWsAJsf5sxcHDciN8dlvLb1SWv/6RfWBKJZiqlmj7XBu/bDUS7KX3pxkZtvp2HTVLww9M+RBySppb8+ujSJgWbZzFrasXq2p7YLPToDZ0iB8Sk6aBzm/EvB17GXX/YVa2Hq5d4QDV5jdN2sAzXIFD6SptTPUoqA7L2x7jxoyf1u9CZAUAlwflThC7TzPlhzos+qA67R+fpRZKS+Ird1WzGRaIXZk2VS8pPI5ywSXqzRpMP+A0xtcbdXbIq7g7kLtJeOEMu06Gki1jPQfTivB+/8DI3ZC7ebpNXz2AmGvLYWS7nAZFU/Qvzd25BEtyQfqPD+HDBreMiKpCggpTHrFmxdQjIFUzAQUGR5pEodfOOVjbX85Jt5/IFPvtYhLCH8Tz24E7yc+DBeHhEdBn25BbyzHTj8IUJdKJbzYAj1AXb03H9T+dWj6YE/mZix9XSN3UtnWIg7u/o/+aGN1KyvktqMzb8wlnsUmy22cqJFbt08Fe3xAzqhTcjrHzPc5mb61g4I50Bv3L9vyHIkcK084g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241aa67e-8ffb-4ab2-eed0-08d854c6939c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:13.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DF87jEaU91r1OIDczNc6Nnu3QNCu1iWEq1MrQv3sXsEOmMnT7JNi6UD3U2LvigcJVYHCm5eKiVFSOwNm1JUiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 169f474..08c0125 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1088A family SoC.
  *
- * Copyright 2017 NXP
+ * Copyright 2017-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -473,7 +473,7 @@
 			};
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -499,7 +499,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -525,7 +525,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

