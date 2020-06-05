Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6317020897
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ax2Rzb74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFECKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:10:53 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:45569
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgFECKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POXDS+Cg0PIg9P9yJ9SgCYudsqaxeOoxARRNGhPvAEXa6aNH4VAE7nx6tymls8TEMcrTOYXrdg4CMSaNxQw0P62N9SpWzZiHOqOH8EXtcsssuUh8Hj/edKkNah8EZBy2mRZzQhakZzPlWOs5LWkYXCnkwl3lDvsJLLJ6onhscRxuJyhhlVLACVfuD9kSLcpsTE+uEKKn79+w2QKiFLMA7KPemIXw2128//dFnDnY2p7L+5kjOG5a8m0yCX5avjbGgXxLnlQGHz76aY4SkNF7vEKrpJ/x0fBVyYm6NL2IDViHocccBtx6LRXG9NdvpKSO/m8WBOHTR3wUNhe2vCVVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTNMJKnmzYPf2aJxxbbqOyDbOxZ83LKwA9t9cMSoDrc=;
 b=AT+IzNx5vUUUgkFAMFJucgxLGyyJYpBOPU7SASXBekAsZ69QhrAePXko79miCJU0USLa/4Z4eDNzid0we8H7C+iO70Fs/Iq/euUyz0Jd5wqu4Tg+TTZmghclsmoSbijtgihoQwreHXPXvDYiLF3lZ5sUsPMJG0tkVqLytrHtCb3iJhGz9OztRuwtyIZm8ce3oOEe0toZPOFq86afAlHnyb61C7N+eBlx/zjNdWpICaZkvao3MIksZxdHPyrNEq4+UFvgHyo19tHFmaPq1y7qdzXn5Fyf6CfjbjbvP1HIn71awBDbxMQk3IQBzYZTZybFQcoOMO3MwXEcJveTGDfGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTNMJKnmzYPf2aJxxbbqOyDbOxZ83LKwA9t9cMSoDrc=;
 b=ax2Rzb74CRGG9d5pF0pFsSi4QvrUETB2o6CQKcTwNK0pz0lnqLYwyzDkhCjMcTkfaDXiPUlP/WaxT1t7X5r8ybDBAEBXb7vqW3J6W3t6ObqpWzfjvBE0IkRdrrEe9ON4ESuHYbqbtqBu2/0eymVk1+IYvu83+76elDJ24Kdt6nc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2696.eurprd04.prod.outlook.com (2603:10a6:4:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:10:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 02:10:46 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        franck.lenormand@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/3] firmware: imx: scu-pd: add more cm4 resources
Date:   Fri,  5 Jun 2020 09:59:32 +0800
Message-Id: <1591322372-3793-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
References: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 02:10:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f79eaed5-4b36-47da-c4ea-08d808f5a865
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2696DB0E2FBDB2C2D8B22F8388860@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrGuVoncW1u9tnGuSHmL3wFuHKr8sM35Ej7M/azG8faU5QBEjL99R6g+5j1DEXO4givrCOiEz6VSkheyRPj41OA633qdwWWz5nRiFoXMBu/Nz679T2VCUtboeiCxC4dqVWhkiwP/1a+sFGWuN8cIYoIReVqvgsJ1z9bY0l0kvrx9z0fLFrct8x1ZiEN+jIq0wsHL2cuADAb7Bw/0GDb/n1h/Ck68c2U3HswAzmTKUlY1tpZGrBjcjdD8qnqBPV4lwl5pXT411KWLGqOlo4lO0qtIvynDM7hHqMDUdZFixoo3HINcUVRExpyLLFzExuUIk3TSRRw0p454AeX8HOv79jPkkn4XGWs6Ws1wClw+4jqPiysw13w1iYskcJFZU8kl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(83380400001)(6506007)(52116002)(478600001)(66556008)(66946007)(8676002)(9686003)(66476007)(6512007)(8936002)(2906002)(186003)(36756003)(2616005)(6486002)(956004)(4326008)(69590400007)(16526019)(6666004)(26005)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CHKyqFLh6VGa8efsS7qiLWV9x3qY1ehlZtc9Sq9e1o2r+W7Nd/MP+7cRw3VnJGZWblSrf0jKM/t+gHQ9FRQqvZRHsjnz6vASz1GfUOa7yBgPK5X1LX0bpOGuQYWjgRMVHJ3Z3Fjj0Bfnjalvsq0BEkvtqKzOg8mOI8WGxTcv6PfzaC6bHERW18iKB5YuLltxOjVMsLXqoGE72qa1N2pUqy5Dtc4mF9/ZCooZtTuMHOva1WEZUD2WOxYZzYdc2e8yRsAHIqj7os4aHPsNbZCtEpzar4REM2SinP77e/DiF7sHRTpgA+pbYKidBTng5VQH1wB5RpmghusRuBju4UpK8nbpRZtOWkKsFcbMON/HyiLe9vf5ykHNlsxQIf40ToRmoVBPVnmTFZHQWdUwL0H9WgpX0pgVCYF3GKkMT/ibiYU1CDw03cknC5NwmpQhevZCfH+l1CrroRtEMY7S4rwODnw5grv8yyQhr/TeV9+aNT1EFMNqYYDuMhx7y63AmUJ0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79eaed5-4b36-47da-c4ea-08d808f5a865
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 02:10:46.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c63ZYavQYsfLWxToPVop6E+BBFA7erYoxdocm1nRcW2WJEWF8ihIFEJIax+H+tpPnHeIrx/UfrokDroGJHla8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more cm4 resources, then linux could use cm4's i2c/lpuart and
could kick cm4 core.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index d1b313fa7b96..af3d6d9ead28 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -167,8 +167,18 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 
 	/* CM40 SS */
-	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
-	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
+	{ "cm40-i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
+	{ "cm40-intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
+	{ "cm40-pid", IMX_SC_R_M4_0_PID0, 5, true, 0},
+	{ "cm40-mu-a1", IMX_SC_R_M4_0_MU_1A, 1, false, 0},
+	{ "cm40-lpuart", IMX_SC_R_M4_0_UART, 1, false, 0},
+
+	/* CM41 SS */
+	{ "cm41-i2c", IMX_SC_R_M4_1_I2C, 1, false, 0 },
+	{ "cm41-intmux", IMX_SC_R_M4_1_INTMUX, 1, false, 0 },
+	{ "cm41-pid", IMX_SC_R_M4_1_PID0, 5, true, 0},
+	{ "cm41-mu-a1", IMX_SC_R_M4_1_MU_1A, 1, false, 0},
+	{ "cm41-lpuart", IMX_SC_R_M4_1_UART, 1, false, 0},
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.16.4

