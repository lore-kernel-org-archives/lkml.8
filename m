Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220EC5ACBF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B645A2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgCKSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:17:04 -0400
Received: from foss.arm.com ([217.140.110.172]:53240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgCKSRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:17:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D067FA;
        Wed, 11 Mar 2020 11:17:02 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 057813F6CF;
        Wed, 11 Mar 2020 11:17:00 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 6/9] sched: Kill select_task_rq()'s sd_flag parameter
Date:   Wed, 11 Mar 2020 18:15:58 +0000
Message-Id: <20200311181601.18314-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only select_task_rq_fair() uses that parameter to do an actual domain
search, other classes only care about what kind of wakeup is happening
(fork, exec, or "regular") and thus just translate the flag into a wakeup
type.

WF_TTWU and WF_EXEC have just been added, use these along with WF_FORK to
encode the wakeup types we care about. This cleans up the API a
bit, but adds an extra conversion layer within select_task_rq_fair().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c      | 10 +++++-----
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      | 18 +++++++++++++++---
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 ++--
 kernel/sched/sched.h     |  2 +-
 kernel/sched/stop_task.c |  2 +-
 7 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e6f38073ab3..f9c1ea734061 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2094,12 +2094,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
-int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
+int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
 	if (p->nr_cpus_allowed > 1)
-		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
+		cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
 
@@ -2618,7 +2618,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
-	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
+	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
@@ -2951,7 +2951,7 @@ void wake_up_new_task(struct task_struct *p)
 	 * as we're not fully set-up yet.
 	 */
 	p->recent_used_cpu = task_cpu(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
+	__set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -3492,7 +3492,7 @@ void sched_exec(void)
 	int dest_cpu;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), SD_BALANCE_EXEC, 0);
+	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
 	if (dest_cpu == smp_processor_id())
 		goto unlock;
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f875cb9..53216fffb871 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1599,12 +1599,12 @@ static void yield_task_dl(struct rq *rq)
 static int find_later_rq(struct task_struct *task);
 
 static int
-select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
 
-	if (sd_flag != SD_BALANCE_WAKE)
+	if (!(flags & WF_TTWU))
 		goto out;
 
 	rq = cpu_rq(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f8eb950fbefd..920c4e2ce0d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6575,7 +6575,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
+ * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
  *
  * Balances load by selecting the idlest CPU in the idlest group, or under
@@ -6586,13 +6586,25 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * preempt must be disabled.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 {
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int sd_flag;
+
+	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
+	case WF_TTWU:
+		sd_flag = SD_BALANCE_WAKE;
+		break;
+	case WF_FORK:
+		sd_flag = SD_BALANCE_FORK;
+		break;
+	default:
+		sd_flag = SD_BALANCE_EXEC;
+	}
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b743bf38f08f..e9c6a27f0647 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -367,7 +367,7 @@ void cpu_startup_entry(enum cpuhp_state state)
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_idle(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_idle(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* IDLE tasks as never migrated */
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55a4a5042292..d2f0931c7d62 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1426,14 +1426,14 @@ static void yield_task_rt(struct rq *rq)
 static int find_lowest_rq(struct task_struct *task);
 
 static int
-select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
 	bool test;
 
 	/* For anything but wake ups, just return the task_cpu */
-	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
+	if (!(flags & (WF_TTWU | WF_FORK)))
 		goto out;
 
 	rq = cpu_rq(cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0d1ab04622d0..ad2106245e12 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1737,7 +1737,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
+	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4c9e9975684f..4f061ddf8470 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_stop(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
-- 
2.24.0

