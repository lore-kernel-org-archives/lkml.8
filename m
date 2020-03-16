Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05BD206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hEyqCr1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgCPDPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:15:53 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:41862
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729655AbgCPDPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 23:15:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFErWGu852fv//9sgQIpLbZNgLE8Cdw9SOj/l2fdCNF0FVkCLIRAHQijCrWhTo+jjKBwxQNCllxagSuoclL5XmklekVpwAUkdtpEqCKCBJ+o40CE2XfeCwjZdqHEJe87XuThTtg5icu6H2mtaRlVCSasatH1jdUsnn1it2nmwMNnRLY8KV4TH8YFjL3AtxsgHYEhFvQao4RJLF+HtwYxH2p9uq+mib8kXoUUq6aFCXklnTLOLbx6BHqxSZXDMFkB1puXKRhoOxyVbVFGEZ2Tl0O63AcvrvzK7/J6oYoCgdqwjRUnEpnasgMaPVuEWJTVN5IRtnTHO7FFAEhkLhEe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFpcJfWftyCyHL3ntM+JubuiOiojkiOMfrs1o5LdxuE=;
 b=aXQ3sIL7VfHIAam2uqHLUF12lFLbHIrEufM62v+HXo/DvPoogRs0Et4hgPp84kHy4qzJSqJRf26ZTVikr0vy3gGI7rdpYA/hXbcWXUSTfOqP0YsZ1zdbQ3KBLPKrkR/D11Uv5ptg8l6bqvJdMZlJKklwLU/R4+WYCfjKdwvDhDsTHeyiZoCtlPvbOg2ywpNngXUKUduNelKJQ5fCNOdp6xeDIO/L4Ygr0lnbPC8XtXZnvLMOrPU5dHOh5C96wQAG13HTuX6+8ZiIzoY5ohyfmrbIQvTIbXU04SS7BkyC2O5Ca0JwE45kXWTgbQx1hO+a8meD2CZOHujlFgA+UAlRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFpcJfWftyCyHL3ntM+JubuiOiojkiOMfrs1o5LdxuE=;
 b=hEyqCr1FD+GF6YOU6/fuJfr/vAULhERjWYO+fAUHPqY9MOb6Iy2NQOCXmtfd/PJ2VgKfHWobLLWLYhOEbvW9ec/XPOonG60JjsXagmK1AhlQicp1jJnv4Lr1V4Jcp//1cfK4OPVp7Lv8o2GIM73v1KfWXuGr89tvSy89FCfTlf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4225.eurprd04.prod.outlook.com (52.134.91.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 03:15:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 03:15:49 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: drop COMPILE_TEST for IMX_SCU_SOC
Date:   Mon, 16 Mar 2020 11:09:02 +0800
Message-Id: <1584328142-11810-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.16 via Frontend Transport; Mon, 16 Mar 2020 03:15:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b60b472a-ae99-4789-d3ed-08d7c958537a
X-MS-TrafficTypeDiagnostic: AM0PR04MB4225:|AM0PR04MB4225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB42253903013F267F80A6D59788F90@AM0PR04MB4225.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(2906002)(2616005)(69590400007)(4326008)(6666004)(4744005)(66946007)(478600001)(86362001)(66556008)(66476007)(956004)(26005)(316002)(6506007)(186003)(36756003)(6486002)(5660300002)(52116002)(6512007)(8936002)(9686003)(16526019)(8676002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4225;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyAMpjpe1W5ka7bQxpUjbVPj2uAcpfzLaOKT/69CI/9KYe80gY87rOSmuj5RmzXrBix6hi5bmI09bMZCKtwwEbMSclaCVdSA9LlFardm0PuShbZpHOHuVg8yRsMJDaR3zg3FrnA8pFfAipRju/pPC8iMLQYrbnfm8rxEJlde7qyPMQ/rB1iMmJqDiOepJwOrNGgxXDFUAM4xGyXevX4h8T2zs2JZMb7YmGP5y/k96WcoVAge5GgvtNE8YdIGJ3af4NJMA3Vce6N5/qNj7WdLTyk7dRfV9CmAO5tXArSikHpjxCyf8pdmE8TQRZpYX3s97hgsJQ2u2Cqdb5dlk+3mha692LUZB/DCujdgbDtvUz9JDjy8T9gtQ2VH+dIX0h0e+XIFIO3278BK18c4tF9C/Jgvg/DSEoa288BBwjD3QCECGfiKm4mqk7jEn/kKCMDmwrqqidHoGncuZfxDbucM6s3MGxgRAPyJu80gqXwgl+63tvmc0M23iHywdSiOyB0o
X-MS-Exchange-AntiSpam-MessageData: FvgLiG0KB60DusRGQ3RcraBisx9woOQVu7TWb2kDkv30DhGOGarwmzBUiYCQTLBHIi9t09B3RWcIF9Kk2oomSozBIXET8dDW0sIVZW4zjzqc0PGZIUZ+hH1oE1vXRFB6alXg7yY9AbcqmPQi6Gau+A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b472a-ae99-4789-d3ed-08d7c958537a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 03:15:49.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YigBz5+szbxTznNEoja8FLF1lIZ9DRg1kvHhyrY0BDmeU4WLEzXDJ3DmMQgKvB54MWNcZmqp0KSldTZ1CaqkwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

With COMPILE_TEST, there will be build error, because IMX_SCU
might be set to n, so drop COMPILE_TEST.

Suggested-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 0b69024296d5..b18271e99d4f 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
 
 config IMX_SCU_SOC
 	bool "i.MX System Controller Unit SoC info support"
-	depends on IMX_SCU || COMPILE_TEST
+	depends on IMX_SCU
 	select SOC_BUS
 	help
 	  If you say yes here you get support for the NXP i.MX System
-- 
2.16.4

