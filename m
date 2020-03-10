Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A10C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3847E222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dhw9Y/8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCJUzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:55:38 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:29670
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbgCJUzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWv7naXCLtSlrsY3j0Q88XmqXXbzAYJXkU5AAB6Gqt/rVHO3AkFqWnrT5+Nxfwfaf5yujMLq6CXtanNugavnLurAE2V+/EEhKcOd6Ye9rfT5ofR22img3UBCami2xZvlheCmHacm1D5Eqn4WXY1VEs/+2CtpC7pKsBtBfAeohGnqtQsnroJ04cPsBFpfsZWm/+yhUi2cd3kSMVTghKP+UpEpyi2FUTWk3DRbGhe7NX2KzRFjKUGTdOgyhO/IVYQjs1gWFm/J8CwfBc45JOPydev2eje4U2NnnyPW/dZmiyVPX/z4JeiwehvDb7ydIljr4s3J1k/X6tyJot8oaZFPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxuvIhzW4A+yVAThE6YY5+0KzdACmu3Yh6KN9k+qD2U=;
 b=KBf3TEzhOsKG8B0IpWiMHOitpCuBSCbd0OhMDDO1CpinJ9cQUfB0F2+6egW+A5Ii/hTuS/aJRL/0+1tYYYG1GCFp4GdC27BcdYn1VaHlkdXSqkbA01fU75KB3SPeD4fXLK5uP11F/WO4aa5ku50fSiWKyVJ7IA5v9+yPCmUDRFrkKMrZVnThVkz145sZdKwg9y257MPup1lA56urlsizhudgOtQXtQelDEphi/1sCKey2tQuZ7ZPrqQ0A0XgA2hGwSWDD/kstDeKp26JUyRI3/N7oHqvc8BE82TY9Nt7QF0i190cH7vuyjkAOOVuPwe5pL1H0RAHrxjgErnHef6W3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxuvIhzW4A+yVAThE6YY5+0KzdACmu3Yh6KN9k+qD2U=;
 b=dhw9Y/8Qm5fC8nu4QRjCJELm++/MX9ZJ2uLRyB7p7+0uPUOLlYuFmXW5IZIQXStcRRA+gyA8yFJulfgj8T0e2Q5yQtstsUbY5zdLiU9yWItPFK2SChEU4mhbjKKfJCX8/1zmVrPx/TmXbpqaEgYS1aU/h34cRvPRwu4sYYjftmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB4031.namprd12.prod.outlook.com (2603:10b6:208:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 20:55:35 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:55:35 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 4/5] ntb_tool: pass correct struct device to dma_alloc_coherent
Date:   Tue, 10 Mar 2020 15:54:53 -0500
Message-Id: <1583873694-19151-5-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:55:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08a4efae-cecd-451d-7682-08d7c535611b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4031:|MN2PR12MB4031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4031039074D3C5357660A652E5FF0@MN2PR12MB4031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(86362001)(316002)(66946007)(6636002)(8936002)(956004)(8676002)(5660300002)(81166006)(66476007)(66556008)(52116002)(7696005)(2616005)(4326008)(478600001)(6666004)(6486002)(2906002)(81156014)(26005)(36756003)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4031;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDJK4UCisrzWPmc5ykChaL/cedrkRYiG+bzL6GEf8Qs1I7Q8c4rhCGiZeqDSDMGhZJzIBjD0v1BsXOseVjFQj6Lfn4Zm5DWZf3vDMqfYngcIJZnk08OIEUfMlSrEbjlw/QhOIX07SOrP3DY3ZJwXamEPpZdsowtR31Ltx9phy+NSS10+KS1k/fEQpGo3CoyfM6JR/YgMO+xuWCMthtcFJCxFE6DO5Gs52LoErqWAjARm2P+gpegKU9VVCb0YT8xs3Kt7JB+UJ/Qq/Ichu6lRQWyP09ElWbK7lqG/SPa03fzblnyQPJ4SjIN542xrablcMBhxmqG9iOjXDtz/N5i/8Xy2zO664gSB8Q6K2Vhntk9SGpm1lP9NT4PzLsMhTJKEtfTgyNWj+NXX3RAPZLV1R14XrljiJpN6Ers/Drd2K3q44l6GJCZlmSHCFheBIcRv
X-MS-Exchange-AntiSpam-MessageData: 2mP6sPbCnnB7l+oqaNkTpFjZ0vP/4lzZ990/0wsvJd6Yn3Rg8CZsZBHc+nNv4Ga3m7OrS4xYI9ylQoCM32frwpiXb4ZAfvAVU/jl3oTYdVYrdK8iyixIROXdRL1S4zvtWbTqUDuTAiaris+Q8C7oSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4efae-cecd-451d-7682-08d7c535611b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:55:35.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6itHnEjSysdKWEdCddnOFUJ1rIsn3xnSEUGdoeQHyNoo5TvdrZEgmsid/NTXpGBuFw0Nyuwy6Tcy4YK/aJWzIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ntb->dev is passed to dma_alloc_coherent
and dma_free_coherent calls. The returned dma_addr_t
is the CPU physical address. This works fine as long
as IOMMU is disabled. But when IOMMU is enabled, we
need to make sure that IOVA is returned for dma_addr_t.
So the correct way to achieve this is by changing the
first parameter of dma_alloc_coherent() as ntb->pdev->dev
instead.

Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_tool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0f..025747c 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -590,7 +590,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	inmw->size = min_t(resource_size_t, req_size, size);
 	inmw->size = round_up(inmw->size, addr_align);
 	inmw->size = round_up(inmw->size, size_align);
-	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+	inmw->mm_base = dma_alloc_coherent(&tc->ntb->pdev->dev, inmw->size,
 					   &inmw->dma_base, GFP_KERNEL);
 	if (!inmw->mm_base)
 		return -ENOMEM;
@@ -612,7 +612,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	return 0;
 
 err_free_dma:
-	dma_free_coherent(&tc->ntb->dev, inmw->size, inmw->mm_base,
+	dma_free_coherent(&tc->ntb->pdev->dev, inmw->size, inmw->mm_base,
 			  inmw->dma_base);
 	inmw->mm_base = NULL;
 	inmw->dma_base = 0;
@@ -629,7 +629,7 @@ static void tool_free_mw(struct tool_ctx *tc, int pidx, int widx)
 
 	if (inmw->mm_base != NULL) {
 		ntb_mw_clear_trans(tc->ntb, pidx, widx);
-		dma_free_coherent(&tc->ntb->dev, inmw->size,
+		dma_free_coherent(&tc->ntb->pdev->dev, inmw->size,
 				  inmw->mm_base, inmw->dma_base);
 	}
 
-- 
2.7.4

