Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6FC4725C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C43206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kwZw4P6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEFEWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:22:36 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:3054
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgEFEWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG21xO1WqAn9Rm2HVvjHaC3NivRkKlvrVOcB7GREYZ9AMiIGj91LK73iYqjUsG/xgQyub01/oCAq0FHKMy7EAKgttKnugRhNo4/jKZm8vYb7Ene0iFrJ8K6UD7RZ40c8utGQ+NgbqDmWnd6M5IjtuiSb1fOix1hrSfEgx5kzbcCphdubj/niUYOF90iejAynolQB4wnrKi2chAH3MLYsAzumTSgbA8KkzN2Oa/nCk8wBDkyfBJ2k8ZeOUu2rMYqCfvYnGCcrT+HB0sEVESzC5As2aFUbH9GCrC4ZVscRETYa5CpN6PDeeKyOjW1TCY6vGix1iHLUzlysvNVRC+OnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJZgWJkf5d29f/gUBum2lAsZkS6rsVPE78yQQn23TuM=;
 b=TtnW3UAfTA86EpASpUD9X2D168C7BvVH9/ykQ88zElaYo1RvbYqwviKJjXbI+i6YHuWYLqMAsPZWySKNTL5rS3rUeEaqSW3g+9MDVBrCqqDXuYD8iSwKKWhERQYP0vymHm0vA2A5GaDpSIFtmFg82T4wUUO81GeA0knZ3J9r6FCSKsFdNUfVow6QCfRm9fgQd+FjETmyx3FB8ZDs2BiEqGdrizNtX2ewFiqubCfZmR3myPx31eM37PKBwGGvdgN5P5Co4Psgmpvs7LGMFPMpKuGCmn42WphrjlFYFbguNIzrCmAxO3gTo9BllB+pDhSzPPzSka7lfY4fObxrdmX9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJZgWJkf5d29f/gUBum2lAsZkS6rsVPE78yQQn23TuM=;
 b=kwZw4P6m0Nu/nmvbdj8NuDE5abtthlnKM9AEJMfql8c6WRpFgqp9Nm2PYUI8is80rTYpzvfmnoKFbHTyNLjl/Gw3LUwJP+VBBhJkpYuVNIMF3+UoZVhNc75aUDIBnlt9Vwlvqasm9rYmIdD3akgblQ4VFrdiE3IFS2c8IG737SY=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Wed, 6 May 2020 04:22:32 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 04:22:32 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 2/5] ntb_perf: pass correct struct device to dma_alloc_coherent
Date:   Tue,  5 May 2020 23:21:49 -0500
Message-Id: <1588738912-24827-3-git-send-email-sanju.mehta@amd.com>
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
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 04:22:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4be0ed2-8276-48fe-ae12-08d7f17518cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:|DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707D46ED9C2B2D3AB6DE33CE5A40@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA1dgcIxergJ4EC6i2MwgxSd6gdo1fccH/9Wh+OiJMwyGvhLVQYUybuwRL8LoltKsO//EVKWTqQTanEXU7e8cbjvCgfB/4D3K6J35gkRjBnMnAE+37mliZaGtE4ERDlH/s02TMB1kEJZbVfPL4dpKx4kFZGoSm46Inf3lzkJofmILut/j/RhiVOvErZV5tpDhKLKpS0fPABEddel71iRDSSeeA+cvq3D7miy/lXIzthWIVJNDC/TFg5wdNHNOu6zAdknkFNKnxmkGrol3mjhcAcM+ZKiFYnnSo4vtN8uDoudHhbazu3S2gf2O//CHhs8704VjSXcYrYdsPQif5FD8+Hxkk59ZsF+BWKwT+/+ExhJib9L+VOwYMWikiIWMcrMKC2AbaDO5UQ11yAdaEcwnsBOKViXXuqkZEG4b2FDJVbJPmHjOD37WChGcv/zDl0HBpGPrSe1de/32m88vgEhFTL/KjmH+7xGJuLhwHc0eh7a0CwvsSAZTL+LtkqevMgjzlDOk/axUwF5XqeCk7ytBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(33430700001)(5660300002)(478600001)(6666004)(4326008)(316002)(66476007)(33440700001)(86362001)(6636002)(66556008)(8676002)(8936002)(52116002)(2906002)(7696005)(36756003)(6486002)(186003)(16526019)(26005)(956004)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Jmq9lP04uG+Ovu7oNmi0+zf9VqCZm7ZH1i9bR3i9ugronbEFfw0W6/knU5Yshc1JP4O8m8arvqMWPVzEeaSQyFAdSxiysEqiONuFAr5ceGibiUiGBOwb+LfJCTa+Vi4BeAiDywO4s6vHVmdbjaee+FfOgNpSADT1IEFXFukegFv+eWi26z6TH2jkLysQ3YIj8VvYChsqMq16nF2ld7SDTMXVixwQJMOFtatgVxUvNcaXBuGwSkDzB8Wn0eN5XA/L2tEFYHcNZDl93WT/WplVk4A3avICwaRQ/mpLQA6xrHkAR+zoVG1vpzwSnVpKoVcceYfwFBh18jX2KZcHydrDJnxyw1S15ZmykuLtgw9soxCmUUShTIExnSTpACoTw8y2YCstNwuFYu7QfoNtDTZRCWoFLad7ZilW+LmYH02FsI59jOn+z9K5DGYUVod89XM1pR3N8oIx8cgNy684w8CeHJ9dcc/2eJqHKBvEnv/Khk46uWiembupDRICjqg/i90rSRyblqsRZi2cy7d9a+L4LimoEeSM6IurQe5iAO1zjghSM4DLwYuKN6kleR1R0hPhq5pMbblHDrQUBECOzzvAzwCMlOeQYcu/D94+ARGkRcwxdc0skUhxTDYGC0aDoUeOWdyj/DhNhe1vTEvS3F1JAp6T3mjpxu3RSFnKcSy1nj4N51WXrocJWbppgK0ZkcegDtz0gen93xOaIti5pYyeW8L2QOLoERWgxWgTOzlHZ75ui3t0Ozo4CZNjQ6drarvxMfxbH3W7Sf2owQKboIc6c2z2whxH0wGbE/fFrVBjxagXehHaw4b/1GRgxvfSJ4q5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be0ed2-8276-48fe-ae12-08d7f17518cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 04:22:32.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOwFbkpntkncd3k8UMi14WQcByoCpwJ0iErFuN/mIjy7FngEfryZXsmwxLmHtGVg1OehcRTunxoQ/9fIzPCjMQ==
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
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 972f6d9..1c93b9f 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -557,7 +557,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -586,8 +586,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+					 peer->inbuf_size, &peer->inbuf_xlat,
+					 GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
@@ -1554,4 +1555,3 @@ static void __exit perf_exit(void)
 	destroy_workqueue(perf_wq);
 }
 module_exit(perf_exit);
-
-- 
2.7.4

