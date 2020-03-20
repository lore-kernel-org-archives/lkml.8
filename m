Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A64BC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD7B2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCTPNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:13:11 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:46831 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgCTPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:13:10 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 6B7CD1B75
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:13:07 +0000 (GMT)
Received: (qmail 29015 invoked from network); 20 Mar 2020 15:13:07 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 20 Mar 2020 15:13:07 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/fair: Track efficiency of select_idle_sibling
Date:   Fri, 20 Mar 2020 15:12:42 +0000
Message-Id: <20200320151245.21152-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200320151245.21152-1-mgorman@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling is an important path that finds a nearby idle CPU on
wakeup. As it is examining other CPUs state, it can be expensive in terms
of cache usage. This patch tracks the search efficiency if schedstats
are enabled. In general, this is only useful for kernel developers but
schedstats are typically disabled by default so it is convenient for
development and mostly free otherwise.

The series can be done without this patch but the stats were used to
generate a number of useful metrics in mmtest to analyse what was
going on.

SIS Search: Number of calls to select_idle_sibling

SIS Domain Search: Number of times the domain was searched because the
	fast path failed.

SIS Scanned: Generally the number of runqueues scanned but the fast
	path counts as 1 regardless of the values for target, prev
	and recent.

SIS Domain Scanned: Number of runqueues scanned during a search of the
	LLC domain.

SIS Failures: Number of SIS calls that failed to find an idle CPU

SIS Search Efficiency: A ratio expressed as a percentage of runqueues
	scanned versus idle CPUs found. A 100% efficiency indicates that
	the target, prev or recent CPU of a task was idle at wakeup. The
	lower the efficiency, the more runqueues were scanned before an
	idle CPU was found.

SIS Domain Search Efficiency: Similar, except only for the slower SIS
	patch.

SIS Fast Success Rate: Percentage of SIS that used target, prev or
	recent CPUs.

SIS Success rate: Percentage of scans that found an idle CPU.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  4 ++++
 kernel/sched/fair.c  | 14 ++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 kernel/sched/stats.c |  8 +++++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8331bc04aea2..7af6e8a12f40 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -661,6 +661,10 @@ do {									\
 		P(sched_goidle);
 		P(ttwu_count);
 		P(ttwu_local);
+		P(sis_search);
+		P(sis_domain_search);
+		P(sis_scanned);
+		P(sis_failed);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dea8554ead0..9d32a81ece08 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5999,6 +5999,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			schedstat_inc(this_rq()->sis_scanned);
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				break;
@@ -6029,6 +6030,7 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -6094,6 +6096,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!--nr)
 			return -1;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -6150,6 +6153,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	schedstat_inc(this_rq()->sis_search);
+
+	/*
+	 * Checking if prev, target and recent is treated as one scan. A
+	 * perfect hit on one of those is considered 100% efficiency.
+	 * Further scanning impairs efficiency.
+	 */
+	schedstat_inc(this_rq()->sis_scanned);
+
 	/*
 	 * For asymmetric CPU capacity systems, our domain of interest is
 	 * sd_asym_cpucapacity rather than sd_llc.
@@ -6215,6 +6227,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	schedstat_inc(this_rq()->sis_domain_search);
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
@@ -6227,6 +6240,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	schedstat_inc(this_rq()->sis_failed);
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e173fad0425..ff23cd92d25f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1008,6 +1008,12 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	/* select_idle_sibling stats */
+	unsigned int		sis_search;
+	unsigned int		sis_domain_search;
+	unsigned int		sis_scanned;
+	unsigned int		sis_failed;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..390bfcc3842c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,12 +30,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->sis_search, rq->sis_domain_search,
+		    rq->sis_scanned, rq->sis_failed);
 
 		seq_printf(seq, "\n");
 
-- 
2.16.4

