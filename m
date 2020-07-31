Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195F2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E842D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jePimbr8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1GdDTVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgGaJX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732440AbgGaJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:25 -0400
Date:   Fri, 31 Jul 2020 09:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mOUSBhu0WuGZUVp3yKsVYqoGuqtWy0OM4prqdJlsJx0=;
        b=jePimbr82MJUSIS5cc29K4sEkIzc3aerrA+EF9+vsEa+t6+t8oZWNKX8kLHHsNKbCL3n+0
        +ZeHufSluaZ+cdbd/qACLs/vB0Hc+NTOQ6/cANF8hUIaKxCR6SpCs9IeA4tJEJokpLulCP
        /xmsTmQ5yvkDdYjCdN00cUnZWYwpmEFrBbs0ypvzk7LRVui8EcNxqmkXJN+JTKLKfY0o6C
        CiEIk3j5eYiw1QgahYBs6yyb29gdB1d/c3kKBiY6lO85Qpw01vSEQh8BB8mnxXrJxJcoei
        tJmICUtkOBNcXdfQMoP0RSVLnLfx/aYIxT03sEbXGYoFAAzGnGgdOk4PsuuL2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mOUSBhu0WuGZUVp3yKsVYqoGuqtWy0OM4prqdJlsJx0=;
        b=y1GdDTVdhaDrZqlT/A9CLfmF2BRWVPcsWM6TE3ociZFB/iP1Nb3bBHu9/Q9kKUKTT7ZT/I
        NpCV2KDqHzJAY+BA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Make debug_objects logic independent of rcu_head
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740251.4006.127645069637323433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     446044eb9c9c335d3ae1be4665193ab43ebb284e
Gitweb:        https://git.kernel.org/tip/446044eb9c9c335d3ae1be4665193ab43ebb284e
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 25 May 2020 23:47:48 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Make debug_objects logic independent of rcu_head

kfree_rcu()'s debug_objects logic uses the address of the object's
embedded rcu_head to queue/unqueue. Instead of this, make use of the
object's address itself as preparation for future headless kfree_rcu()
support.

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5151fe4..143c1e9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2970,13 +2970,11 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * @nr_records: Number of active pointers in the array
  * @records: Array of the kfree_rcu() pointers
  * @next: Next bulk object in the block chain
- * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
  */
 struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
 	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
-	struct rcu_head *head_free_debug;
 };
 
 /**
@@ -3026,11 +3024,13 @@ struct kfree_rcu_cpu {
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
-debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	for (; head; head = head->next)
-		debug_rcu_head_unqueue(head);
+	int i;
+
+	for (i = 0; i < bhead->nr_records; i++)
+		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
 #endif
 }
 
@@ -3060,7 +3060,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -3082,14 +3082,15 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		void *ptr = (void *)head - offset;
 
 		next = head->next;
-		debug_rcu_head_unqueue(head);
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree((void *)head - offset);
+			kfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3228,18 +3229,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
 		bnode->next = krcp->bhead;
-		bnode->head_free_debug = NULL;
 
 		/* Attach it to the head. */
 		krcp->bhead = bnode;
 	}
 
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	head->func = func;
-	head->next = krcp->bhead->head_free_debug;
-	krcp->bhead->head_free_debug = head;
-#endif
-
 	/* Finally insert. */
 	krcp->bhead->records[krcp->bhead->nr_records++] =
 		(void *) head - (unsigned long) func;
@@ -3263,14 +3257,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		raw_spin_lock(&krcp->lock);
 
+	ptr = (void *)head - (unsigned long)func;
+
 	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(head)) {
+	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
