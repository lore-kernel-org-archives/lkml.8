Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D59FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC3720809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwSz+KYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgG3Jjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:39:43 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:16206
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgG3Jjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Q9kAiBcHN5AMfieN6627s9A0YcFeepMse+oak7zqBR7veXUdzxTIgzTATI+eWm5jnKANJpe1rnS+mU48VPFl3I0pwxuUF8a5cRxY1Er3zGmR0BGTgAm49yxDQPC5vM+XSmsiP+3aac91qdt0hK6WgjBpLq4hiNlRxYOukr0hkjiQTvC1rrm+2y65R22uy9YK8aV0/ZBrwoQPkw28sJBoNG3kDEr5OLaD04RQ9p1GtWTWe0SGClzXHCn9lqlzYCcdl8ZHJIh6AQ0lXN6ZLdkgV3+p5fer6yy82rUiaqehTO8KtsPR4+P8gdXFiHjFKh+bIeMU4ehluzM7bLKBYvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LodwBDdBn3w3Q8KIT2hYO5TkeBzXUES03uNVP7Bwgfs=;
 b=SP8pbVdeP4g+heDeE7OceaBUHTIptlLx2tI2287e6x9megJia1FOIkulXhsybYU1R/AowJim2xvJFQy2sPExaBYLlfymQOQS1HvKIDEduJ0DGZhyME4XcNzsAauRVsLJ8vVcdQeiHAUqqM88lbRj1uS+OAsG1kBDB3hZ0URutm4ERUL7F1Wj7DxP4gLPXiITJhtCqqqvZ0FppSkQxWaLB9CewR1A5ZaT+aCV77hTb2IvTUwaby5CC9R5eQVNd2r4GRFeNWrSZqZdBEIzXf01GXDLvn10CwBjoLVYL7BF7gHc9nYz/++3EZD1J06+oQ3n+0GqdrBh4zOk4GZdpKa2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LodwBDdBn3w3Q8KIT2hYO5TkeBzXUES03uNVP7Bwgfs=;
 b=YwSz+KYdMAI1iDOmx6YBDGr9Qk5s07CeqtEIt/6gT6tuB4mcdDhdTNVMhCnvctHeuFGm6hgR5YxwRTVBYnefsxGiJr/70HYI5BA0UJXQAqr7qaYTdBfFzNOeMnXGZpA4sNlPQN+SWl4isMZ8yvUx+vuj00gfIYTGaNttg2dp1Us=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com (2603:10a6:209:3::27)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 09:39:37 +0000
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::5dd7:8d36:317a:7fcf]) by AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::5dd7:8d36:317a:7fcf%6]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 09:39:37 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        diana.craciun@oss.nxp.com, laurentiu.tudor@nxp.com,
        makarand.pawagi@nxp.com
Subject: [PATCH] bus: fsl-mc: add missing __iomem attribute
Date:   Thu, 30 Jul 2020 12:39:23 +0300
Message-Id: <20200730093923.26177-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::29) To AM6PR0402MB3400.eurprd04.prod.outlook.com
 (2603:10a6:209:3::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 09:39:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec765a1a-8e6d-42ff-ed87-08d8346c7937
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0401MB25803340478D7DE0864E4A25EC710@AM5PR0401MB2580.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLcu4cFkYwk9HRJIYKsL2wJGdarDuMyg+gut/ViEWCRDpFLzkEA99R5/4iQduBhNce8I9IJJJYfS5+bV8q69WTu/zNKoGiLdgH1FUZUmKh7jklgOXQPiZvt7tpOazW1mGffk9veJnPsqY0dFzQXGk+mqnU4pyOy7JftOAqhxXMZ+YA9bN9lmbNXWlDSP56iLeofxg9TBc0DsYUalY1zfs/sxvk2f0aPco+wkYI0QVJt7XOGJRdUDIvw4yPImt/mQpLcfRp/zMegxXvPXB5erFnYBhkv65LdpoZgJzzj1tNbDrLLMaM7GW1/Cge7eUb9e7EVPEDFleAdJE8OgeypXzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3400.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(66946007)(5660300002)(36756003)(8676002)(956004)(2616005)(8936002)(6636002)(6512007)(66556008)(1076003)(4744005)(6666004)(66476007)(83380400001)(2906002)(6486002)(26005)(16526019)(44832011)(478600001)(86362001)(6506007)(52116002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p3NiK4yGyFypgBtl65j8FKcgDet3gID6o+k+roHgkmUCiv1uQXHXMCtI8gF64esxEsi/HunMHU9QVEmKDd4rwdgyYMj35Lhpy65MwBtT9zf2/5vUbwb1dh+EAcFR4Lz29lExgZu3cxl5oL2wYIR1e/CYxzHLEtCBlAAnwoD4QuBWGiTPLWw5tDAiNE/+aZjIZ2TjOPI8sJyfa1JraTvy2LKEQCZE8Gz0cV8AVmihEFH8L/OVQHTmHKM4GteKzmmpFXeW3nSeuDGzo6+3psM6R/le6JV8qZDEM8orMm1E/gO0VYlkjSFSKN143ez3HgdR2KPJ4k3B5ewXFCbBfXp9tyz+TeyYU/iOHM8GUrgBHlibnhi1nkmfdSR5fbX0I4rAXE2WTzLHjWEVQeEj+aORqdBJwucQfhRVGAcZMTLVyLoN2e0aZG2dVrHRhSE899dHe1aZrVk+FJ6XDmvQ9AXY8MPRzJit+qWcEM1Nmdu1XmLLLFIbXqag7DdJ55xiOr4LSTGoQwbxzzqynSQXzjb4tap0LuachNcMSL8uLhFtLZ7ZK2GXhpPKW+pSLTMaN0s6wVjJJoPGHQA0PcNFlbvvtaSQFj5800k/pbtqSSfST5+LNaOHNgVS0AFt+I/C9PDLGbYBkNKxI5/jkrK385OteA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec765a1a-8e6d-42ff-ed87-08d8346c7937
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3400.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:39:36.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSV/aYWKR9m6Zp/h0YptLpnLjzgLxDa0MD6FcSNTs5l76cCRLQedByDauU1lrqnq2g8Cdjs1G/zi7cZHBgbicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pointer to an i/o register block is missing the __iomem attribute,
so add it. The issue was found with sparse.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 324d49d6df89..bb1056b7dc0a 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -40,7 +40,7 @@ struct fsl_mc {
 	struct fsl_mc_device *root_mc_bus_dev;
 	u8 num_translation_ranges;
 	struct fsl_mc_addr_translation_range *translation_ranges;
-	void *fsl_mc_regs;
+	void __iomem *fsl_mc_regs;
 };
 
 /**
-- 
2.17.1

