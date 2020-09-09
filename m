Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649321582
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:50738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:48:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8C53AB91;
        Wed,  9 Sep 2020 10:48:55 +0000 (UTC)
Subject: Re: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-6-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d5d5ef64-b239-0640-5640-75c7a3c78584@suse.cz>
Date:   Wed, 9 Sep 2020 12:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907163628.26495-6-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a version that will apply on top of next-20200908. The first 4 patches need no change.

----8<----
From 8febc17272b8e8b378e2e5ea5e76b2616f029c5b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 7 Sep 2020 17:20:39 +0200
Subject: [PATCH] mm, page_alloc: disable pcplists during page isolation

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
 mm/internal.h       |  4 +++
 mm/memory_hotplug.c | 55 ++++++++++++++++++++++++++++-------------
 mm/page_alloc.c     | 60 +++++++++++++++++++++++++++++----------------
 mm/page_isolation.c | 45 ++++++++++++++++++++++++++++------
 5 files changed, 119 insertions(+), 46 deletions(-)

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
index ab4beb7c5cd2..149822747db7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -7,6 +7,7 @@
 #ifndef __MM_INTERNAL_H
 #define __MM_INTERNAL_H
 
+#include <linux/rwsem.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -196,8 +197,11 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
+extern struct rw_semaphore pcp_batch_high_lock;
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
+extern void zone_update_pageset_high_and_batch(struct zone *zone,
+		unsigned long high, unsigned long batch);
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index baded53b9ff9..c433565a782c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -803,6 +803,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	int need_zonelists_rebuild = 0;
 	int ret;
 	struct memory_notify arg;
+	bool first_isolated_pageblock = false;
 
 	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
 	if (WARN_ON_ONCE(!nr_pages ||
@@ -826,9 +827,13 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	/*
 	 * Fixup the number of isolated pageblocks before marking the sections
-	 * onlining, such that undo_isolate_page_range() works correctly.
+	 * onlining, such that undo_isolate_page_range() works correctly. We
+	 * also take pcp_batch_high_lock that pairs with the unlock there.
 	 */
+	down_read(&pcp_batch_high_lock);
 	spin_lock_irqsave(&zone->lock, flags);
+	if (!zone->nr_isolate_pageblock)
+		first_isolated_pageblock = true;
 	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -842,6 +847,18 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}
 
+	/* If we are adding the first isolated pageblocks, we have to disable
+	 * pcplists (if the zone is already populated) and drain them, same as
+	 * set_migratetype_isolate() would. While the MIGRATE_ISOLATE pages we
+	 * just added cannot be on the pcplist, there might be another page
+	 * isolation user racing, which might need the drain, and wouldn't do
+	 * it if nr_isolated_pageblock was already non-zero.
+	 */
+	if (first_isolated_pageblock) {
+		zone_update_pageset_high_and_batch(zone, 0, 1);
+		__drain_all_pages(zone, true);
+	}
+
 	online_pages_range(pfn, nr_pages);
 	zone->present_pages += nr_pages;
 
@@ -852,11 +869,17 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
-	zone_pcp_update(zone);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
 
+	/*
+	 * Adjust pcplist high and batch based on new zone's size. This takes
+	 * pcp_batch_high_lock for write, so we have to do that after
+	 * undo_isolate_page_range() unlocks it for read.
+	 */
+	zone_pcp_update(zone);
+
 	/*
 	 * When exposing larger, physically contiguous memory areas to the
 	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
@@ -1472,6 +1495,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	struct memory_notify arg;
 	int ret, node;
 	char *reason;
+	unsigned long nr_isolate_pageblock = nr_pages / pageblock_nr_pages;
+	bool unisolated_last = false;
 
 	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
 	if (WARN_ON_ONCE(!nr_pages ||
@@ -1564,21 +1589,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			goto failed_removal_isolated;
 		}
 
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
 		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
-		if (ret)
-			drain_all_pages(zone);
+
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
@@ -1591,8 +1603,17 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * of isolated pageblocks, memory onlining will properly revert this.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
+	if (nr_isolate_pageblock && nr_isolate_pageblock ==
+			zone->nr_isolate_pageblock)
+		unisolated_last = true;
+	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
 	spin_unlock_irqrestore(&zone->lock, flags);
+	if (unisolated_last) {
+		zone_update_pageset_high_and_batch(zone, zone->pageset_high,
+				zone->pageset_batch);
+	}
+	/* pairs with start_isolate_page_range() */
+	up_read(&pcp_batch_high_lock);
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 72922ef2d7cb..defefed79cfb 100644
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
@@ -3131,7 +3142,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
-	if (pcp->count >= pcp->high) {
+	if (pcp->count >= READ_ONCE(pcp->high)) {
 		unsigned long batch = READ_ONCE(pcp->batch);
 		free_pcppages_bulk(zone, batch, pcp);
 	}
@@ -6228,13 +6239,23 @@ static void pageset_init(struct per_cpu_pageset *p)
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
@@ -6255,10 +6276,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update
 		return;
 	}
 
-	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_update(&p->pcp, new_high, new_batch);
-	}
+	zone_update_pageset_high_and_batch(zone, new_high, new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -8016,7 +8034,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	int old_percpu_pagelist_fraction;
 	int ret;
 
-	mutex_lock(&pcp_batch_high_lock);
+	down_write(&pcp_batch_high_lock);
 	old_percpu_pagelist_fraction = percpu_pagelist_fraction;
 
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
@@ -8038,7 +8056,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	for_each_populated_zone(zone)
 		zone_set_pageset_high_and_batch(zone, false);
 out:
-	mutex_unlock(&pcp_batch_high_lock);
+	up_write(&pcp_batch_high_lock);
 	return ret;
 }
 
@@ -8642,9 +8660,9 @@ EXPORT_SYMBOL(free_contig_range);
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
index abfe26ad59fd..391091a73355 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -20,6 +20,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	struct zone *zone = page_zone(page);
 	struct page *unmovable;
 	unsigned long flags;
+	bool first_isolated_pageblock = false;
 
 	spin_lock_irqsave(&zone->lock, flags);
 
@@ -44,12 +45,17 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
+		if (zone->nr_isolate_pageblock == 1)
+			first_isolated_pageblock = true;
 		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
 									NULL);
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		spin_unlock_irqrestore(&zone->lock, flags);
-		drain_all_pages(zone);
+		if (first_isolated_pageblock) {
+			zone_update_pageset_high_and_batch(zone, 0, 1);
+			__drain_all_pages(zone, true);
+		}
 		return 0;
 	}
 
@@ -73,6 +79,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	unsigned int order;
 	unsigned long pfn, buddy_pfn;
 	struct page *buddy;
+	bool unisolated_last = false;
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lock, flags);
@@ -115,8 +122,14 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
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
@@ -165,13 +178,16 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
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
+ *
+ * Successful call to start_isolate_page_range() has to be paired with
+ * undo_isolate_page_range() for proper accounting of zone->nr_isolate_pageblock
+ * (which controls pcplist enabling/disabling discussed above, including
+ * handling of pcp_batch_high_lock).
+ * If undo_isolate_page_range() is not used, this has to be handled manually
+ * by caller.
  *
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
@@ -185,6 +201,13 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
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
@@ -207,6 +230,8 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		unset_migratetype_isolate(page, migratetype);
 	}
 
+	up_read(&pcp_batch_high_lock);
+
 	return -EBUSY;
 }
 
@@ -230,7 +255,11 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
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


