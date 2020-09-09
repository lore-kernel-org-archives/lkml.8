Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34321941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ues4AXEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgIIQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:49:53 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:20520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730784AbgIIQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0AkgKvETZB/MmAdx2VUIdG0dFThK9+bTiq05f00IwulYiX8pfl5ZlM46c/1rBDjO+FwH53KqZCk31fr5sfl+S9j93ZRha/ZRrZ6/3UpEFB4uPnTOD5iMLqBU5eEkdHIZceWmxLIeCpUOVwEL3CjPTYxcCFDxlYX9PhLEQAQ4c6WbQBmUu9KkMA/1qIWjvNLDJzlsvUumTGkOu/CMljIkdvw4zsuhngakD+XGUjx0LjlQvVX/RarYH2jzAN1fl8yfdIFGi0eb5BoYwMlIR8ceNQQti1o1+EHg/rFydb877ED81YW0sfIavN2wQmfoIWvDcc4rAvC/UvSIt4lL6kKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUy9xrR78gWaa4U204iqXglNoV8XBCoW314thnMMfUk=;
 b=AvYtVg36ORJ8YEe3SiSq1erjWJgzARm9M342joeZ7m7wIzHNORZIi3jvcd9TOEnz2DQ2DZfPudHc9+slRd+5tX2Ih5eXXfBjLB4eaWwK7lLgbSMsnxurLfipmOPpdDsFVlZ29cwBByZuGlCcpFtBtoZP1fjtQh8OIUnJT41WEhY6muemiG3s6Y8sylGZ09ioUNTnigyZVOyj7pEQhYtIvvpttRmWMhzBz8zcCkJUuugRnYy5k9TLDieWxs/wAeEKuYXcJt9uTyaI8tIploGtkMEk383kLOP57FW7To7yyXd+/BSzMewIFH1gRYG506hp0rDDZxfgLwFD64AVUqZpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUy9xrR78gWaa4U204iqXglNoV8XBCoW314thnMMfUk=;
 b=Ues4AXEJB1xmvna6QsCRcDOEzCHdurT7L/yLAjAOUgHa8w3T530FCwgkewD8UfDZlLpmOdErwytMeN9yUjIxynfPZvwjF8Pxb1s2yKIO/1BRyrhYQ8ZNRqKh4JYp/x+5m6qBIEa4unSZy5PLbNYc0kAGuftJ74IT/gUSsgqA2BA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:05 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:05 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 3/6] arm64: dts: ls1043a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:33 +0530
Message-Id: <1599659076-28121-4-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:45:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9e76c7a-60ef-4095-6f19-08d854c68ede
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37100E2FF77D02B6E89271D2D1260@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpN9ML9Giw6soGFOsdv+NuxumzLPvdXrY80ZgEvYKkZBucgiFSJ9AtfofmoV+GqyUbffzuWdC9rH/k4oOwGbCql80fx6emE/Jn7ltlukXkdr8KOV6kUeh9hi6pCJGUnwiMrXIqe2Ra2jzZ6mQhjMajyu0lj0mPUrdWSQ8iKJr0o3A8XrYxjvQWBybunqVL00S+brN6VbU6BtHERvr+0czb1M36SI6br5lL3PqJDc67l5n0MRkIZwChYlP8WoOjk9LlxwWVZdFiRmViTSHeRmVLVIBBU06K2kHsK5ownoRKXpm2Y9TvJ+9/WNCrntvP0TyWKG+R6AS57qYuo8GnzTCUy9xE7b+M5oKQE5aGLWzd4yToumEFynXD0VdrNdtsq8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8936002)(5660300002)(1006002)(2616005)(16526019)(186003)(8676002)(316002)(956004)(6486002)(44832011)(83380400001)(478600001)(66946007)(6506007)(6666004)(55236004)(52116002)(2906002)(66476007)(66556008)(4326008)(6512007)(26005)(86362001)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fu+uDiUJcwZu6cvVE686x6ymuLha0yssevetuCoxTp7SDsLLECBROtIWDC0ekEcXNVszMWsFuS+nl6IBN7x/aRq589+ZNz/7JYf/G5OjeSB18EGmwYjzCbSYgIWj2vleiYV8Mf6RjQQmFhCjYZW3gzShbZ5tEZdEd+WjAlUHD81C6CN8uxacdpajz3XRBFcTBsAXTZRToEncaF9/Lw2elnre+XVQpmd0OpqmtNo3e6OQ874FxPhsu0kh0iuowxAtunQzg1UoliGI4q71WSzLZgPQ4hk5XmhHrCMOZKEN7/Hrhx9pWCQ9P8+PFByXpcYD32VRDPww+z+6q44YBsTlqN88dAEFY/ZA+eEpLPVvmSCbIV3Nya2EK5XgYy8qzDHG1Xm40bE2hIr4AFB9VlT6ZWNYDmeHCBU7j0QmYhvrabe3CfdGlCnRibMgmCgrqRwHwvhuFSopgBFICg/nbsED0SeD1JE03OakKvHLtk5EPvD9IvRo6TH0GYwn3UygcLRutfYiE6RZrVL6m1RieO0+/LXq89PZyzDbOfhPN8+iSkG1bfgyBD+CYSmcasfuvYujB/1agzvZLmO8CZGVYFBRD2HMRTH91IXFlgRRgJccrKYR8FZkfTYlhhuI3pHU+iETGe6hWVzAYFPb6b1Q14zjZw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e76c7a-60ef-4095-6f19-08d854c68ede
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:05.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUjKY839L6QClE2TtnXN33JkEGoBs03bXH35m5na5EDP1XRGEKfWBDItXrtukU94NLd+XrpHKniyqItlU4vwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5c2e370..0464b8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1043A family SoC.
+ * Device Tree Include file for NXP Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018, 2020 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -814,7 +814,7 @@
 			interrupts = <0 160 0x4>;
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -840,7 +840,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -866,7 +866,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

