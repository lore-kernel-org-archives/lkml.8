Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A90220714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgBKLdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:33:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBKLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:33:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Tmm-00065g-DP; Tue, 11 Feb 2020 12:33:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EABD31C1F86;
        Tue, 11 Feb 2020 12:32:59 +0100 (CET)
Date:   Tue, 11 Feb 2020 11:32:59 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Allow a per-CPU kthread waking a task
 to stack on the same CPU, to fix XFS performance regression
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200128154006.GD3466@techsingularity.net>
References: <20200128154006.GD3466@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158142077965.411.14340592040967006216.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     52262ee567ad14c9606be25f3caddcefa3c514e4
Gitweb:        https://git.kernel.org/tip/52262ee567ad14c9606be25f3caddcefa3c514e4
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 28 Jan 2020 15:40:06 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Feb 2020 11:24:37 +01:00

sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression

The following XFS commit:

  8ab39f11d974 ("xfs: prevent CIL push holdoff in log recovery")

changed the logic from using bound workqueues to using unbound
workqueues. Functionally this makes sense but it was observed at the
time that the dbench performance dropped quite a lot and CPU migrations
were increased.

The current pattern of the task migration is straight-forward. With XFS,
an IO issuer delegates work to xlog_cil_push_work ()on an unbound kworker.
This runs on a nearby CPU and on completion, dbench wakes up on its old CPU
as it is still idle and no migration occurs. dbench then queues the real
IO on the blk_mq_requeue_work() work item which runs on a bound kworker
which is forced to run on the same CPU as dbench. When IO completes,
the bound kworker wakes dbench but as the kworker is a bound but,
real task, the CPU is not considered idle and dbench gets migrated by
select_idle_sibling() to a new CPU. dbench may ping-pong between two CPUs
for a while but ultimately it starts a round-robin of all CPUs sharing
the same LLC. High-frequency migration on each IO completion has poor
performance overall. It has negative implications both in commication
costs and power management. mpstat confirmed that at low thread counts
that all CPUs sharing an LLC has low level of activity.

Note that even if the CIL patch was reverted, there still would
be migrations but the impact is less noticeable. It turns out that
individually the scheduler, XFS, blk-mq and workqueues all made sensible
decisions but in combination, the overall effect was sub-optimal.

This patch special cases the IO issue/completion pattern and allows
a bound kworker waker and a task wakee to stack on the same CPU if
there is a strong chance they are directly related. The expectation
is that the kworker is likely going back to sleep shortly. This is not
guaranteed as the IO could be queued asynchronously but there is a very
strong relationship between the task and kworker in this case that would
justify stacking on the same CPU instead of migrating. There should be
few concerns about kworker starvation given that the special casing is
only when the kworker is the waker.

DBench on XFS
MMTests config: io-dbench4-async modified to run on a fresh XFS filesystem

UMA machine with 8 cores sharing LLC
                          5.5.0-rc7              5.5.0-rc7
                  tipsched-20200124           kworkerstack
Amean     1        22.63 (   0.00%)       20.54 *   9.23%*
Amean     2        25.56 (   0.00%)       23.40 *   8.44%*
Amean     4        28.63 (   0.00%)       27.85 *   2.70%*
Amean     8        37.66 (   0.00%)       37.68 (  -0.05%)
Amean     64      469.47 (   0.00%)      468.26 (   0.26%)
Stddev    1         1.00 (   0.00%)        0.72 (  28.12%)
Stddev    2         1.62 (   0.00%)        1.97 ( -21.54%)
Stddev    4         2.53 (   0.00%)        3.58 ( -41.19%)
Stddev    8         5.30 (   0.00%)        5.20 (   1.92%)
Stddev    64       86.36 (   0.00%)       94.53 (  -9.46%)

NUMA machine, 48 CPUs total, 24 CPUs share cache
                           5.5.0-rc7              5.5.0-rc7
                   tipsched-20200124      kworkerstack-v1r2
Amean     1         58.69 (   0.00%)       30.21 *  48.53%*
Amean     2         60.90 (   0.00%)       35.29 *  42.05%*
Amean     4         66.77 (   0.00%)       46.55 *  30.28%*
Amean     8         81.41 (   0.00%)       68.46 *  15.91%*
Amean     16       113.29 (   0.00%)      107.79 *   4.85%*
Amean     32       199.10 (   0.00%)      198.22 *   0.44%*
Amean     64       478.99 (   0.00%)      477.06 *   0.40%*
Amean     128     1345.26 (   0.00%)     1372.64 *  -2.04%*
Stddev    1          2.64 (   0.00%)        4.17 ( -58.08%)
Stddev    2          4.35 (   0.00%)        5.38 ( -23.73%)
Stddev    4          6.77 (   0.00%)        6.56 (   3.00%)
Stddev    8         11.61 (   0.00%)       10.91 (   6.04%)
Stddev    16        18.63 (   0.00%)       19.19 (  -3.01%)
Stddev    32        38.71 (   0.00%)       38.30 (   1.06%)
Stddev    64       100.28 (   0.00%)       91.24 (   9.02%)
Stddev    128      186.87 (   0.00%)      160.34 (  14.20%)

Dbench has been modified to report the time to complete a single "load
file". This is a more meaningful metric for dbench that a throughput
metric as the benchmark makes many different system calls that are not
throughput-related

Patch shows a 9.23% and 48.53% reduction in the time to process a load
file with the difference partially explained by the number of CPUs sharing
a LLC. In a separate run, task migrations were almost eliminated by the
patch for low client counts. In case people have issue with the metric
used for the benchmark, this is a comparison of the throughputs as
reported by dbench on the NUMA machine.

dbench4 Throughput (misleading but traditional)
                           5.5.0-rc7              5.5.0-rc7
                   tipsched-20200124      kworkerstack-v1r2
Hmean     1        321.41 (   0.00%)      617.82 *  92.22%*
Hmean     2        622.87 (   0.00%)     1066.80 *  71.27%*
Hmean     4       1134.56 (   0.00%)     1623.74 *  43.12%*
Hmean     8       1869.96 (   0.00%)     2212.67 *  18.33%*
Hmean     16      2673.11 (   0.00%)     2806.13 *   4.98%*
Hmean     32      3032.74 (   0.00%)     3039.54 (   0.22%)
Hmean     64      2514.25 (   0.00%)     2498.96 *  -0.61%*
Hmean     128     1778.49 (   0.00%)     1746.05 *  -1.82%*

Note that this is somewhat specific to XFS and ext4 shows no performance
difference as it does not rely on kworkers in the same way. No major
problem was observed running other workloads on different machines although
not all tests have completed yet.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200128154006.GD3466@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 11 -----------
 kernel/sched/fair.c  | 14 ++++++++++++++
 kernel/sched/sched.h | 13 +++++++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 89e54f3..1a9983d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1447,17 +1447,6 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-static inline bool is_per_cpu_kthread(struct task_struct *p)
-{
-	if (!(p->flags & PF_KTHREAD))
-		return false;
-
-	if (p->nr_cpus_allowed != 1)
-		return false;
-
-	return true;
-}
-
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25dffc0..94c3b84 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5912,6 +5912,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
+	/*
+	 * Allow a per-cpu kthread to stack with the wakee if the
+	 * kworker thread and the tasks previous CPUs are the same.
+	 * The assumption is that the wakee queued work for the
+	 * per-cpu kthread that is now complete and the wakeup is
+	 * essentially a sync wakeup. An obvious example of this
+	 * pattern is IO completions.
+	 */
+	if (is_per_cpu_kthread(current) &&
+	    prev == smp_processor_id() &&
+	    this_rq()->nr_running <= 1) {
+		return prev;
+	}
+
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a88dc8..5876e6b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2479,3 +2479,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+#ifdef CONFIG_SMP
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+#endif
