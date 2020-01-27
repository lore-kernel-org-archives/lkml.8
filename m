Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA556C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AAE24695
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgA1AGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47601 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgA1AGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:33 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOk-00033Z-FF; Tue, 28 Jan 2020 01:06:30 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-01-28

up to:  35fd7a637c42: debugobjects: Fix various data races


A single commit for debug objects which fixes a pile of potential data
races detected by KCSAN.


Thanks,

	tglx

------------------>
Marco Elver (1):
      debugobjects: Fix various data races


 lib/debugobjects.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 61261195f5b6..48054dbf1b51 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -132,14 +132,18 @@ static void fill_pool(void)
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	if (likely(obj_pool_free >= debug_objects_pool_min_level))
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
 		return;
 
 	/*
 	 * Reuse objs from the global free list; they will be reinitialized
 	 * when allocating.
+	 *
+	 * Both obj_nr_tofree and obj_pool_free are checked locklessly; the
+	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
+	 * sections.
 	 */
-	while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
@@ -148,9 +152,9 @@ static void fill_pool(void)
 		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
-			obj_nr_tofree--;
+			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
 			hlist_add_head(&obj->node, &obj_pool);
-			obj_pool_free++;
+			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
@@ -158,7 +162,7 @@ static void fill_pool(void)
 	if (unlikely(!obj_cache))
 		return;
 
-	while (obj_pool_free < debug_objects_pool_min_level) {
+	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new[ODEBUG_BATCH_SIZE];
 		int cnt;
 
@@ -174,7 +178,7 @@ static void fill_pool(void)
 		while (cnt) {
 			hlist_add_head(&new[--cnt]->node, &obj_pool);
 			debug_objects_allocated++;
-			obj_pool_free++;
+			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
@@ -236,7 +240,7 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	obj = __alloc_object(&obj_pool);
 	if (obj) {
 		obj_pool_used++;
-		obj_pool_free--;
+		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
 
 		/*
 		 * Looking ahead, allocate one batch of debug objects and
@@ -255,7 +259,7 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 					       &percpu_pool->free_objs);
 				percpu_pool->obj_free++;
 				obj_pool_used++;
-				obj_pool_free--;
+				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
 			}
 		}
 
@@ -309,8 +313,8 @@ static void free_obj_work(struct work_struct *work)
 		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 		hlist_del(&obj->node);
 		hlist_add_head(&obj->node, &obj_pool);
-		obj_pool_free++;
-		obj_nr_tofree--;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 	return;
@@ -324,7 +328,7 @@ static void free_obj_work(struct work_struct *work)
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
 		debug_objects_freed += obj_nr_tofree;
-		obj_nr_tofree = 0;
+		WRITE_ONCE(obj_nr_tofree, 0);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
@@ -375,10 +379,10 @@ static void __free_object(struct debug_obj *obj)
 	obj_pool_used--;
 
 	if (work) {
-		obj_nr_tofree++;
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
 		hlist_add_head(&obj->node, &obj_to_free);
 		if (lookahead_count) {
-			obj_nr_tofree += lookahead_count;
+			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
 				hlist_add_head(&objs[--lookahead_count]->node,
@@ -396,15 +400,15 @@ static void __free_object(struct debug_obj *obj)
 			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
 				obj = __alloc_object(&obj_pool);
 				hlist_add_head(&obj->node, &obj_to_free);
-				obj_pool_free--;
-				obj_nr_tofree++;
+				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
+				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
 			}
 		}
 	} else {
-		obj_pool_free++;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		hlist_add_head(&obj->node, &obj_pool);
 		if (lookahead_count) {
-			obj_pool_free += lookahead_count;
+			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
 				hlist_add_head(&objs[--lookahead_count]->node,
@@ -423,7 +427,7 @@ static void __free_object(struct debug_obj *obj)
 static void free_object(struct debug_obj *obj)
 {
 	__free_object(obj);
-	if (!obj_freeing && obj_nr_tofree) {
+	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -982,7 +986,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 		debug_objects_maxchecked = objs_checked;
 
 	/* Schedule work to actually kmem_cache_free() objects */
-	if (!obj_freeing && obj_nr_tofree) {
+	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -1008,12 +1012,12 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", obj_pool_free + obj_percpu_free);
+	seq_printf(m, "pool_free     :%d\n", READ_ONCE(obj_pool_free) + obj_percpu_free);
 	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
+	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(obj_nr_tofree));
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;

