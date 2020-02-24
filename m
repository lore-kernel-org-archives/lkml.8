Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253F42084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBXPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:21:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBXPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:21:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX4-0005pz-S8; Mon, 24 Feb 2020 16:20:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6AF691C213D;
        Mon, 24 Feb 2020 16:20:30 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:30 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Bias swapping tasks based on their
 preferred node
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
In-Reply-To: <20200224095223.13361-13-mgorman@techsingularity.net>
References: <20200224095223.13361-13-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763019.28353.11731318686961855268.tip-bot2@tip-bot2>
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

Commit-ID:     88cca72c9673e631b63eca7a1dba4a9722a3f414
Gitweb:        https://git.kernel.org/tip/88cca72c9673e631b63eca7a1dba4a9722a3f414
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:22 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:39 +01:00

sched/numa: Bias swapping tasks based on their preferred node

When swapping tasks for NUMA balancing, it is preferred that tasks move
to or remain on their preferred node. When considering an imbalance,
encourage tasks to move to their preferred node and discourage tasks from
moving away from their preferred node.

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
Link: https://lore.kernel.org/r/20200224095223.13361-13-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 050c1b1..8c1ac01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1741,18 +1741,27 @@ static void task_numa_compare(struct task_numa_env *env,
 			goto unlock;
 	}
 
+	/* Skip this swap candidate if cannot move to the source cpu. */
+	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
+		goto unlock;
+
+	/*
+	 * Skip this swap candidate if it is not moving to its preferred
+	 * node and the best task is.
+	 */
+	if (env->best_task &&
+	    env->best_task->numa_preferred_nid == env->src_nid &&
+	    cur->numa_preferred_nid != env->src_nid) {
+		goto unlock;
+	}
+
 	/*
 	 * "imp" is the fault differential for the source task between the
 	 * source and destination node. Calculate the total differential for
 	 * the source task and potential destination task. The more negative
 	 * the value is, the more remote accesses that would be expected to
 	 * be incurred if the tasks were swapped.
-	 */
-	/* Skip this swap candidate if cannot move to the source cpu */
-	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
-		goto unlock;
-
-	/*
+	 *
 	 * If dst and source tasks are in the same NUMA group, or not
 	 * in any group then look only at task weights.
 	 */
@@ -1779,6 +1788,19 @@ static void task_numa_compare(struct task_numa_env *env,
 			       task_weight(cur, env->dst_nid, dist);
 	}
 
+	/* Discourage picking a task already on its preferred node */
+	if (cur->numa_preferred_nid == env->dst_nid)
+		imp -= imp / 16;
+
+	/*
+	 * Encourage picking a task that moves to its preferred node.
+	 * This potentially makes imp larger than it's maximum of
+	 * 1998 (see SMALLIMP and task_weight for why) but in this
+	 * case, it does not matter.
+	 */
+	if (cur->numa_preferred_nid == env->src_nid)
+		imp += imp / 8;
+
 	if (maymove && moveimp > imp && moveimp > env->best_imp) {
 		imp = moveimp;
 		cur = NULL;
@@ -1786,6 +1808,15 @@ static void task_numa_compare(struct task_numa_env *env,
 	}
 
 	/*
+	 * Prefer swapping with a task moving to its preferred node over a
+	 * task that is not.
+	 */
+	if (env->best_task && cur->numa_preferred_nid == env->src_nid &&
+	    env->best_task->numa_preferred_nid != env->src_nid) {
+		goto assign;
+	}
+
+	/*
 	 * If the NUMA importance is less than SMALLIMP,
 	 * task migration might only result in ping pong
 	 * of tasks and also hurt performance due to cache
