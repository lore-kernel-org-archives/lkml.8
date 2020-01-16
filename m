Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECD8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806122053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QckFlUWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437185AbgAPS4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:56:08 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:42612 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437132AbgAPS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:56:05 -0500
Received: by mail-wr1-f73.google.com with SMTP id k18so9618922wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cOgDAvUwdmbi4m/kDIybPuInzN3fPgnThGH4mtCL7lc=;
        b=QckFlUWoMtW2AkiBldnh6mGbayGKq/CdHw/K3osDep7C6pRcrJ/WPFJGVDCpblNhWw
         Q90fngGzulhP6sBqSBG/wWhZfgUWv7rCaBNZfMGeL6sGQAjqmKSqXOteawVD8CGY2IEH
         0ZSm0rodqL2e9xFWzAlivd1BqpMRRW7T+L+V+bt9RDPKVpEH3w8CVVSVCOyXKGTZQ+qE
         U7K0APzNbnmJhigjqt9gzizQGveB6gawPuYR87PyjG6cqeYFVLX2NcCzy13qloF8PZYY
         XAp8tQmBE96aJANScc7yROv6qIgyMWxwC+MqC2Ue+VRXbOKI89gkAwBBkgtstAuk8RA3
         ANXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cOgDAvUwdmbi4m/kDIybPuInzN3fPgnThGH4mtCL7lc=;
        b=T/WoADewP+NvI+DoRSHoqvl4ibHIRBZ/TL/8kZJpvMbBiwN8guq7DUQxpmrr07NuaU
         MSCcTGv0oGpoWhrSgoDeFW+muflA+vjHY7SjezBOuwTv1dJ73koRYAR//KZa8+uQ9ud4
         EozmFNhEHkO7qO5BwBtwMYeY4Ajlr8jk0ZHq6q02YD92JPXBamojOudyjfloz57SMRZE
         Iqp3WEzQicDsHeuInjfXfc6zearFZ9cnK32CEToGRxK9CP04xN9/wEkie5fp2Hhho2zA
         rJiKoUn5weckrY71POksQ3uaR8GrFXztskVijWCBqzL/kcFKCPFEenDYnLHPtBfr4+xr
         3oDg==
X-Gm-Message-State: APjAAAWfXm7BK7W8ELarVISdw3RoCZD3I115q9EbjumzFHyBbAYPY9gY
        T4jKNhs+4uUwv8917U3LnVU65oSbag==
X-Google-Smtp-Source: APXvYqzpsEMSRDQVq1aNPlZqFbi8UXaUk2BdJZw+DG8PJVVW6W3zDh/tvDagp/R+D/REv9N0G6qqzTXyCg==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr4947132wrx.288.1579200962616;
 Thu, 16 Jan 2020 10:56:02 -0800 (PST)
Date:   Thu, 16 Jan 2020 19:55:29 +0100
Message-Id: <20200116185529.11026-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] debugobjects: Fix various data races
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        tglx@linutronix.de, longman@redhat.com, gregkh@linuxfoundation.org,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counters obj_pool_free, and obj_nr_tofree, and the flag obj_freeing
are read locklessly outside the pool_lock critical sections. If read
with plain accesses, this would result in data races.

This is addressed as follows:
* reads outside critical sections become READ_ONCE()s (pairing with
  WRITE_ONCE()s added);
* writes become WRITE_ONCE()s (pairing with READ_ONCE()s added); since
  writes happen inside critical sections, only the write and not the
  read of RMWs needs to be atomic, thus WRITE_ONCE(var, var +/- X) is
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

Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Qian Cai <cai@lca.pw>
---
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
-- 
2.25.0.rc1.283.g88dfdc4193-goog

