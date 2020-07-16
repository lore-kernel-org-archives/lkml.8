Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20537C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F104A20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGPLHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:07:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:07:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8019F11B3;
        Thu, 16 Jul 2020 04:07:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9FB93F68F;
        Thu, 16 Jul 2020 04:07:32 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] sched/uclamp: Fix a deadlock when enabling uclamp static key
Date:   Thu, 16 Jul 2020 12:03:47 +0100
Message-Id: <20200716110347.19553-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716110347.19553-1-qais.yousef@arm.com>
References: <20200716110347.19553-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following splat was caught when setting uclamp value of a task.

	BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49

	======================================================
	in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 731, name: l_3-1
	WARNING: possible circular locking dependency detected
	5.8.0-rc4-00040-g6345b3305877-dirty #864 Not tainted
	INFO: lockdep is turned off.
	------------------------------------------------------
	l_0-0/730 is trying to acquire lock:
	irq event stamp: 150
	ffff80001343dea0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x1c/0x38
	el0_svc_common.constprop.4+0xe4/0x200

	but task is already holding lock:
	ffff00097ef4ca58 (&rq->lock){-.-.}-{2:2}, at: task_rq_lock+0x60/0xf0
	_raw_spin_lock_irqsave+0x38/0xa8

	which lock already depends on the new lock.

	the existing dependency chain (in reverse order) is:
	copy_process+0x620/0x18f0

	-> #1 (&rq->lock){-.-.}-{2:2}:
	0x0
	       _raw_spin_lock+0x64/0x80
	       __schedule+0x108/0x910
	CPU: 5 PID: 731 Comm: l_3-1 Not tainted 5.8.0-rc4-00040-g6345b3305877-dirty #864
	       schedule+0x7c/0x108
	       schedule_timeout+0x2b0/0x448
	Hardware name: ARM Juno development board (r2) (DT)
	       wait_for_completion_killable+0xb8/0x1a8
	       __kthread_create_on_node+0xe0/0x1c0
	Call trace:
	       kthread_create_on_node+0x8c/0xb8
	       create_worker+0xd0/0x1b8
	 dump_backtrace+0x0/0x1f0
	       workqueue_prepare_cpu+0x5c/0xa0
	       cpuhp_invoke_callback+0xe8/0xe30
	 show_stack+0x2c/0x38
	       _cpu_up+0xf4/0x1c0
	       cpu_up+0xa0/0xc0
	 dump_stack+0xf0/0x170
	       bringup_nonboot_cpus+0x88/0xc0
	       smp_init+0x34/0x90
	 ___might_sleep+0x144/0x200
	       kernel_init_freeable+0x1b8/0x338
	       kernel_init+0x18/0x118
	 __might_sleep+0x54/0x88
	       ret_from_fork+0x10/0x18

	-> #0 (cpu_hotplug_lock){++++}-{0:0}:
	 cpus_read_lock+0x2c/0x130
	       __lock_acquire+0x11a0/0x1550
	       lock_acquire+0xf8/0x460
	 static_key_enable+0x1c/0x38
	       cpus_read_lock+0x68/0x130
	       static_key_enable+0x1c/0x38
	 __sched_setscheduler+0x900/0xad8
	       __sched_setscheduler+0x900/0xad8
	       __arm64_sys_sched_setattr+0x2e0/0x4f8
	 __arm64_sys_sched_setattr+0x2e0/0x4f8
	       el0_svc_common.constprop.4+0x84/0x200
	       do_el0_svc+0x34/0xa0
	 el0_svc_common.constprop.4+0x84/0x200
	       el0_sync_handler+0x16c/0x340
	       el0_sync+0x140/0x180
	 do_el0_svc+0x34/0xa0

	other info that might help us debug this:

	 Possible unsafe locking scenario:

	 el0_sync_handler+0x16c/0x340
	       CPU0                    CPU1
	       ----                    ----
	 el0_sync+0x140/0x180
	  lock(&rq->lock);
	                               lock(cpu_hotplug_lock);
	                               lock(&rq->lock);
	  lock(cpu_hotplug_lock);

	 *** DEADLOCK ***

	3 locks held by l_0-0/730:
	 #0: ffff80001345b4d0 (&cpuset_rwsem){++++}-{0:0}, at: __sched_setscheduler+0x4c0/0xad8
	 #1: ffff00096e83b718 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x44/0xf0
	 #2: ffff00097ef4ca58 (&rq->lock){-.-.}-{2:2}, at: task_rq_lock+0x60/0xf0

	stack backtrace:
	CPU: 1 PID: 730 Comm: l_0-0 Tainted: G        W         5.8.0-rc4-00040-g6345b3305877-dirty #864
	Hardware name: ARM Juno development board (r2) (DT)
	Call trace:
	 dump_backtrace+0x0/0x1f0
	 show_stack+0x2c/0x38
	 dump_stack+0xf0/0x170
	 print_circular_bug.isra.40+0x228/0x280
	 check_noncircular+0x14c/0x1b0
	 __lock_acquire+0x11a0/0x1550
	 lock_acquire+0xf8/0x460
	 cpus_read_lock+0x68/0x130
	 static_key_enable+0x1c/0x38
	 __sched_setscheduler+0x900/0xad8
	 __arm64_sys_sched_setattr+0x2e0/0x4f8
	 el0_svc_common.constprop.4+0x84/0x200
	 do_el0_svc+0x34/0xa0
	 el0_sync_handler+0x16c/0x340
	 el0_sync+0x140/0x180

Fix by ensuring we enable the key outside of the critical section in
__sched_setscheduler()

Fixes: 46609ce22703 ("sched/uclamp: Protect uclamp fast path code with static key")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1578c3ad40c..947a1f4fa112 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1348,7 +1348,7 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
-static void __setscheduler_uclamp(struct task_struct *p,
+static bool __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
@@ -1376,9 +1376,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
-		return;
-
-	static_branch_enable(&sched_uclamp_used);
+		return false;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
@@ -1389,6 +1387,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	return true;
 }
 
 static void uclamp_fork(struct task_struct *p)
@@ -1465,8 +1465,11 @@ static inline int uclamp_validate(struct task_struct *p,
 {
 	return -EOPNOTSUPP;
 }
-static void __setscheduler_uclamp(struct task_struct *p,
-				  const struct sched_attr *attr) { }
+static bool __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	return false;
+}
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
@@ -5305,7 +5308,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	prev_class = p->sched_class;
 
 	__setscheduler(rq, p, attr, pi);
-	__setscheduler_uclamp(p, attr);
+
+	retval = __setscheduler_uclamp(p, attr);
 
 	if (queued) {
 		/*
@@ -5335,6 +5339,18 @@ static int __sched_setscheduler(struct task_struct *p,
 	balance_callback(rq);
 	preempt_enable();
 
+#ifdef CONFIG_UCLAMP_TASK
+	/*
+	 * Enable uclamp static key outside the critical section.
+	 * static_branch_enable() will hold cpu_hotplug_lock; if done from
+	 * critical section above which holds other locks (rq->lock namely),
+	 * it could lead to deadlock scenarios as both are popular locks and
+	 * could be acquired from different paths in different orders.
+	 */
+	if (retval)
+		static_branch_enable(&sched_uclamp_used);
+#endif
+
 	return 0;
 
 unlock:
-- 
2.17.1

