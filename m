Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34193C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AD8207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fDEhWA7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFCDnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:43:03 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:34760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgFCDm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuOyomA1C4aSGVD7orgYzx+Q/IqwVKQJcFWrhINkASd1iugHpM2Rz1df7UMapdGK6w86CVPN5Iym6eG+7JRgQKbAzj+56/MKVo7btp+BnQ6cjzsJhbkNZRl0syT7uD2R4qDGYuqRVqCClmFfx3WsQSaQZpYeJpR50XTDLitvRYP1jvp9E+IUB5IspyVKckv7YgE82YyZs09BBOZcyb1dqp4RtgvqDiG96OF6vkULTJKGues7uqx269SoFZWtGNZhdrQhUe7IyrPLbVEBgPIwqg79JcRQYtcBQNT4bNAVKWVxHMi5gaZhHmESlrDw8BC3HTeoPhRPR84k6No8Y+CrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8k7NXNuGefdlSKiqskM6lVCF/mKipaKJjqtQnfYlFU=;
 b=guMbD2aDYFKDlLrM2rKoyaG2o0ZpzK7W86I7gOakIeHuPDr9TTbWXgZXk7AghnbsfEn9D0t8dAIiL7ss0jTiUSdudXa/OoRrgRA3HK+pDVkiwZq+MOpJ7C6dRlZong4j+ECOQYz7TP2aVDmLBEowmau2Yyy1ch7PvpCbHc/95YWpRa8JerpR9mCvlrMWxDaqsvtGXVU5Vl9JCWhng+txt6puVw+b6cN9IfDPeG15L5LZwEDgpauI6olKmvXmdAiXpOWOdWJ1noVYgz+uCwPzHURAGafKgC7MiMpXEJsDOQ5RNvxT900WymKL8ImTtwBbIDHWTWE4jmeoBbS3E+dIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8k7NXNuGefdlSKiqskM6lVCF/mKipaKJjqtQnfYlFU=;
 b=fDEhWA7KQqiemJp4KZ0w2oEKCQkH1K6nJruPPE4eE6Cx1RVtdAb1udEGi0z3NVhS4ZW9TKxS65hRYqpLMxcL69VJJgVs0tnlw/eb6j9xyJq7JXvaU4hD/J/9XuFjuj2phtwb1Q20cB51Q6eQmqmsI8+q+dWvLLGo1v7W5/KUihU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2854.eurprd04.prod.outlook.com (2603:10a6:4:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 03:42:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:42:57 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/3] firmware: imx: scu-pd: fix cm40 power domain
Date:   Wed,  3 Jun 2020 11:32:21 +0800
Message-Id: <1591155143-25972-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
References: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 03:42:53 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55cd8f7a-ab25-4044-e756-08d80770346c
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2854D01C1CC3D5CBEC7DF2DD88880@DB6PR0402MB2854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnS5wzsklALvXXLfYm3xCHuvzH6BqgF/SOZqo/bNrdCrmrli7JDUQBbX9L0oqLJEZ35EsigjqnTUko4Al/52FS7xciUv15Fi9VxdJOPX9wGNVx2VVrMFzbovP0D3CBheOxECO6/e05edcow0YWMbfYjBZqY1X5VNys4fIu+RkfK9lNnX8K36Kf2Vtw3te2t3qPfikxMLQQJvRG1mD992kDvFDa7eUcbuUdgRUtolGLqu14zfP5fhWcJ8aJ4Dm1VT48Z7FxklKT1eDOk2ZCGvDwGS/vZBcmTItohLlyLkAr7NDa2jp8hcozrKCbF3TDUUYtz7FtxChHf9cuvpEpFbyeupgLk7DVZ3Hg0RCRoITqBlU3/9xHHEDzNryU0T5cYM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6506007)(478600001)(186003)(6486002)(36756003)(5660300002)(26005)(66476007)(66946007)(66556008)(83380400001)(2616005)(52116002)(8936002)(16526019)(9686003)(316002)(2906002)(956004)(6512007)(69590400007)(4326008)(8676002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p2gIJaHTV5LpdvvLEyh6pGCVTJeRhs9ng/mshTrlLdswgVnZdpQPIV6SK+9R80LZe3VAAxJjT9EoygNTwxK/i07lQSAY8rPICnJouXXUxND6alDyuK/hLSZZge8kw77EVgJz7NsoRJcKuPQu9EMnhAAmFDVIWh7IT4CCuslgdYb6vwVP6B6F6KwMXLDJ1BAhpAyjGKkPu5XYKzbgGwMQobarKU//SJ4rSk+eX+bWkD+GDScVBWpZ90Hc9oMr3qDXU0+60Ulldvs/5jwFs1i+Kc9DgnbwCtUbMrYQP9oia3TFxSZi0+o6Zp5uMt6AW2nCEtckSO6vl4CHUnJM/3Snn6JVxCqNkqL4f+Xyf/Ho0Vj3Qx2ucogWA3wB2b1D2o+uqOZZ1MljQgQKli4a+I52ZuakezQDb44XyFw/ULtuMv3RR9v3WAt/JWtfb5dnAKc+Q6jUQA/n0IbNumec8wBe5dQ4SOsW/E9wC2QED9DiC6C3O6T9sYcPi6eU4ExpAEPV
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd8f7a-ab25-4044-e756-08d80770346c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:42:57.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIa9Bbgy7SY9VffctB/YWY6iS2Neo6x1fBWOWhj1h63Xl/D3YLgI1QUl1+Hk8f14iWtd9Ko/ThEoBJ2o/PKVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The postfix needs to be false. Alought compiler use 0 for postfix now,
and take start_from as 0, it is better we add explicit false to postfix.

Fixes: 705dcca91d0a("firmware: imx: scu-pd: add power domain for I2C and INTMUX in CM40 SS")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index fb5523aa16ee..d1b313fa7b96 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -167,8 +167,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 
 	/* CM40 SS */
-	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, 0 },
-	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, 0 },
+	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
+	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.16.4

