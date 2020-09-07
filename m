Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF16EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C57207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIGQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:40:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbgIGQgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A429CB020;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
Date:   Mon,  7 Sep 2020 18:36:28 +0200
Message-Id: <20200907163628.26495-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907163628.26495-1-vbabka@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page isolation can race with process freeing pages to pcplists in a way that
a page from isolated pageblock can end up on pcplist. This can be fixed by
repeated draining of pcplists, as done by patch "mm/memory_hotplug: drain
per-cpu pages again during memory offline" in [1].

David and Michal would prefer that this race was closed in a way that callers
of page isolation don't need to care about drain. David suggested disabling
pcplists usage completely during page isolation, instead of repeatedly draining
them.

To achieve this without adding special cases in alloc/free fastpath, we can use
the same 'trick' as boot pagesets - when pcp->high is 0, any pcplist addition
will be immediately flushed.

The race can thus be closed by setting pcp->high to 0 and draining pcplists
once in start_isolate_page_range(). The draining will serialize after processes
that already disabled interrupts and read the old value of pcp->high in
free_unref_page_commit(), and processes that have not yet disabled interrupts,
will observe pcp->high == 0 when they are rescheduled, and skip pcplists.
This guarantees no stray pages on pcplists in zones where isolation happens.

We can use the variable zone->nr_isolate_pageblock (protected by zone->lock)
to detect transitions from 0 to 1 (to change pcp->high to 0 and issue drain)
and from 1 to 0 (to restore original pcp->high and batch values cached in
struct zone). We have to avoid external updates to high and batch by taking
pcp_batch_high_lock. To allow multiple isolations in parallel, change this
lock from mutex to rwsem.

For callers that pair start_isolate_page_range() with
undo_isolated_page_range() properly, this is transparent. Currently that's
alloc_contig_range(). __offline_pages() doesn't call undo_isolated_page_range()
in the succes case, so it has to be carful to handle restoring pcp->high and batch
and unlocking pcp_batch_high_lock.

This commit also changes drain_all_pages() to not trust reading pcp->count during
drain for page isolation - I believe that could be racy and lead to missing some
cpu's to drain. If others agree, this can be separated and potentially backported.

[1] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  4 ++++
 mm/memory_hotplug.c | 24 ++++++++-----------
 mm/page_alloc.c     | 58 +++++++++++++++++++++++++++++----------------
 mm/page_isolation.c | 45 ++++++++++++++++++++++++++++-------
 5 files changed, 89 insertions(+), 43 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..cc52c5cc9fab 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -592,6 +592,7 @@ extern void page_frag_free(void *addr);
 
 void page_alloc_init(void);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
+void __drain_all_pages(struct zone *zone, bool page_isolation);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
diff --git a/mm/internal.h b/mm/internal.h
index 10c677655912..c157af87a9ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -7,6 +7,7 @@
 #ifndef __MM_INTERNAL_H
 #define __MM_INTERNAL_H
 
+#include <linux/rwsem.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -201,8 +202,11 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
+extern struct rw_semaphore pcp_batch_high_lock;
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
+extern void zone_update_pageset_high_and_batch(struct zone *zone,
+		unsigned long high, unsigned long batch);
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b11a269e2356..a978ac32279b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1485,6 +1485,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	struct zone *zone;
 	struct memory_notify arg;
 	char *reason;
+	bool unisolated_last = false;
 
 	mem_hotplug_begin();
 
@@ -1575,20 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		/* check again */
 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
 					    NULL, check_pages_isolated_cb);
-		/*
-		 * per-cpu pages are drained in start_isolate_page_range, but if
-		 * there are still pages that are not free, make sure that we
-		 * drain again, because when we isolated range we might
-		 * have raced with another thread that was adding pages to pcp
-		 * list.
-		 *
-		 * Forward progress should be still guaranteed because
-		 * pages on the pcp list can only belong to MOVABLE_ZONE
-		 * because has_unmovable_pages explicitly checks for
-		 * PageBuddy on freed pages on other zones.
-		 */
-		if (ret)
-			drain_all_pages(zone);
 	} while (ret);
 
 	/* Ok, all of our target is isolated.
@@ -1602,8 +1589,17 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	 * pageblocks zone counter here.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
+	if (nr_isolate_pageblock && nr_isolate_pageblock ==
+			zone->nr_isolate_pageblock)
+		unisolated_last = true;
 	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
 	spin_unlock_irqrestore(&zone->lock, flags);
+	if (unisolated_last) {
+		zone_update_pageset_high_and_batch(zone, zone->pageset_high,
+				zone->pageset_batch);
+	}
+	/* pairs with start_isolate_page_range() */
+	up_read(&pcp_batch_high_lock);
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 004350a2b6ca..d82f3bec7953 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -78,7 +78,7 @@
 #include "page_reporting.h"
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
-static DEFINE_MUTEX(pcp_batch_high_lock);
+DECLARE_RWSEM(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
@@ -2958,14 +2958,7 @@ static void drain_local_pages_wq(struct work_struct *work)
 	preempt_enable();
 }
 
-/*
- * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
- *
- * When zone parameter is non-NULL, spill just the single zone's pages.
- *
- * Note that this can be extremely slow as the draining happens in a workqueue.
- */
-void drain_all_pages(struct zone *zone)
+void __drain_all_pages(struct zone *zone, bool page_isolation)
 {
 	int cpu;
 
@@ -3004,7 +2997,13 @@ void drain_all_pages(struct zone *zone)
 		struct zone *z;
 		bool has_pcps = false;
 
-		if (zone) {
+		if (page_isolation) {
+			/*
+			 * For page isolation, don't trust the racy pcp.count
+			 * check. We need to flush really everything.
+			 */
+			has_pcps = true;
+		} else if (zone) {
 			pcp = per_cpu_ptr(zone->pageset, cpu);
 			if (pcp->pcp.count)
 				has_pcps = true;
@@ -3037,6 +3036,18 @@ void drain_all_pages(struct zone *zone)
 	mutex_unlock(&pcpu_drain_mutex);
 }
 
+/*
+ * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
+ *
+ * When zone parameter is non-NULL, spill just the single zone's pages.
+ *
+ * Note that this can be extremely slow as the draining happens in a workqueue.
+ */
+void drain_all_pages(struct zone *zone)
+{
+	__drain_all_pages(zone, false);
+}
+
 #ifdef CONFIG_HIBERNATION
 
 /*
@@ -6237,13 +6248,23 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp->batch  = 1;
 }
 
+void zone_update_pageset_high_and_batch(struct zone *zone, unsigned long high,
+		unsigned long batch)
+{
+	struct per_cpu_pageset *p;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_update(&p->pcp, high, batch);
+	}
+}
+
 static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update)
 {
 	unsigned long new_high;
 	unsigned long new_batch;
 	int fraction = READ_ONCE(percpu_pagelist_fraction);
-	int cpu;
-	struct per_cpu_pageset *p;
 
 	if (fraction) {
 		new_high = zone_managed_pages(zone) / fraction;
@@ -6264,10 +6285,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update
 		return;
 	}
 
-	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_update(&p->pcp, new_high, new_batch);
-	}
+	zone_update_pageset_high_and_batch(zone, new_high, new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -8026,7 +8044,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	int old_percpu_pagelist_fraction;
 	int ret;
 
-	mutex_lock(&pcp_batch_high_lock);
+	down_write(&pcp_batch_high_lock);
 	old_percpu_pagelist_fraction = percpu_pagelist_fraction;
 
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
@@ -8048,7 +8066,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	for_each_populated_zone(zone)
 		zone_set_pageset_high_and_batch(zone, false);
 out:
-	mutex_unlock(&pcp_batch_high_lock);
+	up_write(&pcp_batch_high_lock);
 	return ret;
 }
 
@@ -8661,9 +8679,9 @@ EXPORT_SYMBOL(free_contig_range);
  */
 void __meminit zone_pcp_update(struct zone *zone)
 {
-	mutex_lock(&pcp_batch_high_lock);
+	down_write(&pcp_batch_high_lock);
 	zone_set_pageset_high_and_batch(zone, false);
-	mutex_unlock(&pcp_batch_high_lock);
+	up_write(&pcp_batch_high_lock);
 }
 
 void zone_pcp_reset(struct zone *zone)
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 63a3db10a8c0..ceada64abd1f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -21,6 +21,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	struct zone *zone;
 	unsigned long flags;
 	int ret = -EBUSY;
+	bool first_isolated_pageblock = false;
 
 	zone = page_zone(page);
 
@@ -45,6 +46,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
+		if (zone->nr_isolate_pageblock == 1)
+			first_isolated_pageblock = true;
 		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
 									NULL);
 
@@ -54,8 +57,9 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret) {
-		drain_all_pages(zone);
+	if (!ret && first_isolated_pageblock) {
+		zone_update_pageset_high_and_batch(zone, 0, 1);
+		__drain_all_pages(zone, true);
 	} else {
 		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
 
@@ -78,6 +82,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	unsigned int order;
 	unsigned long pfn, buddy_pfn;
 	struct page *buddy;
+	bool unisolated_last = false;
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lock, flags);
@@ -120,8 +125,14 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	if (isolated_page)
 		__putback_isolated_page(page, order, migratetype);
 	zone->nr_isolate_pageblock--;
+	if (zone->nr_isolate_pageblock == 0)
+		unisolated_last = true;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+	if (unisolated_last) {
+		zone_update_pageset_high_and_batch(zone, zone->pageset_high,
+				zone->pageset_batch);
+	}
 }
 
 static inline struct page *
@@ -170,14 +181,17 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
  *
- * Please note that there is no strong synchronization with the page allocator
- * either. Pages might be freed while their page blocks are marked ISOLATED.
- * In some cases pages might still end up on pcp lists and that would allow
- * for their allocation even when they are in fact isolated already. Depending
- * on how strong of a guarantee the caller needs drain_all_pages might be needed
- * (e.g. __offline_pages will need to call it after check for isolated range for
- * a next retry).
+ * To synchronize with page allocator users freeing pages on the pcplists, we
+ * disable them by setting their allowed usage (pcp->high) to 0, and issue a
+ * drain. This is only needed when isolating the first pageblock of a zone.
  *
+ * Successful call to start_isolate_page_range() has to be paired with
+ * undo_isolate_page_range() for proper accounting of zone->nr_isolate_pageblock
+ * (which controls pcplist enabling/disabling discussed above, including
+ * handling of pcp_batch_high_lock).
+ * If undo_isolate_page_range() is not used, this has to be handled manually
+ * by caller.
+ * 
  * Return: the number of isolated pageblocks on success and -EBUSY if any part
  * of range cannot be isolated.
  */
@@ -192,6 +206,13 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
 
+	/*
+	 * We are going to change pcplists's high and batch values temporarily,
+	 * so block any updates via sysctl. Caller must unlock by
+	 * undo_isolate_page_range() or finish_isolate_page_range().
+	 */
+	down_read(&pcp_batch_high_lock);
+
 	for (pfn = start_pfn;
 	     pfn < end_pfn;
 	     pfn += pageblock_nr_pages) {
@@ -215,6 +236,8 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		unset_migratetype_isolate(page, migratetype);
 	}
 
+	up_read(&pcp_batch_high_lock);
+
 	return -EBUSY;
 }
 
@@ -238,7 +261,11 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			continue;
 		unset_migratetype_isolate(page, migratetype);
 	}
+
+	up_read(&pcp_batch_high_lock);
 }
+
+
 /*
  * Test all pages in the range is free(means isolated) or not.
  * all pages in [start_pfn...end_pfn) must be in the same zone.
-- 
2.28.0

