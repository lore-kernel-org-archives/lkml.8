Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D536C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4320C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgFPMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgFPMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149AC08C5C4;
        Tue, 16 Jun 2020 05:22:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbH-0004fM-Vf; Tue, 16 Jun 2020 14:22:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 04D7E1C0821;
        Tue, 16 Jun 2020 14:21:52 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:51 -0000
From:   "tip-bot2 for Luca Abeni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520134243.19352-4-dietmar.eggemann@arm.com>
References: <20200520134243.19352-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011178.16989.2586072790400652946.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     60ffd5edc5e4fa69622c125c54ef8e7d5d894af8
Gitweb:        https://git.kernel.org/tip/60ffd5edc5e4fa69622c125c54ef8e7d5d894af8
Author:        Luca Abeni <luca.abeni@santannapisa.it>
AuthorDate:    Wed, 20 May 2020 15:42:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:05 +02:00

sched/deadline: Improve admission control for asymmetric CPU capacities

The current SCHED_DEADLINE (DL) admission control ensures that

    sum of reserved CPU bandwidth < x * M

where

    x = /proc/sys/kernel/sched_rt_{runtime,period}_us
    M = # CPUs in root domain.

DL admission control works well for homogeneous systems where the
capacity of all CPUs are equal (1024). I.e. bounded tardiness for DL
and non-starvation of non-DL tasks is guaranteed.

But on heterogeneous systems where capacity of CPUs are different it
could fail by over-allocating CPU time on smaller capacity CPUs.

On an Arm big.LITTLE/DynamIQ system DL tasks can easily starve other
tasks making it unusable.

Fix this by explicitly considering the CPU capacity in the DL admission
test by replacing M with the root domain CPU capacity sum.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200520134243.19352-4-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 30 +++++++++++++++++-------------
 kernel/sched/sched.h    |  6 +++---
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 01f474a..9ebd0a9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2590,11 +2590,12 @@ void sched_dl_do_global(void)
 int sched_dl_overflow(struct task_struct *p, int policy,
 		      const struct sched_attr *attr)
 {
-	struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 	u64 period = attr->sched_period ?: attr->sched_deadline;
 	u64 runtime = attr->sched_runtime;
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
-	int cpus, err = -1;
+	int cpus, err = -1, cpu = task_cpu(p);
+	struct dl_bw *dl_b = dl_bw_of(cpu);
+	unsigned long cap;
 
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return 0;
@@ -2609,15 +2610,17 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	 * allocated bandwidth of the container.
 	 */
 	raw_spin_lock(&dl_b->lock);
-	cpus = dl_bw_cpus(task_cpu(p));
+	cpus = dl_bw_cpus(cpu);
+	cap = dl_bw_capacity(cpu);
+
 	if (dl_policy(policy) && !task_has_dl_policy(p) &&
-	    !__dl_overflow(dl_b, cpus, 0, new_bw)) {
+	    !__dl_overflow(dl_b, cap, 0, new_bw)) {
 		if (hrtimer_active(&p->dl.inactive_timer))
 			__dl_sub(dl_b, p->dl.dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 		err = 0;
 	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
-		   !__dl_overflow(dl_b, cpus, p->dl.dl_bw, new_bw)) {
+		   !__dl_overflow(dl_b, cap, p->dl.dl_bw, new_bw)) {
 		/*
 		 * XXX this is slightly incorrect: when the task
 		 * utilization decreases, we should delay the total
@@ -2772,19 +2775,19 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 #ifdef CONFIG_SMP
 int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed)
 {
+	unsigned long flags, cap;
 	unsigned int dest_cpu;
 	struct dl_bw *dl_b;
 	bool overflow;
-	int cpus, ret;
-	unsigned long flags;
+	int ret;
 
 	dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(dest_cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cpus = dl_bw_cpus(dest_cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, p->dl.dl_bw);
+	cap = dl_bw_capacity(dest_cpu);
+	overflow = __dl_overflow(dl_b, cap, 0, p->dl.dl_bw);
 	if (overflow) {
 		ret = -EBUSY;
 	} else {
@@ -2794,6 +2797,8 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 		 * We will free resources in the source root_domain
 		 * later on (see set_cpus_allowed_dl()).
 		 */
+		int cpus = dl_bw_cpus(dest_cpu);
+
 		__dl_add(dl_b, p->dl.dl_bw, cpus);
 		ret = 0;
 	}
@@ -2826,16 +2831,15 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 
 bool dl_cpu_busy(unsigned int cpu)
 {
-	unsigned long flags;
+	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow;
-	int cpus;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cpus = dl_bw_cpus(cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, 0);
+	cap = dl_bw_capacity(cpu);
+	overflow = __dl_overflow(dl_b, cap, 0, 0);
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 	rcu_read_unlock_sched();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8d5d068..91b250f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -310,11 +310,11 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 	__dl_update(dl_b, -((s32)tsk_bw / cpus));
 }
 
-static inline
-bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
+static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
+				 u64 old_bw, u64 new_bw)
 {
 	return dl_b->bw != -1 &&
-	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
+	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
 }
 
 extern void init_dl_bw(struct dl_bw *dl_b);
