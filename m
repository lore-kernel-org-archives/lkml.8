Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8652C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBA220780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGBAw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:52:58 -0400
Received: from mail5.windriver.com ([192.103.53.11]:57022 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgGBAw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:52:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0620p0UZ025910
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 1 Jul 2020 17:51:21 -0700
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 17:51:06 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Scott Wood <swood@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched: nohz: drop calc_load_nohz_remote with mismatched ifdefs
Date:   Wed, 1 Jul 2020 20:49:44 -0400
Message-ID: <1593650984-58400-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
we got calc_load_nohz_remote(rq) as a one-line wrapper function around
calc_load_nohz_fold(rq) and with sched_tick_remote() as the only user.

However, we build the sched_tick_remote only for NO_HZ_FULL but the
wrapper inside a block for NO_HZ_COMMON.  So users that parallel the
defconfig with COMMON=y and FULL=n get an unused stub built in.

  (gdb) p calc_load_nohz_remote
  $227 = {void (struct rq *)} 0xffffffff8110a5c0 <calc_load_nohz_remote>
  (gdb) p sched_tick_remote
  No symbol "sched_tick_remote" in current context.

Rather than fix the ifdeffery, we note that calc_load_nohz_remote was
most likely introduced to be self-documenting of the "remote" aspect.

And yet, inside sched_tick_remote, it is fairly clear that all the code
there are acting on behalf of the remote cpu and the corresponding
remote rq without them each adding specific remote named wrappers.

Hence it seems to make sense to just dispense with the stub entirely
and simplify the code code in the process.

Ensure at the same time, that nohz.h is aware of what a rq is - since
that implicit header dependency was introduced by the same commit.

Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
Cc: Scott Wood <swood@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/sched/nohz.h |  5 +++--
 kernel/sched/core.c        |  2 +-
 kernel/sched/loadavg.c     | 11 +----------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..58459fdf6758 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -6,6 +6,8 @@
  * This is the interface between the scheduler and nohz/dynticks:
  */
 
+struct rq;
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
@@ -15,11 +17,10 @@ static inline void nohz_balance_enter_idle(int cpu) { }
 
 #ifdef CONFIG_NO_HZ_COMMON
 void calc_load_nohz_start(void);
-void calc_load_nohz_remote(struct rq *rq);
 void calc_load_nohz_stop(void);
+void calc_load_nohz_fold(struct rq *rq);
 #else
 static inline void calc_load_nohz_start(void) { }
-static inline void calc_load_nohz_remote(struct rq *rq) { }
 static inline void calc_load_nohz_stop(void) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f518af52d0fb..23d3b2282c09 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3763,7 +3763,7 @@ static void sched_tick_remote(struct work_struct *work)
 	}
 	curr->sched_class->task_tick(rq, curr, 0);
 
-	calc_load_nohz_remote(rq);
+	calc_load_nohz_fold(rq);
 out_unlock:
 	rq_unlock_irq(rq, &rf);
 out_requeue:
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index d2a655643a02..5bab95e1bde4 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -231,7 +231,7 @@ static inline int calc_load_read_idx(void)
 	return calc_load_idx & 1;
 }
 
-static void calc_load_nohz_fold(struct rq *rq)
+void calc_load_nohz_fold(struct rq *rq)
 {
 	long delta;
 
@@ -252,15 +252,6 @@ void calc_load_nohz_start(void)
 	calc_load_nohz_fold(this_rq());
 }
 
-/*
- * Keep track of the load for NOHZ_FULL, must be called between
- * calc_load_nohz_{start,stop}().
- */
-void calc_load_nohz_remote(struct rq *rq)
-{
-	calc_load_nohz_fold(rq);
-}
-
 void calc_load_nohz_stop(void)
 {
 	struct rq *this_rq = this_rq();
-- 
1.9.1

