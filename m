Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CCC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AC92086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKKrBrNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGWHtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D67C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so2791988pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5r7ZBhmToWfTh6yXZt2NTooBEemow+91NRlzlx63OaA=;
        b=aKKrBrNfvnuVnx6fk6ZNyxZpIturi5UukrlUbtgchTUg3LoYtaKBLQXQQl846pivrU
         OzVCoEjsAbTk57NfakzdF5y5fWOeEhyvofMScO0C2cgHk3VUOCkgYrxppZE9z7iY//up
         BCFrnJcja1Zx4ScJMAFuBWoat2/OUwUCLJ4cu0i0mRoyF7i7eqOHSOyRu5msm16S6Qlu
         rSjSCqdBrRxQYPeEuDq2jOBkCl+yX9bPNTqR3Gt3q1ygFZOFyw0OVYKUpTzjKgMLpylU
         3kgX5JBz5QJ42NSQFWBGpxCxu6muuyDv37Yb74wKAWpi88250gaL3O7DqckUFM0voS2k
         +pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5r7ZBhmToWfTh6yXZt2NTooBEemow+91NRlzlx63OaA=;
        b=T9Rux7Vm0jaw2dc1O11y+gGTOZzVrSwOjfMy42bwDYVDslI/n4WYAnvXgYGHZSUtI7
         Q0xmQh6qWh7lv3sFEafrDBp8bVNdZiFJgfm0HbRzK3v53I1AroQeRXKlF8ZRQPirg9DW
         mU4oqztfT3C8r+zLAxuyS2wQat/6j1wb6RE+tAXmEh5ZomavD9rXOMZBkbaqsjfvFZax
         xh+9m1qGKTy9GKKPODvQC94cCEH9Zoy1UKKnCWvQ2v9W2mBKVYShWG96NnQSVbK0OJvb
         c+IYUNPJJxj/keVvLZWnulsjKULY7rLBIxM2wpWjLiex/2rzlrHB2j1A3t8uAbuqyUNE
         H2RQ==
X-Gm-Message-State: AOAM530xZrtudsJ12/RzAv9iZQyNClyEuDNu/htUsv1YvME4xmh2P66p
        0vEC9u8siXrMHQes91Bq3Eo7cDJD
X-Google-Smtp-Source: ABdhPJzOmqRN5+guEfjcZ2SZmYbkAu/w/sMiuUlFAihfvY02WYYdo6MpTqejFdG0eBvSrzPSPqKzdQ==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr2816332plm.72.1595490585244;
        Thu, 23 Jul 2020 00:49:45 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:44 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v7 2/6] mm/vmscan: protect the workingset on anonymous LRU
Date:   Thu, 23 Jul 2020 16:49:16 +0900
Message-Id: <1595490560-15117-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In current implementation, newly created or swap-in anonymous page
is started on active list. Growing active list results in rebalancing
active/inactive list so old pages on active list are demoted to inactive
list. Hence, the page on active list isn't protected at all.

Following is an example of this situation.

Assume that 50 hot pages on active list. Numbers denote the number of
pages on active/inactive list (active | inactive).

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

This patch tries to fix this issue.
Like as file LRU, newly created or swap-in anonymous pages will be
inserted to the inactive list. They are promoted to active list if
enough reference happens. This simple modification changes the above
example as following.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(h) | 50(uo)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(uo)

As you can see, hot pages on active list would be protected.

Note that, this implementation has a drawback that the page cannot
be promoted and will be swapped-out if re-access interval is greater than
the size of inactive list but less than the size of total(active+inactive).
To solve this potential issue, following patch will apply workingset
detection similar to the one that's already applied to file LRU.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             |  9 ++++-----
 mm/migrate.c            |  2 +-
 mm/swap.c               | 13 +++++++------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 mm/vmscan.c             |  4 +---
 10 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7eb59bc..51ec9cd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -352,7 +352,7 @@ extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
-extern void lru_cache_add_active_or_unevictable(struct page *page,
+extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
 /* linux/mm/vmscan.c */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f500204..02791f8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -184,7 +184,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	if (new_page) {
 		get_page(new_page);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
 		dec_mm_counter(mm, MM_ANONPAGES);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 15c9690..2068518 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -619,7 +619,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b043c40..02fb51f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1173,7 +1173,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-	lru_cache_add_active_or_unevictable(new_page, vma);
+	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 45e1dc0..25769b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2717,7 +2717,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3268,10 +3268,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
-		activate_page(page);
 	}
 
 	swap_free(entry);
@@ -3416,7 +3415,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	lru_cache_add_active_or_unevictable(page, vma);
+	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3674,7 +3673,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/migrate.c b/mm/migrate.c
index c233781..4fef341 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2912,7 +2912,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	inc_mm_counter(mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
 
 	if (flush) {
diff --git a/mm/swap.c b/mm/swap.c
index 587be74..d16d65d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -476,23 +476,24 @@ void lru_cache_add(struct page *page)
 EXPORT_SYMBOL(lru_cache_add);
 
 /**
- * lru_cache_add_active_or_unevictable
+ * lru_cache_add_inactive_or_unevictable
  * @page:  the page to be added to LRU
  * @vma:   vma in which page is mapped for determining reclaimability
  *
- * Place @page on the active or unevictable LRU list, depending on its
+ * Place @page on the inactive or unevictable LRU list, depending on its
  * evictability.  Note that if the page is not evictable, it goes
  * directly back onto it's zone's unevictable list, it does NOT use a
  * per cpu pagevec.
  */
-void lru_cache_add_active_or_unevictable(struct page *page,
+void lru_cache_add_inactive_or_unevictable(struct page *page,
 					 struct vm_area_struct *vma)
 {
+	bool unevictable;
+
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
-		SetPageActive(page);
-	else if (!TestSetPageMlocked(page)) {
+	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
+	if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
 		/*
 		 * We use the irq-unsafe __mod_zone_page_stat because this
 		 * counter is not modified from interrupt context, and the pte
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7b0974f..6bd9b4c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1921,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		page_add_anon_rmap(page, vma, addr, false);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b804193..9a3d451 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -123,7 +123,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
-	lru_cache_add_active_or_unevictable(page, dst_vma);
+	lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d5a19c7..9406948 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -998,8 +998,6 @@ static enum page_references page_check_references(struct page *page,
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
-		if (PageSwapBacked(page))
-			return PAGEREF_ACTIVATE;
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
@@ -1022,7 +1020,7 @@ static enum page_references page_check_references(struct page *page,
 		/*
 		 * Activate file-backed executable pages after first usage.
 		 */
-		if (vm_flags & VM_EXEC)
+		if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
-- 
2.7.4

