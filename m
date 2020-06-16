Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A223DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8100720C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgFPMW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgFPMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C8C08C5C4;
        Tue, 16 Jun 2020 05:22:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbH-0004f8-V9; Tue, 16 Jun 2020 14:22:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF04D1C04CC;
        Tue, 16 Jun 2020 14:21:51 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:51 -0000
From:   "tip-bot2 for Luca Abeni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Make DL capacity-aware
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520134243.19352-5-dietmar.eggemann@arm.com>
References: <20200520134243.19352-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011148.16989.3880543915105728495.tip-bot2@tip-bot2>
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

Commit-ID:     b4118988fdcb4554ea6687dd8ff68bcab690b8ea
Gitweb:        https://git.kernel.org/tip/b4118988fdcb4554ea6687dd8ff68bcab690b8ea
Author:        Luca Abeni <luca.abeni@santannapisa.it>
AuthorDate:    Wed, 20 May 2020 15:42:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:05 +02:00

sched/deadline: Make DL capacity-aware

The current SCHED_DEADLINE (DL) scheduler uses a global EDF scheduling
algorithm w/o considering CPU capacity or task utilization.
This works well on homogeneous systems where DL tasks are guaranteed
to have a bounded tardiness but presents issues on heterogeneous
systems.

A DL task can migrate to a CPU which does not have enough CPU capacity
to correctly serve the task (e.g. a task w/ 70ms runtime and 100ms
period on a CPU w/ 512 capacity).

Add the DL fitness function dl_task_fits_capacity() for DL admission
control on heterogeneous systems. A task fits onto a CPU if:

    CPU original capacity / 1024 >= task runtime / task deadline

Use this function on heterogeneous systems to try to find a CPU which
meets this criterion during task wakeup, push and offline migration.

On homogeneous systems the original behavior of the DL admission
control should be retained.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200520134243.19352-5-dietmar.eggemann@arm.com
---
 kernel/sched/cpudeadline.c | 14 +++++++++++++-
 kernel/sched/deadline.c    | 18 ++++++++++++++----
 kernel/sched/sched.h       | 15 +++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 5cc4012..8630f2a 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -121,7 +121,19 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 	if (later_mask &&
 	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
-		return 1;
+		int cpu;
+
+		if (!static_branch_unlikely(&sched_asym_cpucapacity))
+			return 1;
+
+		/* Ensure the capacity of the CPUs fits the task. */
+		for_each_cpu(cpu, later_mask) {
+			if (!dl_task_fits_capacity(p, cpu))
+				cpumask_clear_cpu(cpu, later_mask);
+		}
+
+		if (!cpumask_empty(later_mask))
+			return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ebd0a9..84e84ba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1643,6 +1643,7 @@ static int
 select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	struct task_struct *curr;
+	bool select_rq;
 	struct rq *rq;
 
 	if (sd_flag != SD_BALANCE_WAKE)
@@ -1662,10 +1663,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	if (unlikely(dl_task(curr)) &&
-	    (curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
-	    (p->nr_cpus_allowed > 1)) {
+	select_rq = unlikely(dl_task(curr)) &&
+		    (curr->nr_cpus_allowed < 2 ||
+		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		    p->nr_cpus_allowed > 1;
+
+	/*
+	 * Take the capacity of the CPU into account to
+	 * ensure it fits the requirement of the task.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		select_rq |= !dl_task_fits_capacity(p, cpu);
+
+	if (select_rq) {
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91b250f..3368876 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -317,6 +317,21 @@ static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
 	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
 }
 
+/*
+ * Verify the fitness of task @p to run on @cpu taking into account the
+ * CPU original capacity and the runtime/deadline ratio of the task.
+ *
+ * The function will return true if the CPU original capacity of the
+ * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
+ * task and false otherwise.
+ */
+static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned long cap = arch_scale_cpu_capacity(cpu);
+
+	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
+}
+
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
