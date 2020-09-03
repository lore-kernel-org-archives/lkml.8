Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9247C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2015208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X9yZLmZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:08:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5233 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:08:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5123140000>; Thu, 03 Sep 2020 10:08:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 10:08:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Sep 2020 10:08:50 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 17:08:47 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 17:08:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZdU12WmELAtFtWri+kOGe765iFK906FHL5HGICRxM7Ji4yE7GbVk1yeVOMQXRRL/aib3/5IPWqEfXipKw0Hvu0SVqHqZhFZHtRLymx1n7X2QPAIiyRo6QGEjfGDO2r0xED4Lly+R0QKfYoD4hYkjtvqm4cLyp8bPEji/JW/SAX9x9SZcCJT5X/p0q5vCjVOzhqA2gN1tKYigxrjMh/63wvJ48UeNjGXeJAC8PD/kXFAksaN2yMPVO2Kl46W7r1MGWrH6LTdMShSsp22pJgQDyGwTLK3YD/nEFUYbDEQ0darqDn4x0h5VlbdioQZWzuWzBtSzRyFEZ+7P9JKt/hANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVBAqgaKTmVmEZoTf4goNIRyXEMxaq+XM/COrHRy09s=;
 b=Sy4E9JlEGGweGzWxSmu+isJ/4wIVG2u/X1FU42Key78w9CMQO16Cx0orIZZmybtM23XoTlhsUNqMlK/D2mUjoRT/Agh5Lm+xzTdy8rb/1fXWsVhVBGzRgWZXcEX2M0jG+tyJZQ667W1/A71vhtNZ+xn8wj2I+0Ul/ysoLENsccDReLad/DtYcCUX8mDar0dEypD0Ap4HpJpqZlHls12+mqFEIDp2LLxy0FJJQlbNzG0/8TqZWTwCxYWR9pMgBVpruoeLT8ZzwCBujil7U3udafUvae0ROdIiuyjKxJg4mKfLFyjOJx1g4+UVrbjV5RVg/NgmKuKv3z7Z193SC9/efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 17:08:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 17:08:46 +0000
Date:   Thu, 3 Sep 2020 14:08:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903170844.GI1152540@nvidia.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
 <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
 <20200902195739.GI24045@ziepe.ca>
 <C12C60A2-43EA-4AD3-9077-FFB61CCC964C@nvidia.com>
 <20200903164032.GM24045@ziepe.ca>
 <20200903165559.GD14765@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903165559.GD14765@casper.infradead.org>
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 17:08:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDsj6-006dDG-BF; Thu, 03 Sep 2020 14:08:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad22b5ce-a143-45d4-9f1a-08d8502c0448
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB426537730AAC8BE77F69654AC22C0@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jIwvMcT2YYpbuOUxDl8ojmcnt7tKdGof8kJamt1DOBl4Pu+JfbbeWb0sHQWX6HoE5mrcUrplEL67jq23VMXqDiVlZolb41K0Sti8hGaSK4yVI8b3F7LQCT6rw/jsj6pEciW4+N1wYdKpJQ15OVl+Dv4uss3RQlI6kQxSQqYpSNe9vsyvsCcdnRat0gWstcv3x5dXuqF+HL4SHD8v1nFixG/pOfXgRB7hwXQSDgleajIzW+yAB70xOWbZmD82EvY8D9ghYIQq1/e5fot3o6Y+FuVdvu5n9wBqem86tgPsN/y9pfd2dSfGs0DRpeGqNDNsH4AnlaCjREheISkyTGazQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66556008)(6916009)(66476007)(5660300002)(66946007)(1076003)(26005)(186003)(2906002)(8676002)(53546011)(9746002)(9786002)(54906003)(4326008)(8936002)(478600001)(33656002)(86362001)(426003)(316002)(2616005)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yAXAB70Cr33M+1rD5SCQ3X3qHY9otJ2e/9jrbdHJV7DLMpxI+dvEjSNhuWZ+7BCfo2kElCUfZaxmECcVfXWngQYYlPmk8FtvPwGeDMbCiVEB423iUE509kbkxIfYWkEtInwmY7G6jc7jTjJEEqRcFV30ejh+WL3PN68kQGWPOlzuJSPoT6YOIv/3Stue5tNiDGfW4KYTZI2fyZSkO71VMLS0CM8ktuBcekPWhIFWL92QZqyr8PG10VmUug8dvY/2D0XReDCbJBP9fBuSroeaBG1OmLP/3rnJv3sQJPxb85cruXvMv8PsgrYBr+BddYBIUFFmg52A4GPePilFNNIenDWmxUS0DXCMlprKeChf1/jHMkLy+BNUmaCe1PRC4cKcCd7jvGnVwDR5eZwBmpE8T419RMG+bKR8i4a6QMbL1OmyhuPfa2uuWAfgosSO1EvSnitrdi1+kb0DqtH1de05Be6Ilv4tkmrQfPNQ1pxIXuf/o5ZrrMKz+E89odwwOAEmHGFLbDpcOgP+PWI4SAHYMUBTzrgRMbAUfeDj8BJZ2e+hujSBrxUi4KxhGX6WxXiCiJFLeE4XYw6ItsXAWHNJM7EOafr535c2e4SAMyR1f/2Jb01QNb1Co5a8L9J1shunWRZIAnaEM2cLxjJonUOsug==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22b5ce-a143-45d4-9f1a-08d8502c0448
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 17:08:45.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEHwmy5R2hbSeK93S5KKTbBoTG+o+QxMN2PvoGL0BVSY2DA4n22sND+acYiIzvjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599152916; bh=tVBAqgaKTmVmEZoTf4goNIRyXEMxaq+XM/COrHRy09s=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=X9yZLmZ8tF+wyWx8VUM4ycXRQtBhbbYKz8xzvaCR/lK4OP824SUSS1rZBLMNFpanR
         duGI5bsLmyXnHZdUZMPKho2FP7qVYdV4eVBmZ1QCchzi4Y+BLqWN9MmJqGD0vmy5wp
         ddveVCdHdOdq0zZMKyXLeQBtbwy46RtQDBgXNeS9kPBJQs0n6Pd34BbdZspJfUcJgt
         /6dplLP6hcEJuI/WJzMEJpaEbPpIraLyewCdx+PGEF+OFBbgOTJtc2XANtT6VOLNui
         8pmFBEL6VJJGM4q8FEVp3IEeu953QUPk3VNKranPzPaxPapr3DqK/AK/YdtUYRTB9/
         bnh4IyrIYn4nQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 05:55:59PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 03, 2020 at 01:40:32PM -0300, Jason Gunthorpe wrote:
> > However if the sizeof(*pXX) is 8 on a 32 bit platform then load
> > tearing is a problem. At lest the various pXX_*() test functions
> > operate on a single 32 bit word so don't tear, but to to convert the
> > *pXX to a lower level page table pointer a coherent, untorn, read is
> > required.
> > 
> > So, looking again, I remember now, I could never quite figure out why
> > gup_pmd_range() was safe to do:
> > 
> >                 pmd_t pmd = READ_ONCE(*pmdp);
> > [..]
> >                 } else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> > [..]
> >         ptem = ptep = pte_offset_map(&pmd, addr);
> > 
> > As I don't see what prevents load tearing a 64 bit pmd.. Eg no
> > pmd_trans_unstable() or equivalent here.
> 
> I don't think there are any 32-bit page tables which support a PUD-sized
> page.  Pretty sure x86 doesn't until you get to 4- or 5- level page tables
> (which need you to be running in 64-bit mode).  There's not much utility
> in having 1GB of your 3GB process address space taken up by a single page.

Make sense for PUD, but why is the above GUP code OK for PMD?
pmd_trans_unstable() exists specifically to close read tearing races,
so it looks like a real problem?

> I'm OK if there are some oddball architectures which support it, but
> Linux doesn't.

So, based on that observation, I think something approximately like
this is needed for the page walker for PUD: (this has been on my
backlog to return to these patches..)

From 00a361ecb2d9e1226600d9e78e6e1803a886f2d6 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Fri, 13 Mar 2020 13:15:36 -0300
Subject: [RFC] mm/pagewalk: use READ_ONCE when reading the PUD entry
 unlocked

The pagewalker runs while only holding the mmap_sem for read. The pud can
be set asynchronously, while also holding the mmap_sem for read

eg from:

 handle_mm_fault()
  __handle_mm_fault()
   create_huge_pmd()
    dev_dax_huge_fault()
     __dev_dax_pud_fault()
      vmf_insert_pfn_pud()
       insert_pfn_pud()
        pud_lock()
        set_pud_at()

At least x86 sets the PUD using WRITE_ONCE(), so an unlocked read of
unstable data should be paired to use READ_ONCE().

For the pagewalker to work locklessly the PUD must work similarly to the
PMD: once the PUD entry becomes a pointer to a PMD, it must be stable, and
safe to pass to pmd_offset()

Passing the value from READ_ONCE into the callbacks prevents the callers
from seeing inconsistencies after they re-read, such as seeing pud_none().

If a callback does obtain the pud_lock then it should trigger ACTION_AGAIN
if a data race caused the original value to change.

Use the same pattern as gup_pmd_range() and pass in the address of the
local READ_ONCE stack variable to pmd_offset() to avoid reading it again.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/pagewalk.h   |  2 +-
 mm/hmm.c                   | 16 +++++++---------
 mm/mapping_dirty_helpers.c |  6 ++----
 mm/pagewalk.c              | 28 ++++++++++++++++------------
 mm/ptdump.c                |  3 +--
 5 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b1cb6b753abb53..6caf28aadafbff 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -39,7 +39,7 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
-	int (*pud_entry)(pud_t *pud, unsigned long addr,
+	int (*pud_entry)(pud_t pud, pud_t *pudp, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
diff --git a/mm/hmm.c b/mm/hmm.c
index 6d9da4b0f0a9f8..98ced96421b913 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -459,28 +459,26 @@ static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
 				range->flags[HMM_PFN_VALID];
 }
 
-static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
-		struct mm_walk *walk)
+static int hmm_vma_walk_pud(pud_t pud, pud_t *pudp, unsigned long start,
+			    unsigned long end, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long addr = start;
-	pud_t pud;
 	int ret = 0;
 	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
 
 	if (!ptl)
 		return 0;
+	if (memcmp(pudp, &pud, sizeof(pud)) != 0) {
+		walk->action = ACTION_AGAIN;
+		spin_unlock(ptl);
+		return 0;
+	}
 
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
-	if (pud_none(pud)) {
-		spin_unlock(ptl);
-		return hmm_vma_walk_hole(start, end, -1, walk);
-	}
-
 	if (pud_huge(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
 		uint64_t *pfns, cpu_flags;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 71070dda9643d4..8943c2509ec0f7 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -125,12 +125,10 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 }
 
 /* wp_clean_pud_entry - The pagewalk pud callback. */
-static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
-			      struct mm_walk *walk)
+static int wp_clean_pud_entry(pud_t pudval, pud_t *pudp, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
 {
 	/* Dirty-tracking should be handled on the pte level */
-	pud_t pudval = READ_ONCE(*pud);
-
 	if (pud_trans_huge(pudval) || pud_devmap(pudval))
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 928df1638c30d1..cf99536cec23be 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return err;
 }
 
-static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+static int walk_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
 	pmd_t *pmd;
@@ -67,7 +67,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	int err = 0;
 	int depth = real_depth(3);
 
-	pmd = pmd_offset(pud, addr);
+	pmd = pmd_offset(&pud, addr);
 	do {
 again:
 		next = pmd_addr_end(addr, end);
@@ -119,17 +119,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
-	pud_t *pud;
+	pud_t *pudp;
+	pud_t pud;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 	int depth = real_depth(2);
 
-	pud = pud_offset(p4d, addr);
+	pudp = pud_offset(p4d, addr);
 	do {
  again:
+		pud = READ_ONCE(*pudp);
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
+		if (pud_none(pud) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
@@ -140,27 +142,29 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		walk->action = ACTION_SUBTREE;
 
 		if (ops->pud_entry)
-			err = ops->pud_entry(pud, addr, next, walk);
+			err = ops->pud_entry(pud, pudp, addr, next, walk);
 		if (err)
 			break;
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
 
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
+		if ((!walk->vma && (pud_leaf(pud) || !pud_present(pud))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pmd_entry || ops->pte_entry))
 			continue;
 
-		if (walk->vma)
-			split_huge_pud(walk->vma, pud, addr);
-		if (pud_none(*pud))
-			goto again;
+		if (walk->vma) {
+			split_huge_pud(walk->vma, pudp, addr);
+			pud = READ_ONCE(*pudp);
+			if (pud_none(pud))
+				goto again;
+		}
 
 		err = walk_pmd_range(pud, addr, next, walk);
 		if (err)
 			break;
-	} while (pud++, addr = next, addr != end);
+	} while (pudp++, addr = next, addr != end);
 
 	return err;
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 26208d0d03b7a9..c5e1717671e36a 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -59,11 +59,10 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	return 0;
 }
 
-static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
+static int ptdump_pud_entry(pud_t val, pud_t *pudp, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
-	pud_t val = READ_ONCE(*pud);
 
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_KASAN)
 	if (pud_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pmd)))
-- 
2.28.0

