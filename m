Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FAC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63A524690
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgB1Dis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:38:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:36522 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbgB1Dis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:38:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 19:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="232107402"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 19:38:44 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: [RFC 3/3] mm: Discard lazily freed pages when migrating
Date:   Fri, 28 Feb 2020 11:38:19 +0800
Message-Id: <20200228033819.3857058-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228033819.3857058-1-ying.huang@intel.com>
References: <20200228033819.3857058-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

MADV_FREE is a lazy free mechanism in Linux.  According to the manpage
of mavise(2), the semantics of MADV_FREE is,

  The application no longer requires the pages in the range specified
  by addr and len.  The kernel can thus free these pages, but the
  freeing could be delayed until memory pressure occurs. ...

Originally, the pages freed lazily by MADV_FREE will only be freed
really by page reclaiming when there is memory pressure or when
unmapping the address range.  In addition to that, there's another
opportunity to free these pages really, when we try to migrate them.

The main value to do that is to avoid to create the new memory
pressure immediately if possible.  Instead, even if the pages are
required again, they will be allocated gradually on demand.  That is,
the memory will be allocated lazily when necessary.  This follows the
common philosophy in the Linux kernel, allocate resources lazily on
demand.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
---
 include/linux/migrate.h |  4 ++++
 mm/huge_memory.c        | 20 +++++++++++++++-----
 mm/migrate.c            | 16 +++++++++++++++-
 mm/rmap.c               | 10 ++++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 72120061b7d4..2c6cf985a8d3 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -14,8 +14,12 @@ typedef void free_page_t(struct page *page, unsigned long private);
  * Return values from addresss_space_operations.migratepage():
  * - negative errno on page migration failure;
  * - zero on page migration success;
+ *
+ * __unmap_and_move() can also return 1 to indicate the page can be
+ * discarded instead of migrated.
  */
 #define MIGRATEPAGE_SUCCESS		0
+#define MIGRATEPAGE_DISCARD		1
 
 enum migrate_reason {
 	MR_COMPACTION,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b1e069e68189..b64f356ab77e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3063,11 +3063,21 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
 	if (pmd_dirty(pmdval))
 		set_page_dirty(page);
-	entry = make_migration_entry(page, pmd_write(pmdval));
-	pmdswp = swp_entry_to_pmd(entry);
-	if (pmd_soft_dirty(pmdval))
-		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
-	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
+	/* Clean lazyfree page, discard instead of migrate */
+	if (PageLazyFree(page) && !PageDirty(page)) {
+		pmd_clear(pvmw->pmd);
+		zap_deposited_table(mm, pvmw->pmd);
+		/* Invalidate as we cleared the pmd */
+		mmu_notifier_invalidate_range(mm, address,
+					      address + HPAGE_PMD_SIZE);
+		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	} else {
+		entry = make_migration_entry(page, pmd_write(pmdval));
+		pmdswp = swp_entry_to_pmd(entry);
+		if (pmd_soft_dirty(pmdval))
+			pmdswp = pmd_swp_mksoft_dirty(pmdswp);
+		set_pmd_at(mm, address, pvmw->pmd, pmdswp);
+	}
 	page_remove_rmap(page, true);
 	put_page(page);
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 981f8374a6ef..b7e7d18af94c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1122,6 +1122,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 			goto out_unlock_both;
 		}
 		page_was_mapped = 1;
+		/* Clean lazyfree page, discard instead of migrate */
+		if (PageLazyFree(page) && !PageDirty(page)) {
+			rc = MIGRATEPAGE_DISCARD;
+			goto out_unlock_both;
+		}
 	}
 
 	if (!page_mapped(page))
@@ -1242,7 +1247,16 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				num_poisoned_pages_inc();
 		}
 	} else {
-		if (rc != -EAGAIN) {
+		/*
+		 * If page is discard instead of migrated, release
+		 * reference grabbed during isolation, free the new
+		 * page.  For the caller, this is same as migrating
+		 * successfully.
+		 */
+		if (rc == MIGRATEPAGE_DISCARD) {
+			put_page(page);
+			rc = MIGRATEPAGE_SUCCESS;
+		} else if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
 				putback_lru_page(page);
 				goto put_new;
diff --git a/mm/rmap.c b/mm/rmap.c
index 1dcbb1771dd7..bb52883f7b2d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1569,6 +1569,16 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_entry_t entry;
 			pte_t swp_pte;
 
+			/* Clean lazyfree page, discard instead of migrate */
+			if (PageLazyFree(page) && !PageDirty(page) &&
+			    !(flags & TTU_SPLIT_FREEZE)) {
+				/* Invalidate as we cleared the pte */
+				mmu_notifier_invalidate_range(mm,
+						address, address + PAGE_SIZE);
+				dec_mm_counter(mm, MM_ANONPAGES);
+				goto discard;
+			}
+
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
-- 
2.25.0

