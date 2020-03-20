Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646D620739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCTM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgCTM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHEP-0003qd-Lp; Fri, 20 Mar 2020 13:58:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4129D1C22BE;
        Fri, 20 Mar 2020 13:58:33 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Fix bad recursion pattern
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313093325.GW12561@hirez.programming.kicks-ass.net>
References: <20200313093325.GW12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158470911297.28353.8139800721700138950.tip-bot2@tip-bot2>
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

Commit-ID:     10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Gitweb:        https://git.kernel.org/tip/10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Mar 2020 09:56:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:25 +01:00

locking/lockdep: Fix bad recursion pattern

There were two patterns for lockdep_recursion:

Pattern-A:
	if (current->lockdep_recursion)
		return

	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

Pattern-B:
	current->lockdep_recursion++;
	/* do stuff */
	current->lockdep_recursion--;

But a third pattern has emerged:

Pattern-C:
	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

And while this isn't broken per-se, it is highly dangerous because it
doesn't nest properly.

Get rid of all Pattern-C instances and shore up Pattern-A with a
warning.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313093325.GW12561@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 74 +++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2564950..64ea69f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -390,6 +390,12 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+static inline void lockdep_recursion_finish(void)
+{
+	if (WARN_ON_ONCE(--current->lockdep_recursion))
+		current->lockdep_recursion = 0;
+}
+
 void lockdep_set_selftest_task(struct task_struct *task)
 {
 	lockdep_selftest_task_struct = task;
@@ -1723,11 +1729,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1752,11 +1758,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -3668,9 +3674,9 @@ void lockdep_hardirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__trace_hardirqs_on_caller(ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
@@ -3726,7 +3732,7 @@ void trace_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -3741,7 +3747,7 @@ void trace_softirqs_on(unsigned long ip)
 	 */
 	if (curr->hardirqs_enabled)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 
 /*
@@ -3995,9 +4001,9 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion = 1;
+		current->lockdep_recursion++;
 		register_lock_class(lock, subclass, 1);
-		current->lockdep_recursion = 0;
+		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
 	}
 }
@@ -4677,11 +4683,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
@@ -4694,11 +4700,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
@@ -4719,11 +4725,11 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
@@ -4737,11 +4743,11 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_release);
@@ -4757,9 +4763,9 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	ret = __lock_is_held(lock, read);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -4778,9 +4784,9 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	cookie = __lock_pin_lock(lock);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return cookie;
@@ -4797,9 +4803,9 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_repin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_repin_lock);
@@ -4814,9 +4820,9 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_unpin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
@@ -4952,10 +4958,10 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_contended);
@@ -4972,9 +4978,9 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_acquired(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
@@ -5176,7 +5182,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -5188,7 +5194,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
@@ -5235,11 +5241,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
