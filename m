Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F640C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgCBN1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:27:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgCBN1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:27:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17C5111D4;
        Mon,  2 Mar 2020 05:27:44 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28E13F534;
        Mon,  2 Mar 2020 05:27:42 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v3 5/6] sched/rt: Remove unnecessary push for unfit tasks
Date:   Mon,  2 Mar 2020 13:27:20 +0000
Message-Id: <20200302132721.8353-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302132721.8353-1-qais.yousef@arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In task_woken_rt() and switched_to_rto() we try trigger push-pull if the
task is unfit.

But the logic is found lacking because if the task was the only one
running on the CPU, then rt_rq is not in overloaded state and won't
trigger a push.

The necessity of this logic was under a debate as well, a summary of
the discussion can be found in the following thread.

https://lore.kernel.org/lkml/20200226160247.iqvdakiqbakk2llz@e107158-lin.cambridge.arm.com/

Remove the logic for now until a better approach is agreed upon.

Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e79a23ad4a93..ce230bec6847 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2225,7 +2225,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			    (rq->curr->nr_cpus_allowed < 2 ||
 			     rq->curr->prio <= p->prio);
 
-	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
+	if (need_to_push)
 		push_rt_tasks(rq);
 }
 
@@ -2297,10 +2297,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p) && rq->curr != p) {
 #ifdef CONFIG_SMP
-		bool need_to_push = rq->rt.overloaded ||
-				    !rt_task_fits_capacity(p, cpu_of(rq));
-
-		if (p->nr_cpus_allowed > 1 && need_to_push)
+		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
-- 
2.17.1

