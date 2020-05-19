Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10093C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4053206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgESUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380FC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:12 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8if-00012c-WB; Tue, 19 May 2020 22:20:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/8] mm/swap: Use local_lock for protection
Date:   Tue, 19 May 2020 22:19:08 +0200
Message-Id: <20200519201912.1564477-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
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

Add swapvec_lock to protect the per-CPU lru_add_pvec and
lru_lazyfree_pvecs variables and rotate_lock to protect the per-CPU
lru_rotate_pvecs variable

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
No functional change.

[ bigeasy: Adopted to use local_lock ]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swap.h |  2 ++
 mm/compaction.c      |  7 +++---
 mm/swap.c            | 59 ++++++++++++++++++++++++++++++--------------
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e1bbf7a16b276..540b52c71bc95 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <linux/locallock.h>
 #include <asm/page.h>
=20
 struct notifier_block;
@@ -328,6 +329,7 @@ extern unsigned long nr_free_pagecache_pages(void);
=20
=20
 /* linux/mm/swap.c */
+DECLARE_LOCAL_LOCK(swapvec_lock);
 extern void lru_cache_add(struct page *);
 extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081e..77972c8d4dead 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2243,15 +2243,14 @@ compact_zone(struct compact_control *cc, struct cap=
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
+				local_lock(swapvec_lock);
+				lru_add_drain_cpu(smp_processor_id());
 				drain_local_pages(cc->zone);
-				put_cpu();
+				local_unlock(swapvec_lock);
 				/* No more flushing until we migrate again */
 				last_migrated_pfn =3D 0;
 			}
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d7..03c97d15fcd69 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -44,8 +44,14 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
=20
-static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
+
+/* Protecting lru_rotate_pvecs */
+static DEFINE_LOCAL_LOCK(rotate_lock);
 static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
+
+/* Protecting the following struct pagevec */
+DEFINE_LOCAL_LOCK(swapvec_lock);
+static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
@@ -254,11 +260,11 @@ void rotate_reclaimable_page(struct page *page)
 		unsigned long flags;
=20
 		get_page(page);
-		local_irq_save(flags);
+		local_lock_irqsave(rotate_lock, flags);
 		pvec =3D this_cpu_ptr(&lru_rotate_pvecs);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(rotate_lock, flags);
 	}
 }
=20
@@ -308,12 +314,14 @@ void activate_page(struct page *page)
 {
 	page =3D compound_head(page);
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(activate_page_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(swapvec_lock);
+		pvec =3D this_cpu_ptr(&activate_page_pvecs);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, __activate_page, NULL);
-		put_cpu_var(activate_page_pvecs);
+		local_unlock(swapvec_lock);
 	}
 }
=20
@@ -335,9 +343,12 @@ void activate_page(struct page *page)
=20
 static void __lru_cache_activate_page(struct page *page)
 {
-	struct pagevec *pvec =3D &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
 	int i;
=20
+	local_lock(swapvec_lock);
+	pvec =3D this_cpu_ptr(&lru_add_pvec);
+
 	/*
 	 * Search backwards on the optimistic assumption that the page being
 	 * activated has just been added to this pagevec. Note that only
@@ -357,7 +368,7 @@ static void __lru_cache_activate_page(struct page *page)
 		}
 	}
=20
-	put_cpu_var(lru_add_pvec);
+	local_unlock(swapvec_lock);
 }
=20
 /*
@@ -404,12 +415,14 @@ EXPORT_SYMBOL(mark_page_accessed);
=20
 static void __lru_cache_add(struct page *page)
 {
-	struct pagevec *pvec =3D &get_cpu_var(lru_add_pvec);
+	struct pagevec *pvec;
=20
+	local_lock(swapvec_lock);
+	pvec =3D this_cpu_ptr(&lru_add_pvec);
 	get_page(page);
 	if (!pagevec_add(pvec, page) || PageCompound(page))
 		__pagevec_lru_add(pvec);
-	put_cpu_var(lru_add_pvec);
+	local_unlock(swapvec_lock);
 }
=20
 /**
@@ -603,9 +616,9 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
=20
 		/* No harm done if a racing interrupt already did this */
-		local_irq_save(flags);
+		local_lock_irqsave(rotate_lock, flags);
 		pagevec_move_tail(pvec);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(rotate_lock, flags);
 	}
=20
 	pvec =3D &per_cpu(lru_deactivate_file_pvecs, cpu);
@@ -641,11 +654,14 @@ void deactivate_file_page(struct page *page)
 		return;
=20
 	if (likely(get_page_unless_zero(page))) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_deactivate_file_pvecs);
+		struct pagevec *pvec;
+
+		local_lock(swapvec_lock);
+		pvec =3D this_cpu_ptr(&lru_deactivate_file_pvecs);
=20
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
-		put_cpu_var(lru_deactivate_file_pvecs);
+		local_unlock(swapvec_lock);
 	}
 }
=20
@@ -660,12 +676,14 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_deactivate_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(swapvec_lock);
+		pvec =3D this_cpu_ptr(&lru_deactivate_pvecs);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		put_cpu_var(lru_deactivate_pvecs);
+		local_unlock(swapvec_lock);
 	}
 }
=20
@@ -680,19 +698,22 @@ void mark_page_lazyfree(struct page *page)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		struct pagevec *pvec =3D &get_cpu_var(lru_lazyfree_pvecs);
+		struct pagevec *pvec;
=20
+		local_lock(swapvec_lock);
+		pvec =3D this_cpu_ptr(&lru_lazyfree_pvecs);
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
-		put_cpu_var(lru_lazyfree_pvecs);
+		local_unlock(swapvec_lock);
 	}
 }
=20
 void lru_add_drain(void)
 {
-	lru_add_drain_cpu(get_cpu());
-	put_cpu();
+	local_lock(swapvec_lock);
+	lru_add_drain_cpu(smp_processor_id());
+	local_unlock(swapvec_lock);
 }
=20
 #ifdef CONFIG_SMP
--=20
2.26.2

