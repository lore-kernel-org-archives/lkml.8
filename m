Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F73C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8E206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBWSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:40:13 -0500
Received: from foss.arm.com ([217.140.110.172]:50484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:40:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F49FEC;
        Sun, 23 Feb 2020 10:40:11 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FFA53F703;
        Sun, 23 Feb 2020 10:40:10 -0800 (PST)
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
Subject: [PATCH v2 2/6] sched/rt: Re-instate old behavior in select_task_rq_rt
Date:   Sun, 23 Feb 2020 18:39:57 +0000
Message-Id: <20200223184001.14248-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223184001.14248-1-qais.yousef@arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RT Capacity Aware support was added, the logic in select_task_rq_rt
was modified to force a search for a fitting CPU if the task currently
doesn't run on one.

But if the search failed, and the search was only triggered to fulfill
the fitness request; we could end up selecting a new CPU unnecessarily.

Fix this and re-instate the original behavior by ensuring we bail out
in that case.

This behavior change only affected asymmetric systems that are using
util_clamp to implement capacity aware. None asymmetric systems weren't
affected.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
LINK: https://lore.kernel.org/lkml/20200218041620.GD28029@codeaurora.org/
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4043abe45459..2c3fae637cef 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1474,6 +1474,13 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
 
+		/*
+		 * Bail out if we were forcing a migration to find a better
+		 * fitting CPU but our search failed.
+		 */
+		if (!test && !rt_task_fits_capacity(p, target))
+			goto out_unlock;
+
 		/*
 		 * Don't bother moving it if the destination CPU is
 		 * not running a lower priority task.
@@ -1482,6 +1489,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
 			cpu = target;
 	}
+
+out_unlock:
 	rcu_read_unlock();
 
 out:
-- 
2.17.1

