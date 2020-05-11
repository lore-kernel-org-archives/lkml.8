Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B878C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6852078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgEKVBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732090AbgEKVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C79C05BD09;
        Mon, 11 May 2020 14:00:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWi-0005uC-Db; Mon, 11 May 2020 22:59:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8A01F1C0838;
        Mon, 11 May 2020 22:59:35 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:35 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sched/core: Add function to sample state of locked-down task
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077541.390.2895607985565941744.tip-bot2@tip-bot2>
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

Commit-ID:     2beaf3280e57bb891f8012dca49c87ed0f01e2f3
Gitweb:        https://git.kernel.org/tip/2beaf3280e57bb891f8012dca49c87ed0f01e2f3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Mar 2020 14:23:21 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

sched/core: Add function to sample state of locked-down task

A running task's state can be sampled in a consistent manner (for example,
for diagnostic purposes) simply by invoking smp_call_function_single()
on its CPU, which may be obtained using task_cpu(), then having the
IPI handler verify that the desired task is in fact still running.
However, if the task is not running, this sampling can in theory be done
immediately and directly.  In practice, the task might start running at
any time, including during the sampling period.  Gaining a consistent
sample of a not-running task therefore requires that something be done
to lock down the target task's state.

This commit therefore adds a try_invoke_on_locked_down_task() function
that invokes a specified function if the specified task can be locked
down, returning true if successful and if the specified function returns
true.  Otherwise this function simply returns false.  Given that the
function passed to try_invoke_on_nonrunning_task() might be invoked with
a runqueue lock held, that function had better be quite lightweight.

The function is passed the target task's task_struct pointer and the
argument passed to try_invoke_on_locked_down_task(), allowing easy access
to task state and to a location for further variables to be passed in
and out.

Note that the specified function will be called even if the specified
task is currently running.  The function can use ->on_rq and task_curr()
to quickly and easily determine the task's state, and can return false
if this state is not to the function's liking.  The caller of the
try_invoke_on_locked_down_task() would then see the false return value,
and could take appropriate action, for example, trying again later or
sending an IPI if matters are more urgent.

It is expected that use cases such as the RCU CPU stall warning code will
simply return false if the task is currently running.  However, there are
use cases involving nohz_full CPUs where the specified function might
instead fall back to an alternative sampling scheme that relies on heavier
synchronization (such as memory barriers) in the target task.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
[ paulmck: Apply feedback from Peter Zijlstra and Steven Rostedt. ]
[ paulmck: Invoke if running to handle feedback from Mathieu Desnoyers. ]
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/wait.h |  2 ++-
 kernel/sched/core.c  | 48 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index feeb6be..898c890 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1149,4 +1149,6 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 		(wait)->flags = 0;						\
 	} while (0)
 
+bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg);
+
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b..5ca567a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2566,6 +2566,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 *
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
+	 *
+	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2640,6 +2642,52 @@ out:
 }
 
 /**
+ * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
+ * @p: Process for which the function is to be invoked.
+ * @func: Function to invoke.
+ * @arg: Argument to function.
+ *
+ * If the specified task can be quickly locked into a definite state
+ * (either sleeping or on a given runqueue), arrange to keep it in that
+ * state while invoking @func(@arg).  This function can use ->on_rq and
+ * task_curr() to work out what the state is, if required.  Given that
+ * @func can be invoked with a runqueue lock held, it had better be quite
+ * lightweight.
+ *
+ * Returns:
+ *	@false if the task slipped out from under the locks.
+ *	@true if the task was locked onto a runqueue or is sleeping.
+ *		However, @func can override this by returning @false.
+ */
+bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
+{
+	bool ret = false;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	lockdep_assert_irqs_enabled();
+	raw_spin_lock_irq(&p->pi_lock);
+	if (p->on_rq) {
+		rq = __task_rq_lock(p, &rf);
+		if (task_rq(p) == rq)
+			ret = func(p, arg);
+		rq_unlock(rq, &rf);
+	} else {
+		switch (p->state) {
+		case TASK_RUNNING:
+		case TASK_WAKING:
+			break;
+		default:
+			smp_rmb(); // See smp_rmb() comment in try_to_wake_up().
+			if (!p->on_rq)
+				ret = func(p, arg);
+		}
+	}
+	raw_spin_unlock_irq(&p->pi_lock);
+	return ret;
+}
+
+/**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
  *
