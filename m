Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA9C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6AA20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBCLpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:45:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:35244 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgBCLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:45:50 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iyaAH-0004wf-1u; Mon, 03 Feb 2020 14:45:17 +0300
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7a876b46-b80c-1164-d139-6026adcb222c@virtuozzo.com>
Date:   Mon, 3 Feb 2020 14:45:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131151540.155211856@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2020 18:07, Peter Zijlstra wrote:
> The filesystem freezer uses percpu-rwsem in a way that is effectively
> write_non_owner() and achieves this with a few horrible hacks that
> rely on the rwsem (!percpu) implementation.
> 
> When PREEMPT_RT replaces the rwsem implementation with a PI aware
> variant this comes apart.
> 
> Remove the embedded rwsem and implement it using a waitqueue and an
> atomic_t.
> 
>  - make readers_block an atomic, and use it, with the waitqueue
>    for a blocking test-and-set write-side.
> 
>  - have the read-side wait for the 'lock' state to clear.
> 
> Have the waiters use FIFO queueing and mark them (reader/writer) with
> a new WQ_FLAG. Use a custom wake_function to wake either a single
> writer or all readers until a writer.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  include/linux/percpu-rwsem.h  |   19 +----
>  include/linux/rwsem.h         |    6 -
>  include/linux/wait.h          |    1 
>  kernel/locking/percpu-rwsem.c |  153 ++++++++++++++++++++++++++++++------------
>  kernel/locking/rwsem.c        |   11 +--
>  kernel/locking/rwsem.h        |   12 ---
>  6 files changed, 123 insertions(+), 79 deletions(-)
> 
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -3,18 +3,18 @@
>  #define _LINUX_PERCPU_RWSEM_H
>  
>  #include <linux/atomic.h>
> -#include <linux/rwsem.h>
>  #include <linux/percpu.h>
>  #include <linux/rcuwait.h>
> +#include <linux/wait.h>
>  #include <linux/rcu_sync.h>
>  #include <linux/lockdep.h>
>  
>  struct percpu_rw_semaphore {
>  	struct rcu_sync		rss;
>  	unsigned int __percpu	*read_count;
> -	struct rw_semaphore	rw_sem; /* slowpath */
> -	struct rcuwait          writer; /* blocked writer */
> -	int			readers_block;
> +	struct rcuwait		writer;
> +	wait_queue_head_t	waiters;
> +	atomic_t		block;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map	dep_map;
>  #endif
> @@ -31,8 +31,9 @@ static DEFINE_PER_CPU(unsigned int, __pe
>  is_static struct percpu_rw_semaphore name = {				\
>  	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
>  	.read_count = &__percpu_rwsem_rc_##name,			\
> -	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
>  	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
> +	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
> +	.block = ATOMIC_INIT(0),					\
>  	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
>  }
>  
> @@ -130,20 +131,12 @@ static inline void percpu_rwsem_release(
>  					bool read, unsigned long ip)
>  {
>  	lock_release(&sem->dep_map, ip);
> -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> -	if (!read)
> -		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
> -#endif
>  }
>  
>  static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
>  					bool read, unsigned long ip)
>  {
>  	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
> -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> -	if (!read)
> -		atomic_long_set(&sem->rw_sem.owner, (long)current);
> -#endif
>  }
>  
>  #endif
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -53,12 +53,6 @@ struct rw_semaphore {
>  #endif
>  };
>  
> -/*
> - * Setting all bits of the owner field except bit 0 will indicate
> - * that the rwsem is writer-owned with an unknown owner.
> - */
> -#define RWSEM_OWNER_UNKNOWN	(-2L)
> -
>  /* In all implementations count != 0 means locked */
>  static inline int rwsem_is_locked(struct rw_semaphore *sem)
>  {
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -20,6 +20,7 @@ int default_wake_function(struct wait_qu
>  #define WQ_FLAG_EXCLUSIVE	0x01
>  #define WQ_FLAG_WOKEN		0x02
>  #define WQ_FLAG_BOOKMARK	0x04
> +#define WQ_FLAG_CUSTOM		0x08
>  
>  /*
>   * A single wait-queue entry structure:
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -1,15 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/atomic.h>
> -#include <linux/rwsem.h>
>  #include <linux/percpu.h>
> +#include <linux/wait.h>
>  #include <linux/lockdep.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> +#include <linux/sched/task.h>
>  #include <linux/errno.h>
>  
> -#include "rwsem.h"
> -
>  int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
>  			const char *name, struct lock_class_key *key)
>  {
> @@ -17,11 +16,10 @@ int __percpu_init_rwsem(struct percpu_rw
>  	if (unlikely(!sem->read_count))
>  		return -ENOMEM;
>  
> -	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
>  	rcu_sync_init(&sem->rss);
> -	init_rwsem(&sem->rw_sem);
>  	rcuwait_init(&sem->writer);
> -	sem->readers_block = 0;
> +	init_waitqueue_head(&sem->waiters);
> +	atomic_set(&sem->block, 0);
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
>  	lockdep_init_map(&sem->dep_map, name, key, 0);
> @@ -54,23 +52,23 @@ static bool __percpu_down_read_trylock(s
>  	 * the same CPU as the increment, avoiding the
>  	 * increment-on-one-CPU-and-decrement-on-another problem.
>  	 *
> -	 * If the reader misses the writer's assignment of readers_block, then
> -	 * the writer is guaranteed to see the reader's increment.
> +	 * If the reader misses the writer's assignment of sem->block, then the
> +	 * writer is guaranteed to see the reader's increment.
>  	 *
>  	 * Conversely, any readers that increment their sem->read_count after
> -	 * the writer looks are guaranteed to see the readers_block value,
> -	 * which in turn means that they are guaranteed to immediately
> -	 * decrement their sem->read_count, so that it doesn't matter that the
> -	 * writer missed them.
> +	 * the writer looks are guaranteed to see the sem->block value, which
> +	 * in turn means that they are guaranteed to immediately decrement
> +	 * their sem->read_count, so that it doesn't matter that the writer
> +	 * missed them.
>  	 */
>  
>  	smp_mb(); /* A matches D */
>  
>  	/*
> -	 * If !readers_block the critical section starts here, matched by the
> +	 * If !sem->block the critical section starts here, matched by the
>  	 * release in percpu_up_write().
>  	 */
> -	if (likely(!smp_load_acquire(&sem->readers_block)))
> +	if (likely(!atomic_read_acquire(&sem->block)))
>  		return true;
>  
>  	__this_cpu_dec(*sem->read_count);
> @@ -81,6 +79,88 @@ static bool __percpu_down_read_trylock(s
>  	return false;
>  }
>  
> +static inline bool __percpu_down_write_trylock(struct percpu_rw_semaphore *sem)
> +{
> +	if (atomic_read(&sem->block))
> +		return false;
> +
> +	return atomic_xchg(&sem->block, 1) == 0;
> +}
> +
> +static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
> +{
> +	if (reader) {
> +		bool ret;
> +
> +		preempt_disable();
> +		ret = __percpu_down_read_trylock(sem);
> +		preempt_enable();
> +
> +		return ret;
> +	}
> +	return __percpu_down_write_trylock(sem);
> +}
> +
> +/*
> + * The return value of wait_queue_entry::func means:
> + *
> + *  <0 - error, wakeup is terminated and the error is returned
> + *   0 - no wakeup, a next waiter is tried
> + *  >0 - woken, if EXCLUSIVE, counted towards @nr_exclusive.
> + *
> + * We use EXCLUSIVE for both readers and writers to preserve FIFO order,
> + * and play games with the return value to allow waking multiple readers.
> + *
> + * Specifically, we wake readers until we've woken a single writer, or until a
> + * trylock fails.
> + */
> +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
> +				      unsigned int mode, int wake_flags,
> +				      void *key)
> +{
> +	struct task_struct *p = get_task_struct(wq_entry->private);
> +	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
> +	struct percpu_rw_semaphore *sem = key;
> +
> +	/* concurrent against percpu_down_write(), can get stolen */
> +	if (!__percpu_rwsem_trylock(sem, reader))
> +		return 1;
> +
> +	list_del_init(&wq_entry->entry);
> +	smp_store_release(&wq_entry->private, NULL);
> +
> +	wake_up_process(p);
> +	put_task_struct(p);
> +
> +	return !reader; /* wake (readers until) 1 writer */
> +}

Maybe, this is not a subject of this patchset. But since this is a newborn function,
can we introduce it to save one unneeded wake_up of writer? This is a situation,
when writer becomes woken up just to write itself into sem->writer.task.

Something like below:

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a136677543b4..e4f88bfd43ed 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -9,6 +9,8 @@
 #include <linux/sched/task.h>
 #include <linux/errno.h>
 
+static bool readers_active_check(struct percpu_rw_semaphore *sem);
+
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
 {
@@ -101,6 +103,16 @@ static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
 	return __percpu_down_write_trylock(sem);
 }
 
+static void queue_sem_writer(struct percpu_rw_semaphore *sem, struct task_struct *p)
+{
+	rcu_assign_pointer(sem->writer.task, p);
+	smp_mb();
+	if (readers_active_check(sem)) {
+		WRITE_ONCE(sem->writer.task, NULL);
+		wake_up_process(p);
+	}
+}
+
 /*
  * The return value of wait_queue_entry::func means:
  *
@@ -129,7 +141,11 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 
-	wake_up_process(p);
+	if (reader || readers_active_check(sem))
+		wake_up_process(p);
+	else
+		queue_sem_writer(sem, p);
+
 	put_task_struct(p);
 
 	return !reader; /* wake (readers until) 1 writer */
@@ -247,8 +263,11 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	 * them.
 	 */
 
-	/* Wait for all active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	if (rcu_access_pointer(sem->writer.task))
+		WRITE_ONCE(sem->writer.task, NULL);
+	else
+		/* Wait for all active readers to complete. */
+		rcuwait_wait_event(&sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
Just an idea, completely untested.

Kirill
