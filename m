Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEDC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF4206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgDHMUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgDHMUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gv-000650-QU; Wed, 08 Apr 2020 14:20:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A12C1C047B;
        Wed,  8 Apr 2020 14:20:25 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:25 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] workqueue: Remove the warning in wq_worker_sleeping()
Cc:     kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327074308.GY11705@shao2-debian>
References: <20200327074308.GY11705@shao2-debian>
MIME-Version: 1.0
Message-ID: <158634842513.28353.14029698174140162537.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     62849a9612924a655c67cf6962920544aa5c20db
Gitweb:        https://git.kernel.org/tip/62849a9612924a655c67cf6962920544aa5c20db
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 28 Mar 2020 00:29:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:20 +02:00

workqueue: Remove the warning in wq_worker_sleeping()

The kernel test robot triggered a warning with the following race:
   task-ctx A                            interrupt-ctx B
 worker
  -> process_one_work()
    -> work_item()
      -> schedule();
         -> sched_submit_work()
           -> wq_worker_sleeping()
             -> ->sleeping = 1
               atomic_dec_and_test(nr_running)
         __schedule();                *interrupt*
                                       async_page_fault()
                                       -> local_irq_enable();
                                       -> schedule();
                                          -> sched_submit_work()
                                            -> wq_worker_sleeping()
                                               -> if (WARN_ON(->sleeping)) return
                                          -> __schedule()
                                            ->  sched_update_worker()
                                              -> wq_worker_running()
                                                 -> atomic_inc(nr_running);
                                                 -> ->sleeping = 0;

      ->  sched_update_worker()
        -> wq_worker_running()
          if (!->sleeping) return

In this context the warning is pointless everything is fine.
An interrupt before wq_worker_sleeping() will perform the ->sleeping
assignment (0 -> 1 > 0) twice.
An interrupt after wq_worker_sleeping() will trigger the warning and
nr_running will be decremented (by A) and incremented once (only by B, A
will skip it). This is the case until the ->sleeping is zeroed again in
wq_worker_running().

Remove the WARN statement because this condition may happen. Document
that preemption around wq_worker_sleeping() needs to be disabled to
protect ->sleeping and not just as an optimisation.

Fixes: 6d25be5782e48 ("sched/core, workqueues: Distangle worker accounting from rq lock")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Link: https://lkml.kernel.org/r/20200327074308.GY11705@shao2-debian
---
 kernel/sched/core.c | 3 ++-
 kernel/workqueue.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6b329b..c3d12e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4120,7 +4120,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * it wants to wake up a task to maintain concurrency.
 	 * As this function is called inside the schedule() context,
 	 * we disable preemption to avoid it calling schedule() again
-	 * in the possible wakeup of a kworker.
+	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
+	 * requires it.
 	 */
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		preempt_disable();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3816a18..891ccad 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -858,7 +858,8 @@ void wq_worker_running(struct task_struct *task)
  * @task: task going to sleep
  *
  * This function is called from schedule() when a busy worker is
- * going to sleep.
+ * going to sleep. Preemption needs to be disabled to protect ->sleeping
+ * assignment.
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
@@ -875,7 +876,8 @@ void wq_worker_sleeping(struct task_struct *task)
 
 	pool = worker->pool;
 
-	if (WARN_ON_ONCE(worker->sleeping))
+	/* Return if preempted before wq_worker_running() was reached */
+	if (worker->sleeping)
 		return;
 
 	worker->sleeping = 1;
