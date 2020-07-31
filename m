Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE47C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E5F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdIc1fgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANOR8bwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbgGaJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732428AbgGaJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E8C06179E;
        Fri, 31 Jul 2020 02:23:20 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1NZ1ntOoX/WeGoegvq69rpvsPFbosnn9+5dR4GfyqBo=;
        b=YdIc1fgGp/8wxRDMdR/evt4BFdkHDNVnRDx4uj3RW+9KxGOcdY4IeDDAoORBEZA8luA3VN
        trGt12lfbLBLQ9M9KQlM7uEX/BVj/YK3AonBJIckKJxznCv+KYKE9D9QHYoaC/eHEN3sPi
        XncV9y3fJ/aZPXiMfwTu+8pNzkGPrngQz/pWT23z3BZ3erPOM0bmxEnIRjxLDfCtvYNdLT
        7H+rhsuFufaT1psX4wWY2QwE0mZksLjjaikkgCYM3EncgzTRLg/ESeJeTTnQzBnu3bWA66
        Es0ouwsKxaNxajVCGYqH+d5bW0Und3jHgig+vR9qLtaBB4TSNvBSKlgIeZ9PHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1NZ1ntOoX/WeGoegvq69rpvsPFbosnn9+5dR4GfyqBo=;
        b=ANOR8bwRKtU/ilAdP/KeBEZqNtQiQWL89Q6WEb0lKdA4m4+bWXmUaZNy7dTT/OMuOyvxMh
        4bTPKoswMvvxBCDw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739785.4006.9912354847913806868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c408b215f58f7156bb6bafb64c0263ee907033df
Gitweb:        https://git.kernel.org/tip/c408b215f58f7156bb6bafb64c0263ee907033df
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:55 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*

The following changes are introduced:

1. Rename rcu_invoke_kfree_callback() to rcu_invoke_kvfree_callback(),
as well as the associated trace events, so the rcu_kfree_callback(),
becomes rcu_kvfree_callback(). The reason is to be aligned with kvfree()
notation.

2. Rename __is_kfree_rcu_offset to __is_kvfree_rcu_offset. All RCU
paths use kvfree() now instead of kfree(), thus rename it.

3. Rename kfree_call_rcu() to the kvfree_call_rcu(). The reason is,
it is capable of freeing vmalloc() memory now. Do the same with
__kfree_rcu() macro, it becomes __kvfree_rcu(), the goal is the
same.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h   | 14 +++++++-------
 include/linux/rcutiny.h    |  2 +-
 include/linux/rcutree.h    |  2 +-
 include/trace/events/rcu.h |  8 ++++----
 kernel/rcu/tiny.c          |  4 ++--
 kernel/rcu/tree.c          | 16 ++++++++--------
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 659cbfa..b344fc8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -828,17 +828,17 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
  * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
  */
-#define __kfree_rcu(head, offset) \
+#define __kvfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
+		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
 /**
@@ -857,7 +857,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -872,7 +872,7 @@ do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
 	if (___p)							\
-		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
 /*
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8512cae..fb2eb39 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d5cc9d6..d2f4064 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811..0ee93d0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -506,13 +506,13 @@ TRACE_EVENT_RCU(rcu_callback,
 
 /*
  * Tracepoint for the registration of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU type, the second argument
+ * kvfree() form.  The first argument is the RCU type, the second argument
  * is a pointer to the RCU callback, the third argument is the offset
  * of the callback within the enclosing RCU-protected data structure,
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT_RCU(rcu_kfree_callback,
+TRACE_EVENT_RCU(rcu_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen),
@@ -596,12 +596,12 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU flavor, the second
+ * kvfree() form.  The first argument is the RCU flavor, the second
  * argument is a pointer to the RCU callback, and the third argument
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
+TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b99f7b..aa897c3 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -85,8 +85,8 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kfree_callback("", head, offset);
+	if (__is_kvfree_rcu_offset(offset)) {
+		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 67c4b98..f22c47e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2905,8 +2905,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rcu_state.name, head,
+	if (__is_kvfree_rcu_offset((unsigned long)func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
@@ -3146,7 +3146,7 @@ static void kfree_rcu_work(struct work_struct *work)
 					bkvhead[i]->records);
 			} else { // vmalloc() / vfree().
 				for (j = 0; j < bkvhead[i]->nr_records; j++) {
-					trace_rcu_invoke_kfree_callback(
+					trace_rcu_invoke_kvfree_callback(
 						rcu_state.name,
 						bkvhead[i]->records[j], 0);
 
@@ -3179,9 +3179,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
@@ -3344,12 +3344,12 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
  * one, that is used only when the main path can not be maintained temporary,
  * due to memory pressure.
  *
- * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
@@ -3388,7 +3388,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
