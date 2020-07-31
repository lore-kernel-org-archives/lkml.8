Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E10922B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1pbU22O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3s7GmTpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgGaJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbgGaJXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:22 -0400
Date:   Fri, 31 Jul 2020 09:23:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p6aiM6SYXWxBiIoO6ba1UH88B2zn6jixk8xsTs62vN0=;
        b=B1pbU22OOau0GoJhWL4/2I4i9URtRS18HC2MtMFcmfQ77cv7ePdtegTEdZgy9wPVf2YWDT
        yh6ox8AjolZ7dEk//RZZDhXBFqUdNQlgXt5Vqf6pCyIRtftHZa776PQ+r6eCyxWl1KJ/SK
        xTcP69u9Ug8PjdQAtWHUNdOiQ2ccEIDKasqJqMqWlVw7lyHRL7ct5wO2W4YWAo9iNPFcwP
        dj27smE3fIbO5mFc4Q7xaFwZpir27piQvNjMmCajqV651FC8BnEmfAGIGxjaUHDvJMFcS1
        iSYTHr8EoCWVZ6jvSlht7jObgglF9ZQ4bytv8leykcCeb+s9HP5yDa5o08sZ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p6aiM6SYXWxBiIoO6ba1UH88B2zn6jixk8xsTs62vN0=;
        b=3s7GmTpwqHahu7TKeb4iiQ4dqbtA7sfd2cRR52Z73kv1M9gMY5u1ZJEoMBdBjSACpVfC81
        kzlaZiY9PnrFwKBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Use static initializer for krc.lock
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740053.4006.2992200234293813448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     69f08d3999dbef1553a3332b8055282dd3893b6c
Gitweb:        https://git.kernel.org/tip/69f08d3999dbef1553a3332b8055282dd3893b6c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 25 May 2020 23:47:51 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Use static initializer for krc.lock

The per-CPU variable is initialized at runtime in
kfree_rcu_batch_init(). This function is invoked before
'rcu_scheduler_active' is set to 'RCU_SCHEDULER_RUNNING'.
After the initialisation, '->initialized' is to true.

The raw_spin_lock is only acquired if '->initialized' is
set to true. The worqueue item is only used if 'rcu_scheduler_active'
set to RCU_SCHEDULER_RUNNING which happens after initialisation.

Use a static initializer for krc.lock and remove the runtime
initialisation of the lock. Since the lock can now be always
acquired, remove the '->initialized' check.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 368bdc4..a42a469 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3002,7 +3002,7 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @lock and @rcu_work fields have been initialized
+ * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3022,7 +3022,9 @@ struct kfree_rcu_cpu {
 	int count;
 };
 
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
+};
 
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
@@ -3042,8 +3044,7 @@ krc_this_cpu_lock(unsigned long *flags)
 
 	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		raw_spin_lock(&krcp->lock);
+	raw_spin_lock(&krcp->lock);
 
 	return krcp;
 }
@@ -3051,8 +3052,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	if (likely(krcp->initialized))
-		raw_spin_unlock(&krcp->lock);
+	raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 
@@ -4278,7 +4278,6 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
