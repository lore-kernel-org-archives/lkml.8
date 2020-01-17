Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D49320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQOuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:50:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:50:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isSxS-0002HB-8d; Fri, 17 Jan 2020 15:50:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9854F1C19E2;
        Fri, 17 Jan 2020 15:50:45 +0100 (CET)
Date:   Fri, 17 Jan 2020 14:50:45 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Fix various data races
Cc:     Qian Cai <cai@lca.pw>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200116185529.11026-1-elver@google.com>
References: <20200116185529.11026-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <157927264536.396.656322891347828320.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     35fd7a637c42bb54ba4608f4d40ae6e55fc88781
Gitweb:        https://git.kernel.org/tip/35fd7a637c42bb54ba4608f4d40ae6e55fc88781
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 16 Jan 2020 19:55:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jan 2020 15:45:01 +01:00

debugobjects: Fix various data races

The counters obj_pool_free, and obj_nr_tofree, and the flag obj_freeing are
read locklessly outside the pool_lock critical sections. If read with plain
accesses, this would result in data races.

This is addressed as follows:

 * reads outside critical sections become READ_ONCE()s (pairing with
   WRITE_ONCE()s added);

 * writes become WRITE_ONCE()s (pairing with READ_ONCE()s added); since
   writes happen inside critical sections, only the write and not the read
   of RMWs needs to be atomic, thus WRITE_ONCE(var, var +/- X) is
   sufficient.

The data races were reported by KCSAN:

  BUG: KCSAN: data-race in __free_object / fill_pool

  write to 0xffffffff8beb04f8 of 4 bytes by interrupt on cpu 1:
   __free_object+0x1ee/0x8e0 lib/debugobjects.c:404
   __debug_check_no_obj_freed+0x199/0x330 lib/debugobjects.c:969
   debug_check_no_obj_freed+0x3c/0x44 lib/debugobjects.c:994
   slab_free_hook mm/slub.c:1422 [inline]

  read to 0xffffffff8beb04f8 of 4 bytes by task 1 on cpu 2:
   fill_pool+0x3d/0x520 lib/debugobjects.c:135
   __debug_object_init+0x3c/0x810 lib/debugobjects.c:536
   debug_object_init lib/debugobjects.c:591 [inline]
   debug_object_activate+0x228/0x320 lib/debugobjects.c:677
   debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]

  BUG: KCSAN: data-race in __debug_object_init / fill_pool

  read to 0xffffffff8beb04f8 of 4 bytes by task 10 on cpu 6:
   fill_pool+0x3d/0x520 lib/debugobjects.c:135
   __debug_object_init+0x3c/0x810 lib/debugobjects.c:536
   debug_object_init_on_stack+0x39/0x50 lib/debugobjects.c:606
   init_timer_on_stack_key kernel/time/timer.c:742 [inline]

  write to 0xffffffff8beb04f8 of 4 bytes by task 1 on cpu 3:
   alloc_object lib/debugobjects.c:258 [inline]
   __debug_object_init+0x717/0x810 lib/debugobjects.c:544
   debug_object_init lib/debugobjects.c:591 [inline]
   debug_object_activate+0x228/0x320 lib/debugobjects.c:677
   debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]

  BUG: KCSAN: data-race in free_obj_work / free_object

  read to 0xffffffff9140c190 of 4 bytes by task 10 on cpu 6:
   free_object+0x4b/0xd0 lib/debugobjects.c:426
   debug_object_free+0x190/0x210 lib/debugobjects.c:824
   destroy_timer_on_stack kernel/time/timer.c:749 [inline]

  write to 0xffffffff9140c190 of 4 bytes by task 93 on cpu 1:
   free_obj_work+0x24f/0x480 lib/debugobjects.c:313
   process_one_work+0x454/0x8d0 kernel/workqueue.c:2264
   worker_thread+0x9a/0x780 kernel/workqueue.c:2410

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200116185529.11026-1-elver@google.com

---
 lib/debugobjects.c | 46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6126119..48054db 100644
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
@@ -324,7 +328,7 @@ free_objs:
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
 		debug_objects_freed += obj_nr_tofree;
-		obj_nr_tofree = 0;
+		WRITE_ONCE(obj_nr_tofree, 0);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
@@ -375,10 +379,10 @@ free_to_obj_pool:
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
@@ -396,15 +400,15 @@ free_to_obj_pool:
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
@@ -423,7 +427,7 @@ free_to_obj_pool:
 static void free_object(struct debug_obj *obj)
 {
 	__free_object(obj);
-	if (!obj_freeing && obj_nr_tofree) {
+	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -982,7 +986,7 @@ repeat:
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
