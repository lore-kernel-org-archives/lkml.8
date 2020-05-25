Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0E320723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbgEYRIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbgEYRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:07:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:07:59 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdGZw-0005fB-Nw; Mon, 25 May 2020 19:07:56 +0200
Date:   Mon, 25 May 2020 19:07:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/7] mm/swap: Use local_lock for protection
Message-ID: <20200525170756.i3jim5wqon4k5dky@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-4-bigeasy@linutronix.de>
 <20200525064436.GA329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525064436.GA329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 08:44:36 [+0200], Ingo Molnar wrote:
> s/lru_rotate_pvecs
>  /lru_rotate_pvec
> 
> it's a single pagevec, using plural is confusing when reading the 
> code.

right. It had the _pvecs from the beginning so I assumed it is because
it is per-CPU.

With all you suggestions I'm at:

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e1bbf7a16b276..25181d2dd0b9f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -337,6 +337,7 @@ extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
+extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
 extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081e..c9d659e6a02c5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2243,15 +2243,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		 * would succeed.
 		 */
 		if (cc->order > 0 && last_migrated_pfn) {
-			int cpu;
 			unsigned long current_block_start =
 				block_start_pfn(cc->migrate_pfn, cc->order);
 
 			if (last_migrated_pfn < current_block_start) {
-				cpu = get_cpu();
-				lru_add_drain_cpu(cpu);
-				drain_local_pages(cc->zone);
-				put_cpu();
+				lru_add_drain_cpu_zone(cc->zone);
 				/* No more flushing until we migrate again */
 				last_migrated_pfn = 0;
 			}
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d7..0ac463d44cff4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -35,6 +35,7 @@
 #include <linux/uio.h>
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
+#include <linux/local_lock.h>
 
 #include "internal.h"
 
@@ -44,14 +45,32 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
-static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
-static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
-static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
-static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
-static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
+/* Protecting only lru_rotate.pvec which requires disabling interrupts */
+struct lru_rotate {
+	local_lock_t lock;
+	struct pagevec pvec;
+};
+static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
+
+/*
+ * The following struct pagevec are grouped together because they are protected
+ * by disabling preemption (and interrupts remain enabled).
+ */
+struct lru_pvecs {
+	local_lock_t lock;
+	struct pagevec lru_add;
+	struct pagevec lru_deactivate_file;
+	struct pagevec lru_deactivate;
+	struct pagevec lru_lazyfree;
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct pagevec, activate_page_pvecs);
+	struct pagevec activate_page;
 #endif
+};
+static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 /*
  * This path almost never happens for VM activity - pages are normally
@@ -254,11 +273,11 @@ void rotate_reclaimable_page(struct page *page)
 		unsigned long flags;
 
 		get_page(page);
-		local_irq_save(flags);
-		pvec = this_cpu_ptr(&lru_rotate_pvecs);
+		local_lock_irqsave(&lru_rotate.lock, flags);
+		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
 
@@ -293,7 +312,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 #ifdef CONFIG_SMP
 static void activate_page_drain(int cpu)
 {
-	struct pagevec *pvec = &per_cpu(activate_page_pvecs, cpu);
+	struct pagevec *pvec = &per_cpu(lru_pvecs.activate_page, cpu);
 
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, __activate_page, NULL);
@@ -301,19 +320,21 @@ static void activate_page_drain(int cpu)
 
 static bool need_activate_page_drain(int cpu)
 {
-	return pagevec_count(&per_cpu(activate_page_pvecs, cpu)) != 0;
+	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
 void activate_page(struct page *page)
 {
 	page = compound_head(page);
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_cpu_var(activate_page_pvecs);
+		struct pagevec *pvec;
 
+		local_lock(&lru_pvecs.lock);
+		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, __activate_page, NULL);
-		put_cpu_var(activate_page_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -335,9 +356,12 @@ void activate_page(struct page *page)
 
 static void __lru_cache_activate_page(struct page *page)
 {
-	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
 	int i;
 
+	local_lock(&lru_pvecs.lock);
+	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
+
 	/*
 	 * Search backwards on the optimistic assumption that the page being
 	 * activated has just been added to this pagevec. Note that only
@@ -357,7 +381,7 @@ static void __lru_cache_activate_page(struct page *page)
 		}
 	}
 
-	put_cpu_var(lru_add_pvec);
+	local_unlock(&lru_pvecs.lock);
 }
 
 /*
@@ -385,7 +409,7 @@ void mark_page_accessed(struct page *page)
 	} else if (!PageActive(page)) {
 		/*
 		 * If the page is on the LRU, queue it for activation via
-		 * activate_page_pvecs. Otherwise, assume the page is on a
+		 * lru_pvecs.activate_page. Otherwise, assume the page is on a
 		 * pagevec, mark it active and it'll be moved to the active
 		 * LRU on the next drain.
 		 */
@@ -404,12 +428,14 @@ EXPORT_SYMBOL(mark_page_accessed);
 
 static void __lru_cache_add(struct page *page)
 {
-	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
 
+	local_lock(&lru_pvecs.lock);
+	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
 	get_page(page);
 	if (!pagevec_add(pvec, page) || PageCompound(page))
 		__pagevec_lru_add(pvec);
-	put_cpu_var(lru_add_pvec);
+	local_unlock(&lru_pvecs.lock);
 }
 
 /**
@@ -593,30 +619,30 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
  */
 void lru_add_drain_cpu(int cpu)
 {
-	struct pagevec *pvec = &per_cpu(lru_add_pvec, cpu);
+	struct pagevec *pvec = &per_cpu(lru_pvecs.lru_add, cpu);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
 
-	pvec = &per_cpu(lru_rotate_pvecs, cpu);
+	pvec = &per_cpu(lru_rotate.pvec, cpu);
 	if (pagevec_count(pvec)) {
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_irq_save(flags);
+		local_lock_irqsave(&lru_rotate.lock, flags);
 		pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 
-	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
+	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
 
-	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
+	pvec = &per_cpu(lru_pvecs.lru_deactivate, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
 
-	pvec = &per_cpu(lru_lazyfree_pvecs, cpu);
+	pvec = &per_cpu(lru_pvecs.lru_lazyfree, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
 
@@ -641,11 +667,14 @@ void deactivate_file_page(struct page *page)
 		return;
 
 	if (likely(get_page_unless_zero(page))) {
-		struct pagevec *pvec = &get_cpu_var(lru_deactivate_file_pvecs);
+		struct pagevec *pvec;
+
+		local_lock(&lru_pvecs.lock);
+		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
-		put_cpu_var(lru_deactivate_file_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -660,12 +689,14 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
+		struct pagevec *pvec;
 
+		local_lock(&lru_pvecs.lock);
+		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_cpu_var(lru_deactivate_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
 
@@ -680,19 +711,30 @@ void mark_page_lazyfree(struct page *page)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec = &get_cpu_var(lru_lazyfree_pvecs);
+		struct pagevec *pvec;
 
+		local_lock(&lru_pvecs.lock);
+		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
-		put_cpu_var(lru_lazyfree_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
 
 void lru_add_drain(void)
 {
-	lru_add_drain_cpu(get_cpu());
-	put_cpu();
+	local_lock(&lru_pvecs.lock);
+	lru_add_drain_cpu(smp_processor_id());
+	local_unlock(&lru_pvecs.lock);
+}
+
+void lru_add_drain_cpu_zone(struct zone *zone)
+{
+	local_lock(&lru_pvecs.lock);
+	lru_add_drain_cpu(smp_processor_id());
+	drain_local_pages(zone);
+	local_unlock(&lru_pvecs.lock);
 }
 
 #ifdef CONFIG_SMP
@@ -743,11 +785,11 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
-		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
-		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
-		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
-		    pagevec_count(&per_cpu(lru_lazyfree_pvecs, cpu)) ||
+		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		    pagevec_count(&per_cpu(lru_rotate.pvec, cpu)) ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
 		    need_activate_page_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, work);
-- 
2.27.0.rc0


> Thanks,
> 
> 	Ingo

Sebastian
