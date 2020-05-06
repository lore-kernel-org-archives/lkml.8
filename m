Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1274C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B63206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q2t6452k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEFEWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:22:42 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:45732
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:22:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irWIfWwYNMIch35dfZI0XDnfaFk5AIOs0hMmcYLGCf8YY2ZfqzNkpfJqEM/j54/FZvN5fATvQ5bHP0b4EpPRbAiFtB+T2eANl1Vd109EHt/jTnWJWiIoSvQY/MTxPTl6maITBgsXxODyj/fV+UZJOzr5kYnU4i9fZRzehL3FMxM6jfTO86vUizU1wvJYMmp1YcnQgDy867qbwuu/qAyOjCaFyQp6w7ZfGWv2HKaMDa+QKSTDDE0vOGkBKTmn0PKBGsRwAaAgVPI2lIMMj4FnWgN1yEhdRPzbE8yrBlqQOs98PPiyyI0LNMRZOBOsMSalJ2Ovago97Fx3EEFxx+uIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i76LmjhVjQfy949FdsWL0x5D+eEOXKAlyHNpW84ckZ8=;
 b=ie+peGvHj87u0E3cY4U5eDYPI0Z5BcrnboBo+CR0EvQFfbKFqGoSrW2l5wx/LqQxtM7S4XmiF2lfXyfpIOGqgX0FjWawxdabMVIMEzbgprk8nel6+6oxXqnzTjo6nSkFLA78sF0YQOhvQFIYntjll0dzfT1j4HWvK9N0BSTDvS7o0ZlkcEiu7pZXw/FURXag/tTh8fc4s7w9Z8LAWXgVsMTXvRFhpOEK0RejwRAaAos2AHpKZeM5u3cdvaXo0mhQMUV8woeoN+FC9oMjggkDSsxtJwP3+gxtvZmI/qD3SneOFpEjLfCO0AYKKg3GCwU4HX6WeV/fHAyB5VQAY83q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i76LmjhVjQfy949FdsWL0x5D+eEOXKAlyHNpW84ckZ8=;
 b=Q2t6452k0RJLdWA+nT0m6WCQ/zQQLsAzlK6nEcXeWIDxwWDDwtQ5rl6wOPrvURTes15ISgnBDofpWqX1lBoMTqpGGjzYKjlregAc0vHJQlCg1sF6zFk6KJqgY5NhQZe+ve8+Ot54Nmhd+O0sCiy8PenXVVWi1caopLAc80vwpTs=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Wed, 6 May 2020 04:22:38 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:38 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 3/5] ntb_tool: pass correct struct device to dma_alloc_coherent
Date:   Tue,  5 May 2020 23:21:50 -0500
Message-Id: <1588738912-24827-4-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4f58a03-af49-4c9d-9064-08d7f1751c43
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:|DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707D84FB8D1A0C432D2B6B6E5A40@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkBQhk52uZYQHEpSZDuJsy5IPwKhfi7oj2J861JrV9PQw+PCw5MsoRgZZ+pjmyWkDT9qqp7Bf+ocOPoYOCTdyHsmU+vKyoIEC0R+WAmZe6cEFKkdKhQwliiskXJVxW2QegN0KZCaKlCI5+RXxLKcsU8Wj887zOSKf284iHrcijVHhbl+AczqEczTiCdmJE58YNMOEiJKSN50noPNBH1uf77JCspsUfrDC98SSlbaDuRnheE/yTaUFyNIHLCfdq1FyuX6wiqVKHRywr3kxrs7Hla7+mGxbvw6GWupO3k3g5fJw9OwFINhFgEgRYxy3ghFA3ZN0uXrUfbCFb37Tkr6HZS7pWXWXr8ePRh2jC54sznZPfLcFA5exMaj3XLEzgYHXijzTyqRemQQxX56zrXRBTNsdq3/u8UcaWFHrzNtRp7WBx5dfZcEgpizIGMnmsg5tdrWRAtS/WnGplggKMawVVack5AYqz9yYEhY4doXzPi6SEZycdLG8g0RD6aS581GqHHYTl6M2GeW2eV9/KJtoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(33430700001)(5660300002)(478600001)(6666004)(4326008)(316002)(66476007)(33440700001)(86362001)(6636002)(66556008)(8676002)(8936002)(52116002)(2906002)(7696005)(36756003)(6486002)(186003)(16526019)(26005)(956004)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Gl2x60wTUroeVvXemxSkYcaP7cKUAXGEV11SxIfS3QYGjJLAR+0VuSCoI9nmywTXOg6dfb0rULm3uqFuGdTG3cXmrD3sAbOPDiPVgKOj01dVpxK2F4ByC3Jp+44AuN9HwT3lbfYu+cOHbjap4AUXMAlqH3hIoK+uvssODzX7GbfdR6mCABjmx0DQLayQzgvKn5s3MfKrmaCNtH7qqcpuCiC+IXI7331sWLTeD1y+4ZbCVyqlL5qorRdgvcTaYKClZ18YKZL37PUMld4a7do5IRaqHhfXzJo5FLnF15RJXCwz2KlCAgx3FjmWC/Dgf50cSovhA+TCEKNIZIes5unHYe076t07uaDC+5XPXDbXgN/j4I6meFNxdVgHwzvs/CjmmoJt3IgA4ZXHrpNrIOevaGx7F3ZdAUsxvV+4CNb7N8OJu3VptHI98tdgpEySWjmfNFqGGsGnAPOdS4CQlUEzWG0B9CMjXwoiqMgkGJWJhlaqMDAwdQ63unzLl/N7Sgs6hFzTEsI5df57f3DY2+su/3FPz16Z5RmdcmEvcLvaz1ucSYSq/ONA6uBzRzY4V3T46dXz4Ysma26myiHttCyWpt4fxqnhm16hcv32vg2YFhdiweLaVmq+cucO7xgurRFtU7AxR3Xv04vzjO1V7nB0d6kFAFAd6SdXscC58qfRr5MNlh0Si90wgK+2Nd99jzeFitq6+d5DWYjGithbJpwbXM5PwKIjE9dFo9F1vJZvet3BW7vdHxdaMH1RDmHEki/qBJQG96mcAgQG+5ruP1m+fduLQnE9F7Cejvpu7go+k+UF3aJSQfHvSJIxTKCNIAoA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f58a03-af49-4c9d-9064-08d7f1751c43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:38.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZQ0KBsLLM0zCzIzqUUgygAyWX78SKu2NRB3OgQlI4xPszBGkOEEb8jBq1ulBSqAWDnohm524sksQm93souvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
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
index 69da758..9eaeb22 100644
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

