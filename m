Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F052082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMAH0J/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgFQF0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgFQF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD564C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so559826pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmRNk7yUM9fFqnh0E7GxTLrrZ7/Cn3kew7vDIw5Ffcg=;
        b=TMAH0J/YV3EgCO2B24mOeRYf+GljszWc1juopRAukGyNhrhIu0pxSoeoQH0Mefjsel
         mTxmBgo0NSMkTzkzw4opm8QcsRXNtmEtHkAdQqXCJihNdmP19DXrQxKiV1nYaw2pGx63
         JPlPwVPpIcfnC4YPFvwlNcqU1g+flpKvdeAlgbTCnGUekVSYvkOfFhE5wj4OyKlGFzEt
         g96ZI8n8CkV0iiukLGBV2aSB9wcDEa/HfK5N7roFIsAdI0NWeJDU6MvjvXvWrWyiNVKF
         ZnGrYDmqZYFNoYs+dXJY3j+Rdi6dZDRCBkeBshJ1UUNQ5P3NEDBvOpfrPBh0IONgsj9H
         WvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmRNk7yUM9fFqnh0E7GxTLrrZ7/Cn3kew7vDIw5Ffcg=;
        b=ij2nXMiC9tQXz8u9lNPecTCikoSb1NnMLy8B1SxCyj9QBbxkIQ3zbtIHftb3ig4JOw
         qSEgfjdOEagt532u3k1Z+IsZaCpW3CoBUDhoGZ8n2tJejEIWvg4fCjAntgd/3WM0/rRZ
         Q4+DEjA8o69h9K9hMkGPNalEPthh5fevsB/F8H6TRT5fnMFzzntlAFt+iXPk1VpHdD+z
         LD6XtNW6NfguCTZHgxo+1cRA29MlrGhL8xiAMewrXHOaZFTVo3VRAdJbF+Z2E2NKE8ES
         9o/2pxdIBEQz9ip00GibVySC9fUs1RhqSP/yXEhkvsq+b6hzN4eOjJ72sBholAqKkjHO
         M76g==
X-Gm-Message-State: AOAM533mHWW2ZIyOnvZZMBd6oTofmXE+iStV5clZnV0iWXmwUS++FnJ5
        S/oMKhyWKkXdbdvKbSNLdWA=
X-Google-Smtp-Source: ABdhPJxQJ58nlLN/jPiwSln6bfax/824jahBqbjTJu4Rk5OAUgjB1BlzIFtp813Dmc83EmnX4JK1Ew==
X-Received: by 2002:a63:35cc:: with SMTP id c195mr4813470pga.180.1592371606108;
        Tue, 16 Jun 2020 22:26:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:45 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v6 2/6] mm/vmscan: protect the workingset on anonymous LRU
Date:   Wed, 17 Jun 2020 14:26:19 +0900
Message-Id: <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
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
detection that is applied to file LRU some day before.

v6: Before this patch, all anon pages (inactive + active) are considered
as workingset. However, with this patch, only active pages are considered
as workingset. So, file refault formula which uses the number of all
anon pages is changed to use only the number of active anon pages.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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
 mm/workingset.c         |  2 --
 11 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5b3216b..f4f5f94 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -353,7 +353,7 @@ extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
-extern void lru_cache_add_active_or_unevictable(struct page *page,
+extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
 /* linux/mm/vmscan.c */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bb08628..67814de 100644
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
index 78c84be..ffbf5ad 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -640,7 +640,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
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
index 3359057..f221f96 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2711,7 +2711,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3260,10 +3260,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3408,7 +3407,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	lru_cache_add_active_or_unevictable(page, vma);
+	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3666,7 +3665,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/migrate.c b/mm/migrate.c
index c95912f..f0ec043 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2856,7 +2856,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	inc_mm_counter(mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
 
 	if (flush) {
diff --git a/mm/swap.c b/mm/swap.c
index c5d5114..7cf3ab5 100644
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
+	if (unevictable && !TestSetPageMlocked(page)) {
 		/*
 		 * We use the irq-unsafe __mod_zone_page_stat because this
 		 * counter is not modified from interrupt context, and the pte
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c047789..38f6433 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1920,7 +1920,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
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
index 9f940c4..4745e88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1003,8 +1003,6 @@ static enum page_references page_check_references(struct page *page,
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
-		if (PageSwapBacked(page))
-			return PAGEREF_ACTIVATE;
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
@@ -1027,7 +1025,7 @@ static enum page_references page_check_references(struct page *page,
 		/*
 		 * Activate file-backed executable pages after first usage.
 		 */
-		if (vm_flags & VM_EXEC)
+		if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
diff --git a/mm/workingset.c b/mm/workingset.c
index 50b7937..fc16d97c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -357,8 +357,6 @@ void workingset_refault(struct page *page, void *shadow)
 	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_ANON);
-		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
 	}
 	if (refault_distance > workingset_size)
-- 
2.7.4

