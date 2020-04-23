Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FAE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dS2h0QYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDWFzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:55:10 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:45075
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgDWFzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7BAloR1QKB7I4G0+2iMmxQDFiO8p+snCTLQKJjtqS3PxYjC8YHUaas7eBKvLIBGa2NJ2GJ3Kb+vh+9N63AxJ8XaIOAEJ3mpLpolnIbfkGfmGeW6daROBMU6y0xF/l2XlsVf5gUetNf//3qMryvHlJdOwWJ6HOZTnwM8cHNNb1N7Qcl824s9POtRLCgiz473ZUK6QcmZYqC0we5WIC6u/geI3q0Jn3osdrouAv7XX3GIlRXABH1hobWVKewylcCj2Td4KhWI7GQY6YV76UhN56glmcG5ZvURXWhEstEdD08UuyfBIWCs4rt+6T/YqedC1lul1q0A5ht3J3tJkp4nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKQNys9bM89V5fWqHce4Z44blJ+W9EhLHDEgJS7DflI=;
 b=DDxIHeOsDec5FsF8X8mBOVUxPVJlNWIM53UR+7QCf130smz/kcQ46TMRsdM7g9U3UKBkk7P6wa7ZnJ/ZRkLhJcKch5E5err4Da2AdfcLSZs43L+D0OB+sMn1gxTvigPy7/H4AROZtqIWaHheb7hVo9fvJMkxxTPGjxmI5pm6yNl4g3KdxhbZh7HC+w2PKPlE4diO1Qz15zN1G/KLbP3p5+fHposjNU/SCB7QJRiZ+w6JpiKe6yRj7fzpvFqz4qdAWZM8+KM/Bccl7+Z/BYdEwqPdEAbc+0TvrstxtfTlC2dHX7vff1t5PO3j4lQx/NqnT2M/Hof+aoShynnFEpHhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKQNys9bM89V5fWqHce4Z44blJ+W9EhLHDEgJS7DflI=;
 b=dS2h0QYOsUAPILO7/Ae3/+o5fYonKwGeGHJSPmpi3fzMlhYk2KEKd9rvg3X9QgNrYEgzCUXmJ09zddw1mGDcHLxVmtbWmrR5YB02WWOKCe/oPxPWpoo4R8q65vH06c7MglfjzhYV5RgBTlDCTRtUwyLMZpD4JsUH4eqjJf/moGU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2712.eurprd04.prod.outlook.com (2603:10a6:4:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 05:55:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 05:55:06 +0000
From:   peng.fan@nxp.com
To:     broonie@kernel.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Date:   Thu, 23 Apr 2020 13:46:31 +0800
Message-Id: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0075.apcprd02.prod.outlook.com (2603:1096:4:90::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 05:55:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72645e57-de95-437f-bbb7-08d7e74adf79
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2712:|DB6PR0402MB2712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB271215A7AA2EE0792513054988D30@DB6PR0402MB2712.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66556008)(52116002)(8676002)(81156014)(66946007)(66476007)(6506007)(5660300002)(26005)(86362001)(2906002)(36756003)(478600001)(6916009)(316002)(69590400007)(6666004)(6486002)(4326008)(6512007)(2616005)(9686003)(16526019)(186003)(956004)(8936002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQICZkw0uX8QUCExgP5BdP6FGSDT4K+x1gh9U+xQRg7Z483HoM97HVAPWm2EAut64cRNRZD597sCgPBCa49j3Z200TBuMDy0c24cnMsqF/68VA6Gdoo4WWRC42URChyNOMqUvalZuAvC+rgSNU8UUoonWDI7c9HceLnq+jKy+9vXBVA2xLGiHQzO3VxR9ZE6tiTajdvhwnOH0TRTQ4z8dFlvuRsnYl2FoxxCrltx/QYXW0F3GCGsH0Atr2J+vNYYqZNGbaqJUiUPMsPmJQMgjdGkH4m59y4Aze+B4yCaasUABQvmRA8enypQO2YfvVfrXHbGpg1MHbwNKgnduIsVsOXwvqBbJq8t1uXqRiwsTz4WXes5u/o34jv7RoF7AcRkU1po9FSLZuzjvNYI/szazzvZc9klKOCquKWTNGNNwrciBqxW0JyARlog02ZpwaIgaonP7CzXAYTdxTOZR0T0Nly3aNotTttAMMb1OpUYQ6xhF3ymYvUM3P0hi7zVitDM
X-MS-Exchange-AntiSpam-MessageData: FcJQ3YGvr4UwMH2hz5Ei+3SoJw5zkpIwfzY4pgt5xB7i+1MT/jSVIhcx9I6rmWFfZcmYZMLQmYn353JzHwQCmk9Ry5930VMHZ72g/LWIn2+aVToPhUedW+ncXicrRTsRdd0dOtUSNVFsZvja18Sn4w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72645e57-de95-437f-bbb7-08d7e74adf79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 05:55:06.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZZVWxwemztr8E6EmcsdTD396T3d8DMTAsp9YkGkF4hTEipbep61I2z7VAKat3GVV/dainWJXPRW6ud8BHo/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

use clk_prepare at the very beginning will invoke pm runtime resume,
if the clk is binded with a power domain. This will cause runtime
power high. Let's use clk_prepare_enable and clk_disable_unprepare
when read/write to avoid the runtime power issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/regmap/regmap-mmio.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index af967d8f975e..a1ad7419c4a3 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -118,7 +118,7 @@ static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 	int ret;
 
 	if (!IS_ERR(ctx->clk)) {
-		ret = clk_enable(ctx->clk);
+		ret = clk_prepare_enable(ctx->clk);
 		if (ret < 0)
 			return ret;
 	}
@@ -126,7 +126,7 @@ static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 	ctx->reg_write(ctx, reg, val);
 
 	if (!IS_ERR(ctx->clk))
-		clk_disable(ctx->clk);
+		clk_disable_unprepare(ctx->clk);
 
 	return 0;
 }
@@ -175,7 +175,7 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	int ret;
 
 	if (!IS_ERR(ctx->clk)) {
-		ret = clk_enable(ctx->clk);
+		ret = clk_prepare_enable(ctx->clk);
 		if (ret < 0)
 			return ret;
 	}
@@ -183,7 +183,7 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	*val = ctx->reg_read(ctx, reg);
 
 	if (!IS_ERR(ctx->clk))
-		clk_disable(ctx->clk);
+		clk_disable_unprepare(ctx->clk);
 
 	return 0;
 }
@@ -193,7 +193,6 @@ static void regmap_mmio_free_context(void *context)
 	struct regmap_mmio_context *ctx = context;
 
 	if (!IS_ERR(ctx->clk)) {
-		clk_unprepare(ctx->clk);
 		if (!ctx->attached_clk)
 			clk_put(ctx->clk);
 	}
@@ -305,12 +304,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 		goto err_free;
 	}
 
-	ret = clk_prepare(ctx->clk);
-	if (ret < 0) {
-		clk_put(ctx->clk);
-		goto err_free;
-	}
-
 	return ctx;
 
 err_free:
@@ -361,7 +354,7 @@ int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk)
 	ctx->clk = clk;
 	ctx->attached_clk = true;
 
-	return clk_prepare(ctx->clk);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(regmap_mmio_attach_clk);
 
@@ -369,8 +362,6 @@ void regmap_mmio_detach_clk(struct regmap *map)
 {
 	struct regmap_mmio_context *ctx = map->bus_context;
 
-	clk_unprepare(ctx->clk);
-
 	ctx->attached_clk = false;
 	ctx->clk = NULL;
 }
-- 
2.16.4

