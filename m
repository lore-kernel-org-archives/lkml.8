Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32EC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA742083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0Rx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:53:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Rx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:53:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jHtB0-0003Kn-Qs; Fri, 27 Mar 2020 18:53:50 +0100
Date:   Fri, 27 Mar 2020 18:53:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Don't double assign worker->sleeping
Message-ID: <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327074308.GY11705@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot triggered a warning with the following race:
   task-ctx                              interrupt-ctx
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

However, if the interrupt occurs in wq_worker_sleeping() between reading and
setting `sleeping' i.e.

|        if (WARN_ON_ONCE(worker->sleeping))
|                return;
 *interrupt*
|        worker->sleeping = 1;

then pool->nr_running will be decremented twice in wq_worker_sleeping()
but it will be incremented only once in wq_worker_running().

Replace the assignment of `sleeping' with a cmpxchg_local() to ensure
that there is no double assignment of the variable. The variable is only
accessed from the local CPU. Remove the WARN statement because this
condition can be valid.

An alternative would be to move `->sleeping' to `->flags' as a new bit
but this would require to acquire the pool->lock in wq_worker_running().

Fixes: 6d25be5782e48 ("sched/core, workqueues: Distangle worker accounting from rq lock")
Link: https://lkml.kernel.org/r/20200327074308.GY11705@shao2-debian
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4e01c448b4b48..dc477a2a3ce30 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -846,11 +846,10 @@ void wq_worker_running(struct task_struct *task)
 {
 	struct worker *worker = kthread_data(task);
 
-	if (!worker->sleeping)
+	if (cmpxchg_local(&worker->sleeping, 1, 0) == 0)
 		return;
 	if (!(worker->flags & WORKER_NOT_RUNNING))
 		atomic_inc(&worker->pool->nr_running);
-	worker->sleeping = 0;
 }
 
 /**
@@ -875,10 +874,9 @@ void wq_worker_sleeping(struct task_struct *task)
 
 	pool = worker->pool;
 
-	if (WARN_ON_ONCE(worker->sleeping))
+	if (cmpxchg_local(&worker->sleeping, 0, 1) == 1)
 		return;
 
-	worker->sleeping = 1;
 	spin_lock_irq(&pool->lock);
 
 	/*
-- 
2.26.0

