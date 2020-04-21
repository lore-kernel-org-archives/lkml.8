Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7372206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgDUKuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:50:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:22649 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUKuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:08 -0400
IronPort-SDR: M8ZTgGBgXTFksXJ5Ea/enRGo4QNXyQHcv7+aWlOoYnzGpmU8OXoQ7yxfQxWW08ZUaHBrlqgR1d
 52RMrSCAmK0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 03:50:08 -0700
IronPort-SDR: EpLoADLNLOZJ34MWRJ0XztU/gOyHxH7gYbBvA5VTY4oREl1mxYoiWzawQA9lv8QxEAZIROBSNE
 C5HNJSP7Zsqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="247146022"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2020 03:50:05 -0700
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
Subject: [PATCH 1/2][v3] sched: Make newidle_balance() static again
Date:   Tue, 21 Apr 2020 18:50:34 +0800
Message-Id: <83cd3030b031ca5d646cd5e225be10e7a0fdd8f5.1587464698.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587464698.git.yu.c.chen@intel.com>
References: <cover.1587464698.git.yu.c.chen@intel.com>
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
v3: Unchanged.
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

