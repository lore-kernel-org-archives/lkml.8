Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88126C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49003222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3DXXtqSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCJUzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:55:36 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:34571
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgCJUzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQpFWg9kdvy6Aj88w83fPNw+FZF6flI+2LqzD5wXJXqpn7m/0brRGoJo6Fr10HcS2FdyYY5GNZJT3epQoA1fVY0a3PeHIuS3/Qbh2p2fgQrB66giyvDwrZbp11VS5X1i0AJoCA7ggdJ28/B6kkhoIVrAbErlqM71725m0Dxn/KIkbDxwLxuE8SKeO9j6+SkX8Q2B0mO+FH8jkmFcaYIc0BADMSDvJJlrOqzyk5htuYhWo3ywVKmLYclyYX9rboJyTFMoxDa8sxlBF5FeAsd/kWriYahG6j4RszQzh+xqCBsVrfe0QilH5GvpGNIneAUiclozRR8uwC1Ce26VZK50kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukWWs60UOVQ5kGSFjRgCOvv30kHX7httY5WMgOeMy3A=;
 b=DoKS8sWwGOQZ6OozfM/DBfs3NSf+rpVV+J/Xh6/9MIBTE0PP2oowhoVDJAKST+z8nqrFBXgbzMOBz6tvwe048ZMIMzZ6SMfBBGZTjspavCbL7HcxQ8OjPiuggfhDEK7OGXzhy8WO0duCHYMhMbdKJBb+/86xQggmTG9VeNsrpipRslcVXFlWiQRaTlI8l+hHr3RW29aTlqhgpgjqAgdlH2Yk2jTmxfPenLqGbTrtzlDNhK/SGLoDC8kykGOZnPra9BeYIWFPM+GDpkE+xQ/WSxrnOAxGR3myToDSXISRU5D1TF+0tdGKjE6H93dJIcFHdMUNxr17U/pE8B/0INLPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukWWs60UOVQ5kGSFjRgCOvv30kHX7httY5WMgOeMy3A=;
 b=3DXXtqSkfLt4TLowZkwqVq0LBZ1lFmAYA77gVm1jOK1n5GsZpiAJUn+bUxgxBtNOqP4JYohkbCpfzr9CaMx1tCcb7FqUV57XtbtRSW8zBuOt+Z/sE15vLinzFhaCEv9HqxR4mmkE9TLRiaPza8kp3zGOY2e+EbnbyMHAgBTSIYM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB2925.namprd12.prod.outlook.com (2603:10b6:208:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Tue, 10 Mar
 2020 20:55:31 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:55:31 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 3/5] ntb_perf: pass correct struct device to dma_alloc_coherent
Date:   Tue, 10 Mar 2020 15:54:52 -0500
Message-Id: <1583873694-19151-4-git-send-email-sanju.mehta@amd.com>
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
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:55:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0310aba-7ff1-4718-1f53-08d7c5355ebd
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:|MN2PR12MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2925FCC268FC6799999D8926E5FF0@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(2616005)(6666004)(956004)(6486002)(316002)(52116002)(7696005)(478600001)(8936002)(6636002)(36756003)(26005)(16526019)(8676002)(66946007)(4326008)(81156014)(186003)(2906002)(66556008)(5660300002)(66476007)(86362001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2925;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: He9z/6d5rLTEienWCBNw1E3xLSEz6P6aXDkiDTYgaFL5SanIGppazpglIG4ha8cBxJyLUX+bYRuNHewDVX1i1Z0brn0TrnjHgIpHpAVW87j0NoUawALh3yuAunQxvuRhiN58Su9/15TMtmbcRUdCimMN0dYy/vDGsolF63ICATpMgxpKmyPg33DexPSlY7cWxNPHkXj9LCK6jLI1FyCxXFEP4pt/MulmmpuLXS8id/BvQaCvncfmGUpitsI2rAeixs6zAiLN9E1hHQR+rXd0QAQ1OPb0SC6uxWEd7XnC/6w+tsQD9UfriLiKk0bc7DpHKo3loqMPxGcrSth49c7S35YM6Xx0p5PQ5DBb2AmRLHlePzFBYmvmav/O//k7RgdVE6RVNKJzv4qtFQT3zZHHfINlukyG1WFTX8I/LUun0LfD1h4zm3NHydhhZmCczWfb
X-MS-Exchange-AntiSpam-MessageData: 1h8jq/pLA0F6F6FU6qs9v/qCid8+la2v1e3a8+W+mdurWKaPitm9gQDEI8ZbcF1EsjZVHNm9OYU0KevGLvI1GpXG49EwC6icVO+JuqY9HCOysbmxp6soC+7hTzDFw1v3D1pevjjjIkgHJe44mKPgPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0310aba-7ff1-4718-1f53-08d7c5355ebd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:55:31.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUX8x36N74VNcN4z7h3pUSHRBvnqdeSq326gYm7cy559s8m9nQtlMD/aRkUSuKtxRcc1Zj7a5thcFIhXkSJKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
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
index 9068e42..c193d62 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -558,7 +558,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -587,8 +587,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+					 peer->inbuf_size, &peer->inbuf_xlat,
+					 GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
@@ -1596,4 +1597,3 @@ static void __exit perf_exit(void)
 	destroy_workqueue(perf_wq);
 }
 module_exit(perf_exit);
-
-- 
2.7.4

