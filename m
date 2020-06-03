Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED09C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC8F206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFCID3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:03:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgFCIDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A86F1045;
        Wed,  3 Jun 2020 01:03:23 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5766B3F52E;
        Wed,  3 Jun 2020 01:03:22 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched/core: Remove redundant 'preempt' param from sched_class->yield_to_task()
Date:   Wed,  3 Jun 2020 10:03:02 +0200
Message-Id: <20200603080304.16548-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080304.16548-1-dietmar.eggemann@arm.com>
References: <20200603080304.16548-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6d1cafd8b56e ("sched: Resched proper CPU on yield_to()") moved
the code to resched the CPU from yield_to_task_fair() to yield_to()
making the preempt parameter in sched_class->yield_to_task()
unnecessary. Remove it. No other sched_class implements yield_to_task().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e457d4ed1c..687b16047f92 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5812,7 +5812,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	if (task_running(p_rq, p) || p->state)
 		goto out_unlock;
 
-	yielded = curr->sched_class->yield_to_task(rq, p, preempt);
+	yielded = curr->sched_class->yield_to_task(rq, p);
 	if (yielded) {
 		schedstat_inc(rq->yld_count);
 		/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dda9b194d225..5c4a559d0dae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7158,7 +7158,7 @@ static void yield_task_fair(struct rq *rq)
 	set_skip_buddy(se);
 }
 
-static bool yield_to_task_fair(struct rq *rq, struct task_struct *p, bool preempt)
+static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4b32cff0dcbe..12a0d0c7c164 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1752,7 +1752,7 @@ struct sched_class {
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
-	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
+	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
-- 
2.17.1

