Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122E02086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgCBN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:27:50 -0500
Received: from foss.arm.com ([217.140.110.172]:60918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgCBN1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:27:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51F111FB;
        Mon,  2 Mar 2020 05:27:45 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BEED3F534;
        Mon,  2 Mar 2020 05:27:44 -0800 (PST)
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
Subject: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better CPU
Date:   Mon,  2 Mar 2020 13:27:21 +0000
Message-Id: <20200302132721.8353-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302132721.8353-1-qais.yousef@arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task was running on unfit CPU we could ignore migrating if the
priority level of the new fitting CPU is the *same* as the unfit one.

Add an extra check to select_task_rq_rt() to allow the push in case:

	* p->prio == new_cpu.highest_priority
	* task_fits(p, new_cpu)

Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ce230bec6847..8aaa442e4867 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1474,20 +1474,35 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
 
-		/*
-		 * Bail out if we were forcing a migration to find a better
-		 * fitting CPU but our search failed.
-		 */
-		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
-			goto out_unlock;
+		if (target != -1) {
+			bool fit_target = rt_task_fits_capacity(p, target);
 
-		/*
-		 * Don't bother moving it if the destination CPU is
-		 * not running a lower priority task.
-		 */
-		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
-			cpu = target;
+			/*
+			 * Bail out if we were forcing a migration to find a
+			 * better fitting CPU but our search failed.
+			 */
+			if (!test && !fit_target)
+				goto out_unlock;
+
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
+				if (fit_target)
+					cpu = target;
+			}
+		}
 	}
 
 out_unlock:
-- 
2.17.1

