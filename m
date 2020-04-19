Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C8C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2850F21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDSQb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:31:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:3277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDSQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:31:24 -0400
IronPort-SDR: XEQUNEY4/X5fhQpEavB4/tFf0S/fcNuZyzihEFSQUo3CcuLsNM7kTvUW+XdNT+Nf0GyHe8EkF6
 p6lbima7fXOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 09:31:25 -0700
IronPort-SDR: P5GKhzuQDEE9oDkOOUaJtOW5MvRW5zM8rT9Zmsjn/ySd/dr2MuUrPWyllhMvwAv2MlRexzA2C+
 9pMyShu4DrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,403,1580803200"; 
   d="scan'208";a="456144376"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2020 09:31:22 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2] sched: Extract the task putting code from pick_next_task()
Date:   Mon, 20 Apr 2020 00:31:52 +0800
Message-Id: <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587309963.git.yu.c.chen@intel.com>
References: <cover.1587309963.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new function finish_prev_task() to do the balance
when necessary, and then put previous task back to the run queue.
This function is extracted from pick_next_task() to prepare for
future usage by other type of task picking logic.

No functional change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..bf59a5cf030c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	schedstat_inc(this_rq()->sched_count);
 }
 
+static void finish_prev_task(struct rq *rq, struct task_struct *prev,
+			     struct rq_flags *rf)
+{
+	const struct sched_class *class;
+#ifdef CONFIG_SMP
+	/*
+	 * We must do the balancing pass before put_next_task(), such
+	 * that when we release the rq->lock the task is in the same
+	 * state as before we took rq->lock.
+	 *
+	 * We can terminate the balance pass as soon as we know there is
+	 * a runnable task of @class priority or higher.
+	 */
+	for_class_range(class, prev->sched_class, &idle_sched_class) {
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+
+	put_prev_task(rq, prev);
+}
+
 /*
  * Pick up the highest-prio task:
  */
@@ -3937,22 +3959,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 restart:
-#ifdef CONFIG_SMP
-	/*
-	 * We must do the balancing pass before put_next_task(), such
-	 * that when we release the rq->lock the task is in the same
-	 * state as before we took rq->lock.
-	 *
-	 * We can terminate the balance pass as soon as we know there is
-	 * a runnable task of @class priority or higher.
-	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
-		if (class->balance(rq, prev, rf))
-			break;
-	}
-#endif
-
-	put_prev_task(rq, prev);
+	finish_prev_task(rq, prev, rf);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
-- 
2.20.1

