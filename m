Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F3C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AD92192A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgEASWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730595AbgEASWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF1C061A0E;
        Fri,  1 May 2020 11:22:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIb-0003YH-Uc; Fri, 01 May 2020 20:22:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FE811C0085;
        Fri,  1 May 2020 20:22:09 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:09 -0000
From:   "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make newidle_balance() static again
Cc:     kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <83cd3030b031ca5d646cd5e225be10e7a0fdd8f5.1587464698.git.yu.c.chen@intel.com>
References: <83cd3030b031ca5d646cd5e225be10e7a0fdd8f5.1587464698.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Message-ID: <158835732955.8414.10159311341010885250.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d91cecc156620ec75d94c55369509c807c3d07e6
Gitweb:        https://git.kernel.org/tip/d91cecc156620ec75d94c55369509c807c3d07e6
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Tue, 21 Apr 2020 18:50:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:40 +02:00

sched: Make newidle_balance() static again

After Commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change'
pattern race"), there is no need to expose newidle_balance() as it
is only used within fair.c file. Change this function back to static again.

No functional change.

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/83cd3030b031ca5d646cd5e225be10e7a0fdd8f5.1587464698.git.yu.c.chen@intel.com
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 4 ----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b959c0..c0216ef 100644
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
@@ -10414,7 +10416,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7198683..978c6fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1503,14 +1503,10 @@ static inline void unregister_sched_domain_sysctl(void)
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
