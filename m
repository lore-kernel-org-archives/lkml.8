Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B00206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgC0XaI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:30:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgC0XaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:30:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jHyQJ-0007UJ-Mc; Sat, 28 Mar 2020 00:30:00 +0100
Date:   Sat, 28 Mar 2020 00:29:59 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200327232959.rpylymw2edhtxuwr@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Link: https://lkml.kernel.org/r/20200327074308.GY11705@shao2-debian
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1…v2: - Drop the warning instead of using cmpxchg_local().
	 Tglx pointed out that wq_worker_sleeping() is already invoked
	 with disabled preemption so the race described can not happen.

       - Document that it is required to have preemption disabled within
	 wq_worker_sleeping() to protect ->sleeping (against the race
	 described in v1).

 kernel/sched/core.c | 3 ++-
 kernel/workqueue.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408d..7181ea73e5566 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4112,7 +4112,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
index 4e01c448b4b48..39b968146f5f7 100644
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
-- 
2.26.0

