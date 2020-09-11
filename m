Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E318C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5A321D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QY2iJKmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgIKDiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:38:46 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:36230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgIKDh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA9GRp7Tew3ixJdxkVD/DEutQMkjHyt915G6UCbYETbN/ekrZuHYF25DQmkO1Ailn2NX/3esiGAErF/jcgCMcfiLcugox62nIqRkMhP+0WlxFksG2mF6kjie68pg1nHzQg00WR2dnZeK6DnuH4urvNK/+CsVGyxSIKINEz9kcKkCHNsYbjzqODLvpqvPBTp88t+GOi6NBbsi0GAvVKbfAEvutimnb73GIPn7UVA1OniNw8R6SVON/3CUgk5Myc2jpScpZJy5LjQObKxwbqf193HGAzIO9fVn+4FrjAlFrwPcTjWiQ9zvSmcHE6gasdPn0yG15//95VH+k349hHeJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcttnVBSK6XVWdIAzncorlxnBlk/3LRc8dfbGrywN74=;
 b=mTkZWpC+EOtP802DKGcZENN8v8kq0NVVjSFBqcGumAzZvlCDofTx8+5kWAz1TK/LUAZggtiPRoq3/iYGbGm+3WTA9CuH4K5Podh3GLmql7m0in5S4xVExnHVOIPY2WIFu/s5Vh8EkV7mScYwSRPZdbw3msz+a4YG4oxhNeD3iLx/GkkNU+DRWrQf/YAYODg9AvOEkb/oG/3YOvnUN3LJENGxvsOj45cAxEWrXlcgJQrc2fakDUtK7lFLqQNcMjPKjBlGqyuZlp15fVYQ/SzWP6TxfomQX64pMtl1ONkywqVVf2P4clB1CJ3WFu4+EeIFdC75zjoMXxMUoYJ39Bv1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcttnVBSK6XVWdIAzncorlxnBlk/3LRc8dfbGrywN74=;
 b=QY2iJKmFCEh7+h8yMsemauPh04N+79F7TmG6E42vrmI6yoxE+va8x1pSLXNP+oZoH5dh87jxz6cV7vOn3Ns2VR9HXrL9Gkzt7CPeZCMbIUxyzjUAu9xO56yEbHnLMrNCa5j3n74wvVt2+CPTgpZrxMceNKbXiDVfiP9aa0qK7u8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:37:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:37:41 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] ARM: imx: imx7ulp: support HSRUN mode
Date:   Fri, 11 Sep 2020 11:30:52 +0800
Message-Id: <1599795053-5091-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:37:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f3414ed-d81a-4441-b8ff-08d85604096a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5084FA2945A24EF25242262E88240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17MI2A95cK1JcPtK5k1anLdzmSh9iOYxigBrMpjpxxxqNFFNLIQFIHR/RF6IZR+sCrpE3YChxZKYNFChwoeBgYuZ8yN/9FHmg1+368zpQ1V6OCezyTUWQJLue41pShE+cy8tPJR2Al5uHYMsORLkpP0xYfBRUb8qL1dV+FUI9CmZJg1USJ4hQ9nQyW4/BBgp/+Dfptz67mqhVnDVwx9hCDRcT4jysZcL/PnPBAUShE6anhUojtsbJ/Y+tA3zcS25e0xR0uaOajTBrapLa/lURZwJnZGeMCRXR+EOC30LH3ZagV8jxz9iSt+g4GLAByfAwH5KRr+NVgfJVhc2j/5+zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(8936002)(5660300002)(4326008)(66946007)(6486002)(316002)(16576012)(478600001)(66556008)(66476007)(86362001)(36756003)(956004)(2616005)(26005)(16526019)(186003)(8676002)(6666004)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vh7bHQ1n/LWXjYtGWaDxlFiT54B/iNYi5PHpHupGWhp2lrmLbvXYzQ6XeKUp63rwz5ZFUA5RdOFy6xIn6w5+RTI0UzOcCSR5azJY2rwy5HlftxrCO9yrjSUp1JvWK8ldR+BSV02AizpQjKZzHjJ//xcXV0NYncDgEUgXLFMwzgtGPj520mqswqRki53jfY3OgXx3NhVM6UQiT8DveJ6aPIUmkF4WauDVFSbWMOM6FhP18W3Bmlz27JhOxH24Ti5wujKSno2/b/6c5I1dQYpmVU/AALhREajqAX8iwo1JqH5LbJ+lVyp48LaVxYQSx0IvsIaVkjV7pHCvP5ufOcXsRqvu7e9wlw+Fj6C444QXPobmwHNK1YD5t8GHRMGDEMmEKJ+5DCCVSw7pFCydGz8qzimAYjmd9TI3SuCp1K3Xb7RL9LxlFgEyH/2aJ5VQYA3G2AH4qwgBuPsBVS8tjPDvvmm5E5y3Xo4fRe/bxqCva+bOoSuXuqYqr6zpgXSKfPMu0eOBocOPm5aRbnr3u73oW1rE011e2LGJq3+6P0agTSNpTYB4SlBGsq75hw3m8BGcR1zMLKczW6VZeVSdKJgHjgRH/r4FbIJOlVWeB5frITsNmY6BwU6lGMz/yQtdRJUbAOHNxi9EHcZF66X6PTyQvw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3414ed-d81a-4441-b8ff-08d85604096a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:37:41.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHiKbSvo/tNUo5S5AvetJ+cVfC7/PsBuUYNGsuzzo9F+O5SeWYsp5R1Ifos3SJg2rV71K/qeNN6YH1rx21UCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure PMPROT to let ARM core could run into HSRUN mode.
In LDO-enabled mode, HSRUN mode is not allowed, so add a check before
configure PMPROT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..543ac69f5f70 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,10 @@
 
 #include "common.h"
 
+#define PMC0_CTRL		0x28
+#define BM_CTRL_LDOEN		BIT(31)
+
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,7 +29,10 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
+static void __iomem *pmc0_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
@@ -65,5 +72,13 @@ void __init imx7ulp_pm_init(void)
 	of_node_put(np);
 	WARN_ON(!smc1_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-pmc-m4");
+	pmc0_base = of_iomap(np, 0);
+	WARN_ON(!pmc0_base);
+	of_node_put(np);
+
+	if (!(readl_relaxed(pmc0_base + PMC0_CTRL) & BM_CTRL_LDOEN))
+		writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
+
 	imx7ulp_set_lpm(ULP_PM_RUN);
 }
-- 
2.28.0

