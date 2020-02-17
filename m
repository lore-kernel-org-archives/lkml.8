Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A57C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgBQKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:46:31 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:45383 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbgBQKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:46:31 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 4957CFAA95
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:46:29 +0000 (GMT)
Received: (qmail 490 invoked from network); 17 Feb 2020 10:46:29 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 17 Feb 2020 10:46:28 -0000
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
Subject: [PATCH 13/13] sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found
Date:   Mon, 17 Feb 2020 10:44:02 +0000
Message-Id: <20200217104402.11643-14-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200217104402.11643-1-mgorman@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When domains are imbalanced or overloaded a search of all CPUs on the
target domain is searched and compared with task_numa_compare. In some
circumstances, a candidate is found that is an obvious win.

o A task can move to an idle CPU and an idle CPU is found
o A swap candidate is found that would move to its preferred domain

This patch terminates the search when either condition is met.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 935baf529f10..a1d5760f7985 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1707,7 +1707,7 @@ static bool load_too_imbalanced(long src_load, long dst_load,
  * into account that it might be best if task running on the dst_cpu should
  * be exchanged with the source task
  */
-static void task_numa_compare(struct task_numa_env *env,
+static bool task_numa_compare(struct task_numa_env *env,
 			      long taskimp, long groupimp, bool maymove)
 {
 	struct numa_group *cur_ng, *p_ng = deref_curr_numa_group(env->p);
@@ -1718,9 +1718,10 @@ static void task_numa_compare(struct task_numa_env *env,
 	int dist = env->dist;
 	long moveimp = imp;
 	long load;
+	bool stopsearch = false;
 
 	if (READ_ONCE(dst_rq->numa_migrate_on))
-		return;
+		return false;
 
 	rcu_read_lock();
 	cur = rcu_dereference(dst_rq->curr);
@@ -1731,8 +1732,10 @@ static void task_numa_compare(struct task_numa_env *env,
 	 * Because we have preemption enabled we can get migrated around and
 	 * end try selecting ourselves (current == env->p) as a swap candidate.
 	 */
-	if (cur == env->p)
+	if (cur == env->p) {
+		stopsearch = true;
 		goto unlock;
+	}
 
 	if (!cur) {
 		if (maymove && moveimp >= env->best_imp)
@@ -1860,8 +1863,27 @@ static void task_numa_compare(struct task_numa_env *env,
 	}
 
 	task_numa_assign(env, cur, imp);
+
+	/*
+	 * If a move to idle is allowed because there is capacity or load
+	 * balance improves then stop the search. While a better swap
+	 * candidate may exist, a search is not free.
+	 */
+	if (maymove && !cur && env->best_cpu >= 0 && idle_cpu(env->best_cpu))
+		stopsearch = true;
+
+	/*
+	 * If a swap candidate must be identified and the current best task
+	 * moves its preferred node then stop the search.
+	 */
+	if (!maymove && env->best_task &&
+	    env->best_task->numa_preferred_nid == env->src_nid) {
+		stopsearch = true;
+	}
 unlock:
 	rcu_read_unlock();
+
+	return stopsearch;
 }
 
 static void task_numa_find_cpu(struct task_numa_env *env,
@@ -1911,7 +1933,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp, maymove);
+		if (task_numa_compare(env, taskimp, groupimp, maymove))
+			break;
 	}
 }
 
-- 
2.16.4

