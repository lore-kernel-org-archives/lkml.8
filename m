Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E234C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072DA2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgE0ULd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgE0ULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:11:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B2C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:11:30 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je2Ob-0005ku-Hc; Wed, 27 May 2020 22:11:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 3/7] mm/swap: Use local_lock for protection
Date:   Wed, 27 May 2020 22:11:15 +0200
Message-Id: <20200527201119.1692513-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527201119.1692513-1-bigeasy@linutronix.de>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

The various struct pagevec per CPU variables are protected by disabling
either preemption or interrupts across the critical sections. Inside
these sections spinlocks have to be acquired.

These spinlocks are regular spinlock_t types which are converted to
"sleeping" spinlocks on PREEMPT_RT enabled kernels. Obviously sleeping
locks cannot be acquired in preemption or interrupt disabled sections.

local locks provide a trivial way to substitute preempt and interrupt
disable instances. On a non PREEMPT_RT enabled kernel local_lock() maps
to preempt_disable() and local_lock_irq() to local_irq_disable().

Create lru_rotate_pvecs containing the pagevec and the locallock.
Create lru_pvecs containing the remaining pagevecs and the locallock.
Add lru_add_drain_cpu_zone() which is used from compact_zone() to avoid
exporting the pvec structure.

Change the relevant call sites to acquire these locks instead of using
preempt_disable() / get_cpu() / get_cpu_var() and local_irq_disable() /
local_irq_save().

There is neither a functional change nor a change in the generated
binary code for non PREEMPT_RT enabled non-debug kernels.

When lockdep is enabled local locks have lockdep maps embedded. These
allow lockdep to validate the protections, i.e. inappropriate usage of a
preemption only protected sections would result in a lockdep warning
while the same problem would not be noticed with a plain
preempt_disable() based protection.

local locks also improve readability as they provide a named scope for
the protections while preempt/interrupt disable are opaque scopeless.

Finally local locks allow PREEMPT_RT to substitute them with real
locking primitives to ensure the correctness of operation in a fully
preemptible kernel.

[ bigeasy: Adopted to use local_lock ]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swap.h |   1 +
 mm/compaction.c      |   6 +--
 mm/swap.c            | 118 +++++++++++++++++++++++++++++--------------
 3 files changed, 82 insertions(+), 43 deletions(-)

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
@@ -2243,15 +2243,11 @@ compact_zone(struct compact_control *cc, struct cap=
ture_control *capc)
 		 * would succeed.
 		 */
 		if (cc->order > 0 && last_migrated_pfn) {
-			int cpu;
 			unsigned long current_block_start =3D
 				block_start_pfn(cc->migrate_pfn, cc->order);
=20
 			if (last_migrated_pfn < current_block_start) {
-				cpu =3D get_cpu();
-				lru_add_drain_cpu(cpu);
-				drain_local_pages(cc->zone);
-				put_cpu();
+				lru_add_drain_cpu_zone(cc->zone);
 				/* No more flushing until we migrate again */
 				last_migrated_pfn =3D 0;
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
=20
 #include "internal.h"
=20
@@ -44,14 +45,32 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
=20
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
+static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) =3D {
+	.lock =3D INIT_LOCAL_LOCK(lock),
+};
+
+/*
+ * The following struct pagevec are grouped together because they are prot=
ected
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
+static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) =3D {
+	.lock =3D INIT_LOCAL_LOCK(lock),
+};
=20
 /*
  * This path almost never happens for VM activity - pages are normally
@@ -254,11 +273,11 @@ void rotate_reclaimable_page(struct page *page)
 		unsigned long flags;
=20
 		get_page(page);
-		local_irq_save(flags);
-		pvec =3D this_cpu_ptr(&lru_rotate_pvecs);
+		local_lock_irqsave(&lru_rotate.lock, flags);
+		pvec =3D this_cpu_ptr(&lru_rotate.pvec);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
 }
=20
@@ -293,7 +312,7 @@ static void __activate_page(struct page *page, struct l=
ruvec *lruvec,
 #ifdef CONFIG_SMP
 static void activate_page_drain(int cpu)
 {
-	struct pagevec *pvec =3D &per_cpu(activate_page_pvecs, cpu);
+	struct pagevec *pvec =3D &per_cpu(lru_pvecs.activate_page, cpu);
=20
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, __activate_page, NULL);
@@ -301,19 +320,21 @@ static void activate_page_drain(int cpu)
=20
 static bool need_activate_page_drain(int cpu)
 {
-	return pagevec_count(&per_cpu(activate_page_pvecs, cpu)) !=3D 0;
+	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) !=3D 0;
 }
=20
 void activate_page(struct page *page)
 {
 	page =3D compound_head(page);
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(activate_page_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(&lru_pvecs.lock);
+		pvec =3D this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, __activate_page, NULL);
-		put_cpu_var(activate_page_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
=20
@@ -335,9 +356,12 @@ void activate_page(struct page *page)
=20
 static void __lru_cache_activate_page(struct page *page)
 {
-	struct pagevec *pvec =3D &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
 	int i;
=20
+	local_lock(&lru_pvecs.lock);
+	pvec =3D this_cpu_ptr(&lru_pvecs.lru_add);
+
 	/*
 	 * Search backwards on the optimistic assumption that the page being
 	 * activated has just been added to this pagevec. Note that only
@@ -357,7 +381,7 @@ static void __lru_cache_activate_page(struct page *page)
 		}
 	}
=20
-	put_cpu_var(lru_add_pvec);
+	local_unlock(&lru_pvecs.lock);
 }
=20
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
=20
 static void __lru_cache_add(struct page *page)
 {
-	struct pagevec *pvec =3D &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
=20
+	local_lock(&lru_pvecs.lock);
+	pvec =3D this_cpu_ptr(&lru_pvecs.lru_add);
 	get_page(page);
 	if (!pagevec_add(pvec, page) || PageCompound(page))
 		__pagevec_lru_add(pvec);
-	put_cpu_var(lru_add_pvec);
+	local_unlock(&lru_pvecs.lock);
 }
=20
 /**
@@ -593,30 +619,30 @@ static void lru_lazyfree_fn(struct page *page, struct=
 lruvec *lruvec,
  */
 void lru_add_drain_cpu(int cpu)
 {
-	struct pagevec *pvec =3D &per_cpu(lru_add_pvec, cpu);
+	struct pagevec *pvec =3D &per_cpu(lru_pvecs.lru_add, cpu);
=20
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
=20
-	pvec =3D &per_cpu(lru_rotate_pvecs, cpu);
+	pvec =3D &per_cpu(lru_rotate.pvec, cpu);
 	if (pagevec_count(pvec)) {
 		unsigned long flags;
=20
 		/* No harm done if a racing interrupt already did this */
-		local_irq_save(flags);
+		local_lock_irqsave(&lru_rotate.lock, flags);
 		pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
=20
-	pvec =3D &per_cpu(lru_deactivate_file_pvecs, cpu);
+	pvec =3D &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
=20
-	pvec =3D &per_cpu(lru_deactivate_pvecs, cpu);
+	pvec =3D &per_cpu(lru_pvecs.lru_deactivate, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
=20
-	pvec =3D &per_cpu(lru_lazyfree_pvecs, cpu);
+	pvec =3D &per_cpu(lru_pvecs.lru_lazyfree, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
=20
@@ -641,11 +667,14 @@ void deactivate_file_page(struct page *page)
 		return;
=20
 	if (likely(get_page_unless_zero(page))) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_deactivate_file_pvecs);
+		struct pagevec *pvec;
+
+		local_lock(&lru_pvecs.lock);
+		pvec =3D this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
=20
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
-		put_cpu_var(lru_deactivate_file_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
=20
@@ -660,12 +689,14 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_deactivate_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(&lru_pvecs.lock);
+		pvec =3D this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_cpu_var(lru_deactivate_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
=20
@@ -680,19 +711,30 @@ void mark_page_lazyfree(struct page *page)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_lazyfree_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(&lru_pvecs.lock);
+		pvec =3D this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
-		put_cpu_var(lru_lazyfree_pvecs);
+		local_unlock(&lru_pvecs.lock);
 	}
 }
=20
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
=20
 #ifdef CONFIG_SMP
@@ -743,11 +785,11 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work =3D &per_cpu(lru_add_drain_work, cpu);
=20
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
--=20
2.27.0.rc0

