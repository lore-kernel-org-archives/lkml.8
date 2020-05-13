Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758E22054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgEMQ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389665AbgEMQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:28:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:28:20 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jYuF0-0000ME-Bq; Wed, 13 May 2020 18:28:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] workqueue: Convert the pool::lock and wq_mayday_lock to raw_spinlock_t
Date:   Wed, 13 May 2020 18:27:32 +0200
Message-Id: <20200513162732.977489-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513162732.977489-1-bigeasy@linutronix.de>
References: <20200513162732.977489-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue code has it's internal spinlocks (pool::lock), which
are acquired on most workqueue operations. These spinlocks are
converted to 'sleeping' spinlocks on a RT-kernel.

Workqueue functions can be invoked from contexts which are truly atomic
even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
contexts is forbidden.

The pool::lock hold times are bound and the code sections are
relatively short, which allows to convert pool::lock and as a
consequence wq_mayday_lock to raw spinlocks which are truly spinning
locks even on a PREEMPT_RT kernel.

With the previous conversion of the manager waitqueue to a simple
waitqueue workqueues are now fully RT compliant.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 174 ++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c2ead0577f02b..950e356449cfe 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -146,7 +146,7 @@ enum {
 /* struct worker is defined in workqueue_internal.h */
=20
 struct worker_pool {
-	spinlock_t		lock;		/* the pool lock */
+	raw_spinlock_t		lock;		/* the pool lock */
 	int			cpu;		/* I: the associated cpu */
 	int			node;		/* I: the associated node ID */
 	int			id;		/* I: pool ID */
@@ -301,7 +301,7 @@ static struct workqueue_attrs *wq_update_unbound_numa_a=
ttrs_buf;
=20
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list =
*/
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detac=
h */
-static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
+static DEFINE_RAW_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
 static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to g=
o away */
=20
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
@@ -827,7 +827,7 @@ static struct worker *first_idle_worker(struct worker_p=
ool *pool)
  * Wake up the first idle worker of @pool.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void wake_up_worker(struct worker_pool *pool)
 {
@@ -882,7 +882,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
=20
 	worker->sleeping =3D 1;
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
@@ -901,7 +901,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		if (next)
 			wake_up_process(next->task);
 	}
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 /**
@@ -912,7 +912,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * the scheduler to get a worker's last known identity.
  *
  * CONTEXT:
- * spin_lock_irq(rq->lock)
+ * raw_spin_lock_irq(rq->lock)
  *
  * This function is called during schedule() when a kworker is going
  * to sleep. It's used by psi to identify aggregation workers during
@@ -943,7 +943,7 @@ work_func_t wq_worker_last_func(struct task_struct *tas=
k)
  * Set @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int fl=
ags)
 {
@@ -968,7 +968,7 @@ static inline void worker_set_flags(struct worker *work=
er, unsigned int flags)
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock)
+ * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int fl=
ags)
 {
@@ -1016,7 +1016,7 @@ static inline void worker_clr_flags(struct worker *wo=
rker, unsigned int flags)
  * actually occurs, it should be easy to locate the culprit work function.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  *
  * Return:
  * Pointer to worker which is executing @work if found, %NULL
@@ -1051,7 +1051,7 @@ static struct worker *find_worker_executing_work(stru=
ct worker_pool *pool,
  * nested inside outer list_for_each_entry_safe().
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void move_linked_works(struct work_struct *work, struct list_head *=
head,
 			      struct work_struct **nextp)
@@ -1129,9 +1129,9 @@ static void put_pwq_unlocked(struct pool_workqueue *p=
wq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		put_pwq(pwq);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
 	}
 }
=20
@@ -1164,7 +1164,7 @@ static void pwq_activate_first_delayed(struct pool_wo=
rkqueue *pwq)
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 {
@@ -1263,7 +1263,7 @@ static int try_to_grab_pending(struct work_struct *wo=
rk, bool is_dwork,
 	if (!pool)
 		goto fail;
=20
-	spin_lock(&pool->lock);
+	raw_spin_lock(&pool->lock);
 	/*
 	 * work->data is guaranteed to point to pwq only while the work
 	 * item is queued on pwq->wq, and both updating work->data to point
@@ -1292,11 +1292,11 @@ static int try_to_grab_pending(struct work_struct *=
work, bool is_dwork,
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
=20
-		spin_unlock(&pool->lock);
+		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
 	}
-	spin_unlock(&pool->lock);
+	raw_spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
 	local_irq_restore(*flags);
@@ -1317,7 +1317,7 @@ static int try_to_grab_pending(struct work_struct *wo=
rk, bool is_dwork,
  * work_struct flags.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *wo=
rk,
 			struct list_head *head, unsigned int extra_flags)
@@ -1434,7 +1434,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	if (last_pool && last_pool !=3D pwq->pool) {
 		struct worker *worker;
=20
-		spin_lock(&last_pool->lock);
+		raw_spin_lock(&last_pool->lock);
=20
 		worker =3D find_worker_executing_work(last_pool, work);
=20
@@ -1442,11 +1442,11 @@ static void __queue_work(int cpu, struct workqueue_=
struct *wq,
 			pwq =3D worker->current_pwq;
 		} else {
 			/* meh... not running there, queue here */
-			spin_unlock(&last_pool->lock);
-			spin_lock(&pwq->pool->lock);
+			raw_spin_unlock(&last_pool->lock);
+			raw_spin_lock(&pwq->pool->lock);
 		}
 	} else {
-		spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pwq->pool->lock);
 	}
=20
 	/*
@@ -1459,7 +1459,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pwq->pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1491,7 +1491,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	insert_work(pwq, work, worklist, work_flags);
=20
 out:
-	spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pwq->pool->lock);
 	rcu_read_unlock();
 }
=20
@@ -1760,7 +1760,7 @@ EXPORT_SYMBOL(queue_rcu_work);
  * necessary.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_enter_idle(struct worker *worker)
 {
@@ -1800,7 +1800,7 @@ static void worker_enter_idle(struct worker *worker)
  * @worker is leaving idle state.  Update stats.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void worker_leave_idle(struct worker *worker)
 {
@@ -1938,11 +1938,11 @@ static struct worker *create_worker(struct worker_p=
ool *pool)
 	worker_attach_to_pool(worker, pool);
=20
 	/* start the newly created worker */
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
 	wake_up_process(worker->task);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	return worker;
=20
@@ -1961,7 +1961,7 @@ static struct worker *create_worker(struct worker_poo=
l *pool)
  * be idle.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void destroy_worker(struct worker *worker)
 {
@@ -1987,7 +1987,7 @@ static void idle_worker_timeout(struct timer_list *t)
 {
 	struct worker_pool *pool =3D from_timer(pool, t, idle_timer);
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	while (too_many_workers(pool)) {
 		struct worker *worker;
@@ -2005,7 +2005,7 @@ static void idle_worker_timeout(struct timer_list *t)
 		destroy_worker(worker);
 	}
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 static void send_mayday(struct work_struct *work)
@@ -2036,8 +2036,8 @@ static void pool_mayday_timeout(struct timer_list *t)
 	struct worker_pool *pool =3D from_timer(pool, t, mayday_timer);
 	struct work_struct *work;
=20
-	spin_lock_irq(&pool->lock);
-	spin_lock(&wq_mayday_lock);		/* for wq->maydays */
+	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock(&wq_mayday_lock);		/* for wq->maydays */
=20
 	if (need_to_create_worker(pool)) {
 		/*
@@ -2050,8 +2050,8 @@ static void pool_mayday_timeout(struct timer_list *t)
 			send_mayday(work);
 	}
=20
-	spin_unlock(&wq_mayday_lock);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock(&wq_mayday_lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INTERVAL);
 }
@@ -2070,7 +2070,7 @@ static void pool_mayday_timeout(struct timer_list *t)
  * may_start_working() %true.
  *
  * LOCKING:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
  * manager.
  */
@@ -2079,7 +2079,7 @@ __releases(&pool->lock)
 __acquires(&pool->lock)
 {
 restart:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
@@ -2095,7 +2095,7 @@ __acquires(&pool->lock)
 	}
=20
 	del_timer_sync(&pool->mayday_timer);
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/*
 	 * This is necessary even after a new worker was just successfully
 	 * created as @pool->lock was dropped and the new worker might have
@@ -2118,7 +2118,7 @@ __acquires(&pool->lock)
  * and may_start_working() is true.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
  *
  * Return:
@@ -2157,7 +2157,7 @@ static bool manage_workers(struct worker *worker)
  * call this function to process a work.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which is released and regrabbed.
+ * raw_spin_lock_irq(pool->lock) which is released and regrabbed.
  */
 static void process_one_work(struct worker *worker, struct work_struct *wo=
rk)
 __releases(&pool->lock)
@@ -2239,7 +2239,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	lock_map_acquire(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
@@ -2294,7 +2294,7 @@ __acquires(&pool->lock)
 	 */
 	cond_resched();
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/* clear cpu intensive status */
 	if (unlikely(cpu_intensive))
@@ -2320,7 +2320,7 @@ __acquires(&pool->lock)
  * fetches a work from the top and executes it.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock) which may be released and regrabbed
+ * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.
  */
 static void process_scheduled_works(struct worker *worker)
@@ -2362,11 +2362,11 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		set_pf_worker(false);
=20
@@ -2432,7 +2432,7 @@ static int worker_thread(void *__worker)
 	 */
 	worker_enter_idle(worker);
 	__set_current_state(TASK_IDLE);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	schedule();
 	goto woke_up;
 }
@@ -2486,7 +2486,7 @@ static int rescuer_thread(void *__rescuer)
 	should_stop =3D kthread_should_stop();
=20
 	/* see whether any pwq is asking for help */
-	spin_lock_irq(&wq_mayday_lock);
+	raw_spin_lock_irq(&wq_mayday_lock);
=20
 	while (!list_empty(&wq->maydays)) {
 		struct pool_workqueue *pwq =3D list_first_entry(&wq->maydays,
@@ -2498,11 +2498,11 @@ static int rescuer_thread(void *__rescuer)
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
=20
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
=20
 		worker_attach_to_pool(rescuer, pool);
=20
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
=20
 		/*
 		 * Slurp in all works issued via this workqueue and
@@ -2531,7 +2531,7 @@ static int rescuer_thread(void *__rescuer)
 			 * incur MAYDAY_INTERVAL delay inbetween.
 			 */
 			if (need_to_create_worker(pool)) {
-				spin_lock(&wq_mayday_lock);
+				raw_spin_lock(&wq_mayday_lock);
 				/*
 				 * Queue iff we aren't racing destruction
 				 * and somebody else hasn't queued it already.
@@ -2540,7 +2540,7 @@ static int rescuer_thread(void *__rescuer)
 					get_pwq(pwq);
 					list_add_tail(&pwq->mayday_node, &wq->maydays);
 				}
-				spin_unlock(&wq_mayday_lock);
+				raw_spin_unlock(&wq_mayday_lock);
 			}
 		}
=20
@@ -2558,14 +2558,14 @@ static int rescuer_thread(void *__rescuer)
 		if (need_more_worker(pool))
 			wake_up_worker(pool);
=20
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
=20
 		worker_detach_from_pool(rescuer);
=20
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 	}
=20
-	spin_unlock_irq(&wq_mayday_lock);
+	raw_spin_unlock_irq(&wq_mayday_lock);
=20
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
@@ -2645,7 +2645,7 @@ static void wq_barrier_func(struct work_struct *work)
  * underneath us, so we can't reliably determine pwq from @target.
  *
  * CONTEXT:
- * spin_lock_irq(pool->lock).
+ * raw_spin_lock_irq(pool->lock).
  */
 static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
@@ -2732,7 +2732,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueu=
e_struct *wq,
 	for_each_pwq(pwq, wq) {
 		struct worker_pool *pool =3D pwq->pool;
=20
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
=20
 		if (flush_color >=3D 0) {
 			WARN_ON_ONCE(pwq->flush_color !=3D -1);
@@ -2749,7 +2749,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueu=
e_struct *wq,
 			pwq->work_color =3D work_color;
 		}
=20
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
=20
 	if (flush_color >=3D 0 && atomic_dec_and_test(&wq->nr_pwqs_to_flush))
@@ -2949,9 +2949,9 @@ void drain_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		bool drained;
=20
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		drained =3D !pwq->nr_active && list_empty(&pwq->delayed_works);
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
=20
 		if (drained)
 			continue;
@@ -2987,7 +2987,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr,
 		return false;
 	}
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
 	pwq =3D get_work_pwq(work);
 	if (pwq) {
@@ -3003,7 +3003,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr,
 	check_flush_dependency(pwq->wq, work);
=20
 	insert_wq_barrier(pwq, barr, work, worker);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	/*
 	 * Force a lock recursion deadlock when using flush_work() inside a
@@ -3022,7 +3022,7 @@ static bool start_flush_work(struct work_struct *work=
, struct wq_barrier *barr,
 	rcu_read_unlock();
 	return true;
 already_gone:
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 	rcu_read_unlock();
 	return false;
 }
@@ -3415,7 +3415,7 @@ static bool wqattrs_equal(const struct workqueue_attr=
s *a,
  */
 static int init_worker_pool(struct worker_pool *pool)
 {
-	spin_lock_init(&pool->lock);
+	raw_spin_lock_init(&pool->lock);
 	pool->id =3D -1;
 	pool->cpu =3D -1;
 	pool->node =3D NUMA_NO_NODE;
@@ -3541,7 +3541,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
 	 */
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
 	swait_event_lock_irq(wq_manager_wait,
 			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
 	pool->flags |=3D POOL_MANAGER_ACTIVE;
@@ -3549,7 +3549,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	while ((worker =3D first_idle_worker(pool)))
 		destroy_worker(worker);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
=20
 	mutex_lock(&wq_pool_attach_mutex);
 	if (!list_empty(&pool->workers))
@@ -3705,7 +3705,7 @@ static void pwq_adjust_max_active(struct pool_workque=
ue *pwq)
 		return;
=20
 	/* this function can be called during early boot w/ irq disabled */
-	spin_lock_irqsave(&pwq->pool->lock, flags);
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
=20
 	/*
 	 * During [un]freezing, the caller is responsible for ensuring that
@@ -3728,7 +3728,7 @@ static void pwq_adjust_max_active(struct pool_workque=
ue *pwq)
 		pwq->max_active =3D 0;
 	}
=20
-	spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
=20
 /* initialize newly alloced @pwq which is associated with @wq and @pool */
@@ -4130,9 +4130,9 @@ static void wq_update_unbound_numa(struct workqueue_s=
truct *wq, int cpu,
=20
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	spin_lock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
-	spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
 	old_pwq =3D numa_pwq_tbl_install(wq, node, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
@@ -4361,9 +4361,9 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		struct worker *rescuer =3D wq->rescuer;
=20
 		/* this prevents new queueing */
-		spin_lock_irq(&wq_mayday_lock);
+		raw_spin_lock_irq(&wq_mayday_lock);
 		wq->rescuer =3D NULL;
-		spin_unlock_irq(&wq_mayday_lock);
+		raw_spin_unlock_irq(&wq_mayday_lock);
=20
 		/* rescuer will empty maydays list before exiting */
 		kthread_stop(rescuer->task);
@@ -4377,18 +4377,18 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	mutex_lock(&wq_pool_mutex);
 	mutex_lock(&wq->mutex);
 	for_each_pwq(pwq, wq) {
-		spin_lock_irq(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 		if (WARN_ON(pwq_busy(pwq))) {
 			pr_warn("%s: %s has the following busy pwq\n",
 				__func__, wq->name);
 			show_pwq(pwq);
-			spin_unlock_irq(&pwq->pool->lock);
+			raw_spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
 			mutex_unlock(&wq_pool_mutex);
 			show_workqueue_state();
 			return;
 		}
-		spin_unlock_irq(&pwq->pool->lock);
+		raw_spin_unlock_irq(&pwq->pool->lock);
 	}
 	mutex_unlock(&wq->mutex);
 	mutex_unlock(&wq_pool_mutex);
@@ -4559,10 +4559,10 @@ unsigned int work_busy(struct work_struct *work)
 	rcu_read_lock();
 	pool =3D get_work_pool(work);
 	if (pool) {
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (find_worker_executing_work(pool, work))
 			ret |=3D WORK_BUSY_RUNNING;
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 	}
 	rcu_read_unlock();
=20
@@ -4769,10 +4769,10 @@ void show_workqueue_state(void)
 		pr_info("workqueue %s: flags=3D0x%x\n", wq->name, wq->flags);
=20
 		for_each_pwq(pwq, wq) {
-			spin_lock_irqsave(&pwq->pool->lock, flags);
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
 				show_pwq(pwq);
-			spin_unlock_irqrestore(&pwq->pool->lock, flags);
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
 			 * We could be printing a lot from atomic context, e.g.
 			 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4786,7 +4786,7 @@ void show_workqueue_state(void)
 		struct worker *worker;
 		bool first =3D true;
=20
-		spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers =3D=3D pool->nr_idle)
 			goto next_pool;
=20
@@ -4805,7 +4805,7 @@ void show_workqueue_state(void)
 		}
 		pr_cont("\n");
 	next_pool:
-		spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
 		 * sysrq-t -> show_workqueue_state(). Avoid triggering
@@ -4835,7 +4835,7 @@ void wq_worker_comm(char *buf, size_t size, struct ta=
sk_struct *task)
 		struct worker_pool *pool =3D worker->pool;
=20
 		if (pool) {
-			spin_lock_irq(&pool->lock);
+			raw_spin_lock_irq(&pool->lock);
 			/*
 			 * ->desc tracks information (wq name or
 			 * set_worker_desc()) for the latest execution.  If
@@ -4849,7 +4849,7 @@ void wq_worker_comm(char *buf, size_t size, struct ta=
sk_struct *task)
 					scnprintf(buf + off, size - off, "-%s",
 						  worker->desc);
 			}
-			spin_unlock_irq(&pool->lock);
+			raw_spin_unlock_irq(&pool->lock);
 		}
 	}
=20
@@ -4880,7 +4880,7 @@ static void unbind_workers(int cpu)
=20
 	for_each_cpu_worker_pool(pool, cpu) {
 		mutex_lock(&wq_pool_attach_mutex);
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
=20
 		/*
 		 * We've blocked all attach/detach operations. Make all workers
@@ -4894,7 +4894,7 @@ static void unbind_workers(int cpu)
=20
 		pool->flags |=3D POOL_DISASSOCIATED;
=20
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 		mutex_unlock(&wq_pool_attach_mutex);
=20
 		/*
@@ -4920,9 +4920,9 @@ static void unbind_workers(int cpu)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
 		wake_up_worker(pool);
-		spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irq(&pool->lock);
 	}
 }
=20
@@ -4949,7 +4949,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
=20
-	spin_lock_irq(&pool->lock);
+	raw_spin_lock_irq(&pool->lock);
=20
 	pool->flags &=3D ~POOL_DISASSOCIATED;
=20
@@ -4988,7 +4988,7 @@ static void rebind_workers(struct worker_pool *pool)
 		WRITE_ONCE(worker->flags, worker_flags);
 	}
=20
-	spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irq(&pool->lock);
 }
=20
 /**
--=20
2.26.2

