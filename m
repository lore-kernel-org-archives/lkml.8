Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B18C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D782087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgAQKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgAQKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYd-0005Tl-SH; Fri, 17 Jan 2020 11:08:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3DE931C19D5;
        Fri, 17 Jan 2020 11:08:43 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:43 -0000
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Load balance aggressively for SCHED_IDLE CPUs
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Ce485827eb8fe7db0943d6f3f6e0f5a4a70272781=2E15784?=
 =?utf-8?q?71925=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Ce485827eb8fe7db0943d6f3f6e0f5a4a70272781=2E157847?=
 =?utf-8?q?1925=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <157925572307.396.139037000271001461.tip-bot2@tip-bot2>
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

Commit-ID:     323af6deaf70f204880caf94678350802682e0dc
Gitweb:        https://git.kernel.org/tip/323af6deaf70f204880caf94678350802682e0dc
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Wed, 08 Jan 2020 13:57:04 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:20 +01:00

sched/fair: Load balance aggressively for SCHED_IDLE CPUs

The fair scheduler performs periodic load balance on every CPU to check
if it can pull some tasks from other busy CPUs. The duration of this
periodic load balance is set to sd->balance_interval for the idle CPUs
and is calculated by multiplying the sd->balance_interval with the
sd->busy_factor (set to 32 by default) for the busy CPUs. The
multiplication is done for busy CPUs to avoid doing load balance too
often and rather spend more time executing actual task. While that is
the right thing to do for the CPUs busy with SCHED_OTHER or SCHED_BATCH
tasks, it may not be the optimal thing for CPUs running only SCHED_IDLE
tasks.

With the recent enhancements in the fair scheduler around SCHED_IDLE
CPUs, we now prefer to enqueue a newly-woken task to a SCHED_IDLE
CPU instead of other busy or idle CPUs. The same reasoning should be
applied to the load balancer as well to make it migrate tasks more
aggressively to a SCHED_IDLE CPU, as that will reduce the scheduling
latency of the migrated (SCHED_OTHER) tasks.

This patch makes minimal changes to the fair scheduler to do the next
load balance soon after the last non SCHED_IDLE task is dequeued from a
runqueue, i.e. making the CPU SCHED_IDLE. Also the sd->busy_factor is
ignored while calculating the balance_interval for such CPUs. This is
done to avoid delaying the periodic load balance by few hundred
milliseconds for SCHED_IDLE CPUs.

This is tested on ARM64 Hikey620 platform (octa-core) with the help of
rt-app and it is verified, using kernel traces, that the newly
SCHED_IDLE CPU does load balancing shortly after it becomes SCHED_IDLE
and pulls tasks from other busy CPUs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/e485827eb8fe7db0943d6f3f6e0f5a4a70272781.1578471925.git.viresh.kumar@linaro.org
---
 kernel/sched/fair.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35c1057..d292883 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5210,6 +5210,18 @@ static inline void update_overutilized_status(struct rq *rq)
 static inline void update_overutilized_status(struct rq *rq) { }
 #endif
 
+/* Runqueue only has SCHED_IDLE tasks enqueued */
+static int sched_idle_rq(struct rq *rq)
+{
+	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+			rq->nr_running);
+}
+
+static int sched_idle_cpu(int cpu)
+{
+	return sched_idle_rq(cpu_rq(cpu));
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5324,6 +5336,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	bool was_sched_idle = sched_idle_rq(rq);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5370,6 +5383,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	/* balance early to pull high priority tasks */
+	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
+		rq->next_balance = jiffies;
+
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -5392,15 +5409,6 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-/* CPU only has SCHED_IDLE tasks enqueued */
-static int sched_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
-			rq->nr_running);
-}
-
 static unsigned long cpu_load(struct rq *rq)
 {
 	return cfs_rq_load_avg(&rq->cfs);
@@ -9546,6 +9554,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
 	int continue_balancing = 1;
 	int cpu = rq->cpu;
+	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
 	/* Earliest time when we have to do rebalance again */
@@ -9582,7 +9591,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 			break;
 		}
 
-		interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
+		interval = get_sd_balance_interval(sd, busy);
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
@@ -9598,9 +9607,10 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 				 * state even if we migrated tasks. Update it.
 				 */
 				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
+				busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
 			}
 			sd->last_balance = jiffies;
-			interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
+			interval = get_sd_balance_interval(sd, busy);
 		}
 		if (need_serialize)
 			spin_unlock(&balancing);
