Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D4D20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBXJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:54:40 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:49069 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgBXJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:54:39 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 05B74148004
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:54:38 +0000 (GMT)
Received: (qmail 27537 invoked from network); 24 Feb 2020 09:54:37 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:54:37 -0000
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
Subject: [PATCH 12/13] sched/numa: Bias swapping tasks based on their preferred node
Date:   Mon, 24 Feb 2020 09:52:22 +0000
Message-Id: <20200224095223.13361-13-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When swapping tasks for NUMA balancing, it is preferred that tasks move
to or remain on their preferred node. When considering an imbalance,
encourage tasks to move to their preferred node and discourage tasks from
moving away from their preferred node.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee14cd9815ec..63f22b1a5f0b 100644
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
@@ -1779,12 +1788,34 @@ static void task_numa_compare(struct task_numa_env *env,
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
 		goto assign;
 	}
 
+	/*
+	 * Prefer swapping with a task moving to its preferred node over a
+	 * task that is not.
+	 */
+	if (env->best_task && cur->numa_preferred_nid == env->src_nid &&
+	    env->best_task->numa_preferred_nid != env->src_nid) {
+		goto assign;
+	}
+
 	/*
 	 * If the NUMA importance is less than SMALLIMP,
 	 * task migration might only result in ping pong
-- 
2.16.4

