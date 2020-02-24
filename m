Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78422C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590B42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBXPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:21:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBXPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX4-0005py-P3; Mon, 24 Feb 2020 16:20:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0CC001C213A;
        Mon, 24 Feb 2020 16:20:30 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:29 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Stop an exhastive search if a
 reasonable swap candidate or idle CPU is found
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
In-Reply-To: <20200224095223.13361-14-mgorman@techsingularity.net>
References: <20200224095223.13361-14-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255762967.28353.14025771290351307714.tip-bot2@tip-bot2>
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

Commit-ID:     a0f03b617c3b2644d3d47bf7d9e60aed01bd5b10
Gitweb:        https://git.kernel.org/tip/a0f03b617c3b2644d3d47bf7d9e60aed01bd5b10
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:23 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:40 +01:00

sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found

When domains are imbalanced or overloaded a search of all CPUs on the
target domain is searched and compared with task_numa_compare. In some
circumstances, a candidate is found that is an obvious win.

 o A task can move to an idle CPU and an idle CPU is found
 o A swap candidate is found that would move to its preferred domain

This patch terminates the search when either condition is met.

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
Link: https://lore.kernel.org/r/20200224095223.13361-14-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c1ac01..fcc9686 100644
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
@@ -1860,8 +1863,27 @@ assign:
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
@@ -1916,7 +1938,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp, maymove);
+		if (task_numa_compare(env, taskimp, groupimp, maymove))
+			break;
 	}
 }
 
