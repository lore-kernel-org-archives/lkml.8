Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5832084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGrGqP42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBDNlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:45 -0500
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:14849
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbgBDNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD1Hcq8XItEIfUat0huGq9C0JLHXIbgeGiTtjQMcrM0Ok61QQr/PA0JhEg/yF/7SFgA88fKBe3PB44tNHK849XxVdzgqg015TET3yqRxfpRb2hOvRBTcNszrph8DSNEk0qHg7fUYKQZvIvKAWIoyp2q2oXYLROTMCj/4koiP7d7aZcdvFw6DoyYf9apsDWrKFAuDTfHK+zqOhdcNLSyy1FVMh+XTVfa4c+vt+koNxuJcxs72ecvMs9NnFrX5cYi67WVAojdeP9h6KkyZFr7OmD+a/Sd3VyO4x0EoqF3VtknqYjGpmukniDxVtPyZtKbgP8BrZ+btY5zw/G611kSS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEvjWr/4AdbPMAtC1YFADze47JBcfN0qbQO1FdM2O68=;
 b=SL22kKevIjInpACyB4NUXI8azzwUjgbjT2/p9C2YZJt0wBzIeNJ0KQbPCEh88uqzos9wiEPYWe/uM9UzVUclSqXPKmhdl+UBAv6+44Oz8qYugnn4FcutQeY4/wNev+7cnZFcJvnBdnSgBlEBv4oR4qn5TaD87kwq2L5ojN4qYkkGW2WDGF80/Q/kIZVXAeTRgquvM3VjPzjg914bHiOQMm0JuVLTd1nAR2s28PlD2bSVXUfeZEP/MhD/T6S9DPJcPC/J+sA4WGNQG2mfVueBaJVcEqjHHYvf27DG0329h41hv+/3gIbi0vc9C9iclSZz3LPbFpxfeGhPqX7n4y5oAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEvjWr/4AdbPMAtC1YFADze47JBcfN0qbQO1FdM2O68=;
 b=ZGrGqP42cLN9VPfkKfNCfpkR7BtHsNToGhk7VIRs7Pmx1B57dta9NeHJ4gCFQFGMIid+oBB7vRETKURErTGQbL/tYmcr/UYu64LwbnpHB2dUTUE4KSB0WyHwD6DxWIP/wbTxXt0H3ffxOUfvuCyVJ6Dz/XbEMgNUteAk7ianIH4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6932.eurprd04.prod.outlook.com (52.132.213.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 13:41:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:41 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] ARM: imx: imx7ulp: create cpufreq device
Date:   Tue,  4 Feb 2020 21:34:37 +0800
Message-Id: <1580823277-13644-8-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ee1e305-793f-4cd0-36fa-08d7a977f725
X-MS-TrafficTypeDiagnostic: AM0PR04MB6932:|AM0PR04MB6932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6932E326EB1DA519BBD960F688030@AM0PR04MB6932.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(16526019)(8936002)(26005)(186003)(2616005)(8676002)(81156014)(956004)(81166006)(4326008)(36756003)(86362001)(478600001)(6506007)(66476007)(66556008)(66946007)(69590400006)(4744005)(6512007)(9686003)(316002)(6486002)(2906002)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6932;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRKqjbExcXdjnzh42MlKq/RN0e5hNSOIooptQxI8q/jSI0RlSp/s5ErUMCK7gLuHc4mfkceBP4oHO6+5P6RKNc1QVrteqexLRgrdpdCpMs36fG8wqgiVBFq6HmM0YEP9mc05OjqSJ0xLTdkQlFfmGJ5x7i6ir//ndLXNmej3mLFLuT6+DYrxDYjq2GiKYL+Fq17dZzwtGUDlZ4ar8PwoVp/TzR4tMA1/0oSTxuaM8qu3nu4ImyGN9zG/FtTwu2ExFLz5V3q/Ok/U616E7yxezo50FRw/WTCMvsGCN+bXiBPLn1iypEFS78h+zzSPgsaua5VBFZgCl5AVWaCxZK0HrUA7X9qWh8i0P6ISIylmo7COoUg/nBBKtYtARzQzmFPOnohzyIjMrUlFiPGVLU/wQwXjmWfiN6reyn5NItDSWNna4YbNXCaykwNxDYZ79uAUWNwtVQryo5hJALzXk/JPAFcnKBYfA9yLpECm3vMwP3wPbA2U01AWUrEC0XDSfgNpNqY6Kp0lTnUiwvOEuiL6cHKS15YwTIZN5QC80hfypDw=
X-MS-Exchange-AntiSpam-MessageData: nFnRvmrc5t4r63UlwMxbjLlWz6Prm/xRqZEJjkrooVMixm7J59os+T/asyqgXdJP47ftZ8WtMCYtxKHZrD3H1fv9UZK66ffocKAlh4O/ZPQewttpr8aD+mIwqneUDwAmEMJT+JaBj6TPvcns1OZCiQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee1e305-793f-4cd0-36fa-08d7a977f725
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:41.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvei+I6lgn3QdydFwK3Bq1lz6cTIBb3bGA/q0k5M2SBppfVNlJo9d4C3OpxdnX2G+M2FnHK0tom9jbREcSbHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Create cpufreq device to let cpufreq driver could probe

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mach-imx7ulp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
index 128cf4c92aab..fc44fb4ca48b 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -67,6 +67,8 @@ static const char *const imx7ulp_dt_compat[] __initconst = {
 
 static void __init imx7ulp_init_late(void)
 {
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+
 	imx7ulp_cpuidle_init();
 }
 
-- 
2.16.4

