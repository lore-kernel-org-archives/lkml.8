Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC99C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7E920787
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502114AbgDNMhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:37:10 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:14029 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502096AbgDNMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:37:01 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 572BB261975;
        Tue, 14 Apr 2020 20:36:51 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Wang Qing <wangqing@vivo.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [V3 3/3] sched:rename task_running() and to task_running_on_rq
Date:   Tue, 14 Apr 2020 20:36:32 +0800
Message-Id: <1586867796-5768-4-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586867796-5768-1-git-send-email-wangqing@vivo.com>
References: <1586867796-5768-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVKTExLS0tLT05MTE1ITFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Kjo6DDgxAgpMHRkRMC9L
        FQMaFD1VSlVKTkNNQ01MQ0pKQ0tJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUxCSEM3Bg++
X-HM-Tid: 0a7178b135589375kuws572bb261975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task_running() should be renamed to task_running_on_rq()
like the naming of task_running_on_cpu(), this is what it
originally mean.

This solves the confusing naming problem.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/core.c     | 14 +++++++-------
 kernel/sched/deadline.c |  6 +++---
 kernel/sched/fair.c     |  2 +-
 kernel/sched/rt.c       |  6 +++---
 kernel/sched/sched.h    |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2694ba..7ba1840 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1672,7 +1672,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
+	if (task_running_on_rq(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
 		task_rq_unlock(rq, p, &rf);
@@ -1905,11 +1905,11 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 *
 		 * NOTE! Since we don't hold any locks, it's not
 		 * even sure that "rq" stays as the right runqueue!
-		 * But we don't care, since "task_running()" will
-		 * return false if the runqueue has changed and p
-		 * is actually now running somewhere else!
+		 * But we don't care, since "task_running_on_rq()"
+		 * will return false if the runqueue has changed
+		 * and p is actually now running somewhere else!
 		 */
-		while (task_running(rq, p)) {
+		while (task_running_on_rq(rq, p)) {
 			if (match_state && unlikely(p->state != match_state))
 				return 0;
 			cpu_relax();
@@ -1922,7 +1922,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 */
 		rq = task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
-		running = task_running(rq, p);
+		running = task_running_on_rq(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
 		if (!match_state || p->state == match_state)
@@ -5745,7 +5745,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || p->state)
+	if (task_running_on_rq(p_rq, p) || p->state)
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p, preempt);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f5..c04cecd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1838,7 +1838,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_running_on_rq(rq, p) &&
 	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 	return 0;
@@ -1990,7 +1990,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
-				     task_running(rq, task) ||
+				     task_running_on_rq(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
@@ -2217,7 +2217,7 @@ static void pull_dl_task(struct rq *this_rq)
  */
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
-	if (!task_running(rq, p) &&
+	if (!task_running_on_rq(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ea3ddd..6cc0b5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7503,7 +7503,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_running(env->src_rq, p)) {
+	if (task_running_on_rq(env->src_rq, p)) {
 		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
 		return 0;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index df11d88..ea647d9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1655,7 +1655,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_running_on_rq(rq, p) &&
 	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 
@@ -1810,7 +1810,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
-				     task_running(rq, task) ||
+				     task_running_on_rq(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
 
@@ -2218,7 +2218,7 @@ static void pull_rt_task(struct rq *this_rq)
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
-	bool need_to_push = !task_running(rq, p) &&
+	bool need_to_push = !task_running_on_rq(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f616bf..e5b6538 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1659,7 +1659,7 @@ static inline int task_current(struct rq *rq, struct task_struct *p)
 	return rq->curr == p;
 }
 
-static inline int task_running(struct rq *rq, struct task_struct *p)
+static inline int task_running_on_rq(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
 	return p->on_cpu;
-- 
2.7.4

