Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B533C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED5206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoCKeHWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgCQFmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37268 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgCQFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so3460066pff.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+BJ176dSSBvN9sSY2HrTg8Wa1CvMEwHoET9AcrbjQWU=;
        b=EoCKeHWONcrPNClKHYjCVVBrGvv6mVutawTcqSgaObAaZvNTy04Tv3Wt8ZKCTTCCQ3
         L2WMrSNLcX5aao24W/7f45slovez9HTVdlkPwH4gU3+7fXHnPka0gQgPT1PUTnhP59zR
         5Un8EKF9LTJ8QsOMzeYidChTOyL7WgvNr4+X2dUk2vytDJQmexcpwxd6kJ/d65GCYAky
         9rjK3KP1h5IAphIE8WwBXyePxDgWXXW9Jab9XPAe5x4H/RYxl9JQbRbzV0JiaCh46q9X
         ViUFfRsnm0Vmu2fYHaXp6fvrX+Cjgt0HPklHOEZT4kCTv4NQgjoMQ4isj5okkxJem/gZ
         2rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+BJ176dSSBvN9sSY2HrTg8Wa1CvMEwHoET9AcrbjQWU=;
        b=VS60yNEU2hBCsmFOoNNmlP5p4jhbnC9ZzK7HwVpOpYWDhpLUuVU5JaQkguxeBfEDPE
         /aWpldKWJ24R34QGGPnhgzbooKFs6R0T8Ji9z7gSNy1cy/JZuD56A0CzZJNmc9zqEnG8
         H2vZ3gOfvfU9M841/1FglMkqWPbZNiMdWaonIHXJ9gLI2zZYOG1wUMkw7xRxYyj5Fd89
         voZKdWyrbVXfTmg/yglxNOvcnj1NvaXFAn8WLv1HWGOe1ypSV77fX0jExoseBUdggGTY
         Q9VkxtRakMBEFGJfyr2yeXBpOo3BpgHIcvS2vUWTmiPspe+w2r9ES2pqjYqDYjkT0MKF
         AM3w==
X-Gm-Message-State: ANhLgQ0VTrZbC8X9xpJm6mMzmwAbOvauJrC2gDr2M6Qy72+haGf4g/NS
        j1fFFqe/j3K/EG7lROWbX7lvfv6aKDU=
X-Google-Smtp-Source: ADFU+vtW+jHX7lzdw/DvQPtw/zdBehGT/6+QiGAVp1vAD1jy6OhA5UreXdNjwp6mBqXyqXSexNQmDQ==
X-Received: by 2002:a63:7359:: with SMTP id d25mr3267242pgn.2.1584423732584;
        Mon, 16 Mar 2020 22:42:12 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:12 -0700 (PDT)
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
Subject: [PATCH v3 2/9] mm/vmscan: protect the workingset on anonymous LRU
Date:   Tue, 17 Mar 2020 14:41:50 +0900
Message-Id: <1584423717-3440-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  6 +++---
 mm/khugepaged.c         |  2 +-
 mm/memory.c             |  9 ++++-----
 mm/migrate.c            |  2 +-
 mm/swap.c               | 13 +++++++------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 mm/vmscan.c             |  4 +---
 10 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7a..954e13e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,7 +344,7 @@ extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
-extern void lru_cache_add_active_or_unevictable(struct page *page,
+extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
 /* linux/mm/vmscan.c */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13..14156fc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -190,7 +190,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		get_page(new_page);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
 		dec_mm_counter(mm, MM_ANONPAGES);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a880932..6356dfd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -638,7 +638,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
 		mem_cgroup_commit_charge(page, memcg, false, true);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1282,7 +1282,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 		set_page_private(pages[i], 0);
 		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
 		mem_cgroup_commit_charge(pages[i], memcg, false, false);
-		lru_cache_add_active_or_unevictable(pages[i], vma);
+		lru_cache_add_inactive_or_unevictable(pages[i], vma);
 		vmf->pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*vmf->pte));
 		set_pte_at(vma->vm_mm, haddr, vmf->pte, entry);
@@ -1435,7 +1435,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		if (!page) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908..246c155 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1092,7 +1092,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	page_add_new_anon_rmap(new_page, vma, address, true);
 	mem_cgroup_commit_charge(new_page, memcg, false, true);
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
-	lru_cache_add_active_or_unevictable(new_page, vma);
+	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9..5f7813a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2513,7 +2513,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3038,11 +3038,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
-		activate_page(page);
 	}
 
 	swap_free(entry);
@@ -3186,7 +3185,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(page, vma);
+	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3449,7 +3448,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/migrate.c b/mm/migrate.c
index 86873b6..ef034c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2784,7 +2784,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	page_add_new_anon_rmap(page, vma, addr, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	if (!is_zone_device_page(page))
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
 
 	if (flush) {
diff --git a/mm/swap.c b/mm/swap.c
index 5341ae9..18b2735 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -448,23 +448,24 @@ void lru_cache_add(struct page *page)
 }
 
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
+	bool evictable;
+
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
-		SetPageActive(page);
-	else if (!TestSetPageMlocked(page)) {
+	evictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED;
+	if (!evictable && !TestSetPageMlocked(page)) {
 		/*
 		 * We use the irq-unsafe __mod_zone_page_stat because this
 		 * counter is not modified from interrupt context, and the pte
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d..6bdcbf9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1888,7 +1888,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 1b0d7ab..875e329 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -120,7 +120,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(page, dst_vma);
+	lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e772f3f..c932141 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1010,8 +1010,6 @@ static enum page_references page_check_references(struct page *page,
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
-		if (PageSwapBacked(page))
-			return PAGEREF_ACTIVATE;
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
@@ -1034,7 +1032,7 @@ static enum page_references page_check_references(struct page *page,
 		/*
 		 * Activate file-backed executable pages after first usage.
 		 */
-		if (vm_flags & VM_EXEC)
+		if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
-- 
2.7.4

