Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491BC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE6207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGPMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728805AbgGPMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2183BB940;
        Thu, 16 Jul 2020 12:38:39 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 12/15] mm,hwpoison: Rework soft offline for in-use pages
Date:   Thu, 16 Jul 2020 14:38:06 +0200
Message-Id: <20200716123810.25292-13-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way we set and handle in-use poisoned pages.
Until now, poisoned pages were released to the buddy allocator, trusting
that the checks that take place prior to deliver the page to its end
user would act as a safe net and would skip that page.

This has proved to be wrong, as we got some pfn walkers out there, like
compaction, that all they care is the page to be PageBuddy and be in a
freelist.
Although this might not be the only user, having poisoned pages
in the buddy allocator seems a bad idea as we should only have
free pages that are ready and meant to be used as such.

Before explaining the taken approach, let us break down the kind
of pages we can soft offline.

- Anonymous THP (after the split, they end up being 4K pages)
- Hugetlb
- Order-0 pages (that can be either migrated or invalited)

* Normal pages (order-0 and anon-THP)

  - If they are clean and unmapped page cache pages, we invalidate
    then by means of invalidate_inode_page().
  - If they are mapped/dirty, we do the isolate-and-migrate dance.

  Either way, do not call put_page directly from those paths.
  Instead, we keep the page and send it to page_set_poison to perform the
  right handling.

  Among other things, page_set_poison() sets the HWPoison flag and does the last
  put_page.
  This call to put_page is mainly to be able to call __page_cache_release,
  since this function is not exported.

  Down the chain, we placed a check for HWPoison page in
  free_pages_prepare, that just skips any poisoned page, so those pages
  do not end up either in a pcplist or in buddy-freelist.

  After that, we set the refcount on the page to 1 and we increment
  the poisoned pages counter.

  We could do as we do for free pages:
  1) wait until the page hits buddy's freelists
  2) take it off
  3) flag it

  The problem is that we could race with an allocation, so by the time we
  want to take the page off the buddy, the page is already allocated, so we
  cannot soft-offline it.
  This is not fatal of course, but if it is better if we can close the race
  as does not require a lot of code.

* Hugetlb pages

  - We isolate-and-migrate them

  There is no magic in here, we just isolate and migrate them.
  A new set of internal functions have been made to flag a hugetlb page as
  poisoned (SetPageHugePoisoned(), PageHugePoisoned(), ClearPageHugePoisoned())
  This allows us to flag the page when we migrate it, back in
  move_hugetlb_state().
  Later on we check whether the page is poisoned in __free_huge_page,
  and we bail out in that case before sending the page to e.g: active
  free list.
  This gives us full control of the page, and we can handle it
  page_handle_poison().

  In other words, we do not allow migrated hugepages to get back to the
  freelists.

  Since now the page has no user and has been migrated, we can call
  dissolve_free_huge_page, which will end up calling update_and_free_page.
  In update_and_free_page(), we check for the page to be poisoned.
  If it so, we handle it as we handle gigantic pages, i.e: we break down
  the page in order-0 pages and free them one by one.
  Doing so, allows us for free_pages_prepare to skip poisoned pages.

Because of the way we handle now in-use pages, we no longer need the
put-as-isolation-migratetype dance, that was guarding for poisoned pages
to end up in pcplists.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/page-flags.h |  5 ----
 mm/hugetlb.c               | 60 +++++++++++++++++++++++++++++++++-----
 mm/memory-failure.c        | 53 +++++++++++++--------------------
 mm/migrate.c               | 11 ++-----
 mm/page_alloc.c            | 38 +++++++-----------------
 5 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 01baf6d426ff..2ac8bfa0cf20 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -426,13 +426,8 @@ PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool take_page_off_buddy(struct page *page);
-extern bool set_hwpoison_free_buddy_page(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
-static inline bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	return 0;
-}
 #define __PG_HWPOISON 0
 #endif
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7badb01d15e3..1c6397936512 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -29,6 +29,7 @@
 #include <linux/numa.h>
 #include <linux/llist.h>
 #include <linux/cma.h>
+#include <linux/migrate.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -1209,9 +1210,26 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static inline bool PageHugePoisoned(struct page *page)
+{
+	if (!PageHuge(page))
+		return false;
+
+	return (unsigned long)page[3].mapping == -1U;
+}
+
+static inline void SetPageHugePoisoned(struct page *page)
+{
+	page[3].mapping = (void *)-1U;
+}
+
+static inline void ClearPageHugePoisoned(struct page *page)
+{
+	page[3].mapping = NULL;
+}
+
+static void destroy_compound_gigantic_page(struct hstate *h, struct page *page,
+					   unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1222,14 +1240,19 @@ static void destroy_compound_gigantic_page(struct page *page,
 		atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		if (!hstate_is_gigantic(h))
+			 p->mapping = NULL;
 		clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 
+	if (PageHugePoisoned(page))
+		ClearPageHugePoisoned(page);
 	set_compound_order(page, 0);
 	__ClearPageHead(page);
 }
 
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
@@ -1284,13 +1307,16 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-static inline void destroy_compound_gigantic_page(struct page *page,
-						unsigned int order) { }
+static inline void destroy_compound_gigantic_page(struct hstate *h,
+						  struct page *page,
+						  unsigned int order) { }
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
+	bool poisoned = PageHugePoisoned(page);
+	unsigned int order = huge_page_order(h);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1313,11 +1339,21 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 		 * we might block in free_gigantic_page().
 		 */
 		spin_unlock(&hugetlb_lock);
-		destroy_compound_gigantic_page(page, huge_page_order(h));
-		free_gigantic_page(page, huge_page_order(h));
+		destroy_compound_gigantic_page(h, page, order);
+		free_gigantic_page(page, order);
 		spin_lock(&hugetlb_lock);
 	} else {
-		__free_pages(page, huge_page_order(h));
+		if (unlikely(poisoned)) {
+			/*
+			 * If the hugepage is poisoned, do as we do for
+			 * gigantic pages and free the pages as order-0.
+			 * free_pages_prepare will skip over the poisoned ones.
+			 */
+			destroy_compound_gigantic_page(h, page, order);
+			free_contig_range(page_to_pfn(page), 1 << order);
+		} else {
+			__free_pages(page, huge_page_order(h));
+		}
 	}
 }
 
@@ -1427,6 +1463,11 @@ static void __free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
+	if (PageHugePoisoned(page)) {
+		spin_unlock(&hugetlb_lock);
+		return;
+	}
+
 	if (PageHugeTemporary(page)) {
 		list_del(&page->lru);
 		ClearPageHugeTemporary(page);
@@ -5642,6 +5683,9 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	hugetlb_cgroup_migrate(oldpage, newpage);
 	set_page_owner_migrate_reason(newpage, reason);
 
+	if (reason == MR_MEMORY_FAILURE)
+		SetPageHugePoisoned(oldpage);
+
 	/*
 	 * transfer temporary state of the new huge page. This is
 	 * reverse to other transitions because the newpage is going to
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index caf012d34607..c0ebab4eed4c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -65,9 +65,17 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static void page_handle_poison(struct page *page)
+static void page_handle_poison(struct page *page, bool release, bool set_flag,
+			       bool huge_flag)
 {
-	SetPageHWPoison(page);
+	if (set_flag)
+		SetPageHWPoison(page);
+
+        if (huge_flag)
+		dissolve_free_huge_page(page);
+        else if (release)
+		put_page(page);
+
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
 }
@@ -1717,7 +1725,7 @@ static int get_any_page(struct page *page, unsigned long pfn)
 
 static int soft_offline_huge_page(struct page *page)
 {
-	int ret;
+	int ret = -EBUSY;
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
 	LIST_HEAD(pagelist);
@@ -1757,19 +1765,12 @@ static int soft_offline_huge_page(struct page *page)
 			ret = -EIO;
 	} else {
 		/*
-		 * We set PG_hwpoison only when the migration source hugepage
-		 * was successfully dissolved, because otherwise hwpoisoned
-		 * hugepage remains on free hugepage list, then userspace will
-		 * find it as SIGBUS by allocation failure. That's not expected
-		 * in soft-offlining.
+		 * At this point the page cannot be in-use since we do not
+		 * let the page to go back to hugetlb freelists.
+		 * In that case we just need to dissolve it.
+		 * page_handle_poison will take care of it.
 		 */
-		ret = dissolve_free_huge_page(page);
-		if (!ret) {
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-			else
-				ret = -EBUSY;
-		}
+		page_handle_poison(page, true, true, true);
 	}
 	return ret;
 }
@@ -1804,10 +1805,8 @@ static int __soft_offline_page(struct page *page)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		SetPageHWPoison(page);
-		num_poisoned_pages_inc();
+		page_handle_poison(page, true, true, false);
 		return 0;
 	}
 
@@ -1838,7 +1837,9 @@ static int __soft_offline_page(struct page *page)
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
-		if (ret) {
+		if (!ret) {
+			page_handle_poison(page, true, true, false);
+		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
@@ -1857,37 +1858,25 @@ static int __soft_offline_page(struct page *page)
 static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
-	int mt;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
 
-	/*
-	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
-	 * to free list immediately (not via pcplist) when released after
-	 * successful page migration. Otherwise we can't guarantee that the
-	 * page is really free after put_page() returns, so
-	 * set_hwpoison_free_buddy_page() highly likely fails.
-	 */
-	mt = get_pageblock_migratetype(page);
-	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
 		ret = soft_offline_huge_page(page);
 	else
 		ret = __soft_offline_page(page);
-	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
 static int soft_offline_free_page(struct page *page)
 {
 	int rc = -EBUSY;
-	int rc = dissolve_free_huge_page(page);
 
 	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page);
+		page_handle_poison(page, false, true, false);
 		rc = 0;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 75c10d81e833..a68d81d0ae6e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1222,16 +1222,11 @@ static int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		put_page(page);
-		if (reason == MR_MEMORY_FAILURE) {
+		if (reason != MR_MEMORY_FAILURE)
 			/*
-			 * Set PG_HWPoison on just freed page
-			 * intentionally. Although it's rather weird,
-			 * it's how HWPoison flag works at the moment.
+			 * We handle poisoned pages in page_handle_poison.
 			 */
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-		}
+			put_page(page);
 	} else {
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4fa0e0887c07..11df51fc2718 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1175,6 +1175,16 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	trace_mm_page_free(page, order);
 
+	if (unlikely(PageHWPoison(page)) && !order) {
+		/*
+		 * Untie memcg state and reset page's owner
+		 */
+		if (memcg_kmem_enabled() && PageKmemcg(page))
+			__memcg_kmem_uncharge_page(page, order);
+		reset_page_owner(page, order);
+		return false;
+	}
+
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
@@ -8844,32 +8854,4 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
-
-/*
- * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
- * test is performed under the zone lock to prevent a race against page
- * allocation.
- */
-bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long flags;
-	unsigned int order;
-	bool hwpoisoned = false;
-
-	spin_lock_irqsave(&zone->lock, flags);
-	for (order = 0; order < MAX_ORDER; order++) {
-		struct page *page_head = page - (pfn & ((1 << order) - 1));
-
-		if (PageBuddy(page_head) && page_order(page_head) >= order) {
-			if (!TestSetPageHWPoison(page))
-				hwpoisoned = true;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&zone->lock, flags);
-
-	return hwpoisoned;
-}
 #endif
-- 
2.26.2

