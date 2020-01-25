Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13DB24687
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgAYKqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgAYKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItw-0008Nv-HX; Sat, 25 Jan 2020 11:42:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D2F61C1A78;
        Sat, 25 Jan 2020 11:42:44 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:43 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove kfree_call_rcu_nobatch()
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896385.396.7647975391977110099.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     189a6883dcf7fa70e17403ae4225c60ffc9e404b
Gitweb:        https://git.kernel.org/tip/189a6883dcf7fa70e17403ae4225c60ffc9e404b
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Fri, 30 Aug 2019 12:36:33 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:24:31 -08:00

rcu: Remove kfree_call_rcu_nobatch()

Now that the kfree_rcu() special-casing has been removed from tree RCU,
this commit removes kfree_call_rcu_nobatch() since it is no longer needed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +----
 include/linux/rcutiny.h                         |  5 +----
 include/linux/rcutree.h                         |  1 +-
 kernel/rcu/rcuperf.c                            | 10 +---------
 kernel/rcu/tree.c                               | 18 +++-------------
 5 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ce270b..ed83d6d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3991,10 +3991,6 @@
 			Number of loops doing rcuperf.kfree_alloc_num number
 			of allocations and frees.
 
-	rcuperf.kfree_no_batch= [KNL]
-			Use the non-batching (less efficient) version of kfree_rcu().
-			This is useful for comparing with the batched version.
-
 	rcuperf.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 1bd166a..b2b2dc9 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -39,11 +39,6 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	call_rcu(head, func);
 }
 
-static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 6a65d3a..2f787b9 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,7 +34,6 @@ static inline void rcu_virt_note_context_switch(int cpu)
 
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c1e25fd..da94b89 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -593,7 +593,6 @@ rcu_perf_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
-torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -632,14 +631,7 @@ kfree_perf_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			if (!kfree_no_batch) {
-				kfree_rcu(alloc_ptr, rh);
-			} else {
-				rcu_callback_t cb;
-
-				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
-				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
-			}
+			kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a8dd612..31d2d92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2763,8 +2763,10 @@ static void kfree_rcu_work(struct work_struct *work)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-		/* Could be possible to optimize with kfree_bulk in future */
-		kfree((void *)head - offset);
+		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
+			/* Could be optimized with kfree_bulk() in future. */
+			kfree((void *)head - offset);
+		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2836,16 +2838,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 /*
- * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
- * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
- */
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func);
-}
-EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
-
-/*
  * Queue a request for lazy invocation of kfree() after a grace period.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
@@ -2864,8 +2856,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 
-	head->func = func;
-
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
