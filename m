Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB41C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20E2467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBNISi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:18:38 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:50981 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgBNISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:18:38 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 9205DFAE61
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:18:36 +0000 (GMT)
Received: (qmail 20015 invoked from network); 14 Feb 2020 08:18:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Feb 2020 08:18:36 -0000
Date:   Fri, 14 Feb 2020 08:18:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/12] sched/numa: Stop an exhastive search if a reasonable
 swap candidate or idle CPU is found
Message-ID: <20200214081834.GG3466@techsingularity.net>
References: <20200214081324.26859-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214081324.26859-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
index d046fa97b7ef..4870eed91857 100644
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
+		return true;
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

