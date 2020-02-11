Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60722C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E7208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgBKMsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgBKMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxo-0007p2-58; Tue, 11 Feb 2020 13:48:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 88E671C201B;
        Tue, 11 Feb 2020 13:48:26 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:26 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Decrement IRQ context counters
 when removing lock chain
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206152408.24165-2-longman@redhat.com>
References: <20200206152408.24165-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <158142530623.411.14020420897822218115.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b3b9c187dc2544923a601733a85352b9ddaba9b3
Gitweb:        https://git.kernel.org/tip/b3b9c187dc2544923a601733a85352b9ddaba9b3
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 06 Feb 2020 10:24:03 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:48 +01:00

locking/lockdep: Decrement IRQ context counters when removing lock chain

There are currently three counters to track the IRQ context of a lock
chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
They are incremented when a new lock chain is added, but they are
not decremented when a lock chain is removed. That causes some of the
statistic counts reported by /proc/lockdep_stats to be incorrect.
IRQ
Fix that by decrementing the right counter when a lock chain is removed.

Since inc_chains() no longer accesses hardirq_context and softirq_context
directly, it is moved out from the CONFIG_TRACE_IRQFLAGS conditional
compilation block.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200206152408.24165-2-longman@redhat.com
---
 kernel/locking/lockdep.c           | 40 ++++++++++++++++-------------
 kernel/locking/lockdep_internals.h |  6 ++++-
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef..35449f5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2298,18 +2298,6 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	return 0;
 }
 
-static void inc_chains(void)
-{
-	if (current->hardirq_context)
-		nr_hardirq_chains++;
-	else {
-		if (current->softirq_context)
-			nr_softirq_chains++;
-		else
-			nr_process_chains++;
-	}
-}
-
 #else
 
 static inline int check_irq_usage(struct task_struct *curr,
@@ -2317,13 +2305,27 @@ static inline int check_irq_usage(struct task_struct *curr,
 {
 	return 1;
 }
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
-static inline void inc_chains(void)
+static void inc_chains(int irq_context)
 {
-	nr_process_chains++;
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains++;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains++;
+	else
+		nr_process_chains++;
 }
 
-#endif /* CONFIG_TRACE_IRQFLAGS */
+static void dec_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains--;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains--;
+	else
+		nr_process_chains--;
+}
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2843,7 +2845,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
+	inc_chains(chain->irq_context);
 
 	return 1;
 }
@@ -3596,7 +3598,8 @@ lock_used:
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return 2 * !!task->hardirq_context + !!task->softirq_context;
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
@@ -4798,6 +4801,8 @@ recalc:
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, chain_key);
+	dec_chains(chain->irq_context);
+
 	/*
 	 * Note: calling hlist_del_rcu() from inside a
 	 * hlist_for_each_entry_rcu() loop is safe.
@@ -4819,6 +4824,7 @@ recalc:
 	}
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+	inc_chains(new_chain->irq_context);
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 18d85ae..a525368 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -106,6 +106,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define STACK_TRACE_HASH_SIZE	16384
 #endif
 
+/*
+ * Bit definitions for lock_chain.irq_context
+ */
+#define LOCK_CHAIN_SOFTIRQ_CONTEXT	(1 << 0)
+#define LOCK_CHAIN_HARDIRQ_CONTEXT	(1 << 1)
+
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
