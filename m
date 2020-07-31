Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A33C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9FA208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxME3PGG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFlLow5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbgGaJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbgGaJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12874C06174A;
        Fri, 31 Jul 2020 02:23:18 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HVBBUB3HpKb1Fzy50FL0BCdbBBBwKcFqTtsw6DVzWNA=;
        b=wxME3PGGqrelE+RqzkPidWPi7tM0gIoD345VUx691hbjfseOmt5ijhWTXUjCvEaGqh51TN
        6VNjmeeEYDbP6jdgzzA6BA0CedZFvahcPX8ZL9Ri0V8ycKyL483st7eNxbYZvv+9LboHRk
        RZwwYDgeQVrPUebSeRcdK7qyfujCR1aSb5ss6PcMI9unyEHwdd12yQzHJUkKrkyPBTajCX
        ZB96t5klPmaSOTjidcQxwsRjmGPirXeiUGDRphYby890xPMmi3Ui0k64Fbma4TG1cd0vSv
        kX8xEAddeeduSYg0uYcr5qOFh8AivXy91OI842c6h2IzVS0DeOthZr0BkpF20Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HVBBUB3HpKb1Fzy50FL0BCdbBBBwKcFqTtsw6DVzWNA=;
        b=CFlLow5QJQVSGJHr5oKYJ26kFfFN4431Ui7KvbQL2VKfE0CcOD0ma9eOfHx1rdi3zP1gb+
        A91ciCgJeDzaA8CA==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Support reclaim for head-less object
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739588.4006.5527211593509750022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3042f83f19bec2e0cd356f72b39e4d816e8cd5ff
Gitweb:        https://git.kernel.org/tip/3042f83f19bec2e0cd356f72b39e4d816e8cd5ff
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:58 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:26 -07:00

rcu: Support reclaim for head-less object

Update the kvfree_call_rcu() function with head-less support.
This allows RCU to reclaim objects without an embedded rcu_head.

tree-RCU:
We introduce two chains of arrays to store SLAB-backed and vmalloc
pointers, each.  Storage in either of these arrays does not require
embedding an rcu_head within the object.

Maintaining the arrays may become impossible due to high memory
pressure. For such cases there is an emergency path. Objects with
rcu_head inside are just queued on a backup rcu_head list. Later on
that list is drained. As for the head-less variant, as the current
context can sleep, the following emergency measures are applied:
   a) Synchronously wait until a grace period has elapsed.
   b) Call kvfree().

tiny-RCU:
For double argument calls, there are no new changes in behavior. For
single argument call, kvfree() is directly inlined on the current
stack after a synchronize_rcu() call. Note that for tiny-RCU, any
call to synchronize_rcu() is actually a quiescent state, therefore
it does nothing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 18 +++++++++++++++-
 kernel/rcu/tree.c       | 45 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index fb2eb39..5cc9637 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,9 +34,25 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
+/*
+ * Add one more declaration of kvfree() here. It is
+ * not so straight forward to just include <linux/mm.h>
+ * where it is defined due to getting many compile
+ * errors caused by that include.
+ */
+extern void kvfree(const void *addr);
+
 static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	call_rcu(head, func);
+	if (head) {
+		call_rcu(head, func);
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree((void *) func);
 }
 
 void rcu_qs(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f22c47e..01f29e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3314,6 +3314,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			/*
+			 * NOTE: For one argument of kvfree_rcu() we can
+			 * drop the lock and get the page in sleepable
+			 * context. That would allow to maintain an array
+			 * for the CONFIG_PREEMPT_RT as well if no cached
+			 * pages are available.
+			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
@@ -3353,16 +3360,33 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool success;
 	void *ptr;
 
+	if (head) {
+		ptr = (void *) head - (unsigned long) func;
+	} else {
+		/*
+		 * Please note there is a limitation for the head-less
+		 * variant, that is why there is a clear rule for such
+		 * objects: it can be used from might_sleep() context
+		 * only. For other places please embed an rcu_head to
+		 * your data.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	krcp = krc_this_cpu_lock(&flags);
-	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		// Mark as success and leave.
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3370,10 +3394,16 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		if (head == NULL)
+			// Inline if kvfree_rcu(one_arg) call.
+			goto unlock_return;
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3387,6 +3417,17 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
+
+	/*
+	 * Inline kvfree() after synchronize_rcu(). We can do
+	 * it from might_sleep() context only, so the current
+	 * CPU can pass the QS state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue((struct rcu_head *) ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
