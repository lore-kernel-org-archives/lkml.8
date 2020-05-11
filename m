Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B87C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06F02078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgEKVDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732032AbgEKU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF2C061A0E;
        Mon, 11 May 2020 13:59:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWj-0005wV-0Z; Mon, 11 May 2020 22:59:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 54C411C0494;
        Mon, 11 May 2020 22:59:38 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:38 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make rcu_read_unlock_special() safe for rq/pi locks
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077826.390.5439916886562177953.tip-bot2@tip-bot2>
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

Commit-ID:     e4453d8a1c56050df320ef54f339ffa4a9513d0a
Gitweb:        https://git.kernel.org/tip/e4453d8a1c56050df320ef54f339ffa4a9513d0a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 15 Feb 2020 14:18:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Make rcu_read_unlock_special() safe for rq/pi locks

The scheduler is currently required to hold rq/pi locks across the entire
RCU read-side critical section or not at all.  This is inconvenient and
leaves traps for the unwary, including the author of this commit.

But now that excessively long grace periods enable scheduling-clock
interrupts for holdout nohz_full CPUs, the nohz_full rescue logic in
rcu_read_unlock_special() can be dispensed with.  In other words, the
rcu_read_unlock_special() function can refrain from doing wakeups unless
such wakeups are guaranteed safe.

This commit therefore avoids unsafe wakeups, freeing the scheduler to
hold rq/pi locks across rcu_read_unlock() even if the corresponding RCU
read-side critical section might have been preempted.  This commit also
updates RCU's requirements documentation.

This commit is inspired by a patch from Lai Jiangshan:
https://lore.kernel.org/lkml/20191102124559.1135-2-laijs@linux.alibaba.com
This commit is further intended to be a step towards his goal of permitting
the inlining of RCU-preempt's rcu_read_lock() and rcu_read_unlock().

Cc: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 61 ++-------
 kernel/rcu/tree_plugin.h                               | 17 +--
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index fd5e2cb..75b8ca0 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1943,56 +1943,27 @@ invoked from a CPU-hotplug notifier.
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
-RCU depends on the scheduler, and the scheduler uses RCU to protect some
-of its data structures. The preemptible-RCU ``rcu_read_unlock()``
-implementation must therefore be written carefully to avoid deadlocks
-involving the scheduler's runqueue and priority-inheritance locks. In
-particular, ``rcu_read_unlock()`` must tolerate an interrupt where the
-interrupt handler invokes both ``rcu_read_lock()`` and
-``rcu_read_unlock()``. This possibility requires ``rcu_read_unlock()``
-to use negative nesting levels to avoid destructive recursion via
-interrupt handler's use of RCU.
-
-This scheduler-RCU requirement came as a `complete
-surprise <https://lwn.net/Articles/453002/>`__.
-
-As noted above, RCU makes use of kthreads, and it is necessary to avoid
-excessive CPU-time accumulation by these kthreads. This requirement was
-no surprise, but RCU's violation of it when running context-switch-heavy
-workloads when built with ``CONFIG_NO_HZ_FULL=y`` `did come as a
-surprise
+RCU makes use of kthreads, and it is necessary to avoid excessive CPU-time
+accumulation by these kthreads. This requirement was no surprise, but
+RCU's violation of it when running context-switch-heavy workloads when
+built with ``CONFIG_NO_HZ_FULL=y`` `did come as a surprise
 [PDF] <http://www.rdrop.com/users/paulmck/scalability/paper/BareMetal.2015.01.15b.pdf>`__.
 RCU has made good progress towards meeting this requirement, even for
 context-switch-heavy ``CONFIG_NO_HZ_FULL=y`` workloads, but there is
 room for further improvement.
 
-It is forbidden to hold any of scheduler's runqueue or
-priority-inheritance spinlocks across an ``rcu_read_unlock()`` unless
-interrupts have been disabled across the entire RCU read-side critical
-section, that is, up to and including the matching ``rcu_read_lock()``.
-Violating this restriction can result in deadlocks involving these
-scheduler spinlocks. There was hope that this restriction might be
-lifted when interrupt-disabled calls to ``rcu_read_unlock()`` started
-deferring the reporting of the resulting RCU-preempt quiescent state
-until the end of the corresponding interrupts-disabled region.
-Unfortunately, timely reporting of the corresponding quiescent state to
-expedited grace periods requires a call to ``raise_softirq()``, which
-can acquire these scheduler spinlocks. In addition, real-time systems
-using RCU priority boosting need this restriction to remain in effect
-because deferred quiescent-state reporting would also defer deboosting,
-which in turn would degrade real-time latencies.
-
-In theory, if a given RCU read-side critical section could be guaranteed
-to be less than one second in duration, holding a scheduler spinlock
-across that critical section's ``rcu_read_unlock()`` would require only
-that preemption be disabled across the entire RCU read-side critical
-section, not interrupts. Unfortunately, given the possibility of vCPU
-preemption, long-running interrupts, and so on, it is not possible in
-practice to guarantee that a given RCU read-side critical section will
-complete in less than one second. Therefore, as noted above, if
-scheduler spinlocks are held across a given call to
-``rcu_read_unlock()``, interrupts must be disabled across the entire RCU
-read-side critical section.
+There is no longer any prohibition against holding any of
+scheduler's runqueue or priority-inheritance spinlocks across an
+``rcu_read_unlock()``, even if interrupts and preemption were enabled
+somewhere within the corresponding RCU read-side critical section.
+Therefore, it is now perfectly legal to execute ``rcu_read_lock()``
+with preemption enabled, acquire one of the scheduler locks, and hold
+that lock across the matching ``rcu_read_unlock()``.
+
+Similarly, the RCU flavor consolidation has removed the need for negative
+nesting.  The fact that interrupt-disabled regions of code act as RCU
+read-side critical sections implicitly avoids earlier issues that used
+to result in destructive recursion via interrupt handler's use of RCU.
 
 Tracing and RCU
 ~~~~~~~~~~~~~~~
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c..ccad776 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -615,19 +615,18 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-		      tick_nohz_full_cpu(rdp->cpu);
+		exp = (t->rcu_blocked_node &&
+		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
+		      (rdp->grpmask & READ_ONCE(rnp->expmask));
 		// Need to defer quiescent state until everything is enabled.
-		if (irqs_were_disabled && use_softirq &&
-		    (in_interrupt() ||
-		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
-			// Using softirq, safe to awaken, and we get
-			// no help from enabling irqs, unlike bh/preempt.
+		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+			// Using softirq, safe to awaken, and either the
+			// wakeup is free or there is an expedited GP.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting or NO_HZ_FULL, slow is OK.
+			// Also if no expediting, slow is OK.
+			// Plus nohz_full CPUs eventually get tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
