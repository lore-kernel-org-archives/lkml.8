Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A95C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4999120768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437165AbgDNPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:15:53 -0400
Received: from foss.arm.com ([217.140.110.172]:57714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406985AbgDNPGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88D53113E;
        Tue, 14 Apr 2020 08:06:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73C593F73D;
        Tue, 14 Apr 2020 08:06:50 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched/rt: Better distribute tasks that wakeup simultaneously
Date:   Tue, 14 Apr 2020 16:05:56 +0100
Message-Id: <20200414150556.10920-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414150556.10920-1-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multiple RT tasks of the same priority wakeup simultaneously,
select_task_rt_rt() will always return the same CPU for all tasks
because find_lowest_rq() always returns the first cpu in the
lowest_mask.

Use cpumask_any_and() to randomize the selection, hence better
distribute the tasks.

This helps alleviate the thundering herd issue described here when
multiple tasks of the same priority wake up simultaneously:

	https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Yury Norov <yury.norov@gmail.com>
CC: Paul Turner <pjt@google.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Josh Don <joshdon@google.com>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/sched/rt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index df11d88c9895..16c7eede370a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1750,8 +1750,8 @@ static int find_lowest_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and(lowest_mask,
+						   sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
-- 
2.17.1

