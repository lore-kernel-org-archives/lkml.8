Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79E2C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D720658
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="KPoB8Ki2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgGWGSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:18:10 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com ([40.107.22.136]:10337
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgGWGSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7tM9kM2Ebzs0jx8cCbXXKKT/bZq24hwpSaFP1DqPB2dUpO/zEajBmrEem3BgZZs4d4u2vvlj0U1lYnd1I8WIcP5nHXxjXc6CuRZyGoXvlXKBqtA8adDPzJvv8ZOMzTCiBqEtkvYrL3NNsuLbwuQoTr4E2FqhiixFStSItEMrliEBnVWaQQwf0Knzd98lBtGQp7mPtKlyHKHOOcNwej+vg1tjiU63FdipwD9gTNH0by0ljt3qlLYZURfFq7mtRINDxaflW8XRkyK4JycMHVwlGwI8nGQmCwWEqAZYK3ac7nN0wqA8rOX5b5SPtK3IssckVGAYA/CVSzR+T2hms0S9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYzWfbFvxnce6TWsJ8eKgE613lRZZGQApr+HX5A2ig=;
 b=ib2jhf75+GcQ8F4m6Mn6jtRu4lktkVTv2m4S5mmhvSDY0vntSrKMDfeM2+lBFfbICm2zOmbzkj41tC7ueGoXxAB+FLX9wXumnQ5llix2lc5sIjfnn6WdF9kFh/2WLxa6PmzkUUFr6a5q7BvAUaOkzaF6KGeBZ5AE5VY5Zz/3lmFczPdjHRSAELZ83HSmNXktwfZ3VZFGNQePWrAq3CPYljJju1oWMwlsL65FZtXDNjZI5PY1fJWeslUvN6MwG3TpMtmeBZRvUpWAUo5Lcutb6rjL9ZUpSyPzK2yF1+qzLRRjvvQxWSTYi+owHN8wPs+EXkM9lJnR126BZ4+Xap7DNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYzWfbFvxnce6TWsJ8eKgE613lRZZGQApr+HX5A2ig=;
 b=KPoB8Ki2MGoDQ6tpe0hnQL/d/norNeK1TZCcu7MYTVKxyl426ySVymNhU0K18+Siwd3ghyQ38lPKgr8jRVeEdh0wHl4fQUWjfIvsg8JRY0VJOAAyaQ3AQo/QKmNk2IzgkpqWSCLlAA5XpLlovdYMpfWICRgf9mmfHo4VUZiWVzM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3548.eurprd02.prod.outlook.com (2603:10a6:8:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 23 Jul
 2020 06:18:04 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 06:18:04 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: Fix memory leak in error flow of context init
Date:   Thu, 23 Jul 2020 09:17:57 +0300
Message-Id: <20200723061757.12906-1-ttayar@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0082.eurprd07.prod.outlook.com
 (2603:10a6:207:6::16) To DB8PR02MB5468.eurprd02.prod.outlook.com
 (2603:10a6:10:ef::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ttayar-VM.habana-labs.com (213.57.90.10) by AM3PR07CA0082.eurprd07.prod.outlook.com (2603:10a6:207:6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Thu, 23 Jul 2020 06:18:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [213.57.90.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57478071-b7b7-4e90-d680-08d82ed0287a
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0202MB3548516714B14CAA0FD0340ED2760@DB3PR0202MB3548.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzC2JAHFIFvRURbTZhO8trbScpwCkoj/LpkNmNXHW7pKMilIOA8s7yLMHGoG9lkpw/m/E2Gtn8ktFbJ8PK2nTwol5E0ewOzZ4e0fa0iKjQRIyUekIFzBhi2aN6ipQdPJOkxqZSqC8v+DS4CqzvNqMi049oxMZEcK1XtJkLJ3EF00gY8MomtDQbajhvIET/g1WWftRYxfiAMQl79IMBSy8CaLkDp9oG0cOapXDDi9iDU17/xou8fD3wAahhg2x1JarHlF8JyH2JPFYmUG8G9vNNno4qI+LRSELcZmci4ZTMO0MmLmIMWkw/bhJPHN3EvzYhDLGhIAB778bbe1VClK8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39850400004)(396003)(366004)(107886003)(186003)(2906002)(6916009)(26005)(6512007)(16526019)(6486002)(8676002)(478600001)(6666004)(36756003)(83380400001)(52116002)(316002)(8936002)(1076003)(66476007)(2616005)(956004)(86362001)(55236004)(66946007)(6506007)(4326008)(5660300002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /hWMGiNwOQxubcBcCkJBzI+9FyOWL0/s8BUWm8Aagt55s0vrVt42kgEAK3hWV5uYI46VCa1VORfLe7J06thvybV9IxGhdrFQKxSuxpxspLh/rRsnqfOqhiT6I2Bg5x75InhmCJ0+vcqsyU8rb6sXkcmdfSV0FJu/eQePSGwtBB6m9CJX2IQDmp2FuBJruCfqtJAQb1HPn/bYMsuXBusI4v9zHY9BzjtbNC3p6wsxypXRbeYY1T1HzGRthcGW3ZxEcHz6BSInIEi7997Lm+qEGWkUQr+5HkSwdemDlnZ9q8fX2KR5koHgHHfRF3DcA+c7HE7hpUgVQXMsIyATb4JIkZsHUptr4IbX1uNwobyaKAjtrcN7bwlfVfXsKn4Iddy4zKqphd2dzT9bURQHrfaQrC4NCC9KDcxPviz51+xoEXlIxDB3/op6bzyr/MzUZRd98z5Qd0DG4KHzvlq1+Joodx94jL3vNosjPIh2fsVXN9A=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 57478071-b7b7-4e90-d680-08d82ed0287a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 06:18:04.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfB7O3IA48NkCS6pyUdyF0RSXnVfmQYld2iJ9VWdzEZlKu/gVEB91mPxys71bCuRijFVes3dRZQlJzwT+0K/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing free of the cs_pending array in the error flow of context
init.

Fixes: 4b49c5b118b9 ("habanalabs: Use pending cs amount per asic")

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/common/context.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index b75a20364fad..3e375958e73b 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -138,36 +138,38 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 		rc = hl_mmu_ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "Failed to init mmu ctx module\n");
-			goto mem_ctx_err;
+			goto err_free_cs_pending;
 		}
 	} else {
 		ctx->asid = hl_asid_alloc(hdev);
 		if (!ctx->asid) {
 			dev_err(hdev->dev, "No free ASID, failed to create context\n");
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto err_free_cs_pending;
 		}
 
 		rc = hl_vm_ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "Failed to init mem ctx module\n");
 			rc = -ENOMEM;
-			goto mem_ctx_err;
+			goto err_asid_free;
 		}
 
 		rc = hdev->asic_funcs->ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "ctx_init failed\n");
-			goto ctx_init_err;
+			goto err_vm_ctx_fini;
 		}
 	}
 
 	return 0;
 
-ctx_init_err:
+err_vm_ctx_fini:
 	hl_vm_ctx_fini(ctx);
-mem_ctx_err:
-	if (ctx->asid != HL_KERNEL_ASID_ID)
-		hl_asid_free(hdev, ctx->asid);
+err_asid_free:
+	hl_asid_free(hdev, ctx->asid);
+err_free_cs_pending:
+	kfree(ctx->cs_pending);
 
 	return rc;
 }
-- 
2.17.1

