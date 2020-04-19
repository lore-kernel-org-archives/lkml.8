Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ACBC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B5F21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDSQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:31:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:29984 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDSQbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:31:16 -0400
IronPort-SDR: oRsgdWIAy4YWEcP3lt72WuQqdjyD6Vm9MNtqu7OK4Cvb3FxffouP9sZjeNH8E127DJxLS+s9HV
 dZHlutXmqHuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 09:31:15 -0700
IronPort-SDR: bHGpUcAnYkmMxIV0bsv7fC9rfz5ZJxxfgwH56Ay2uQRpgmFLmnaW5J77OTpYciMWGIX13o18dF
 vaYgHtcDOx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,403,1580803200"; 
   d="scan'208";a="456144353"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2020 09:31:13 -0700
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
Subject: [PATCH 1/2] sched: Make newidle_balance() static again
Date:   Mon, 20 Apr 2020 00:31:42 +0800
Message-Id: <6a614d7e5487d4e4c16eeddbf95dda94a776d7c0.1587309963.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587309963.git.yu.c.chen@intel.com>
References: <cover.1587309963.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After Commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change'
pattern race"), there is no need to expose newidle_balance() as it
is only used within fair.c file. Change this function back to static again.

No functional change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c  | 4 +++-
 kernel/sched/sched.h | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..da7a505c28a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,8 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 int sched_thermal_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
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
2.20.1

