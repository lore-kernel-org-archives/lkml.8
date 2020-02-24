Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D0C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBXPVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:21:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50380 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBXPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:21:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX5-0005q1-2o; Mon, 24 Feb 2020 16:20:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B65971C213E;
        Mon, 24 Feb 2020 16:20:30 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:30 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Find an alternative idle CPU if the CPU
 is part of an active NUMA balance
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-12-mgorman@techsingularity.net>
References: <20200224095223.13361-12-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763050.28353.15038756479892807074.tip-bot2@tip-bot2>
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

Commit-ID:     5fb52dd93a2fe9a738f730de9da108bd1f6c30d0
Gitweb:        https://git.kernel.org/tip/5fb52dd93a2fe9a738f730de9da108bd1f6c30d0
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:21 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:39 +01:00

sched/numa: Find an alternative idle CPU if the CPU is part of an active NUMA balance

Multiple tasks can attempt to select and idle CPU but fail because
numa_migrate_on is already set and the migration fails. Instead of failing,
scan for an alternative idle CPU. select_idle_sibling is not used because
it requires IRQs to be disabled and it ignores numa_migrate_on allowing
multiple tasks to stack. This scan may still fail if there are idle
candidate CPUs due to races but if this occurs, it's best that a task
stay on an available CPU that move to a contended one.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-12-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2da21f4..050c1b1 100644
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
@@ -1806,21 +1825,6 @@ assign:
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
 
