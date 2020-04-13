Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05642C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E089B20692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgDMMwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:52:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:52678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgDMMw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:52:28 -0400
IronPort-SDR: AWnQIaJCB0SNIF98fYKj5W1f7zT6UnOpW+7/vnMjBibQZtbEnkwLl2BzuM+8ClR7uH/tDvxwxm
 UwWe8X9gxs0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 05:52:28 -0700
IronPort-SDR: 0wGN6UiggZoH8hQIHsCNUhXlwygtfdaiAN9tzmqvmAtGHGxKCsojsh3SHGtgVrqSthTenhaERq
 +4BiwxUX6Hhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="243529249"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 05:52:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0A3872B6; Mon, 13 Apr 2020 15:52:22 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3, RESEND 7/8] thp: Change CoW semantics for anon-THP
Date:   Mon, 13 Apr 2020 15:52:19 +0300
Message-Id: <20200413125220.663-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have different copy-on-write semantics for anon- and
file-THP. For anon-THP we try to allocate huge page on the write fault,
but on file-THP we split PMD and allocate 4k page.

Arguably, file-THP semantics is more desirable: we don't necessary want
to unshare full PMD range from the parent on the first access. This is
the primary reason THP is unusable for some workloads, like Redis.

The original THP refcounting didn't allow to have PTE-mapped compound
pages, so we had no options, but to allocate huge page on CoW (with
fallback to 512 4k pages).

The current refcounting doesn't have such limitations and we can cut a
lot of complex code out of fault path.

khugepaged is now able to recover THP from such ranges if the
configuration allows.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c | 249 +++++------------------------------------------
 1 file changed, 25 insertions(+), 224 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 24ad53b4dfc0..25b84cc0f17d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1206,262 +1206,63 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 	spin_unlock(vmf->ptl);
 }
 
-static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
-			pmd_t orig_pmd, struct page *page)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	struct mem_cgroup *memcg;
-	pgtable_t pgtable;
-	pmd_t _pmd;
-	int i;
-	vm_fault_t ret = 0;
-	struct page **pages;
-	struct mmu_notifier_range range;
-
-	pages = kmalloc_array(HPAGE_PMD_NR, sizeof(struct page *),
-			      GFP_KERNEL);
-	if (unlikely(!pages)) {
-		ret |= VM_FAULT_OOM;
-		goto out;
-	}
-
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
-					       vmf->address, page_to_nid(page));
-		if (unlikely(!pages[i] ||
-			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
-				     GFP_KERNEL, &memcg, false))) {
-			if (pages[i])
-				put_page(pages[i]);
-			while (--i >= 0) {
-				memcg = (void *)page_private(pages[i]);
-				set_page_private(pages[i], 0);
-				mem_cgroup_cancel_charge(pages[i], memcg,
-						false);
-				put_page(pages[i]);
-			}
-			kfree(pages);
-			ret |= VM_FAULT_OOM;
-			goto out;
-		}
-		set_page_private(pages[i], (unsigned long)memcg);
-	}
-
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		copy_user_highpage(pages[i], page + i,
-				   haddr + PAGE_SIZE * i, vma);
-		__SetPageUptodate(pages[i]);
-		cond_resched();
-	}
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				haddr, haddr + HPAGE_PMD_SIZE);
-	mmu_notifier_invalidate_range_start(&range);
-
-	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
-		goto out_free_pages;
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-
-	/*
-	 * Leave pmd empty until pte is filled note we must notify here as
-	 * concurrent CPU thread might write to new page before the call to
-	 * mmu_notifier_invalidate_range_end() happens which can lead to a
-	 * device seeing memory write in different order than CPU.
-	 *
-	 * See Documentation/vm/mmu_notifier.rst
-	 */
-	pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
-
-	pgtable = pgtable_trans_huge_withdraw(vma->vm_mm, vmf->pmd);
-	pmd_populate(vma->vm_mm, &_pmd, pgtable);
-
-	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
-		pte_t entry;
-		entry = mk_pte(pages[i], vma->vm_page_prot);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		memcg = (void *)page_private(pages[i]);
-		set_page_private(pages[i], 0);
-		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
-		mem_cgroup_commit_charge(pages[i], memcg, false, false);
-		lru_cache_add_active_or_unevictable(pages[i], vma);
-		vmf->pte = pte_offset_map(&_pmd, haddr);
-		VM_BUG_ON(!pte_none(*vmf->pte));
-		set_pte_at(vma->vm_mm, haddr, vmf->pte, entry);
-		pte_unmap(vmf->pte);
-	}
-	kfree(pages);
-
-	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(vma->vm_mm, vmf->pmd, pgtable);
-	page_remove_rmap(page, true);
-	spin_unlock(vmf->ptl);
-
-	/*
-	 * No need to double call mmu_notifier->invalidate_range() callback as
-	 * the above pmdp_huge_clear_flush_notify() did already call it.
-	 */
-	mmu_notifier_invalidate_range_only_end(&range);
-
-	ret |= VM_FAULT_WRITE;
-	put_page(page);
-
-out:
-	return ret;
-
-out_free_pages:
-	spin_unlock(vmf->ptl);
-	mmu_notifier_invalidate_range_end(&range);
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		memcg = (void *)page_private(pages[i]);
-		set_page_private(pages[i], 0);
-		mem_cgroup_cancel_charge(pages[i], memcg, false);
-		put_page(pages[i]);
-	}
-	kfree(pages);
-	goto out;
-}
-
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = NULL, *new_page;
-	struct mem_cgroup *memcg;
+	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	struct mmu_notifier_range range;
-	gfp_t huge_gfp;			/* for allocation and charge */
-	vm_fault_t ret = 0;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
+
 	if (is_huge_zero_pmd(orig_pmd))
-		goto alloc;
+		goto fallback;
+
 	spin_lock(vmf->ptl);
-	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
-		goto out_unlock;
+
+	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 
 	page = pmd_page(orig_pmd);
 	VM_BUG_ON_PAGE(!PageCompound(page) || !PageHead(page), page);
-	/*
-	 * We can only reuse the page if nobody else maps the huge page or it's
-	 * part.
-	 */
+
+	/* Lock page for reuse_swap_page() */
 	if (!trylock_page(page)) {
 		get_page(page);
 		spin_unlock(vmf->ptl);
 		lock_page(page);
 		spin_lock(vmf->ptl);
 		if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
+			spin_unlock(vmf->ptl);
 			unlock_page(page);
 			put_page(page);
-			goto out_unlock;
+			return 0;
 		}
 		put_page(page);
 	}
+
+	/*
+	 * We can only reuse the page if nobody else maps the huge page or it's
+	 * part.
+	 */
 	if (reuse_swap_page(page, NULL)) {
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry,  1))
+		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		ret |= VM_FAULT_WRITE;
 		unlock_page(page);
-		goto out_unlock;
-	}
-	unlock_page(page);
-	get_page(page);
-	spin_unlock(vmf->ptl);
-alloc:
-	if (__transparent_hugepage_enabled(vma) &&
-	    !transparent_hugepage_debug_cow()) {
-		huge_gfp = alloc_hugepage_direct_gfpmask(vma);
-		new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
-	} else
-		new_page = NULL;
-
-	if (likely(new_page)) {
-		prep_transhuge_page(new_page);
-	} else {
-		if (!page) {
-			split_huge_pmd(vma, vmf->pmd, vmf->address);
-			ret |= VM_FAULT_FALLBACK;
-		} else {
-			ret = do_huge_pmd_wp_page_fallback(vmf, orig_pmd, page);
-			if (ret & VM_FAULT_OOM) {
-				split_huge_pmd(vma, vmf->pmd, vmf->address);
-				ret |= VM_FAULT_FALLBACK;
-			}
-			put_page(page);
-		}
-		count_vm_event(THP_FAULT_FALLBACK);
-		goto out;
-	}
-
-	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
-					huge_gfp, &memcg, true))) {
-		put_page(new_page);
-		split_huge_pmd(vma, vmf->pmd, vmf->address);
-		if (page)
-			put_page(page);
-		ret |= VM_FAULT_FALLBACK;
-		count_vm_event(THP_FAULT_FALLBACK);
-		goto out;
-	}
-
-	count_vm_event(THP_FAULT_ALLOC);
-	count_memcg_events(memcg, THP_FAULT_ALLOC, 1);
-
-	if (!page)
-		clear_huge_page(new_page, vmf->address, HPAGE_PMD_NR);
-	else
-		copy_user_huge_page(new_page, page, vmf->address,
-				    vma, HPAGE_PMD_NR);
-	__SetPageUptodate(new_page);
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				haddr, haddr + HPAGE_PMD_SIZE);
-	mmu_notifier_invalidate_range_start(&range);
-
-	spin_lock(vmf->ptl);
-	if (page)
-		put_page(page);
-	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
 		spin_unlock(vmf->ptl);
-		mem_cgroup_cancel_charge(new_page, memcg, true);
-		put_page(new_page);
-		goto out_mn;
-	} else {
-		pmd_t entry;
-		entry = mk_huge_pmd(new_page, vma->vm_page_prot);
-		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
-		page_add_new_anon_rmap(new_page, vma, haddr, true);
-		mem_cgroup_commit_charge(new_page, memcg, false, true);
-		lru_cache_add_active_or_unevictable(new_page, vma);
-		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
-		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		if (!page) {
-			add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		} else {
-			VM_BUG_ON_PAGE(!PageHead(page), page);
-			page_remove_rmap(page, true);
-			put_page(page);
-		}
-		ret |= VM_FAULT_WRITE;
+		return VM_FAULT_WRITE;
 	}
+
+	unlock_page(page);
 	spin_unlock(vmf->ptl);
-out_mn:
-	/*
-	 * No need to double call mmu_notifier->invalidate_range() callback as
-	 * the above pmdp_huge_clear_flush_notify() did already call it.
-	 */
-	mmu_notifier_invalidate_range_only_end(&range);
-out:
-	return ret;
-out_unlock:
-	spin_unlock(vmf->ptl);
-	return ret;
+fallback:
+	__split_huge_pmd(vma, vmf->pmd, vmf->address, false, NULL);
+	return VM_FAULT_FALLBACK;
 }
 
 /*
-- 
2.26.0

