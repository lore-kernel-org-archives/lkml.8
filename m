Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC712C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B0206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgBLJhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:37:16 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:57316 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbgBLJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:37:00 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 502EFD01DD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:58 +0000 (GMT)
Received: (qmail 25269 invoked from network); 12 Feb 2020 09:36:58 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 12 Feb 2020 09:36:58 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 04/11] sched/numa: Trace when no candidate CPU was found on the preferred node
Date:   Wed, 12 Feb 2020 09:36:47 +0000
Message-Id: <20200212093654.4816-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched:sched_stick_numa is meant to fire when a task is unable to migrate
to the preferred node. The case where no candidate CPU could be found is
not traced which is an important gap. The tracepoint is not fired when
the task is not allowed to run on any CPU on the preferred node or the
task is already running on the target CPU but neither are interesting
corner cases.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6b1d70e0b83..4ab18fba5b82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1848,8 +1848,10 @@ static int task_numa_migrate(struct task_struct *p)
 	}
 
 	/* No better CPU than the current one was found. */
-	if (env.best_cpu == -1)
+	if (env.best_cpu == -1) {
+		trace_sched_stick_numa(p, env.src_cpu, -1);
 		return -EAGAIN;
+	}
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
-- 
2.16.4

