Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C8C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC8221927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cG0rWpGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBDNlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:40 -0500
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:9938
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbgBDNlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msGO8O7q7PA6KxcxMn6QnMpwVAtdxBJEmnbChaoN36F0xoINaH4A0LhNOQ5HI13iUmX4m+xZcTaxHf6aWbujqIFEM4ejlLO3+4VQSR6r9/kZ/ycF1PK69AHuHJjvGLjz14Tc+AvRNUnwfoW4pfCSPbCf+BdVF9AGqPAyuy+rw7U+RU5l8jdCh3OpOZHHdzM6Dep30yXuej5PVWheMqNljOvxnSYtK3xi/W9/HbRvKPSwENDV5JtsUPN1bpG06B8J7FtokSat66sivs9MFdUyGtsdTPJ/827k9z8KVWydm3L5/hNeSF83auHGls5DH4dVYAL6XLdZ2hkpfpuTlI/nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjcVH/OE1OYbG2WI3e1JdUW90gQac/Y3FTEYb7pvf3M=;
 b=AD9jRoDTux6c5fnHzPLgdnyyK8cs8Jj4HD7bxLOZpstnO/MJ6/JWh9/8Mxse3IbPshqoln2e5G/A56Sd6J1/uMfyZa0byDO8EJgXjpsQFvhY+P32J6Md2EWI7DuAFArZQZe0NhlJt88hEQtMC67MQJuj82znbTwl+G0RkV+E89VWOw6dR3SPlxyzgPFSClWQ7zBEDAQLb2Cv9X+me4745AFW/2drFffCmvIN0NxM8V+b9sqesEBt3Nxwg7LKspTJno+uTpT5tlGfmpdv1khEz2bfqSvwzbDHwsPc1NylgcjQ4ZRrueybEVZpVQZvp71d9F1XZYV4BdkvqLox1jz89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjcVH/OE1OYbG2WI3e1JdUW90gQac/Y3FTEYb7pvf3M=;
 b=cG0rWpGqSSI5Xe30xFONRtv5uEhvPcLA4LUZPyO4ulrsYYv3OS1qaNGJk5Siem+B8umEgSdGpWoGj8CVFbQj5XmvCJAZw2k7Qp7S4RX0ZE5fwPDPahvvubxkHfMWy0iAcjg9x1aeq1ipS4xgNdmHplpqp7vKHLM1OxnfkUD8Tqg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6932.eurprd04.prod.outlook.com (52.132.213.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 13:41:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:36 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] ARM: imx: imx7ulp: support HSRUN mode
Date:   Tue,  4 Feb 2020 21:34:36 +0800
Message-Id: <1580823277-13644-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2407a0d4-64d7-43b6-fd7a-08d7a977f462
X-MS-TrafficTypeDiagnostic: AM0PR04MB6932:|AM0PR04MB6932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB693225CE6CA4B1BAEC30CF1488030@AM0PR04MB6932.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(16526019)(8936002)(26005)(186003)(2616005)(8676002)(81156014)(956004)(81166006)(4326008)(36756003)(86362001)(478600001)(6506007)(66476007)(66556008)(66946007)(69590400006)(4744005)(6512007)(9686003)(316002)(6486002)(2906002)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6932;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A88d7CU9T7ACFWmM2sKHbhSFcbGLfOXlyT+ah9Syzn01sqT2sq96yqPpdvAqmkR4OTQDvS4nnIzp1areINXQpdWU/U9jZRMr63mq2fOhVRxj+JjiAFdUCly0lfQY02eerryonj4XRPF14IzQmvR7NhiwK70p+ElSUoukBYwNw3m01sb0tEyMVvt3MWwwsehV74wQ/OKdXej5nUoS064xmfId/AIJ77JI2F/gi74PMzSNIHFWuXixa4uTqubeCJQ6lBrg7nGSrdIF6IsK3t0rxBu4mqeqv8UsxvBT1Y+aMfqM/1d4bw5uu5zUVPqV+wAYkurjdAF1aatnF7LwVsd8u8Ou7RIIMA5jMz13rU8Nohim9IdhrqWZUvhH1nyiHuIgl5ngz2hI+YQ1rh3mERHqYXk2SGHsAZRNI0jcI9f1I5fe1z0SnE3BwpMqz2u+8QhoQYEhw+z3U7WBEeD82BWOVx6funO3Fv700bD7btKHrkGXfcM5xTshW7AWpJU6O6jPLXMLPpuJw4uTBGfHIFVPIRw07UtjSuCEhqLKT63UK0w=
X-MS-Exchange-AntiSpam-MessageData: /k9+Hfg7AfuMfIHy9uWeY5DaYldn2AnlZw7CJt2Ez3WIs9+KegCAhdkB18POu1ycstD5LOsTWpHAmT9381gjUL/x25PLAVjDwI6u2JhyqLCJNzOTmb32EmGOsCr/1jZTVXOWxAfTcz3k6DlRDpvLrg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2407a0d4-64d7-43b6-fd7a-08d7a977f462
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:36.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhk80Wb0AS0XMMZRoUKcWThbAg4Wnfz3sWAWVXdRPHG1WssoogtqaJU13ebBqlIn1Oy5WPHMGl1oKuzBrSYH7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure pmprot to let ARM core could run into HSRUN mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 7b2f7387e662..dc2bc6f2cadd 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,7 @@
 
 #include "common.h"
 
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,6 +26,8 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
@@ -51,6 +54,7 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 		return -EINVAL;
 	}
 
+	writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
 	writel_relaxed(val, smc1_base + SMC_PMCTRL);
 
 	return 0;
-- 
2.16.4

