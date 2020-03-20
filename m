Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228642072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCTPNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:13:20 -0400
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:35665 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbgCTPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:13:19 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id DB2BCFA750
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:13:17 +0000 (GMT)
Received: (qmail 29841 invoked from network); 20 Mar 2020 15:13:17 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 20 Mar 2020 15:13:17 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/fair: Track efficiency of task recent_used_cpu
Date:   Fri, 20 Mar 2020 15:12:43 +0000
Message-Id: <20200320151245.21152-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200320151245.21152-1-mgorman@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply tracks the efficiency of p->recent_used_cpu. The hit rate of
this matters as it can avoid a domain search. Similarly, the miss rate
matters because each miss is a penalty to the fast path. MMTests uses
this to generate additional metrics

SIS Recent Used Hit: A recent CPU was eligible and used. Each hit is
	a domain search avoided.

SIS Recent Used Miss: A recent CPU was eligible but unavailable. Each
	time this is hit, there was a penalty to the fast path before
	a domain search happened.

SIS Recent Success Rate: A percentage of the number of hits versus
	the total attempts to use the recent CPU.

SIS Recent Attempts: The total number of times the recent CPU was examined.
	A high number of Recent Attempts with a low Success Rate implies
	the fast path is being punished severely. This could have been
	presented as a weighting of hits and misses but calculating an
	appropriate weight for misses is problematic.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 21 ++++++++++++---------
 kernel/sched/sched.h |  2 ++
 kernel/sched/stats.c |  7 ++++---
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7af6e8a12f40..d58f333bb739 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -665,6 +665,8 @@ do {									\
 		P(sis_domain_search);
 		P(sis_scanned);
 		P(sis_failed);
+		P(sis_recent_hit);
+		P(sis_recent_miss);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d32a81ece08..7f4356c520be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6212,15 +6212,18 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
-		return recent_used_cpu;
+	    cpus_share_cache(recent_used_cpu, target)) {
+		if ((available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+		    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
+			/*
+			 * Replace recent_used_cpu with prev as it is a potential
+			 * candidate for the next wake:
+			 */
+			p->recent_used_cpu = prev;
+			schedstat_inc(this_rq()->sis_recent_hit);
+			return recent_used_cpu;
+		}
+		schedstat_inc(this_rq()->sis_recent_miss);
 	}
 
 	sd = rcu_dereference(per_cpu(sd_llc, target));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ff23cd92d25f..3cb7de0b11d7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1014,6 +1014,8 @@ struct rq {
 	unsigned int		sis_domain_search;
 	unsigned int		sis_scanned;
 	unsigned int		sis_failed;
+	unsigned int		sis_recent_hit;
+	unsigned int		sis_recent_miss;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 390bfcc3842c..402fab75aa14 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 16
+#define SCHEDSTAT_VERSION 17
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,14 +30,15 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
 		    rq->sis_search, rq->sis_domain_search,
-		    rq->sis_scanned, rq->sis_failed);
+		    rq->sis_scanned, rq->sis_failed,
+		    rq->sis_recent_hit, rq->sis_recent_miss);
 
 		seq_printf(seq, "\n");
 
-- 
2.16.4

