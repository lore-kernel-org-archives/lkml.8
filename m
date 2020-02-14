Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A702187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgBNQkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:40:08 -0500
Received: from foss.arm.com ([217.140.110.172]:39292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405845AbgBNQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:40:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8C1113E;
        Fri, 14 Feb 2020 08:40:02 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30CC23F6CF;
        Fri, 14 Feb 2020 08:40:01 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 3/3] sched/rt: fix pushing unfit tasks to a better CPU
Date:   Fri, 14 Feb 2020 16:39:49 +0000
Message-Id: <20200214163949.27850-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214163949.27850-1-qais.yousef@arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task was running on unfit CPU we could ignore migrating if the
priority level of the new fitting CPU is the *same* as the unfit one.

Add an extra check to select_task_rq_rt() to allow the push in case:

	* old_cpu.highest_priority == new_cpu.highest_priority
	* task_fits(p, new_cpu)

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

I was seeing some delays in migrating a task to a big CPU sometimes although it
was free, and I think this fixes it.

TBH, I fail to see how the check of

	p->prio < cpu_rq(target)->rt.highest_prio.curr

is necessary as find_lowest_rq() surely implies the above condition by
definition?

Unless we're fighting a race condition here where the rt_rq priority has
changed between the time we selected the lowest_rq and taking the decision to
migrate, then this makes sense.


 kernel/sched/rt.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0c8bac134d3a..5ea235f2cfe8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1430,7 +1430,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
-	bool test;
+	bool test, fit;
 
 	/* For anything but wake ups, just return the task_cpu */
 	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
@@ -1471,16 +1471,32 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	       unlikely(rt_task(curr)) &&
 	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
 
-	if (test || !rt_task_fits_capacity(p, cpu)) {
+	fit = rt_task_fits_capacity(p, cpu);
+
+	if (test || !fit) {
 		int target = find_lowest_rq(p);
 
-		/*
-		 * Don't bother moving it if the destination CPU is
-		 * not running a lower priority task.
-		 */
-		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
-			cpu = target;
+		if (target != -1) {
+			/*
+			 * Don't bother moving it if the destination CPU is
+			 * not running a lower priority task.
+			 */
+			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
+
+				cpu = target;
+
+			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
+
+				/*
+				 * If the priority is the same and the new CPU
+				 * is a better fit, then move, otherwise don't
+				 * bother here either.
+				 */
+				fit = rt_task_fits_capacity(p, target);
+				if (fit)
+					cpu = target;
+			}
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

