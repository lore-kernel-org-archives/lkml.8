Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627EC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2687217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405965AbgBNQkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:40:05 -0500
Received: from foss.arm.com ([217.140.110.172]:39270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405859AbgBNQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:40:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C81106F;
        Fri, 14 Feb 2020 08:40:00 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 869E73F68E;
        Fri, 14 Feb 2020 08:39:59 -0800 (PST)
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
Subject: [PATCH 2/3] sched/rt: allow pulling unfitting task
Date:   Fri, 14 Feb 2020 16:39:48 +0000
Message-Id: <20200214163949.27850-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214163949.27850-1-qais.yousef@arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When implemented RT Capacity Awareness; the logic was done such that if
a task was running on a fitting CPU, then it was sticky and we would try
our best to keep it there.

But as Steve suggested, to adhere to the strict priority rules of RT
class; allow pulling an RT task to unfitting CPU to ensure it gets a
chance to run ASAP. When doing so, mark the queue as overloaded to give
the system a chance to push the task to a better fitting CPU when a
chance arises.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4043abe45459..0c8bac134d3a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1646,10 +1646,20 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
-	    rt_task_fits_capacity(p, cpu))
+	if (!task_running(rq, p) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+
+		/*
+		 * If the CPU doesn't fit the task, allow pulling but mark the
+		 * rq as overloaded so that we can push it again to a more
+		 * suitable CPU ASAP.
+		 */
+		if (!rt_task_fits_capacity(p, cpu)) {
+			rt_set_overload(rq);
+			rq->rt.overloaded = 1;
+		}
+
 		return 1;
+	}
 
 	return 0;
 }
-- 
2.17.1

