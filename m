Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F5BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C652084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgDUKuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:50:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:22658 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgDUKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:17 -0400
IronPort-SDR: Xmb6aiz7XMAis+pfDYhD1qcJwwlz1UKwY3pOH/ewBfmV6AWGVE3ZEhW4lJLgTvEqgPVFXJgl4X
 W5mdD/ptvGHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 03:50:17 -0700
IronPort-SDR: 1/7uHZJs+ksuoPYOpbP3jEsnt+fB9q2u4GE7YI0HccD9ma8xvDqB98w96Lefg3XXDrj5rXutF8
 w+FVaCZlqTSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="247146052"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2020 03:50:14 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][v3] sched: Extract the task putting code from pick_next_task()
Date:   Tue, 21 Apr 2020 18:50:43 +0800
Message-Id: <5a99860cf66293db58a397d6248bcb2eee326776.1587464698.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587464698.git.yu.c.chen@intel.com>
References: <cover.1587464698.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new function put_prev_task_balance() to do the balance
when necessary, and then put previous task back to the run queue.
This function is extracted from pick_next_task() to prepare for
future usage by other type of task picking logic.

No functional change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3: According to Steven's suggestion, fix the comment
    to change put_next_task() to put_prev_task()

    Rename finish_prev_task() to put_prev_task_balance()
    as this reflects what we do before picking a new task. 

    Per Valentin's suggestion, put the declaration of
    struct sched_class within the ifdef, given it isn't
    used outside of it.
---
 kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..c9d7880f6bf2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	schedstat_inc(this_rq()->sched_count);
 }
 
+static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
+				  struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	const struct sched_class *class;
+	/*
+	 * We must do the balancing pass before put_prev_task(), such
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
+	put_prev_task_balance(rq, prev, rf);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
-- 
2.17.1

