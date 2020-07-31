Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8190B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UycYC49L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Dkvuxyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgGaJ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbgGaJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:23 -0400
Date:   Fri, 31 Jul 2020 09:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ozsZ5sv4mPAuYAveQN19/AWAxqU1GxEBOzSxdLd8DSk=;
        b=UycYC49LwUVa5cDL3Yku09f7Gn8+xcUl1XPKrd1x8gSjyh25rG64ppOsdoOmqnP25io4ju
        f+76I0MwnBQ8BFFTsUXS6kVmT7DWB7KiOCPX6xNIEXhzZ7Vjr5xfggfggrOA0i5VNJ5+TK
        JwdSFNIYT8ZX8ogf2P3xZrErIS+37U1u3VarbfYElFkItRNn1oCr3x9Ir2utvidlVyyugT
        SAgJi6Pggy/XglXuy362CbfwgNIPAzvD1nV+XNMj5XbByMo1UuWeVse32pR5eUuD9zFlC9
        8NV4Q+YxIk9VUIlllsvf630S4bFCAWqSsrTrX5vJbSajpXSuQwCNXD15CG9+VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ozsZ5sv4mPAuYAveQN19/AWAxqU1GxEBOzSxdLd8DSk=;
        b=5DkvuxytQ5o4C3If7aPar7kr3/KUm9rbCgIGagunthB2l+9xjXnD6VrNSnwW4NLOMmRCop
        u2hNfEhCcTPg0zDQ==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Maintain separate array for vmalloc ptrs
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739921.4006.13956119084091010650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5f3c8d620447d509e534962e23f7edfb85f4e533
Gitweb:        https://git.kernel.org/tip/5f3c8d620447d509e534962e23f7edfb85f4e533
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:53 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Maintain separate array for vmalloc ptrs

To do so, we use an array of kvfree_rcu_bulk_data structures.
It consists of two elements:
 - index number 0 corresponds to slab pointers.
 - index number 1 corresponds to vmalloc pointers.

Keeping vmalloc pointers separated from slab pointers makes
it possible to invoke the right freeing API for the right
kind of pointer.

It also prepares us for future headless support for vmalloc
and SLAB objects. Such objects cannot be queued on a linked
list and are instead directly into an array.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 173 ++++++++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 73 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 37c0cd0..67c4b98 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -57,6 +57,8 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/clock.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -2966,46 +2968,47 @@ EXPORT_SYMBOL_GPL(call_rcu);
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
+#define FREE_N_CHANNELS 2
 
 /**
- * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
- * @records: Array of the kfree_rcu() pointers
  * @next: Next bulk object in the block chain
+ * @records: Array of the kvfree_rcu() pointers
  */
-struct kfree_rcu_bulk_data {
+struct kvfree_rcu_bulk_data {
 	unsigned long nr_records;
-	struct kfree_rcu_bulk_data *next;
+	struct kvfree_rcu_bulk_data *next;
 	void *records[];
 };
 
 /*
  * This macro defines how many entries the "records" array
  * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
+ * kvfree_rcu_bulk_data structure becomes exactly one page.
  */
-#define KFREE_BULK_MAX_ENTR \
-	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
- * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
+ * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
-	struct kfree_rcu_bulk_data *bhead_free;
+	struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
+ * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -3020,7 +3023,7 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
-	struct kfree_rcu_bulk_data *bhead;
+	struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -3044,7 +3047,7 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
 };
 
 static __always_inline void
-debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
+debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	int i;
@@ -3073,20 +3076,20 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 	local_irq_restore(flags);
 }
 
-static inline struct kfree_rcu_bulk_data *
+static inline struct kvfree_rcu_bulk_data *
 get_cached_bnode(struct kfree_rcu_cpu *krcp)
 {
 	if (!krcp->nr_bkv_objs)
 		return NULL;
 
 	krcp->nr_bkv_objs--;
-	return (struct kfree_rcu_bulk_data *)
+	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
 
 static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
-	struct kfree_rcu_bulk_data *bnode)
+	struct kvfree_rcu_bulk_data *bnode)
 {
 	// Check the limit.
 	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
@@ -3105,43 +3108,63 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS], *bnext;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	int i, j;
 
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
+	// Channels 1 and 2.
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		bkvhead[i] = krwp->bkvhead_free[i];
+		krwp->bkvhead_free[i] = NULL;
+	}
+
+	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
-	bhead = krwp->bhead_free;
-	krwp->bhead_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	/* "bhead" is now private, so traverse locklessly. */
-	for (; bhead; bhead = bnext) {
-		bnext = bhead->next;
-
-		debug_rcu_bhead_unqueue(bhead);
-
-		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
-			bhead->nr_records, bhead->records);
-
-		kfree_bulk(bhead->nr_records, bhead->records);
-		rcu_lock_release(&rcu_callback_map);
+	// Handle two first channels.
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		for (; bkvhead[i]; bkvhead[i] = bnext) {
+			bnext = bkvhead[i]->next;
+			debug_rcu_bhead_unqueue(bkvhead[i]);
+
+			rcu_lock_acquire(&rcu_callback_map);
+			if (i == 0) { // kmalloc() / kfree().
+				trace_rcu_invoke_kfree_bulk_callback(
+					rcu_state.name, bkvhead[i]->nr_records,
+					bkvhead[i]->records);
+
+				kfree_bulk(bkvhead[i]->nr_records,
+					bkvhead[i]->records);
+			} else { // vmalloc() / vfree().
+				for (j = 0; j < bkvhead[i]->nr_records; j++) {
+					trace_rcu_invoke_kfree_callback(
+						rcu_state.name,
+						bkvhead[i]->records[j], 0);
+
+					vfree(bkvhead[i]->records[j]);
+				}
+			}
+			rcu_lock_release(&rcu_callback_map);
 
-		krcp = krc_this_cpu_lock(&flags);
-		if (put_cached_bnode(krcp, bhead))
-			bhead = NULL;
-		krc_this_cpu_unlock(krcp, flags);
+			krcp = krc_this_cpu_lock(&flags);
+			if (put_cached_bnode(krcp, bkvhead[i]))
+				bkvhead[i] = NULL;
+			krc_this_cpu_unlock(krcp, flags);
 
-		if (bhead)
-			free_page((unsigned long) bhead);
+			if (bkvhead[i])
+				free_page((unsigned long) bkvhead[i]);
 
-		cond_resched_tasks_rcu_qs();
+			cond_resched_tasks_rcu_qs();
+		}
 	}
 
 	/*
@@ -3159,7 +3182,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree(ptr);
+			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3176,7 +3199,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
 	struct kfree_rcu_cpu_work *krwp;
 	bool repeat = false;
-	int i;
+	int i, j;
 
 	lockdep_assert_held(&krcp->lock);
 
@@ -3184,21 +3207,25 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		krwp = &(krcp->krw_arr[i]);
 
 		/*
-		 * Try to detach bhead or head and attach it over any
+		 * Try to detach bkvhead or head and attach it over any
 		 * available corresponding free channel. It can be that
 		 * a previous RCU batch is in progress, it means that
 		 * immediately to queue another one is not possible so
 		 * return false to tell caller to retry.
 		 */
-		if ((krcp->bhead && !krwp->bhead_free) ||
+		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
+			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			/* Channel 1. */
-			if (!krwp->bhead_free) {
-				krwp->bhead_free = krcp->bhead;
-				krcp->bhead = NULL;
+			// Channel 1 corresponds to SLAB ptrs.
+			// Channel 2 corresponds to vmalloc ptrs.
+			for (j = 0; j < FREE_N_CHANNELS; j++) {
+				if (!krwp->bkvhead_free[j]) {
+					krwp->bkvhead_free[j] = krcp->bkvhead[j];
+					krcp->bkvhead[j] = NULL;
+				}
 			}
 
-			/* Channel 2. */
+			// Channel 3 corresponds to emergency path.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
@@ -3207,16 +3234,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			WRITE_ONCE(krcp->count, 0);
 
 			/*
-			 * One work is per one batch, so there are two "free channels",
-			 * "bhead_free" and "head_free" the batch can handle. It can be
-			 * that the work is in the pending state when two channels have
-			 * been detached following each other, one by one.
+			 * One work is per one batch, so there are three
+			 * "free channels", the batch can handle. It can
+			 * be that the work is in the pending state when
+			 * channels have been detached following by each
+			 * other.
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 
-		/* Repeat if any "free" corresponding channel is still busy. */
-		if (krcp->bhead || krcp->head)
+		// Repeat if any "free" corresponding channel is still busy.
+		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
 			repeat = true;
 	}
 
@@ -3258,23 +3286,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 static inline bool
-kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
-	struct rcu_head *head, rcu_callback_t func)
+kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
-	struct kfree_rcu_bulk_data *bnode;
+	struct kvfree_rcu_bulk_data *bnode;
+	int idx;
 
 	if (unlikely(!krcp->initialized))
 		return false;
 
 	lockdep_assert_held(&krcp->lock);
+	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bhead ||
-			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+	if (!krcp->bkvhead[idx] ||
+			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
-			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
-
 			/*
 			 * To keep this path working on raw non-preemptible
 			 * sections, prevent the optional entry into the
@@ -3287,7 +3314,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
-			bnode = (struct kfree_rcu_bulk_data *)
+			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
 
@@ -3297,30 +3324,30 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bhead;
+		bnode->next = krcp->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bhead = bnode;
+		krcp->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bhead->records[krcp->bhead->nr_records++] =
-		(void *) head - (unsigned long) func;
+	krcp->bkvhead[idx]->records
+		[krcp->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
 
 /*
- * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
- * period. Please note there are two paths are maintained, one is the main one
- * that uses kfree_bulk() interface and second one is emergency one, that is
- * used only when the main path can not be maintained temporary, due to memory
- * pressure.
+ * Queue a request for lazy invocation of appropriate free routine after a
+ * grace period. Please note there are three paths are maintained, two are the
+ * main ones that use array of pointers interface and third one is emergency
+ * one, that is used only when the main path can not be maintained temporary,
+ * due to memory pressure.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu() load.
+ * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -3343,7 +3370,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
@@ -4324,7 +4351,7 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kfree_rcu_bulk_data *bnode;
+		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
@@ -4332,7 +4359,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kfree_rcu_bulk_data *)
+			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 
 			if (bnode)
