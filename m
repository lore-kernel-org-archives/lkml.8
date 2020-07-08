Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FEE20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsLAGSLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgGHHQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgGHHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:16:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4720C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:16:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so1810525pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/j7etSqm2CvvtGvUX/WpYIoiSvXeTmOIHFxWZnBTsE=;
        b=CsLAGSLMEkS8nWCE4rutnqTqYmrr772RHKWtnIG7n4rxu9Kgmb8TFYZTFc9rLNYc62
         Dswlr87tKNVy9tgVSZz1acJjl82kwNbQRKBEPw78xFnTWC5Bi0pYqJ5hj6IhLgRv/sTO
         fxftVmAHCBM+YsVtUw89/B7n71Ynb19aHG1jwmkqLegnV9K/VogWyqbdTWDYpCDw0oJe
         NjV33d3BeVd7JE0wOua77ABRsG5xdyf/9KWhAD2dmt28vB3np4P5ft4QALeyblVEfFq3
         NyDF1J6hoJnkmrE3FR0UnxSOUcN2O8WZT712SbUIKWiKLGqRkFlKIO6N9PBvCggVVRwC
         94MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/j7etSqm2CvvtGvUX/WpYIoiSvXeTmOIHFxWZnBTsE=;
        b=Zf2pLIYRrAaed/f0/wWkRlu1/Ne+ephf5TdkoZBvieBDeu4OwGemI40RsTWz+tBhIK
         mk2siY+L85Z4ONj/NNHA0jL5j+Yl7B2idIGVmnRPc50e+7E53PRR9zWuv79/bBs5LEuM
         iq319fKEs/GLgzUETi13Pnhp11DLwSLEn3dVJRf4W2zVQg6QGb+3Na05P7ZEkE/bUtB2
         RZIApjdqCqG+2ZjYXXJWWQkYi6TIpugo4FlYUCRtWeFRecFSIeDapogKHb0RwgChMKiM
         NCwwC+Y3rhWI08UZcMvnHp6uUNwjHPong4nO/IxmdRheIlUc47oPrqDqKpxA2wdbWwzN
         3m4A==
X-Gm-Message-State: AOAM531UUQabzS07I6FD0mRkgpZIPYLusooPpkV85Y31PkvOWreZT71d
        515xiW78TPMTB+I5tofEtfA=
X-Google-Smtp-Source: ABdhPJwIaRAbWPm7Qqidfy0HbX46p0sykZW0ruEPtvxhOIAw8VzmiWtxVFvhdD4GNEn3668EWKYDyw==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr51156464pls.29.1594192568168;
        Wed, 08 Jul 2020 00:16:08 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id h100sm4532663pjb.46.2020.07.08.00.16.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:16:07 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:16:02 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200708071602.GB16543@js1304-desktop>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > new_non_cma_page() in gup.c which try to allocate migration target page
> > requires to allocate the new page that is not on the CMA area.
> > new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> > works well for THP page or normal page but not for hugetlb page.
> > 
> > hugetlb page allocation process consists of two steps.  First is dequeing
> > from the pool.  Second is, if there is no available page on the queue,
> > allocating from the page allocator.
> > 
> > new_non_cma_page() can control allocation from the page allocator by
> > specifying correct gfp flag.  However, dequeing cannot be controlled until
> > now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> > since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> > patch tries to fix this situation.
> > 
> > This patch makes the deque function on hugetlb CMA aware and skip CMA
> > pages if newly added skip_cma argument is passed as true.
> 
> Hmm, can't you instead change dequeue_huge_page_node_exact() to test the PF_
> flag and avoid adding bool skip_cma everywhere?

Okay! Please check following patch.
> 
> I think that's what Michal suggested [1] except he said "the code already does
> by memalloc_nocma_{save,restore} API". It needs extending a bit though, AFAICS.
> __gup_longterm_locked() indeed does the save/restore, but restore comes before
> check_and_migrate_cma_pages() and thus new_non_cma_page() is called, so an
> adjustment is needed there, but that's all?
> 
> Hm the adjustment should be also done because save/restore is done around
> __get_user_pages_locked(), but check_and_migrate_cma_pages() also calls
> __get_user_pages_locked(), and that call not being between nocma save and
> restore is thus also a correctness issue?

Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
would not cause any problem.

------------------>8-------------------
From bcfc57e3c6f2df1ad2940308b89d740cd3f0fba8 Mon Sep 17 00:00:00 2001
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Wed, 8 Jul 2020 14:39:26 +0900
Subject: [PATCH] mm/hugetlb: make hugetlb migration callback CMA aware

new_non_cma_page() in gup.c which try to allocate migration target page
requires to allocate the new page that is not on the CMA area.
new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
works well for THP page or normal page but not for hugetlb page.

hugetlb page allocation process consists of two steps.  First is dequeing
from the pool.  Second is, if there is no available page on the queue,
allocating from the page allocator.

new_non_cma_page() can control allocation from the page allocator by
specifying correct gfp flag.  However, dequeing cannot be controlled until
now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
patch tries to fix this situation.

This patch makes new_non_cma_page() uses memalloc_nocma_{save,restore}
to exclude CMA memory rather than manually clearing __GFP_MOVABLE. And,
this patch also makes the deque function on hugetlb CMA aware. In the
deque function, CMA memory is skipped if PF_MEMALLOC_NOCMA flag is set
by memalloc_nocma_{save,restore}.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 --
 mm/gup.c                | 32 +++++++++++++++-----------------
 mm/hugetlb.c            | 11 +++++++++--
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bb93e95..34a10e5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -509,8 +509,6 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
diff --git a/mm/gup.c b/mm/gup.c
index 5daadae..79142a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1623,6 +1623,8 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	 * allocation memory.
 	 */
 	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
+	unsigned int flags = memalloc_nocma_save();
+	struct page *new_page = NULL;
 
 	if (PageHighMem(page))
 		gfp_mask |= __GFP_HIGHMEM;
@@ -1630,33 +1632,29 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+
+		new_page = alloc_huge_page_nodemask(h, nid, NULL, gfp_mask);
+		goto out;
 	}
 #endif
+
 	if (PageTransHuge(page)) {
-		struct page *thp;
 		/*
 		 * ignore allocation failure warnings
 		 */
 		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
 
-		/*
-		 * Remove the movable mask so that we don't allocate from
-		 * CMA area again.
-		 */
-		thp_gfpmask &= ~__GFP_MOVABLE;
-		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
+		new_page = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
+		if (new_page)
+			prep_transhuge_page(new_page);
+		goto out;
 	}
 
-	return __alloc_pages_node(nid, gfp_mask, 0);
+	new_page = __alloc_pages_node(nid, gfp_mask, 0);
+
+out:
+	memalloc_nocma_restore(flags);
+	return new_page;
 }
 
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3245aa0..514e29c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -29,6 +29,7 @@
 #include <linux/numa.h>
 #include <linux/llist.h>
 #include <linux/cma.h>
+#include <linux/sched/mm.h>
 
 #include <asm/page.h>
 #include <asm/tlb.h>
@@ -1036,10 +1037,16 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
+	bool nocma = !!(READ_ONCE(current->flags) & PF_MEMALLOC_NOCMA);
+
+	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
+		if (nocma && is_migrate_cma_page(page))
+			continue;
 
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
 		if (!PageHWPoison(page))
 			break;
+	}
+
 	/*
 	 * if 'non-isolated free hugepage' not found on the list,
 	 * the allocation fails.
@@ -1928,7 +1935,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
-- 
2.7.4

