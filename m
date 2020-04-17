Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13065C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2A72076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgDQOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:44:17 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42005 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgDQOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:44:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TvqMaZN_1587134650;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvqMaZN_1587134650)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 22:44:11 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm/swap: clean up parameter pass in swapin funcs
Date:   Fri, 17 Apr 2020 22:43:44 +0800
Message-Id: <1587134624-184860-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folding parameter struct vm_area_struct *vma, unsigned long addr into
struct vm_fault vmf, this makes func path more readble, and give a chance
to pass more parameters as vmf fields on these series funcs.

No functional change yet.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: linux-kernel@vger.kernel.org 
Cc: linux-mm@kvack.org 
---
 include/linux/swap.h |  6 ++----
 mm/madvise.c         | 11 +++++++----
 mm/shmem.c           | 12 ++++++------
 mm/swap_state.c      | 23 ++++++++++-------------
 mm/swapfile.c        |  8 +++++---
 mm/zswap.c           |  3 ++-
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7e44e1e6ef27..5627fb8ca827 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -417,11 +417,9 @@ extern struct page *lookup_swap_cache(swp_entry_t entry,
 				      struct vm_area_struct *vma,
 				      unsigned long addr);
 extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool do_poll);
+				struct vm_fault *vmf, bool do_poll);
 extern struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated);
+				struct vm_fault *vmf, bool *new_page_allocated);
 extern struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				struct vm_fault *vmf);
 extern struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4bb30ed6c8d2..e9bd80087dbb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -184,8 +184,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
 {
 	pte_t *orig_pte;
-	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	struct vm_fault vmf = { .vma = walk->private};
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
@@ -196,7 +196,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+		orig_pte = pte_offset_map_lock(vmf.vma->vm_mm,
+						pmd, start, &ptl);
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
@@ -206,8 +207,9 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		if (unlikely(non_swap_entry(entry)))
 			continue;
 
+		vmf.address = index;
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-							vma, index, false);
+							&vmf, false);
 		if (page)
 			put_page(page);
 	}
@@ -226,6 +228,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	pgoff_t index;
 	struct page *page;
 	swp_entry_t swap;
+	struct vm_fault vmf = { .vma = NULL, .address = 0};
 
 	for (; start < end; start += PAGE_SIZE) {
 		index = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
@@ -238,7 +241,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		}
 		swap = radix_to_swp_entry(page);
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-							NULL, 0, false);
+							&vmf, false);
 		if (page)
 			put_page(page);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index d722eb830317..d17dd0e49cef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1437,16 +1437,15 @@ static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
 }
 
 static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
+	struct vm_fault *vmf, struct shmem_inode_info *info, pgoff_t index)
 {
 	struct vm_area_struct pvma;
 	struct page *page;
-	struct vm_fault vmf;
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	vmf.vma = &pvma;
-	vmf.address = 0;
-	page = swap_cluster_readahead(swap, gfp, &vmf);
+	vmf->vma = &pvma;
+	vmf->address = 0;
+	page = swap_cluster_readahead(swap, gfp, vmf);
 	shmem_pseudo_vma_destroy(&pvma);
 
 	return page;
@@ -1621,6 +1620,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
 	struct mem_cgroup *memcg;
 	struct page *page;
+	struct vm_fault vmf;
 	swp_entry_t swap;
 	int error;
 
@@ -1638,7 +1638,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(charge_mm, PGMAJFAULT);
 		}
 		/* Here we actually start the io */
-		page = shmem_swapin(swap, gfp, info, index);
+		page = shmem_swapin(swap, gfp, &vmf, info, index);
 		if (!page) {
 			error = -ENOMEM;
 			goto failed;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..b04f9893608d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -357,11 +357,12 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 }
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+			struct vm_fault *vmf, bool *new_page_allocated)
 {
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address;
 	int err;
 	*new_page_allocated = false;
 
@@ -446,11 +447,11 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * the swap entry is no longer in use.
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-		struct vm_area_struct *vma, unsigned long addr, bool do_poll)
+					struct vm_fault *vmf, bool do_poll)
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+						vmf, &page_was_allocated);
 
 	if (page_was_allocated)
 		swap_readpage(retpage, do_poll);
@@ -547,8 +548,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	bool do_poll = true, page_allocated;
-	struct vm_area_struct *vma = vmf->vma;
-	unsigned long addr = vmf->address;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
@@ -575,7 +574,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+			gfp_mask, vmf, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -591,7 +590,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	return read_swap_cache_async(entry, gfp_mask, vmf, do_poll);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -723,7 +722,6 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
-	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte, pentry;
 	swp_entry_t entry;
@@ -746,8 +744,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
-		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+		page = __read_swap_cache_async(entry, gfp_mask, vmf,
+					       &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -762,8 +760,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+	return read_swap_cache_async(fentry, gfp_mask, vmf, ra_info.win == 1);
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..7b3a4aff7d35 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1850,11 +1850,13 @@ static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
  * just let do_wp_page work it out if a write is requested later - to
  * force COW, vm_page_prot omits write permission from any private vma.
  */
-static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, swp_entry_t entry, struct page *page)
+static int unuse_pte(struct vm_fault *vmf, swp_entry_t entry, struct page *page)
 {
 	struct page *swapcache;
 	struct mem_cgroup *memcg;
+	struct vm_area_struct *vma = vmf->vma;
+	pmd_t *pmd = vmf->pmd;
+	unsigned long addr = vmf->address;
 	spinlock_t *ptl;
 	pte_t *pte;
 	int ret = 1;
@@ -1949,7 +1951,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		lock_page(page);
 		wait_on_page_writeback(page);
-		ret = unuse_pte(vma, pmd, addr, entry, page);
+		ret = unuse_pte(&vmf, entry, page);
 		if (ret < 0) {
 			unlock_page(page);
 			put_page(page);
diff --git a/mm/zswap.c b/mm/zswap.c
index fbb782924ccc..ef5a3fe442d6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -846,9 +846,10 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
 				struct page **retpage)
 {
 	bool page_was_allocated;
+	struct vm_fault vmf = { .vma = NULL, .address = 0};
 
 	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
-			NULL, 0, &page_was_allocated);
+			&vmf, &page_was_allocated);
 	if (page_was_allocated)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
-- 
1.8.3.1

