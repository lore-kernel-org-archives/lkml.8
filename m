Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D920C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F217B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iklceCrr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3PYVtsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbgGaJ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbgGaJXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:22 -0400
Date:   Fri, 31 Jul 2020 09:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vMU98mrio06oBlrMZvW2NF+u4EawOkAHerOr1v7CZ5A=;
        b=iklceCrrW8rwZBRL0nBA+lTaBZ2nwBSYQHPIp4W+uLwVo4Vbl0fTduFH9eULi5CWl3Kh53
        UMymSmDXIuZgwyzIAcW2AwMSk+xEsMmafzqOCuZUBzlcL6nH6hiNMENqki08knmMTkvjyj
        UcI/aYyLYQ+y2+l+xKXthUVqxogGVTOmfti0ROopIV5Gtux6W6ihH2JxmdEbLLfOiyKhZX
        7Qi+aij3tm+BX5w4uQ4d95KTZ/xk18u6gNZ8LMkh9q5idrTVZSGkY6QVH1ZacGKr5470zo
        jdMXRvgDrsE9QqmpQ5uBX2Tl/iUU1l3aeiqqkJMvVtkTFINH/H6smhE7TnlBOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vMU98mrio06oBlrMZvW2NF+u4EawOkAHerOr1v7CZ5A=;
        b=I3PYVtszZH33pP7nAObx5A0jeFK60MJB9A839vFX7xS0CpF11v984p968xn6OHaZjbGZop
        OTcvj4gyuGCV5hDw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: cache specified number of objects
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739986.4006.546510754110087404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     53c72b590b3a0afd6747d6f7957e6838003e90a4
Gitweb:        https://git.kernel.org/tip/53c72b590b3a0afd6747d6f7957e6838003e90a4
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:52 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: cache specified number of objects

In order to reduce the dynamic need for pages in kfree_rcu(),
pre-allocate a configurable number of pages per CPU and link
them in a list. When kfree_rcu() reclaims objects, the object's
container page is cached into a list instead of being released
to the low-level page allocator.

Such an approach provides O(1) access to free pages while also
reducing the number of requests to the page allocator. It also
makes the kfree_rcu() code to have free pages available during
a low memory condition.

A read-only sysfs parameter (rcu_min_cached_objs) reflects the
minimum number of allowed cached pages per CPU.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++-
 kernel/rcu/tree.c                               | 66 +++++++++++++++-
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..befaa63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4038,6 +4038,14 @@
 			latencies, which will choose a value aligned
 			with the appropriate hardware boundaries.
 
+	rcutree.rcu_min_cached_objs= [KNL]
+			Minimum number of objects which are cached and
+			maintained per one CPU. Object size is equal
+			to PAGE_SIZE. The cache allows to reduce the
+			pressure to page allocator, also it makes the
+			whole algorithm to behave better in low memory
+			condition.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a42a469..37c0cd0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -175,6 +175,15 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+/*
+ * This rcu parameter is runtime-read-only. It reflects
+ * a minimum allowed number of objects which can be cached
+ * per-CPU. Object size is equal to one page. This value
+ * can be changed at boot time.
+ */
+static int rcu_min_cached_objs = 2;
+module_param(rcu_min_cached_objs, int, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -2997,7 +3006,6 @@ struct kfree_rcu_cpu_work {
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
- * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -3013,13 +3021,22 @@ struct kfree_rcu_cpu_work {
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
 	struct kfree_rcu_bulk_data *bhead;
-	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
 	int count;
+
+	/*
+	 * A simple cache list that contains objects for
+	 * reuse purpose. In order to save some per-cpu
+	 * space the list is singular. Even though it is
+	 * lockless an access has to be protected by the
+	 * per-cpu lock.
+	 */
+	struct llist_head bkvcache;
+	int nr_bkv_objs;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -3056,6 +3073,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 	local_irq_restore(flags);
 }
 
+static inline struct kfree_rcu_bulk_data *
+get_cached_bnode(struct kfree_rcu_cpu *krcp)
+{
+	if (!krcp->nr_bkv_objs)
+		return NULL;
+
+	krcp->nr_bkv_objs--;
+	return (struct kfree_rcu_bulk_data *)
+		llist_del_first(&krcp->bkvcache);
+}
+
+static inline bool
+put_cached_bnode(struct kfree_rcu_cpu *krcp,
+	struct kfree_rcu_bulk_data *bnode)
+{
+	// Check the limit.
+	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
+		return false;
+
+	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
+	krcp->nr_bkv_objs++;
+	return true;
+
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3091,7 +3133,12 @@ static void kfree_rcu_work(struct work_struct *work)
 		kfree_bulk(bhead->nr_records, bhead->records);
 		rcu_lock_release(&rcu_callback_map);
 
-		if (cmpxchg(&krcp->bcached, NULL, bhead))
+		krcp = krc_this_cpu_lock(&flags);
+		if (put_cached_bnode(krcp, bhead))
+			bhead = NULL;
+		krc_this_cpu_unlock(krcp, flags);
+
+		if (bhead)
 			free_page((unsigned long) bhead);
 
 		cond_resched_tasks_rcu_qs();
@@ -3224,7 +3271,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
+		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
@@ -4277,12 +4324,23 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		struct kfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
+		for (i = 0; i < rcu_min_cached_objs; i++) {
+			bnode = (struct kfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+			if (bnode)
+				put_cached_bnode(krcp, bnode);
+			else
+				pr_err("Failed to preallocate for %d CPU!\n", cpu);
+		}
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
