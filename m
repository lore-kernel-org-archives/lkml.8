Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F2C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01BB20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBXJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:54:30 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:56442 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbgBXJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:54:30 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id D9FBDCAC97
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:54:27 +0000 (GMT)
Received: (qmail 26794 invoked from network); 24 Feb 2020 09:54:27 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:54:27 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 11/13] sched/numa: Find an alternative idle CPU if the CPU is part of an active NUMA balance
Date:   Mon, 24 Feb 2020 09:52:21 +0000
Message-Id: <20200224095223.13361-12-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple tasks can attempt to select and idle CPU but fail because
numa_migrate_on is already set and the migration fails. Instead of failing,
scan for an alternative idle CPU. select_idle_sibling is not used because
it requires IRQs to be disabled and it ignores numa_migrate_on allowing
multiple tasks to stack. This scan may still fail if there are idle
candidate CPUs due to races but if this occurs, it's best that a task
stay on an available CPU that move to a contended one.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e285aa0cdd4f..ee14cd9815ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1624,15 +1624,34 @@ static void task_numa_assign(struct task_numa_env *env,
 {
 	struct rq *rq = cpu_rq(env->dst_cpu);
 
-	/* Bail out if run-queue part of active NUMA balance. */
-	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1))
+	/* Check if run-queue part of active NUMA balance. */
+	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1)) {
+		int cpu;
+		int start = env->dst_cpu;
+
+		/* Find alternative idle CPU. */
+		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start) {
+			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
+			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
+				continue;
+			}
+
+			env->dst_cpu = cpu;
+			rq = cpu_rq(env->dst_cpu);
+			if (!xchg(&rq->numa_migrate_on, 1))
+				goto assign;
+		}
+
+		/* Failed to find an alternative idle CPU */
 		return;
+	}
 
+assign:
 	/*
 	 * Clear previous best_cpu/rq numa-migrate flag, since task now
 	 * found a better CPU to move/swap.
 	 */
-	if (env->best_cpu != -1) {
+	if (env->best_cpu != -1 && env->best_cpu != env->dst_cpu) {
 		rq = cpu_rq(env->best_cpu);
 		WRITE_ONCE(rq->numa_migrate_on, 0);
 	}
@@ -1806,21 +1825,6 @@ static void task_numa_compare(struct task_numa_env *env,
 			cpu = env->best_cpu;
 		}
 
-		/*
-		 * Use select_idle_sibling if the previously found idle CPU is
-		 * not idle any more.
-		 */
-		if (!idle_cpu(cpu)) {
-			/*
-			 * select_idle_siblings() uses an per-CPU cpumask that
-			 * can be used from IRQ context.
-			 */
-			local_irq_disable();
-			cpu = select_idle_sibling(env->p, env->src_cpu,
-						   env->dst_cpu);
-			local_irq_enable();
-		}
-
 		env->dst_cpu = cpu;
 	}
 
-- 
2.16.4

