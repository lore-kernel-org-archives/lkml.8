Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB0C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F77420775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgDTPBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:01:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:55407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgDTPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:01:31 -0400
IronPort-SDR: hKZq6191hYOPDL53Wcdnqcic0SYBmSpwyfScQNJmUMhGYTHzO2Dfua+7FL14sG0EJDRl+sCY2c
 4LuX6+uObRlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 08:01:19 -0700
IronPort-SDR: Tj7Hqlbcg61uLPQx9hd2dSt9aKWYf8+4wqpfAZNcR6z3nl613pvu2zBCGHWKnlTIM9yttZ3y3T
 9ddJKJ6bvEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="455725041"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 08:01:15 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][v2] sched: Make newidle_balance() static again
Date:   Mon, 20 Apr 2020 23:01:43 +0800
Message-Id: <34d7c9496b77c928fcbe6085213115bd4d48d5a2.1587393807.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587393807.git.yu.c.chen@intel.com>
References: <cover.1587393807.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After Commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change'
pattern race"), there is no need to expose newidle_balance() as it
is only used within fair.c file. Change this function back to static again.

No functional change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Rename the remaining idle_balance() to newidle_balance()
    to fix an compile error when CONFIG_SMP is not set.
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 4 ----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..cca5c9b7b5ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3873,6 +3873,8 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -4054,7 +4056,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
-static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
+static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
 }
@@ -10425,7 +10427,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..be83f88495fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1504,14 +1504,10 @@ static inline void unregister_sched_domain_sysctl(void)
 }
 #endif
 
-extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 #else
 
 static inline void sched_ttwu_pending(void) { }
 
-static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
-
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
-- 
2.17.1

