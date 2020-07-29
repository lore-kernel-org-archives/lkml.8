Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5933E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nlCXrxoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmxL2GNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG2MCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgG2MCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:02:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C3C061794;
        Wed, 29 Jul 2020 05:02:36 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:02:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9XtJkRN+Zb9Kexda3VrY/y6aoJrrqGJV0XFwX+cZ5k=;
        b=nlCXrxoCECdb3gwyilR2Sw6mEp9bH2TtE3j/TQKvScnYtpfs2rSVak17sEyBMQSaXwIXw+
        G4W3pOzHn7o7ZNrwu1GBedfgTosCtnRxX2aObD+ul52s1J88TNfid4YCUG6zZgRAAbl1vQ
        2NjTbReRjluhS8r4qoDToJO5CFcC59divGZGIvTBdI5zINeirnxgSRSLMq7CmmAeVM4/xT
        KgeXw0y0uJp4hjE8TheBcf13CSNm7hMjxA6GmNud7LfA+iFPkDdvEWA1Ye55dFWSHN+y7N
        k70gLDaInYm52Gs3ueImFVbkz7BIRJpbUmPLxXsWHjJjeeiue8MjGc3cvlYxvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596024155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9XtJkRN+Zb9Kexda3VrY/y6aoJrrqGJV0XFwX+cZ5k=;
        b=dmxL2GNKx4ZEr1p8NJJA9dHsv7W+gxbcmlD4qniZVM4OaWdoTUGtAA/C8oBM0pNYeP6ZEm
        7DXMstBoI2uX3nBg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Add a new sysctl to control RT
 default boost value
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716110347.19553-2-qais.yousef@arm.com>
References: <20200716110347.19553-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <159602415453.4006.5771883945190029640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     13685c4a08fca9dd76bf53bfcbadc044ab2a08cb
Gitweb:        https://git.kernel.org/tip/13685c4a08fca9dd76bf53bfcbadc044ab2a08cb
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 16 Jul 2020 12:03:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 13:51:47 +02:00

sched/uclamp: Add a new sysctl to control RT default boost value

RT tasks by default run at the highest capacity/performance level. When
uclamp is selected this default behavior is retained by enforcing the
requested uclamp.min (p->uclamp_req[UCLAMP_MIN]) of the RT tasks to be
uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
value.

This is also referred to as 'the default boost value of RT tasks'.

See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").

On battery powered devices, it is desired to control this default
(currently hardcoded) behavior at runtime to reduce energy consumed by
RT tasks.

For example, a mobile device manufacturer where big.LITTLE architecture
is dominant, the performance of the little cores varies across SoCs, and
on high end ones the big cores could be too power hungry.

Given the diversity of SoCs, the new knob allows manufactures to tune
the best performance/power for RT tasks for the particular hardware they
run on.

They could opt to further tune the value when the user selects
a different power saving mode or when the device is actively charging.

The runtime aspect of it further helps in creating a single kernel image
that can be run on multiple devices that require different tuning.

Keep in mind that a lot of RT tasks in the system are created by the
kernel. On Android for instance I can see over 50 RT tasks, only
a handful of which created by the Android framework.

To control the default behavior globally by system admins and device
integrator, introduce the new sysctl_sched_uclamp_util_min_rt_default
to change the default boost value of the RT tasks.

I anticipate this to be mostly in the form of modifying the init script
of a particular device.

To avoid polluting the fast path with unnecessary code, the approach
taken is to synchronously do the update by traversing all the existing
tasks in the system. This could race with a concurrent fork(), which is
dealt with by introducing sched_post_fork() function which will ensure
the racy fork will get the right update applied.

Tested on Juno-r2 in combination with the RT capacity awareness [1].
By default an RT task will go to the highest capacity CPU and run at the
maximum frequency, which is particularly energy inefficient on high end
mobile devices because the biggest core[s] are 'huge' and power hungry.

With this patch the RT task can be controlled to run anywhere by
default, and doesn't cause the frequency to be maximum all the time.
Yet any task that really needs to be boosted can easily escape this
default behavior by modifying its requested uclamp.min value
(p->uclamp_req[UCLAMP_MIN]) via sched_setattr() syscall.

[1] 804d402fb6f6: ("sched/rt: Make RT capacity-aware")

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200716110347.19553-2-qais.yousef@arm.com
---
 include/linux/sched.h        |  10 ++-
 include/linux/sched/sysctl.h |   1 +-
 include/linux/sched/task.h   |   1 +-
 kernel/fork.c                |   1 +-
 kernel/sched/core.c          | 119 ++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              |   7 ++-
 6 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index adf0125..a6bf77c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -686,9 +686,15 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/* Clamp values requested for a scheduling entity */
+	/*
+	 * Clamp values requested for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
 	struct uclamp_se		uclamp_req[UCLAMP_CNT];
-	/* Effective clamp values used for a scheduling entity */
+	/*
+	 * Effective clamp values used for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 24be30a..3c31ba8 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -67,6 +67,7 @@ extern unsigned int sysctl_sched_dl_period_min;
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
+extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 3835907..e7ddab0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -55,6 +55,7 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
+extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index efc5493..e75c2e4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2304,6 +2304,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
+	sched_post_fork(p);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e44d83f..12e1f3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -889,6 +889,23 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 /* Max allowed maximum utilization */
 unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
+/*
+ * By default RT tasks run at the maximum performance point/capacity of the
+ * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
+ * SCHED_CAPACITY_SCALE.
+ *
+ * This knob allows admins to change the default behavior when uclamp is being
+ * used. In battery powered devices, particularly, running at the maximum
+ * capacity and frequency will increase energy consumption and shorten the
+ * battery life.
+ *
+ * This knob only affects RT tasks that their uclamp_se->user_defined == false.
+ *
+ * This knob will not override the system default sched_util_clamp_min defined
+ * above.
+ */
+unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -991,6 +1008,64 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+static void __uclamp_update_util_min_rt_default(struct task_struct *p)
+{
+	unsigned int default_util_min;
+	struct uclamp_se *uc_se;
+
+	lockdep_assert_held(&p->pi_lock);
+
+	uc_se = &p->uclamp_req[UCLAMP_MIN];
+
+	/* Only sync if user didn't override the default */
+	if (uc_se->user_defined)
+		return;
+
+	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
+	uclamp_se_set(uc_se, default_util_min, false);
+}
+
+static void uclamp_update_util_min_rt_default(struct task_struct *p)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!rt_task(p))
+		return;
+
+	/* Protect updates to p->uclamp_* */
+	rq = task_rq_lock(p, &rf);
+	__uclamp_update_util_min_rt_default(p);
+	task_rq_unlock(rq, p, &rf);
+}
+
+static void uclamp_sync_util_min_rt_default(void)
+{
+	struct task_struct *g, *p;
+
+	/*
+	 * copy_process()			sysctl_uclamp
+	 *					  uclamp_min_rt = X;
+	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
+	 *   // link thread			  smp_mb__after_spinlock()
+	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
+	 *   sched_post_fork()			  for_each_process_thread()
+	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
+	 *
+	 * Ensures that either sched_post_fork() will observe the new
+	 * uclamp_min_rt or for_each_process_thread() will observe the new
+	 * task.
+	 */
+	read_lock(&tasklist_lock);
+	smp_mb__after_spinlock();
+	read_unlock(&tasklist_lock);
+
+	rcu_read_lock();
+	for_each_process_thread(g, p)
+		uclamp_update_util_min_rt_default(p);
+	rcu_read_unlock();
+}
+
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
@@ -1278,12 +1353,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
-	int old_min, old_max;
+	int old_min, old_max, old_min_rt;
 	int result;
 
 	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
+	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
 
 	result = proc_dointvec(table, write, buffer, lenp, ppos);
 	if (result)
@@ -1292,7 +1368,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		goto done;
 
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
-	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
+	    sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
+
 		result = -EINVAL;
 		goto undo;
 	}
@@ -1313,6 +1391,11 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		uclamp_update_root_tg();
 	}
 
+	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
+		static_branch_enable(&sched_uclamp_used);
+		uclamp_sync_util_min_rt_default();
+	}
+
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
 	 * Otherwise, keep it simple and do just a lazy update at each next
@@ -1324,6 +1407,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
+	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
 done:
 	mutex_unlock(&uclamp_mutex);
 
@@ -1369,17 +1453,20 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
-		unsigned int clamp_value = uclamp_none(clamp_id);
 
 		/* Keep using defined clamps across class changes */
 		if (uc_se->user_defined)
 			continue;
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * RT by default have a 100% boost value that could be modified
+		 * at runtime.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			__uclamp_update_util_min_rt_default(p);
+		else
+			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
 
-		uclamp_se_set(uc_se, clamp_value, false);
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
@@ -1400,6 +1487,10 @@ static void uclamp_fork(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	/*
+	 * We don't need to hold task_rq_lock() when updating p->uclamp_* here
+	 * as the task is still at its early fork stages.
+	 */
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
 
@@ -1412,6 +1503,11 @@ static void uclamp_fork(struct task_struct *p)
 	}
 }
 
+static void uclamp_post_fork(struct task_struct *p)
+{
+	uclamp_update_util_min_rt_default(p);
+}
+
 static void __init init_uclamp_rq(struct rq *rq)
 {
 	enum uclamp_id clamp_id;
@@ -1462,6 +1558,7 @@ static inline int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
+static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -3205,6 +3302,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
+void sched_post_fork(struct task_struct *p)
+{
+	uclamp_post_fork(p);
+}
+
 unsigned long to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
@@ -5724,6 +5826,11 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
+	/*
+	 * This could race with another potential updater, but this is fine
+	 * because it'll correctly read the old or the new value. We don't need
+	 * to guarantee who wins the race as long as it doesn't return garbage.
+	 */
 	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
 	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4aea67d..1b4d2dc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1815,6 +1815,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_util_clamp_min_rt_default",
+		.data		= &sysctl_sched_uclamp_util_min_rt_default,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
