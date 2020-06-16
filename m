Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D011C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD782071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgFPMpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:45:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDFBC08C5C2;
        Tue, 16 Jun 2020 05:45:05 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlAxa-0005Wn-Us; Tue, 16 Jun 2020 14:45:03 +0200
Date:   Tue, 16 Jun 2020 14:45:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.17-rt10
Message-ID: <20200616124502.vfmbsec3avnbhupz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.17-rt10 patch set. 

Changes since v5.6.17-rt9:

  - Add the seqcount series by Ahmed S. Darwish.
    The series annotates the lock protecting the struct seqcount against
    multiple writer. In RT the lock annotation can be utilized to block
    on in case the writer is active. This is the same technique that is
    used now but we can avoid replacing the seqcount with a seqlock and
    have code that is closer to mainline.
    
    As part of the integration I dropped seqcount replacements which
    are no longer needed, like in NFS or vfs.

  - Added down_read_non_owner() for RT. There is no owner tracking since
    we allow multiple reader locking on struct rw_semaphore. This
    removes on patch from the NFS subsystem and allows to enable bcache.

  - Drop the lock raw_spinlock_t from struct hlist_bl_head. The struct
    hlist_bl_head uses bit_spin_lock() for locking so we are still
    spinning.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.17-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.17-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.17-rt10

The RT patch against v5.6.17 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.17-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.17-rt10.tar.xz

Sebastian

diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index 626a463f7e42e..080090378734a 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -13,6 +13,7 @@ locking
     mutex-design
     rt-mutex-design
     rt-mutex
+    seqlock
     spinlocks
     ww-mutex-design
 
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
new file mode 100644
index 0000000000000..2d526dc954081
--- /dev/null
+++ b/Documentation/locking/seqlock.rst
@@ -0,0 +1,242 @@
+======================================
+Sequence counters and sequential locks
+======================================
+
+Introduction
+============
+
+Sequence counters are a reader-writer consistency mechanism with
+lockless readers (read-only retry loops), and no writer starvation. They
+are used for data that's rarely written to (e.g. system time), where the
+reader wants a consistent set of information and is willing to retry if
+that information changes.
+
+A data set is consistent when the sequence count at the beginning of the
+read side critical section is even and the same sequence count value is
+read again at the end of the critical section. The data in the set must
+be copied out inside the read side critical section. If the sequence
+count has changed between the start and the end of the critical section,
+the reader must retry.
+
+Writers increment the sequence count at the start and the end of their
+critical section. After starting the critical section the sequence count
+is odd and indicates to the readers that an update is in progress. At
+the end of the write side critical section the sequence count becomes
+even again which lets readers make progress.
+
+A sequence counter write side critical section must never be preempted
+or interrupted by read side sections. Otherwise the reader will spin for
+the entire scheduler tick due to the odd sequence count value and the
+interrupted writer. If that reader belongs to a real-time scheduling
+class, it can spin forever and the kernel will livelock.
+
+This mechanism cannot be used if the protected data contains pointers,
+as the writer can invalidate a pointer that the reader is following.
+
+.. _seqcount_t:
+
+Sequence counters (:c:type:`seqcount_t`)
+========================================
+
+This is the the raw counting mechanism, which does not protect against
+multiple writers.  Write side critical sections must thus be serialized
+by an external lock.
+
+If the write serialization primitive is not implicitly disabling
+preemption, preemption must be explicitly disabled before entering the
+write side section. If the read section can be invoked from hardirq or
+softirq contexts, interrupts or bottom halves must also be respectively
+disabled before entering the write section.
+
+If the write serialization mechanism is one of the common kernel locking
+primitives, use :ref:`sequence counters with associated locks
+<seqcount_locktype_t>` instead. If it's desired to automatically handle
+the sequence counter writer serialization and non-preemptibility
+requirements, use a :ref:`sequential lock <seqlock_t>`.
+
+Initialization:
+
+.. code-block:: c
+
+	/* dynamic */
+	seqcount_t foo_seqcount;
+	seqcount_init(&foo_seqcount);
+
+	/* static */
+	static seqcount_t foo_seqcount = SEQCNT_ZERO(foo_seqcount);
+
+	/* C99 struct init */
+	struct {
+		.seq   = SEQCNT_ZERO(foo.seq),
+	} foo;
+
+Write path:
+
+.. _seqcount_write_ops:
+.. code-block:: c
+
+	/* Serialized context with disabled preemption */
+
+	write_seqcount_begin(&foo_seqcount);
+
+	/* ... [[write-side critical section]] ... */
+
+	write_seqcount_end(&foo_seqcount);
+
+Read path:
+
+.. _seqcount_read_ops:
+.. code-block:: c
+
+	do {
+		seq = read_seqcount_begin(&foo_seqcount);
+
+		/* ... [[read-side critical section]] ... */
+
+	} while (read_seqcount_retry(&foo_seqcount, seq));
+
+.. _seqcount_locktype_t:
+
+Sequence counters with associated locks (:c:type:`seqcount_LOCKTYPE_t`)
+-----------------------------------------------------------------------
+
+As :ref:`earlier discussed <seqcount_t>`, seqcount write side critical
+sections must be serialized and non-preemptible. This variant of
+sequence counters associate the lock used for writer serialization at
+the seqcount initialization time. This enables lockdep to validate that
+the write side critical section is properly serialized.
+
+This lock association is a NOOP if lockdep is disabled and has neither
+storage nor runtime overhead. If lockdep is enabled, the lock pointer is
+stored in struct seqcount and lockdep's "lock is held" assertions are
+injected at the beginning of the write side critical section to validate
+that it is properly protected.
+
+For lock types which do not implicitly disable preemption, preemption
+protection is enforced in the write side function.
+
+The following seqcounts with associated locks are defined:
+
+  - :c:type:`seqcount_spinlock_t`
+  - :c:type:`seqcount_raw_spinlock_t`
+  - :c:type:`seqcount_rwlock_t`
+  - :c:type:`seqcount_mutex_t`
+  - :c:type:`seqcount_ww_mutex_t`
+
+The plain seqcount read and write APIs branch out to the specific
+seqcount_LOCKTYPE_t implementation at compile-time. This avoids kernel
+API explosion per each new seqcount LOCKTYPE.
+
+Initialization (replace "LOCKTYPE" with one of the supported locks):
+
+.. code-block:: c
+
+	/* dynamic */
+	seqcount_LOCKTYPE_t foo_seqcount;
+	seqcount_LOCKTYPE_init(&foo_seqcount, &lock);
+
+	/* static */
+	static seqcount_LOCKTYPE_t foo_seqcount =
+		SEQCNT_LOCKTYPE_ZERO(foo_seqcount, &lock);
+
+	/* C99 struct init */
+	struct {
+		.seq   = SEQCNT_LOCKTYPE_ZERO(foo.seq, &lock),
+	} foo;
+
+Write path: same as in :ref:`plain seqcount_t <seqcount_write_ops>`,
+while running from a context with the associated LOCKTYPE lock acquired.
+
+Read path: same as in :ref:`plain seqcount_t <seqcount_read_ops>`.
+
+.. _seqlock_t:
+
+Sequential locks (:c:type:`seqlock_t`)
+======================================
+
+This contains the :ref:`sequence counting mechanism <seqcount_t>`
+earlier discussed, plus an embedded spinlock for writer serialization
+and non-preemptibility.
+
+If the read side section can be invoked from hardirq or softirq context,
+use the write side function variants which disable interrupts or bottom
+halves respectively.
+
+Initialization:
+
+.. code-block:: c
+
+	/* dynamic */
+	seqlock_t foo_seqlock;
+	seqlock_init(&foo_seqlock);
+
+	/* static */
+	static DEFINE_SEQLOCK(foo_seqlock);
+
+	/* C99 struct init */
+	struct {
+		.seql   = __SEQLOCK_UNLOCKED(foo.seql)
+	} foo;
+
+Write path:
+
+.. code-block:: c
+
+	write_seqlock(&foo_seqlock);
+
+	/* ... [[write-side critical section]] ... */
+
+	write_sequnlock(&foo_seqlock);
+
+Read path, three categories:
+
+1. Normal Sequence readers which never block a writer but they must
+   retry if a writer is in progress by detecting change in the sequence
+   number.  Writers do not wait for a sequence reader.
+
+   .. code-block:: c
+
+	do {
+		seq = read_seqbegin(&foo_seqlock);
+
+		/* ... [[read-side critical section]] ... */
+
+	} while (read_seqretry(&foo_seqlock, seq));
+
+2. Locking readers which will wait if a writer or another locking reader
+   is in progress. A locking reader in progress will also block a writer
+   from entering its critical section. This read lock is
+   exclusive. Unlike rwlock_t, only one locking reader can acquire it.
+
+   .. code-block:: c
+
+	read_seqlock_excl(&foo_seqlock);
+
+	/* ... [[read-side critical section]] ... */
+
+	read_sequnlock_excl(&foo_seqlock);
+
+3. Conditional lockless reader (as in 1), or locking reader (as in 2),
+   according to a passed marker. This is used to avoid lockless readers
+   starvation (too much retry loops) in case of a sharp spike in write
+   activity. First, a lockless read is tried (even marker passed). If
+   that trial fails (odd sequence counter is returned, which is used as
+   the next iteration marker), the lockless read is transformed to a
+   full locking read and no retry loop is necessary.
+
+   .. code-block:: c
+
+	/* marker; even initialization */
+	int seq = 0;
+	do {
+		read_seqbegin_or_lock(&foo_seqlock, &seq);
+
+		/* ... [[read-side critical section]] ... */
+
+	} while (need_seqretry(&foo_seqlock, seq));
+	done_seqretry(&foo_seqlock, seq);
+
+API documentation
+=================
+
+.. kernel-doc:: include/linux/seqlock.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a5332b3591d7..1c95a9bc231f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9821,7 +9821,7 @@ F:	arch/*/include/asm/spinlock*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwsem*.h
-F:	include/linux/seqlock.h
+F:	include/linux/seqlock*.h
 F:	lib/locking*.[ch]
 F:	kernel/locking/
 X:	kernel/locking/locktorture.c
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d083f77040827..2452148eee931 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -408,7 +408,7 @@ struct ioc {
 	enum ioc_running		running;
 	atomic64_t			vtime_rate;
 
-	seqcount_t			period_seqcount;
+	seqcount_spinlock_t		period_seqcount;
 	u32				period_at;	/* wallclock starttime */
 	u64				period_at_vtime; /* vtime starttime */
 
@@ -875,7 +875,6 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 
 static void ioc_start_period(struct ioc *ioc, struct ioc_now *now)
 {
-	lockdep_assert_held(&ioc->lock);
 	WARN_ON_ONCE(ioc->running != IOC_RUNNING);
 
 	write_seqcount_begin(&ioc->period_seqcount);
@@ -1961,7 +1960,7 @@ static int blk_iocost_init(struct request_queue *q)
 
 	ioc->running = IOC_IDLE;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
-	seqcount_init(&ioc->period_seqcount);
+	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
 	ioc->period_at = ktime_to_us(ktime_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 88cec9598d138..e7589d91de8fb 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -215,7 +215,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		return 0;
 
 retry:
-	seq = read_seqbegin(&resv->seq);
+	seq = read_seqcount_begin(&resv->seq);
 	rcu_read_lock();
 
 	fobj = rcu_dereference(resv->fence);
@@ -224,7 +224,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	else
 		shared_count = 0;
 	fence_excl = rcu_dereference(resv->fence_excl);
-	if (read_seqretry(&resv->seq, seq)) {
+	if (read_seqcount_retry(&resv->seq, seq)) {
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -1198,12 +1198,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
 		robj = buf_obj->resv;
 		while (true) {
-			seq = read_seqbegin(&robj->seq);
+			seq = read_seqcount_begin(&robj->seq);
 			rcu_read_lock();
 			fobj = rcu_dereference(robj->fence);
 			shared_count = fobj ? fobj->shared_count : 0;
 			fence = rcu_dereference(robj->fence_excl);
-			if (!read_seqretry(&robj->seq, seq))
+			if (!read_seqcount_retry(&robj->seq, seq))
 				break;
 			rcu_read_unlock();
 		}
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 3c51f44e9f9bf..3aba2b2bfc487 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -128,8 +128,8 @@ subsys_initcall(dma_resv_lockdep);
 void dma_resv_init(struct dma_resv *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
+	seqcount_ww_mutex_init(&obj->seq, &obj->lock);
 
-	seqlock_init(&obj->seq);
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
 }
@@ -259,7 +259,7 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 	fobj = dma_resv_get_list(obj);
 	count = fobj->shared_count;
 
-	write_seqlock(&obj->seq);
+	write_seqcount_begin(&obj->seq);
 
 	for (i = 0; i < count; ++i) {
 
@@ -279,7 +279,7 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 	/* pointer update must be visible before we extend the shared_count */
 	smp_store_mb(fobj->shared_count, count);
 
-	write_sequnlock(&obj->seq);
+	write_seqcount_end(&obj->seq);
 	dma_fence_put(old);
 }
 EXPORT_SYMBOL(dma_resv_add_shared_fence);
@@ -306,12 +306,12 @@ void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence)
 	if (fence)
 		dma_fence_get(fence);
 
-	write_seqlock(&obj->seq);
-	/* write_seqlock provides the necessary memory barrier */
+	write_seqcount_begin(&obj->seq);
+	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(obj->fence_excl, fence);
 	if (old)
 		old->shared_count = 0;
-	write_sequnlock(&obj->seq);
+	write_seqcount_end(&obj->seq);
 
 	/* inplace update, no shared fences */
 	while (i--)
@@ -389,11 +389,11 @@ int dma_resv_copy_fences(struct dma_resv *dst, struct dma_resv *src)
 	src_list = dma_resv_get_list(dst);
 	old = dma_resv_get_excl(dst);
 
-	write_seqlock(&dst->seq);
-	/* write_seqlock provides the necessary memory barrier */
+	write_seqcount_begin(&dst->seq);
+	/* write_seqcount_begin provides the necessary memory barrier */
 	RCU_INIT_POINTER(dst->fence_excl, new);
 	RCU_INIT_POINTER(dst->fence, dst_list);
-	write_sequnlock(&dst->seq);
+	write_seqcount_end(&dst->seq);
 
 	dma_resv_list_free(src_list);
 	dma_fence_put(old);
@@ -433,7 +433,7 @@ int dma_resv_get_fences_rcu(struct dma_resv *obj,
 		shared_count = i = 0;
 
 		rcu_read_lock();
-		seq = read_seqbegin(&obj->seq);
+		seq = read_seqcount_begin(&obj->seq);
 
 		fence_excl = rcu_dereference(obj->fence_excl);
 		if (fence_excl && !dma_fence_get_rcu(fence_excl))
@@ -475,7 +475,7 @@ int dma_resv_get_fences_rcu(struct dma_resv *obj,
 			}
 		}
 
-		if (i != shared_count || read_seqretry(&obj->seq, seq)) {
+		if (i != shared_count || read_seqcount_retry(&obj->seq, seq)) {
 			while (i--)
 				dma_fence_put(shared[i]);
 			dma_fence_put(fence_excl);
@@ -526,7 +526,7 @@ long dma_resv_wait_timeout_rcu(struct dma_resv *obj,
 
 retry:
 	shared_count = 0;
-	seq = read_seqbegin(&obj->seq);
+	seq = read_seqcount_begin(&obj->seq);
 	rcu_read_lock();
 	i = -1;
 
@@ -572,7 +572,7 @@ long dma_resv_wait_timeout_rcu(struct dma_resv *obj,
 
 	rcu_read_unlock();
 	if (fence) {
-		if (read_seqretry(&obj->seq, seq)) {
+		if (read_seqcount_retry(&obj->seq, seq)) {
 			dma_fence_put(fence);
 			goto retry;
 		}
@@ -626,7 +626,7 @@ bool dma_resv_test_signaled_rcu(struct dma_resv *obj, bool test_all)
 retry:
 	ret = true;
 	shared_count = 0;
-	seq = read_seqbegin(&obj->seq);
+	seq = read_seqcount_begin(&obj->seq);
 
 	if (test_all) {
 		unsigned i;
@@ -646,7 +646,7 @@ bool dma_resv_test_signaled_rcu(struct dma_resv *obj, bool test_all)
 				break;
 		}
 
-		if (read_seqretry(&obj->seq, seq))
+		if (read_seqcount_retry(&obj->seq, seq))
 			goto retry;
 	}
 
@@ -658,7 +658,7 @@ bool dma_resv_test_signaled_rcu(struct dma_resv *obj, bool test_all)
 			if (ret < 0)
 				goto retry;
 
-			if (read_seqretry(&obj->seq, seq))
+			if (read_seqcount_retry(&obj->seq, seq))
 				goto retry;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2c97b3dc588fa..70969fac13fb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -257,9 +257,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-	write_seqlock(&resv->seq);
+	write_seqcount_begin(&resv->seq);
 	RCU_INIT_POINTER(resv->fence, new);
-	write_sequnlock(&resv->seq);
+	write_seqcount_end(&resv->seq);
 
 	/* Drop the references to the removed fences or move them to ef_list */
 	for (i = j, k = 0; i < old->shared_count; ++i) {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_busy.c b/drivers/gpu/drm/i915/gem/i915_gem_busy.c
index eaa8735aabee2..25235ef630c10 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_busy.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_busy.c
@@ -75,6 +75,7 @@ busy_check_writer(const struct dma_fence *fence)
 
 	return __busy_set_if_active(fence, __busy_write_id);
 }
+
 int
 i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 		    struct drm_file *file)
@@ -109,8 +110,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 	 *
 	 */
 retry:
-	/* XXX raw_read_seqcount() does not wait for the WRTIE to finish */
-	seq = read_seqbegin(&obj->base.resv->seq);
+	seq = raw_read_seqcount(&obj->base.resv->seq);
 
 	/* Translate the exclusive fence to the READ *and* WRITE engine */
 	args->busy =
@@ -129,7 +129,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	if (args->busy && read_seqretry(&obj->base.resv->seq, seq))
+	if (args->busy && read_seqcount_retry(&obj->base.resv->seq, seq))
 		goto retry;
 
 	err = 0;
diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 29c35eb524148..6dfa653d30db7 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -2,7 +2,6 @@
 
 config BCACHE
 	tristate "Block device as cache"
-	depends on !PREEMPT_RT
 	select CRC64
 	help
 	Allows a block device to be used as cache for other devices; uses
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4f5420851da29..17ab60d9e4288 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6932,7 +6932,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	} else
 		goto abort;
 	spin_lock_init(&conf->device_lock);
-	seqcount_init(&conf->gen_lock);
+	seqcount_spinlock_init(&conf->gen_lock, &conf->device_lock);
 	mutex_init(&conf->cache_size_mutex);
 	init_waitqueue_head(&conf->wait_for_quiescent);
 	init_waitqueue_head(&conf->wait_for_stripe);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index cca69edd669da..078d2284938a7 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -589,7 +589,7 @@ struct r5conf {
 	int			prev_chunk_sectors;
 	int			prev_algo;
 	short			generation; /* increments with every reshape */
-	seqcount_t		gen_lock;	/* lock against generation changes */
+	seqcount_spinlock_t	gen_lock;	/* lock against generation changes */
 	unsigned long		reshape_checkpoint; /* Time we last updated
 						     * metadata */
 	long long		min_offset_diff; /* minimum difference between
diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 4a3d34f40cb9f..c4641b1704d61 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
-#include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
 #include <linux/linkmode.h>
@@ -34,7 +33,6 @@ struct fixed_mdio_bus {
 struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
-	seqcount_t seqcount;
 	struct fixed_phy_status status;
 	bool no_carrier;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
@@ -80,19 +78,17 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
 			struct fixed_phy_status state;
-			int s;
 
-			do {
-				s = read_seqcount_begin(&fp->seqcount);
-				fp->status.link = !fp->no_carrier;
-				/* Issue callback if user registered it. */
-				if (fp->link_update)
-					fp->link_update(fp->phydev->attached_dev,
-							&fp->status);
-				/* Check the GPIO for change in status */
-				fixed_phy_update(fp);
-				state = fp->status;
-			} while (read_seqcount_retry(&fp->seqcount, s));
+			fp->status.link = !fp->no_carrier;
+
+			/* Issue callback if user registered it. */
+			if (fp->link_update)
+				fp->link_update(fp->phydev->attached_dev,
+						&fp->status);
+
+			/* Check the GPIO for change in status */
+			fixed_phy_update(fp);
+			state = fp->status;
 
 			return swphy_read_reg(reg_num, &state);
 		}
@@ -150,8 +146,6 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 	if (!fp)
 		return -ENOMEM;
 
-	seqcount_init(&fp->seqcount);
-
 	if (irq != PHY_POLL)
 		fmb->mii_bus->irq[phy_addr] = irq;
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 9bb9f37f21dc3..f7c01646b25c3 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -740,6 +740,7 @@ EXPORT_SYMBOL(mdiobus_scan);
 
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
+	preempt_disable();
 	u64_stats_update_begin(&stats->syncp);
 
 	u64_stats_inc(&stats->transfers);
@@ -754,6 +755,7 @@ static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 		u64_stats_inc(&stats->writes);
 out:
 	u64_stats_update_end(&stats->syncp);
+	preempt_enable();
 }
 
 /**
diff --git a/fs/dcache.c b/fs/dcache.c
index a6b6d7eb6f15d..ab1adb4cc0f3c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1727,7 +1727,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
 	spin_lock_init(&dentry->d_lock);
-	seqcount_init(&dentry->d_seq);
+	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
 	dentry->d_sb = sb;
@@ -3146,8 +3146,6 @@ __setup("dhash_entries=", set_dhash_entries);
 
 static void __init dcache_init_early(void)
 {
-	unsigned int loop;
-
 	/* If hashes are distributed across NUMA nodes, defer
 	 * hash allocation until vmalloc space is available.
 	 */
@@ -3164,16 +3162,11 @@ static void __init dcache_init_early(void)
 					NULL,
 					0,
 					0);
-
-	for (loop = 0; loop < (1U << d_hash_shift); loop++)
-		INIT_HLIST_BL_HEAD(dentry_hashtable + loop);
-
 	d_hash_shift = 32 - d_hash_shift;
 }
 
 static void __init dcache_init(void)
 {
-	unsigned int loop;
 	/*
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
@@ -3197,10 +3190,6 @@ static void __init dcache_init(void)
 					NULL,
 					0,
 					0);
-
-	for (loop = 0; loop < (1U << d_hash_shift); loop++)
-		INIT_HLIST_BL_HEAD(dentry_hashtable + loop);
-
 	d_hash_shift = 32 - d_hash_shift;
 }
 
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index ca639ed967b7a..04b3f5b9c6295 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -117,7 +117,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		fs->users = 1;
 		fs->in_exec = 0;
 		spin_lock_init(&fs->lock);
-		seqcount_init(&fs->seq);
+		seqcount_spinlock_init(&fs->seq, &fs->lock);
 		fs->umask = old->umask;
 
 		spin_lock(&old->lock);
@@ -163,6 +163,6 @@ EXPORT_SYMBOL(current_umask);
 struct fs_struct init_fs = {
 	.users		= 1,
 	.lock		= __SPIN_LOCK_UNLOCKED(init_fs.lock),
-	.seq		= SEQCNT_ZERO(init_fs.seq),
+	.seq		= SEQCNT_SPINLOCK_ZERO(init_fs.seq, &init_fs.lock),
 	.umask		= 0022,
 };
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 5508d92e3f8fc..0ce39658a6200 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -958,11 +958,3 @@ int __fscache_check_consistency(struct fscache_cookie *cookie,
 	return -ESTALE;
 }
 EXPORT_SYMBOL(__fscache_check_consistency);
-
-void __init fscache_cookie_init(void)
-{
-	int i;
-
-	for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
-		INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
-}
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index f9625eb898530..59c2494efda34 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -145,7 +145,6 @@ static int __init fscache_init(void)
 		ret = -ENOMEM;
 		goto error_cookie_jar;
 	}
-	fscache_cookie_init();
 
 	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
 	if (!fscache_root)
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index eba641b5f4f2d..1865322de142d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -195,11 +195,11 @@ static int nfs_delegation_claim_opens(struct inode *inode,
 		sp = state->owner;
 		/* Block nfs4_proc_unlck */
 		mutex_lock(&sp->so_delegreturn_mutex);
-		seq = read_seqbegin(&sp->so_reclaim_seqlock);
+		seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
 		err = nfs4_open_delegation_recall(ctx, state, stateid);
 		if (!err)
 			err = nfs_delegation_claim_locks(state, stateid);
-		if (!err && read_seqretry(&sp->so_reclaim_seqlock, seq))
+		if (!err && read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
 			err = -EAGAIN;
 		mutex_unlock(&sp->so_delegreturn_mutex);
 		put_nfs_open_context(ctx);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3a1621e7268f2..ea4e4b7279f3e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1964,11 +1964,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 
 	trace_nfs_rmdir_enter(dir, dentry);
 	if (d_really_is_positive(dentry)) {
-#ifdef CONFIG_PREEMPT_RT
-		down(&NFS_I(d_inode(dentry))->rmdir_sem);
-#else
 		down_write(&NFS_I(d_inode(dentry))->rmdir_sem);
-#endif
 		error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
 		/* Ensure the VFS deletes this inode */
 		switch (error) {
@@ -1978,11 +1974,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 		case -ENOENT:
 			nfs_dentry_handle_enoent(dentry);
 		}
-#ifdef CONFIG_PREEMPT_RT
-		up(&NFS_I(d_inode(dentry))->rmdir_sem);
-#else
 		up_write(&NFS_I(d_inode(dentry))->rmdir_sem);
-#endif
 	} else
 		error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
 	trace_nfs_rmdir_exit(dir, dentry, error);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b801e63e8c4b7..a10fb87c6ac33 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2111,11 +2111,7 @@ static void init_once(void *foo)
 	atomic_long_set(&nfsi->nrequests, 0);
 	atomic_long_set(&nfsi->commit_info.ncommit, 0);
 	atomic_set(&nfsi->commit_info.rpcs_out, 0);
-#ifdef CONFIG_PREEMPT_RT
-	sema_init(&nfsi->rmdir_sem, 1);
-#else
 	init_rwsem(&nfsi->rmdir_sem);
-#endif
 	mutex_init(&nfsi->commit_mutex);
 	nfs4_init_once(nfsi);
 	nfsi->cache_change_attribute = 0;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 929ad7770f63d..1b3cfcbd702c6 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -115,7 +115,7 @@ struct nfs4_state_owner {
 	unsigned long	     so_flags;
 	struct list_head     so_states;
 	struct nfs_seqid_counter so_seqid;
-	seqlock_t	     so_reclaim_seqlock;
+	seqcount_spinlock_t  so_reclaim_seqcount;
 	struct mutex	     so_delegreturn_mutex;
 };
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 289e4b53cb5cd..1b1e21bcb9940 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2979,7 +2979,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	unsigned int seq;
 	int ret;
 
-	seq = raw_seqcount_begin(&sp->so_reclaim_seqlock.seqcount);
+	seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
 	dir_verifier = nfs_save_change_attribute(dir);
 
 	ret = _nfs4_proc_open(opendata, ctx);
@@ -3033,7 +3033,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 
 	if (d_inode(dentry) == state->inode) {
 		nfs_inode_attach_open_context(ctx);
-		if (read_seqretry(&sp->so_reclaim_seqlock, seq))
+		if (read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
 			nfs4_schedule_stateid_recovery(server, state);
 	}
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 297ca56a4ef0a..2aada0449a46e 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -509,7 +509,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	nfs4_init_seqid_counter(&sp->so_seqid);
 	atomic_set(&sp->so_count, 1);
 	INIT_LIST_HEAD(&sp->so_lru);
-	seqlock_init(&sp->so_reclaim_seqlock);
+	seqcount_spinlock_init(&sp->so_reclaim_seqcount, &sp->so_lock);
 	mutex_init(&sp->so_delegreturn_mutex);
 	return sp;
 }
@@ -1639,12 +1639,8 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	 * recovering after a network partition or a reboot from a
 	 * server that doesn't support a grace period.
 	 */
-#ifdef CONFIG_PREEMPT_RT
-	write_seqlock(&sp->so_reclaim_seqlock);
-#else
-	write_seqcount_begin(&sp->so_reclaim_seqlock.seqcount);
-#endif
 	spin_lock(&sp->so_lock);
+	raw_write_seqcount_begin(&sp->so_reclaim_seqcount);
 restart:
 	list_for_each_entry(state, &sp->so_states, open_states) {
 		if (!test_and_clear_bit(ops->state_flag_bit, &state->flags))
@@ -1712,12 +1708,8 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 		spin_lock(&sp->so_lock);
 		goto restart;
 	}
+	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
 	spin_unlock(&sp->so_lock);
-#ifdef CONFIG_PREEMPT_RT
-	write_sequnlock(&sp->so_reclaim_seqlock);
-#else
-	write_seqcount_end(&sp->so_reclaim_seqlock.seqcount);
-#endif
 #ifdef CONFIG_NFS_V4_2
 	if (found_ssc_copy_state)
 		return -EIO;
@@ -1725,11 +1717,9 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	return 0;
 out_err:
 	nfs4_put_open_state(state);
-#ifdef CONFIG_PREEMPT_RT
-	write_sequnlock(&sp->so_reclaim_seqlock);
-#else
-	write_seqcount_end(&sp->so_reclaim_seqlock.seqcount);
-#endif
+	spin_lock(&sp->so_lock);
+	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
+	spin_unlock(&sp->so_lock);
 	return status;
 }
 
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index efa5adce9b309..d8961f327bee7 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -53,29 +53,6 @@ static void nfs_async_unlink_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 }
 
-#ifdef CONFIG_PREEMPT_RT
-static void nfs_down_anon(struct semaphore *sema)
-{
-	down(sema);
-}
-
-static void nfs_up_anon(struct semaphore *sema)
-{
-	up(sema);
-}
-
-#else
-static void nfs_down_anon(struct rw_semaphore *rwsem)
-{
-	down_read_non_owner(rwsem);
-}
-
-static void nfs_up_anon(struct rw_semaphore *rwsem)
-{
-	up_read_non_owner(rwsem);
-}
-#endif
-
 /**
  * nfs_async_unlink_release - Release the sillydelete data.
  * @calldata: struct nfs_unlinkdata to release
@@ -89,7 +66,7 @@ static void nfs_async_unlink_release(void *calldata)
 	struct dentry *dentry = data->dentry;
 	struct super_block *sb = dentry->d_sb;
 
-	nfs_up_anon(&NFS_I(d_inode(dentry->d_parent))->rmdir_sem);
+	up_read_non_owner(&NFS_I(d_inode(dentry->d_parent))->rmdir_sem);
 	d_lookup_done(dentry);
 	nfs_free_unlinkdata(data);
 	dput(dentry);
@@ -142,10 +119,10 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct inode *dir = d_inode(dentry->d_parent);
 	struct dentry *alias;
 
-	nfs_down_anon(&NFS_I(dir)->rmdir_sem);
+	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
 	alias = d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
 	if (IS_ERR(alias)) {
-		nfs_up_anon(&NFS_I(dir)->rmdir_sem);
+		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
 	}
 	if (!d_in_lookup(alias)) {
@@ -167,7 +144,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 			ret = 0;
 		spin_unlock(&alias->d_lock);
 		dput(alias);
-		nfs_up_anon(&NFS_I(dir)->rmdir_sem);
+		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		/*
 		 * If we'd displaced old cached devname, free it.  At that
 		 * point dentry is definitely not a root, so we won't need
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9a593ccf74b9e..69c1e4d4173ef 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -61,7 +61,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	seqlock_t refile_seq;
+	seqcount_spinlock_t refile_seq;
 	/* pseudo fd refcounting */
 	refcount_t refcount;
 	/* userfaultfd syscall flags */
@@ -1063,7 +1063,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqlock(&ctx->refile_seq);
+			write_seqcount_begin(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1089,7 +1089,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_sequnlock(&ctx->refile_seq);
+			write_seqcount_end(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1262,11 +1262,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	 * sure we've userfaults to wake.
 	 */
 	do {
-		seq = read_seqbegin(&ctx->refile_seq);
+		seq = read_seqcount_begin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
 		cond_resched();
-	} while (read_seqretry(&ctx->refile_seq, seq));
+	} while (read_seqcount_retry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
 }
@@ -1940,7 +1940,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqlock_init(&ctx->refile_seq);
+	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index d7fd61cbb2c75..bb32fe1cd1379 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -89,7 +89,7 @@ extern struct dentry_stat_t dentry_stat;
 struct dentry {
 	/* RCU lookup touched fields */
 	unsigned int d_flags;		/* protected by d_lock */
-	seqcount_t d_seq;		/* per dentry seqlock */
+	seqcount_spinlock_t d_seq;	/* per dentry seqlock */
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 81272ca122ee5..d44a77e8a7e34 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -46,8 +46,6 @@
 #include <linux/rcupdate.h>
 
 extern struct ww_class reservation_ww_class;
-extern struct lock_class_key reservation_seqcount_class;
-extern const char reservation_seqcount_string[];
 
 /**
  * struct dma_resv_list - a list of shared fences
@@ -65,13 +63,13 @@ struct dma_resv_list {
 /**
  * struct dma_resv - a reservation object manages fences for a buffer
  * @lock: update side lock
- * @seq: sequence lock for managing RCU read-side synchronization
+ * @seq: sequence count for managing RCU read-side synchronization
  * @fence_excl: the exclusive fence, if there is one currently
  * @fence: list of current shared fences
  */
 struct dma_resv {
 	struct ww_mutex lock;
-	seqlock_t seq;
+	seqcount_ww_mutex_t seq;
 
 	struct dma_fence __rcu *fence_excl;
 	struct dma_resv_list __rcu *fence;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index cf1015abfbf23..783b48dedb723 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -9,7 +9,7 @@
 struct fs_struct {
 	int users;
 	spinlock_t lock;
-	seqcount_t seq;
+	seqcount_spinlock_t seq;
 	int umask;
 	int in_exec;
 	struct path root, pwd;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 164bfe4d207d0..ad044c0cb1f3b 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -226,7 +226,6 @@ extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
 				    bool (*)(void *), void *);
-extern void fscache_cookie_init(void);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 07dc91835b989..e448d48869791 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -752,9 +752,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	preempt_disable();
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
+	preempt_enable();
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	part->nr_sects = size;
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 15c8ac3136780..25993b86ac5ca 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -159,7 +159,7 @@ struct hrtimer_clock_base {
 	struct hrtimer_cpu_base	*cpu_base;
 	unsigned int		index;
 	clockid_t		clockid;
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct hrtimer		*running;
 	struct timerqueue_head	active;
 	ktime_t			(*get_time)(void);
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index dc1da020305b6..dac047abdba7c 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -42,7 +42,7 @@ struct kvm_kernel_irqfd {
 	wait_queue_entry_t wait;
 	/* Update side is protected by irqfds.lock */
 	struct kvm_kernel_irq_routing_entry irq_entry;
-	seqcount_t irq_entry_sc;
+	seqcount_spinlock_t irq_entry_sc;
 	/* Used for level IRQ fast-path */
 	int gsi;
 	struct work_struct inject;
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 83e0ec90ed0d5..ae1b541446c90 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -3,7 +3,6 @@
 #define _LINUX_LIST_BL_H
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
 #include <linux/bit_spinlock.h>
 
 /*
@@ -34,24 +33,13 @@
 
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
-#ifdef CONFIG_PREEMPT_RT
-	raw_spinlock_t lock;
-#endif
 };
 
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
-
-#ifdef CONFIG_PREEMPT_RT
-#define INIT_HLIST_BL_HEAD(h)		\
-do {					\
-	(h)->first = NULL;		\
-	raw_spin_lock_init(&(h)->lock);	\
-} while (0)
-#else
-#define INIT_HLIST_BL_HEAD(h) (h)->first = NULL
-#endif
+#define INIT_HLIST_BL_HEAD(ptr) \
+	((ptr)->first = NULL)
 
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
@@ -157,26 +145,12 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
-#ifndef CONFIG_PREEMPT_RT
 	bit_spin_lock(0, (unsigned long *)b);
-#else
-	raw_spin_lock(&b->lock);
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	__set_bit(0, (unsigned long *)b);
-#endif
-#endif
 }
 
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 {
-#ifndef CONFIG_PREEMPT_RT
 	__bit_spin_unlock(0, (unsigned long *)b);
-#else
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	__clear_bit(0, (unsigned long *)b);
-#endif
-	raw_spin_unlock(&b->lock);
-#endif
 }
 
 static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f277621a36888..5d5b91e54f736 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -165,11 +165,7 @@ struct nfs_inode {
 
 	/* Readers: in-flight sillydelete RPC calls */
 	/* Writers: rmdir */
-#ifdef CONFIG_PREEMPT_RT
-	struct semaphore        rmdir_sem;
-#else
 	struct rw_semaphore	rmdir_sem;
-#endif
 	struct mutex		commit_mutex;
 
 	/* track last access to cached pages */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ca4881f38545d..020a12bea8142 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1069,7 +1069,7 @@ struct task_struct {
 	/* Protected by ->alloc_lock: */
 	nodemask_t			mems_allowed;
 	/* Seqence number to catch updates: */
-	seqcount_t			mems_allowed_seq;
+	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
 	int				cpuset_slab_spread_rotor;
 #endif
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 41d756244843c..538cb44a6bee9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1,36 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_SEQLOCK_H
 #define __LINUX_SEQLOCK_H
+
 /*
- * Reader/writer consistent mechanism without starving writers. This type of
- * lock for data where the reader wants a consistent set of information
- * and is willing to retry if the information changes. There are two types
- * of readers:
- * 1. Sequence readers which never block a writer but they may have to retry
- *    if a writer is in progress by detecting change in sequence number.
- *    Writers do not wait for a sequence reader.
- * 2. Locking readers which will wait if a writer or another locking reader
- *    is in progress. A locking reader in progress will also block a writer
- *    from going forward. Unlike the regular rwlock, the read lock here is
- *    exclusive so that only one locking reader can get it.
+ * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
+ * lockless readers (read-only retry loops), and no writer starvation.
  *
- * This is not as cache friendly as brlock. Also, this may not work well
- * for data that contains pointers, because any writer could
- * invalidate a pointer that a reader was following.
+ * See Documentation/locking/seqlock.rst for full description.
  *
- * Expected non-blocking reader usage:
- * 	do {
- *	    seq = read_seqbegin(&foo);
- * 	...
- *      } while (read_seqretry(&foo, seq));
- *
- *
- * On non-SMP the spin locks disappear but the writer still needs
- * to increment the sequence variables because an interrupt routine could
- * change the state of the data.
- *
- * Based on x86_64 vsyscall gettimeofday 
- * by Keith Owens and Andrea Arcangeli
+ * Copyrights:
+ * - Based on x86_64 vsyscall gettimeofday: Keith Owens, Andrea Arcangeli
  */
 
 #include <linux/spinlock.h>
@@ -40,10 +19,28 @@
 #include <asm/processor.h>
 
 /*
- * Version using sequence counter only.
- * This can be used when code has its own mutex protecting the
- * updating starting before the write_seqcountbeqin() and ending
- * after the write_seqcount_end().
+ * Sequence counters (seqcount_t)
+ *
+ * This is the raw counting mechanism, without any writer protection.
+ *
+ * Write side critical sections must be serialized and non-preemptible.
+ *
+ * If readers can be invoked from hardirq or softirq contexts,
+ * interrupts or bottom halves must also be respectively disabled before
+ * entering the write section.
+ *
+ * This mechanism can't be used if the protected data contains pointers,
+ * as the writer can invalidate a pointer that a reader is following.
+ *
+ * If the write serialization mechanism is one of the common kernel
+ * locking primitives, use a sequence counter with associated lock
+ * (seqcount_LOCKTYPE_t) instead.
+ *
+ * If it's desired to automatically handle the sequence counter writer
+ * serialization and non-preemptibility requirements, use a sequential
+ * lock (seqlock_t) instead.
+ *
+ * See Documentation/locking/seqlock.rst
  */
 typedef struct seqcount {
 	unsigned sequence;
@@ -66,6 +63,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the &typedef seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -89,12 +90,15 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
-#define SEQCNT_ZERO(lockname) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(lockname)}
-
+/**
+ * SEQCNT_ZERO() - static initializer for seqcount_t
+ * @name: Name of the &typedef seqcount_t instance
+ */
+#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 /**
- * __read_seqcount_begin - begin a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_begin() - begin a seq-read critical section (without barrier)
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
@@ -105,7 +109,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline unsigned __read_seqcount_begin(const seqcount_t *s)
+#define __read_seqcount_begin(s)	do___read_seqcount_begin(s)
+
+static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
@@ -119,15 +125,18 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
+ * raw_read_seqcount() - Read the raw seqcount
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
  * raw_read_seqcount opens a read critical section of the given
- * seqcount without any lockdep checking and without checking or
- * masking the LSB. Calling code is responsible for handling that.
+ * seqcount_t, without any lockdep checks and without checking or
+ * masking the sequence counter LSB. Calling code is responsible for
+ * handling that.
  */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
+#define raw_read_seqcount(s)	do_raw_read_seqcount(s)
+
+static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -135,42 +144,46 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
- * @s: pointer to seqcount_t
+ * raw_read_seqcount_begin() - start seq-read critical section w/o lockdep
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
  * raw_read_seqcount_begin opens a read critical section of the given
- * seqcount, but without any lockdep checking. Validity of the critical
- * section is tested by checking read_seqcount_retry function.
+ * seqcount_t, but without any lockdep checking. Validity of the read
+ * section must be checked with read_seqcount_retry().
  */
-static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
+#define raw_read_seqcount_begin(s)	do_raw_read_seqcount_begin(s)
+
+static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
 {
-	unsigned ret = __read_seqcount_begin(s);
+	unsigned ret = __read_seqcount_t_begin(s);
 	smp_rmb();
 	return ret;
 }
 
 /**
- * read_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_begin() - begin a seq-read critical section
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
- * read_seqcount_begin opens a read critical section of the given seqcount.
- * Validity of the critical section is tested by checking read_seqcount_retry
- * function.
+ * read_seqcount_begin opens a read critical section of the given
+ * seqcount_t. Validity of the read section must be checked with
+ * read_seqcount_retry().
  */
-static inline unsigned read_seqcount_begin(const seqcount_t *s)
+#define read_seqcount_begin(s)	do_read_seqcount_begin(s)
+
+static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
 {
 	seqcount_lockdep_reader_access(s);
-	return raw_read_seqcount_begin(s);
+	return raw_read_seqcount_t_begin(s);
 }
 
 /**
- * raw_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * raw_seqcount_begin() - begin a seq-read critical section
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
- * raw_seqcount_begin opens a read critical section of the given seqcount.
+ * raw_seqcount_begin opens a read critical section of the given seqcount_t.
  * Validity of the critical section is tested by checking read_seqcount_retry
  * function.
  *
@@ -179,7 +192,9 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
  * read_seqcount_retry() instead of stabilizing at the beginning of the
  * critical section.
  */
-static inline unsigned raw_seqcount_begin(const seqcount_t *s)
+#define raw_seqcount_begin(s)	do_raw_seqcount_begin(s)
+
+static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -187,8 +202,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_retry() - end a seq-read critical section (without barrier)
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -200,58 +215,54 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define __read_seqcount_retry(s, start)	do___read_seqcount_retry(s, start)
+
+static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
 	return unlikely(s->sequence != start);
 }
 
 /**
- * read_seqcount_retry - end a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_retry() - end a seq-read critical section
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
- * read_seqcount_retry closes a read critical section of the given seqcount.
+ * read_seqcount_retry closes a read critical section of given seqcount_t.
  * If the critical section was invalid, it must be ignored (and typically
  * retried).
  */
-static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define read_seqcount_retry(s, start)	do_read_seqcount_retry(s, start)
+
+static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_retry(s, start);
+	return __read_seqcount_t_retry(s, start);
 }
 
-static inline void __raw_write_seqcount_begin(seqcount_t *s)
+#define raw_write_seqcount_begin(s)	do_raw_write_seqcount_begin(s)
+
+static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 {
 	s->sequence++;
 	smp_wmb();
 }
 
-static inline void raw_write_seqcount_begin(seqcount_t *s)
-{
-	preempt_disable_rt();
-	__raw_write_seqcount_begin(s);
-}
+#define raw_write_seqcount_end(s)	do_raw_write_seqcount_end(s)
 
-static inline void __raw_write_seqcount_end(seqcount_t *s)
+static inline void raw_write_seqcount_t_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
 }
 
-static inline void raw_write_seqcount_end(seqcount_t *s)
-{
-	__raw_write_seqcount_end(s);
-	preempt_enable_rt();
-}
-
 /**
- * raw_write_seqcount_barrier - do a seq write barrier
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_barrier() - do a seq write barrier
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
- * collapse the two back-to-back wmb()s.
+ * collapse the two back-to-back wmb()s::
  *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
@@ -279,14 +290,33 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *              X = false;
  *      }
  */
-static inline void raw_write_seqcount_barrier(seqcount_t *s)
+#define raw_write_seqcount_barrier(s)	do_raw_write_seqcount_barrier(s)
+
+static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
 }
 
-static inline int raw_read_seqcount_latch(seqcount_t *s)
+/**
+ * raw_read_seqcount_latch() - pick even or odd seqcount latch data copy
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ *
+ * Use seqcount latching to switch between two storage places with
+ * sequence protection to allow interruptible, preemptible, writer
+ * sections.
+ *
+ * Check raw_write_seqcount_latch() for more details and a full reader
+ * and writer usage example.
+ *
+ * Return: sequence counter. Use the lowest bit as index for picking
+ * which data copy to read. Full counter must then be checked with
+ * read_seqcount_retry().
+ */
+#define raw_read_seqcount_latch(s)	do_raw_read_seqcount_latch(s)
+
+static inline int raw_read_seqcount_t_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
 	int seq = READ_ONCE(s->sequence); /* ^^^ */
@@ -294,8 +324,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -311,213 +341,561 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  * Very simply put: we first modify one copy and then the other. This ensures
  * there is always one copy in a stable state, ready to give us an answer.
  *
- * The basic form is a data structure like:
+ * The basic form is a data structure like::
  *
- * struct latch_struct {
- *	seqcount_t		seq;
- *	struct data_struct	data[2];
- * };
+ *	struct latch_struct {
+ *		seqcount_t		seq;
+ *		struct data_struct	data[2];
+ *	};
  *
  * Where a modification, which is assumed to be externally serialized, does the
- * following:
+ * following::
  *
- * void latch_modify(struct latch_struct *latch, ...)
- * {
- *	smp_wmb();	<- Ensure that the last data[1] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ *	void latch_modify(struct latch_struct *latch, ...)
+ *	{
+ *		smp_wmb();	// Ensure that the last data[1] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
  *
- *	modify(latch->data[0], ...);
+ *		modify(latch->data[0], ...);
  *
- *	smp_wmb();	<- Ensure that the data[0] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ *		smp_wmb();	// Ensure that the data[0] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
  *
- *	modify(latch->data[1], ...);
- * }
+ *		modify(latch->data[1], ...);
+ *	}
  *
- * The query will have a form like:
+ * The query will have a form like::
  *
- * struct entry *latch_query(struct latch_struct *latch, ...)
- * {
- *	struct entry *entry;
- *	unsigned seq, idx;
+ *	struct entry *latch_query(struct latch_struct *latch, ...)
+ *	{
+ *		struct entry *entry;
+ *		unsigned seq, idx;
  *
- *	do {
- *		seq = raw_read_seqcount_latch(&latch->seq);
+ *		do {
+ *			seq = raw_read_seqcount_latch(&latch->seq);
  *
- *		idx = seq & 0x01;
- *		entry = data_query(latch->data[idx], ...);
+ *			idx = seq & 0x01;
+ *			entry = data_query(latch->data[idx], ...);
  *
- *		smp_rmb();
- *	} while (seq != latch->seq);
+ *			// read_seqcount_retry() includes necessary smp_rmb()
+ *		} while (read_seqcount_retry(&latch->seq, seq);
  *
- *	return entry;
- * }
+ *		return entry;
+ *	}
  *
  * So during the modification, queries are first redirected to data[1]. Then we
  * modify data[0]. When that is complete, we redirect queries back to data[0]
  * and we can modify data[1].
  *
- * NOTE: The non-requirement for atomic modifications does _NOT_ include
- *       the publishing of new entries in the case where data is a dynamic
- *       data structure.
+ * NOTE:
  *
- *       An iteration might start in data[0] and get suspended long enough
- *       to miss an entire modification sequence, once it resumes it might
- *       observe the new entry.
+ *	The non-requirement for atomic modifications does _NOT_ include
+ *	the publishing of new entries in the case where data is a dynamic
+ *	data structure.
  *
- * NOTE: When data is a dynamic data structure; one should use regular RCU
- *       patterns to manage the lifetimes of the objects within.
+ *	An iteration might start in data[0] and get suspended long enough
+ *	to miss an entire modification sequence, once it resumes it might
+ *	observe the new entry.
+ *
+ * NOTE:
+ *
+ *	When data is a dynamic data structure; one should use regular RCU
+ *	patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_t *s)
+#define raw_write_seqcount_latch(s)	do_raw_write_seqcount_latch(s)
+
+static inline void raw_write_seqcount_t_latch(seqcount_t *s)
 {
        smp_wmb();      /* prior stores before incrementing "sequence" */
        s->sequence++;
        smp_wmb();      /* increment "sequence" before following stores */
 }
 
-/*
- * Sequence counter only version assumes that callers are using their
- * own mutexing.
- */
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+#define write_seqcount_begin_nested(s, subclass)		\
+	do_write_seqcount_begin_nested(s, subclass)
+
+static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_begin(s);
+	raw_write_seqcount_t_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
-static inline void write_seqcount_begin(seqcount_t *s)
-{
-	write_seqcount_begin_nested(s, 0);
-}
+/**
+ * write_seqcount_begin() - start a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * write_seqcount_begin opens a write-side critical section of the given
+ * seqcount. Seqcount write-side critical sections must be externally
+ * serialized and non-preemptible.
+ */
+#define write_seqcount_begin(s)		do_write_seqcount_begin(s)
 
-static inline void write_seqcount_end(seqcount_t *s)
+static inline void write_seqcount_t_begin(seqcount_t *s)
 {
-	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_end(s);
+	write_seqcount_t_begin_nested(s, 0);
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_end() - end a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * The write section must've been opened with write_seqcount_begin().
+ */
+#define write_seqcount_end(s)		do_write_seqcount_end(s)
+
+static inline void write_seqcount_t_end(seqcount_t *s)
+{
+	seqcount_release(&s->dep_map, _RET_IP_);
+	raw_write_seqcount_t_end(s);
+}
+
+/**
+ * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
  */
-static inline void write_seqcount_invalidate(seqcount_t *s)
+#define write_seqcount_invalidate(s)	do_write_seqcount_invalidate(s)
+
+static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence+=2;
 }
 
+/*
+ * Sequence counters with associated locks (seqcount_LOCKTYPE_t)
+ *
+ * A sequence counter which associates the lock used for writer
+ * serialization at initialization time. This enables lockdep to validate
+ * that the write side critical section is properly serialized.
+ *
+ * For associated locks which do not implicitly disable preemption,
+ * preemption protection is enforced in the write side function.
+ *
+ * See Documentation/locking/seqlock.rst
+ */
+
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
+#define SEQCOUNT_ASSOC_LOCK
+#endif
+
+/**
+ * typedef seqcount_spinlock_t - sequence count with spinlock associated
+ * @seqcount:		The real sequence counter
+ * @lock:		Pointer to the associated spinlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * spinlock. The spinlock is associated to the sequence count in the
+ * static initializer or init function. This enables lockdep to validate
+ * that the write side critical section is properly serialized.
+ */
+typedef struct seqcount_spinlock {
+	seqcount_t      seqcount;
+#ifdef SEQCOUNT_ASSOC_LOCK
+	spinlock_t	*lock;
+#endif
+} seqcount_spinlock_t;
+
+#ifdef SEQCOUNT_ASSOC_LOCK
+
+#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {		\
+	.seqcount	= SEQCNT_ZERO(seq_name.seqcount),	\
+	.lock		= (assoc_lock),				\
+}
+
+/* Define as macro due to static lockdep key @ seqcount_init() */
+#define seqcount_locktype_init(s, assoc_lock)			\
+do {								\
+	seqcount_init(&(s)->seqcount);				\
+	(s)->lock = (assoc_lock);				\
+} while (0)
+
+#else /* !SEQCOUNT_ASSOC_LOCK */
+
+#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {		\
+	.seqcount	= SEQCNT_ZERO(seq_name.seqcount),	\
+}
+
+#define seqcount_locktype_init(s, assoc_lock)			\
+do {								\
+	seqcount_init(&(s)->seqcount);				\
+} while (0)
+
+#endif /* SEQCOUNT_ASSOC_LOCK */
+
+/**
+ * SEQCNT_SPINLOCK_ZERO - static initializer for seqcount_spinlock_t
+ * @name:	Name of the &typedef seqcount_spinlock_t instance
+ * @lock:	Pointer to the associated spinlock
+ */
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_spinlock_init - runtime initializer for seqcount_spinlock_t
+ * @s:		Pointer to the &typedef seqcount_spinlock_t instance
+ * @lock:	Pointer to the associated spinlock
+ */
+#define seqcount_spinlock_init(s, lock)		\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_raw_spinlock_t - sequence count with raw spinlock associated
+ * @seqcount:		The real sequence counter
+ * @lock:		Pointer to the associated raw spinlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * raw spinlock. The raw spinlock is associated to the sequence count in
+ * the static initializer or init function. This enables lockdep to
+ * validate that the write side critical section is properly serialized.
+ */
+typedef struct seqcount_raw_spinlock {
+	seqcount_t      seqcount;
+#ifdef SEQCOUNT_ASSOC_LOCK
+	raw_spinlock_t	*lock;
+#endif
+} seqcount_raw_spinlock_t;
+
+/**
+ * SEQCNT_RAW_SPINLOCK_ZERO - static initializer for seqcount_raw_spinlock_t
+ * @name:	Name of the &typedef seqcount_raw_spinlock_t instance
+ * @lock:	Pointer to the associated raw_spinlock
+ */
+#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_raw_spinlock_init - runtime initializer for seqcount_raw_spinlock_t
+ * @s:		Pointer to the &typedef seqcount_raw_spinlock_t instance
+ * @lock:	Pointer to the associated raw_spinlock
+ */
+#define seqcount_raw_spinlock_init(s, lock)	\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_rwlock_t - sequence count with rwlock associated
+ * @seqcount:		The real sequence counter
+ * @lock:		Pointer to the associated rwlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * rwlock. The rwlock is associated to the sequence count in the static
+ * initializer or init function. This enables lockdep to validate that
+ * the write side critical section is properly serialized.
+ */
+typedef struct seqcount_rwlock {
+	seqcount_t      seqcount;
+#ifdef SEQCOUNT_ASSOC_LOCK
+	rwlock_t	*lock;
+#endif
+} seqcount_rwlock_t;
+
+/**
+ * SEQCNT_RWLOCK_ZERO - static initializer for seqcount_rwlock_t
+ * @name:	Name of the &typedef seqcount_rwlock_t instance
+ * @lock:	Pointer to the associated rwlock
+ */
+#define SEQCNT_RWLOCK_ZERO(name, lock)		\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_rwlock_init - runtime initializer for seqcount_rwlock_t
+ * @s:		Pointer to the &typedef seqcount_rwlock_t instance
+ * @lock:	Pointer to the associated rwlock
+ */
+#define seqcount_rwlock_init(s, lock)		\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_mutex_t - sequence count with mutex associated
+ * @seqcount:		The real sequence counter
+ * @lock:		Pointer to the associated mutex
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * mutex. The mutex is associated to the sequence counter in the static
+ * initializer or init function. This enables lockdep to validate that
+ * the write side critical section is properly serialized.
+ *
+ * The write side API functions write_seqcount_begin()/end() automatically
+ * disable and enable preemption when used with seqcount_mutex_t.
+ */
+typedef struct seqcount_mutex {
+	seqcount_t      seqcount;
+#ifdef SEQCOUNT_ASSOC_LOCK
+	struct mutex	*lock;
+#endif
+} seqcount_mutex_t;
+
+/**
+ * SEQCNT_MUTEX_ZERO - static initializer for seqcount_mutex_t
+ * @name:	Name of the &typedef seqcount_mutex_t instance
+ * @lock:	Pointer to the associated mutex
+ */
+#define SEQCNT_MUTEX_ZERO(name, lock)		\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_mutex_init - runtime initializer for seqcount_mutex_t
+ * @s:		Pointer to the &typedef seqcount_mutex_t instance
+ * @lock:	Pointer to the associated mutex
+ */
+#define seqcount_mutex_init(s, lock)		\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_ww_mutex_t - sequence count with ww_mutex associated
+ * @seqcount:		The real sequence counter
+ * @lock:		Pointer to the associated ww_mutex
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * ww_mutex. The ww_mutex is associated to the sequence counter in the static
+ * initializer or init function. This enables lockdep to validate that
+ * the write side critical section is properly serialized.
+ *
+ * The write side API functions write_seqcount_begin()/end() automatically
+ * disable and enable preemption when used with seqcount_ww_mutex_t.
+ */
+typedef struct seqcount_ww_mutex {
+	seqcount_t      seqcount;
+#ifdef SEQCOUNT_ASSOC_LOCK
+	struct ww_mutex	*lock;
+#endif
+} seqcount_ww_mutex_t;
+
+/**
+ * SEQCNT_WW_MUTEX_ZERO - static initializer for seqcount_ww_mutex_t
+ * @name:	Name of the &typedef seqcount_ww_mutex_t instance
+ * @lock:	Pointer to the associated ww_mutex
+ */
+#define SEQCNT_WW_MUTEX_ZERO(name, lock)	\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_ww_mutex_init - runtime initializer for seqcount_ww_mutex_t
+ * @s:		Pointer to the &typedef seqcount_ww_mutex_t instance
+ * @lock:	Pointer to the associated ww_mutex
+ */
+#define seqcount_ww_mutex_init(s, lock)		\
+	seqcount_locktype_init(s, lock)
+
+#include <linux/seqlock_types_internal.h>
+
+/*
+ * Sequential locks (seqlock_t)
+ *
+ * Sequence counters with an embedded spinlock for writer serialization
+ * and non-preemptibility.
+ *
+ * For more info, see:
+ *   - Comments on top of seqcount_t
+ *   - Documentation/locking/seqlock.rst
+ */
 typedef struct {
 	struct seqcount seqcount;
 	spinlock_t lock;
 } seqlock_t;
 
-/*
- * These macros triggered gcc-3.x compile-time problems.  We think these are
- * OK now.  Be cautious.
- */
 #define __SEQLOCK_UNLOCKED(lockname)			\
 	{						\
 		.seqcount = SEQCNT_ZERO(lockname),	\
 		.lock =	__SPIN_LOCK_UNLOCKED(lockname)	\
 	}
 
-#define seqlock_init(x)					\
+/**
+ * seqlock_init() - dynamic initializer for seqlock_t
+ * @sl: Pointer to the &typedef seqlock_t instance
+ */
+#define seqlock_init(sl)				\
 	do {						\
-		seqcount_init(&(x)->seqcount);		\
-		spin_lock_init(&(x)->lock);		\
+		seqcount_init(&(sl)->seqcount);		\
+		spin_lock_init(&(sl)->lock);		\
 	} while (0)
 
-#define DEFINE_SEQLOCK(x) \
-		seqlock_t x = __SEQLOCK_UNLOCKED(x)
+/**
+ * DEFINE_SEQLOCK() - Define a statically-allocated seqlock_t
+ * @sl: Name of the &typedef seqlock_t instance
+ */
+#define DEFINE_SEQLOCK(sl) \
+		seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
+
+/**
+ * read_seqbegin() - start a seqlock_t read-side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * read_seqbegin opens a read side critical section of the given
+ * seqlock_t. Validity of the critical section is tested by checking
+ * read_seqretry().
+ *
+ * Return: count to be passed to read_seqretry()
+ */
 
 /*
- * Read side functions for starting and finalizing a read side section.
+ * For PREEMPT_RT, preemption cannot be disabled upon entering the write
+ * side critical section. With disabled preemption:
+ *
+ *   - The writer cannot be preempted by a task with higher priority
+ *
+ *   - The writer cannot acquire a spinlock_t since it's a sleeping
+ *     lock.  This would invalidate the existing, and non-PREEMPT_RT
+ *     valid, code pattern of acquiring a spinlock_t inside the seqcount
+ *     write side critical section.
+ *
+ * To remain preemptible, while avoiding a livelock caused by the reader
+ * preempting the writer, use a different technique:
+ *
+ *   - If the sequence counter is even upon entering a read side
+ *     section, then no writer is in progress, and the reader did not
+ *     preempt any write side sections. It can continue.
+ *
+ *   - If the counter is odd, a writer is in progress and the reader may
+ *     have preempted a write side section. Let the reader acquire the
+ *     lock used for seqcount writer serialization, which is already
+ *     held by the writer.
+ *
+ *     The higher-priority reader will block on the lock, and the
+ *     lower-priority preempted writer will make progress until it
+ *     finishes its write serialization lock critical section.
+ *
+ *     Once the reader has the writer serialization lock acquired, the
+ *     writer is finished and the counter is even. Drop the writer
+ *     serialization lock and re-read the sequence counter.
+ *
+ * This technique must be implemented for all PREEMPT_RT sleeping locks.
  */
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_RT
+
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	return read_seqcount_begin(&sl->seqcount);
-}
-#else
-/*
- * Starvation safe read side for RT
- */
-static inline unsigned read_seqbegin(seqlock_t *sl)
-{
-	unsigned ret;
+	unsigned seq;
+
+	seqcount_lockdep_reader_access(&sl->seqcount);
+
+	do {
+		seq = READ_ONCE(sl->seqcount.sequence);
+		if (unlikely(seq & 1)) {
+			seqlock_t *msl = (seqlock_t *)sl;
+			spin_lock(&msl->lock);
+			spin_unlock(&msl->lock);
+		}
+	} while (unlikely(seq & 1));
 
-repeat:
-	ret = READ_ONCE(sl->seqcount.sequence);
-	if (unlikely(ret & 1)) {
-		/*
-		 * Take the lock and let the writer proceed (i.e. evtl
-		 * boost it), otherwise we could loop here forever.
-		 */
-		rt_spin_lock_unlock(&sl->lock);
-		goto repeat;
-	}
 	smp_rmb();
-	return ret;
+	return seq;
 }
+
+#else /* !CONFIG_PREEMPT_RT */
+
+static inline unsigned read_seqbegin(const seqlock_t *sl)
+{
+	return read_seqcount_t_begin(&sl->seqcount);
+}
+
 #endif
 
+/**
+ * read_seqretry() - end and validate a seqlock_t read side section
+ * @sl: Pointer to &typedef seqlock_t
+ * @start: count, from read_seqbegin()
+ *
+ * read_seqretry closes the given seqlock_t read side critical section,
+ * and checks its validity. If the read section was invalid, it must be
+ * ignored and retried.
+ *
+ * Return: 1 if a retry is required, 0 otherwise
+ */
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
-	return read_seqcount_retry(&sl->seqcount, start);
+	return read_seqcount_t_retry(&sl->seqcount, start);
 }
 
-/*
- * Lock out other writers and update the count.
- * Acts like a normal spin_lock/unlock.
- * Don't need preempt_disable() because that is in the spin_lock already.
+/**
+ * write_seqlock() - start a seqlock_t write side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_seqlock opens a write side critical section of the given
+ * seqlock_t.  It also acquires the spinlock_t embedded inside the
+ * sequential lock. All the seqlock_t write side critical sections are
+ * thus automatically serialized and non-preemptible.
+ *
+ * Use the ``_irqsave`` and ``_bh`` variants instead if the read side
+ * can be invoked from a hardirq or softirq context.
+ *
+ * The opened write side section must be closed with write_sequnlock().
  */
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	__raw_write_seqcount_begin(&sl->seqcount);
-}
-
-static inline int try_write_seqlock(seqlock_t *sl)
-{
-	if (spin_trylock(&sl->lock)) {
-		__raw_write_seqcount_begin(&sl->seqcount);
-		return 1;
-	}
-	return 0;
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock() - end a seqlock_t write side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_sequnlock closes the (serialized and non-preemptible) write
+ * side critical section of given seqlock_t.
+ */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	__raw_write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
+/**
+ * write_seqlock_bh() - start a softirqs-disabled seqlock_t write section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_bh`` variant of write_seqlock(). Use only if the read side section
+ * can be invoked from a softirq context.
+ *
+ * The opened write section must be closed with write_sequnlock_bh().
+ */
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	__raw_write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_bh() - end a softirqs-disabled seqlock_t write section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_sequnlock_bh closes the serialized, non-preemptible,
+ * softirqs-disabled, seqlock_t write side critical section opened with
+ * write_seqlock_bh().
+ */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	__raw_write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
+/**
+ * write_seqlock_irq() - start a non-interruptible seqlock_t write side section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * This is the ``_irq`` variant of write_seqlock(). Use only if the read
+ * section of given seqlock_t can be invoked from a hardirq context.
+ */
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	__raw_write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_irq() - end a non-interruptible seqlock_t write side section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_irq`` variant of write_sequnlock(). The write side section of
+ * given seqlock_t must've been opened with write_seqlock_irq().
+ */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	__raw_write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -526,44 +904,98 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	__raw_write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
+
 	return flags;
 }
 
+/**
+ * write_seqlock_irqsave() - start a non-interruptible seqlock_t write section
+ * @lock:  Pointer to &typedef seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to write_sequnlock_irqrestore().
+ *
+ * ``_irqsave`` variant of write_seqlock(). Use if the read section of
+ * given seqlock_t can be invoked from a hardirq context.
+ *
+ * The opened write section must be closed with write_sequnlock_irqrestore().
+ */
 #define write_seqlock_irqsave(lock, flags)				\
 	do { flags = __write_seqlock_irqsave(lock); } while (0)
 
+/**
+ * write_sequnlock_irqrestore() - end non-interruptible seqlock_t write section
+ * @sl:    Pointer to &typedef seqlock_t
+ * @flags: Caller's saved interrupt state, from write_seqlock_irqsave()
+ *
+ * ``_irqrestore`` variant of write_sequnlock(). The write section of
+ * given seqlock_t must've been opened with write_seqlock_irqsave().
+ */
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	__raw_write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-/*
- * A locking reader exclusively locks out other writers and locking readers,
- * but doesn't update the sequence number. Acts like a normal spin_lock/unlock.
- * Don't need preempt_disable() because that is in the spin_lock already.
+/**
+ * read_seqlock_excl() - begin a seqlock_t locking reader critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * read_seqlock_excl opens a locking reader critical section for the
+ * given seqlock_t. A locking reader exclusively locks out other writers
+ * and other *locking* readers, but doesn't update the sequence number.
+ *
+ * Locking readers act like a normal spin_lock()/spin_unlock().
+ *
+ * The opened read side section must be closed with read_sequnlock_excl().
  */
 static inline void read_seqlock_excl(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl() - end a seqlock_t locking reader critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * read_sequnlock_excl closes the locking reader critical section opened
+ * with read_seqlock_excl().
+ */
 static inline void read_sequnlock_excl(seqlock_t *sl)
 {
 	spin_unlock(&sl->lock);
 }
 
 /**
- * read_seqbegin_or_lock - begin a sequence number check or locking block
- * @lock: sequence lock
- * @seq : sequence number to be checked
+ * read_seqbegin_or_lock() - begin a seqlock_t lockless or locking reader
+ * @lock: Pointer to &typedef seqlock_t
+ * @seq : Marker and return parameter. If the passed value is even, the
+ * reader will become a *lockless* seqlock_t sequence counter reader as
+ * in read_seqbegin(). If the passed value is odd, the reader will
+ * become a fully locking reader, as in read_seqlock_excl().  In the
+ * first call to read_seqbegin_or_lock(), the caller **must** initialize
+ * and pass an even value to @seq so a lockless read is optimistically
+ * tried first.
  *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
+ * read_seqbegin_or_lock is an API designed to optimistically try a
+ * normal lockless seqlock_t read section first, as in read_seqbegin().
+ * If an odd counter is found, the normal lockless read trial has
+ * failed, and the next reader iteration transforms to a full seqlock_t
+ * locking reader as in read_seqlock_excl().
+ *
+ * This is typically used to avoid lockless seqlock_t readers starvation
+ * (too much retry loops) in the case of a sharp spike in write
+ * activity.
+ *
+ * The opened read section must be closed with done_seqretry().  Check
+ * Documentation/locking/seqlock.rst for template example code.
+ *
+ * Return: The encountered sequence counter value, returned through the
+ * @seq parameter, which is overloaded as a return parameter. The
+ * returned value must be checked with need_seqretry(). If the read
+ * section must be retried, the returned value must also be passed to
+ * the @seq parameter of the next read_seqbegin_or_lock() iteration.
  */
 static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 {
@@ -573,32 +1005,90 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 		read_seqlock_excl(lock);
 }
 
+/**
+ * need_seqretry() - validate seqlock_t "locking or lockless" reader section
+ * @lock: Pointer to &typedef seqlock_t
+ * @seq: count, from read_seqbegin_or_lock()
+ *
+ * need_seqretry checks if the seqlock_t read-side critical section
+ * started with read_seqbegin_or_lock() is valid. If it was not, the
+ * caller must retry the read-side section.
+ *
+ * Return: 1 if a retry is required, 0 otherwise
+ */
 static inline int need_seqretry(seqlock_t *lock, int seq)
 {
 	return !(seq & 1) && read_seqretry(lock, seq);
 }
 
+/**
+ * done_seqretry() - end seqlock_t "locking or lockless" reader section
+ * @lock: Pointer to &typedef seqlock_t
+ * @seq: count, from read_seqbegin_or_lock()
+ *
+ * done_seqretry finishes the seqlock_t read side critical section
+ * started by read_seqbegin_or_lock(). The read section must've been
+ * already validated with need_seqretry().
+ */
 static inline void done_seqretry(seqlock_t *lock, int seq)
 {
 	if (seq & 1)
 		read_sequnlock_excl(lock);
 }
 
+/**
+ * read_seqlock_excl_bh() - start a locking reader seqlock_t section
+ *			    with softirqs disabled
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_bh`` variant of read_seqlock_excl(). Use this variant if the
+ * seqlock_t write side section, *or other read sections*, can be
+ * invoked from a softirq context
+ *
+ * The opened section must be closed with read_sequnlock_excl_bh().
+ */
 static inline void read_seqlock_excl_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl_bh() - stop a seqlock_t softirq-disabled locking
+ *			      reader section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_bh`` variant of read_sequnlock_excl(). The closed section must've
+ * been opened with read_seqlock_excl_bh().
+ */
 static inline void read_sequnlock_excl_bh(seqlock_t *sl)
 {
 	spin_unlock_bh(&sl->lock);
 }
 
+/**
+ * read_seqlock_excl_irq() - start a non-interruptible seqlock_t locking
+ *			     reader section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_irq`` variant of read_seqlock_excl(). Use this only if the
+ * seqlock_t write side critical section, *or other read side sections*,
+ * can be invoked from a hardirq context.
+ *
+ * The opened read section must be closed with read_sequnlock_excl_irq().
+ */
 static inline void read_seqlock_excl_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl_irq() - end an interrupts-disabled seqlock_t
+ *                             locking reader section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * ``_irq`` variant of read_sequnlock_excl(). The closed section must've
+ * been opened with read_seqlock_excl_irq().
+ */
 static inline void read_sequnlock_excl_irq(seqlock_t *sl)
 {
 	spin_unlock_irq(&sl->lock);
@@ -612,15 +1102,59 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
 	return flags;
 }
 
+/**
+ * read_seqlock_excl_irqsave() - start a non-interruptible seqlock_t
+ *				 locking reader section
+ * @lock: Pointer to &typedef seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to read_sequnlock_excl_irqrestore().
+ *
+ * ``_irqsave`` variant of read_seqlock_excl(). Use this only if the
+ * seqlock_t write side critical section, *or other read side sections*,
+ * can be invoked from a hardirq context.
+ *
+ * Opened section must be closed with read_sequnlock_excl_irqrestore().
+ */
 #define read_seqlock_excl_irqsave(lock, flags)				\
 	do { flags = __read_seqlock_excl_irqsave(lock); } while (0)
 
+/**
+ * read_sequnlock_excl_irqrestore() - end non-interruptible seqlock_t
+ *				      locking reader section
+ * @sl: Pointer to &typedef seqlock_t
+ * @flags: Caller's saved interrupt state, from
+ *	   read_seqlock_excl_irqsave()
+ *
+ * ``_irqrestore`` variant of read_sequnlock_excl(). The closed section
+ * must've been opened with read_seqlock_excl_irqsave().
+ */
 static inline void
 read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
 {
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
+/**
+ * read_seqbegin_or_lock_irqsave() - begin a seqlock_t lockless reader, or
+ *                                   a non-interruptible locking reader
+ * @lock: Pointer to &typedef seqlock_t
+ * @seq: Marker and return parameter. Check read_seqbegin_or_lock().
+ *
+ * This is the ``_irqsave`` variant of read_seqbegin_or_lock(). Use if
+ * the seqlock_t write side critical section, *or other read side sections*,
+ * can be invoked from hardirq context.
+ *
+ * The validity of the read section must be checked with need_seqretry().
+ * The opened section must be closed with done_seqretry_irqrestore().
+ *
+ * Return:
+ *
+ *   1. The saved local interrupts state in case of a locking reader, to be
+ *      passed to done_seqretry_irqrestore().
+ *
+ *   2. The encountered sequence counter value, returned through @seq which
+ *      is overloaded as a return parameter. Check read_seqbegin_or_lock().
+ */
 static inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
@@ -634,6 +1168,18 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 	return flags;
 }
 
+/**
+ * done_seqretry_irqrestore() - end a seqlock_t lockless reader, or a
+ *				non-interruptible locking reader section
+ * @lock:  Pointer to &typedef seqlock_t
+ * @seq:   Count, from read_seqbegin_or_lock_irqsave()
+ * @flags: Caller's saved local interrupt state in case of a locking
+ *	   reader, also from read_seqbegin_or_lock_irqsave()
+ *
+ * This is the ``_irqrestore`` variant of done_seqretry(). The read
+ * section must've been opened with read_seqbegin_or_lock_irqsave(), and
+ * validated with need_seqretry().
+ */
 static inline void
 done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 {
diff --git a/include/linux/seqlock_types_internal.h b/include/linux/seqlock_types_internal.h
new file mode 100644
index 0000000000000..e99517c53f40e
--- /dev/null
+++ b/include/linux/seqlock_types_internal.h
@@ -0,0 +1,309 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SEQLOCK_TYPES_INTERNAL_H
+#define __LINUX_SEQLOCK_TYPES_INTERNAL_H
+
+/*
+ * Sequence counters with associated locks
+ *
+ * Copyright (C) 2020 Linutronix GmbH
+ */
+
+#ifndef __LINUX_SEQLOCK_H
+#error This is an INTERNAL header; it must only be included by seqlock.h
+#endif
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/ww_mutex.h>
+
+/*
+ * @s: pointer to seqcount_t or any of the seqcount_locktype_t variants
+ */
+#define __to_seqcount_t(s)						\
+({									\
+	seqcount_t *seq;						\
+									\
+	if (__same_type(*(s), seqcount_t))				\
+		seq = (seqcount_t *)(s);				\
+	else if (__same_type(*(s), seqcount_spinlock_t))		\
+		seq = &((seqcount_spinlock_t *)(s))->seqcount;		\
+	else if (__same_type(*(s), seqcount_raw_spinlock_t))		\
+		seq = &((seqcount_raw_spinlock_t *)(s))->seqcount;	\
+	else if (__same_type(*(s), seqcount_rwlock_t))			\
+		seq = &((seqcount_rwlock_t *)(s))->seqcount;		\
+	else if (__same_type(*(s), seqcount_mutex_t))			\
+		seq = &((seqcount_mutex_t *)(s))->seqcount;		\
+	else if (__same_type(*(s), seqcount_ww_mutex_t))		\
+		seq = &((seqcount_ww_mutex_t *)(s))->seqcount;		\
+	else								\
+		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");		\
+									\
+	seq;								\
+})
+
+/*
+ *	seqcount_LOCKTYPE_t -- write APIs
+ *
+ * For associated lock types which do not implicitly disable preemption,
+ * enforce preemption protection in the write side functions.
+ *
+ * Never use lockdep for the raw write variants.
+ */
+
+#ifdef CONFIG_PREEMPT_RT
+
+/*
+ * Do not disable preemption for PREEMPT_RT. Check comment on top of
+ * seqlock.h read_seqbegin() for rationale.
+ */
+#define __enforce_preemption_protection(s)			(false)
+
+#else
+
+#define __associated_lock_is_preemptible(s)				\
+({									\
+	bool ret;							\
+									\
+	if (__same_type(*(s), seqcount_t) ||				\
+	    __same_type(*(s), seqcount_spinlock_t) ||			\
+	    __same_type(*(s), seqcount_raw_spinlock_t) ||		\
+	    __same_type(*(s), seqcount_rwlock_t)) {			\
+		ret = false;						\
+	} else if (__same_type(*(s), seqcount_mutex_t) ||		\
+		   __same_type(*(s), seqcount_ww_mutex_t)) {		\
+		ret = true;						\
+	} else								\
+		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");		\
+									\
+	ret;								\
+})
+
+#define __enforce_preemption_protection(s)				\
+	__associated_lock_is_preemptible(s)
+
+#endif /* CONFIG_PREEMPT_RT */
+
+#ifdef CONFIG_LOCKDEP
+
+#define __assert_associated_lock_held(s)				\
+do {									\
+	if (__same_type(*(s), seqcount_t))				\
+		break;							\
+									\
+	if (__same_type(*(s), seqcount_spinlock_t))			\
+		lockdep_assert_held(((seqcount_spinlock_t *)(s))->lock);\
+	else if (__same_type(*(s), seqcount_raw_spinlock_t))		\
+		lockdep_assert_held(((seqcount_raw_spinlock_t *)(s))->lock);	\
+	else if (__same_type(*(s), seqcount_rwlock_t))			\
+		lockdep_assert_held_write(((seqcount_rwlock_t *)(s))->lock);	\
+	else if (__same_type(*(s), seqcount_mutex_t))			\
+		lockdep_assert_held(((seqcount_mutex_t *)(s))->lock);	\
+	else if (__same_type(*(s), seqcount_ww_mutex_t))		\
+		lockdep_assert_held(&((seqcount_ww_mutex_t *)(s))->lock->base);	\
+	else								\
+		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");		\
+} while (0)
+
+#else
+
+#define __assert_associated_lock_held(s)				\
+do {									\
+	(void) __to_seqcount_t(s);					\
+} while (0)
+
+#endif /* CONFIG_LOCKDEP */
+
+#define do_raw_write_seqcount_begin(s)					\
+do {									\
+	if (__enforce_preemption_protection(s))				\
+		preempt_disable();					\
+									\
+	raw_write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+#define do_raw_write_seqcount_end(s)					\
+do {									\
+	raw_write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__enforce_preemption_protection(s))				\
+		preempt_enable();					\
+} while (0)
+
+#define do_write_seqcount_begin_nested(s, subclass)			\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__enforce_preemption_protection(s))				\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin_nested(__to_seqcount_t(s), subclass);	\
+} while (0)
+
+#define do_write_seqcount_begin(s)					\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__enforce_preemption_protection(s))				\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+#define do_write_seqcount_end(s)					\
+do {									\
+	write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__enforce_preemption_protection(s))				\
+		preempt_enable();					\
+} while (0)
+
+#define do_write_seqcount_invalidate(s)					\
+	write_seqcount_t_invalidate(__to_seqcount_t(s))
+
+#define do_raw_write_seqcount_barrier(s)				\
+	raw_write_seqcount_t_barrier(__to_seqcount_t(s))
+
+/*
+ * Latch sequence counters write side critical sections don't need to
+ * run with preemption disabled. Check @raw_write_seqcount_latch().
+ */
+#define do_raw_write_seqcount_latch(s)					\
+	raw_write_seqcount_t_latch(__to_seqcount_t(s))
+
+/*
+ *	seqcount_LOCKTYPE_t -- read APIs
+ */
+
+#ifdef CONFIG_PREEMPT_RT
+
+/*
+ * Check comment on top of read_seqbegin() for rationale.
+ *
+ * @s: pointer to seqcount_t or any of the seqcount_locktype_t variants
+ */
+#define __rt_lock_unlock_associated_sleeping_lock(s)			\
+do {									\
+	if (__same_type(*(s), seqcount_t)  ||				\
+	    __same_type(*(s), seqcount_raw_spinlock_t))	{		\
+		break;	/* NOP */					\
+	}								\
+									\
+	if (__same_type(*(s), seqcount_spinlock_t)) {			\
+		spin_lock(((seqcount_spinlock_t *) s)->lock);		\
+		spin_unlock(((seqcount_spinlock_t *) s)->lock);		\
+	} else if (__same_type(*(s), seqcount_rwlock_t)) {		\
+		read_lock(((seqcount_rwlock_t *) s)->lock);		\
+		read_unlock(((seqcount_rwlock_t *) s)->lock);		\
+	} else if (__same_type(*(s), seqcount_mutex_t)) {		\
+		mutex_lock(((seqcount_mutex_t *) s)->lock);		\
+		mutex_unlock(((seqcount_mutex_t *) s)->lock);		\
+	} else if (__same_type(*(s), seqcount_ww_mutex_t)) {		\
+		ww_mutex_lock(((seqcount_ww_mutex_t *) s)->lock, NULL); \
+		ww_mutex_unlock(((seqcount_ww_mutex_t *) s)->lock);	\
+	} else								\
+		BUILD_BUG_ON_MSG(1, "Unknown seqcount type");		\
+} while (0)
+
+/*
+ * @s: pointer to seqcount_t or any of the seqcount_locktype_t variants
+ *
+ * After the lock-unlock operation, re-read the sequence counter since
+ * the writer made progress.
+ *
+ * Do not lock-unlock the seqcount associated sleeping lock again if the
+ * second counter read value is odd. If the first counter read was odd
+ * because the reader preempted the write-side critical section, the
+ * second odd value read must've been the result of a writer running on
+ * a parallel core instead.
+ */
+#define __raw_read_seqcount(s)						\
+({									\
+	unsigned seq = READ_ONCE(__to_seqcount_t(s)->sequence);		\
+									\
+	if (unlikely(seq & 1))						\
+		__rt_lock_unlock_associated_sleeping_lock(s);		\
+									\
+	/* no read barrier, no counter stabilization, no lockdep */	\
+	READ_ONCE(__to_seqcount_t(s)->sequence);			\
+})
+
+#define do___read_seqcount_begin(s)					\
+({									\
+	unsigned seq;							\
+									\
+	do {								\
+		seq = __raw_read_seqcount(s);				\
+		cpu_relax();						\
+	} while (unlikely(seq & 1));					\
+									\
+	/* no read barrier, with stabilized counter, no lockdep */	\
+	seq;								\
+})
+
+#define do_raw_read_seqcount(s)						\
+({									\
+	unsigned seq = __raw_read_seqcount(s);				\
+									\
+	smp_rmb();							\
+									\
+	/* with read barrier, no counter stabilization, no lockdep */	\
+	seq;								\
+})
+
+#define do_raw_seqcount_begin(s)					\
+({									\
+	/* with read barrier, no counter stabilization, no lockdep */	\
+	(do_raw_read_seqcount(s) & ~1);					\
+})
+
+#define do_raw_read_seqcount_begin(s)					\
+({									\
+	unsigned seq = do___read_seqcount_begin(s);			\
+									\
+	smp_rmb();							\
+									\
+	/* with read barrier, with stabilized counter, no lockdep */	\
+	seq;								\
+})
+
+#define do_read_seqcount_begin(s)					\
+({									\
+	seqcount_lockdep_reader_access(__to_seqcount_t(s));		\
+									\
+	/* with read barrier, stabilized counter, and lockdep */	\
+	do_raw_read_seqcount_begin(s);					\
+})
+
+#else /* !CONFIG_PREEMPT_RT */
+
+#define do___read_seqcount_begin(s)					\
+	__read_seqcount_t_begin(__to_seqcount_t(s))
+
+#define do_raw_read_seqcount(s)						\
+	raw_read_seqcount_t(__to_seqcount_t(s))
+
+#define do_raw_seqcount_begin(s)					\
+	raw_seqcount_t_begin(__to_seqcount_t(s))
+
+#define do_raw_read_seqcount_begin(s)					\
+	raw_read_seqcount_t_begin(__to_seqcount_t(s))
+
+#define do_read_seqcount_begin(s)					\
+	read_seqcount_t_begin(__to_seqcount_t(s))
+
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
+ * Latch sequence counters allows interruptible, preemptible, writer
+ * sections. There is no need for a special PREEMPT_RT implementation.
+ */
+#define do_raw_read_seqcount_latch(s)					\
+	raw_read_seqcount_t_latch(__to_seqcount_t(s))
+
+#define do___read_seqcount_retry(s, start)				\
+	__read_seqcount_t_retry(__to_seqcount_t(s), start)
+
+#define do_read_seqcount_retry(s, start)				\
+	read_seqcount_t_retry(__to_seqcount_t(s), start)
+
+#endif /* __LINUX_SEQLOCK_TYPES_INTERNAL_H */
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 6cdf3a0741974..8ec77bfdc1a41 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -459,7 +459,7 @@ static inline int neigh_hh_bridge(struct hh_cache *hh, struct sk_buff *skb)
 }
 #endif
 
-static inline int neigh_hh_output(struct hh_cache *hh, struct sk_buff *skb)
+static inline int neigh_hh_output(const struct hh_cache *hh, struct sk_buff *skb)
 {
 	unsigned int hh_alen = 0;
 	unsigned int seq;
@@ -502,7 +502,7 @@ static inline int neigh_hh_output(struct hh_cache *hh, struct sk_buff *skb)
 static inline int neigh_output(struct neighbour *n, struct sk_buff *skb,
 			       bool skip_cache)
 {
-	struct hh_cache *hh = &n->hh;
+	const struct hh_cache *hh = &n->hh;
 
 	if ((n->nud_state & NUD_CONNECTED) && hh->hh_len && !skip_cache)
 		return neigh_hh_output(hh, skb);
@@ -543,7 +543,7 @@ struct neighbour_cb {
 
 #define NEIGH_CB(skb)	((struct neighbour_cb *)(skb)->cb)
 
-static inline void neigh_ha_snapshot(char *dst, struct neighbour *n,
+static inline void neigh_ha_snapshot(char *dst, const struct neighbour *n,
 				     const struct net_device *dev)
 {
 	unsigned int seq;
diff --git a/include/net/net_seq_lock.h b/include/net/net_seq_lock.h
index 67710bace7418..95a497a72e511 100644
--- a/include/net/net_seq_lock.h
+++ b/include/net/net_seq_lock.h
@@ -6,6 +6,15 @@
 # define net_seq_begin(__r)		read_seqbegin(__r)
 # define net_seq_retry(__r, __s)	read_seqretry(__r, __s)
 
+static inline int try_write_seqlock(seqlock_t *sl)
+{
+	if (spin_trylock(&sl->lock)) {
+		write_seqcount_begin(&sl->seqcount);
+		return 1;
+	}
+	return 0;
+}
+
 #else
 # define net_seqlock_t			seqcount_t
 # define net_seq_begin(__r)		read_seqcount_begin(__r)
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 90690e37a56f0..ea4e2010b2465 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -286,7 +286,7 @@ int nf_conntrack_hash_resize(unsigned int hashsize);
 
 extern struct hlist_nulls_head *nf_conntrack_hash;
 extern unsigned int nf_conntrack_htable_size;
-extern seqcount_t nf_conntrack_generation;
+extern seqcount_spinlock_t nf_conntrack_generation;
 extern unsigned int nf_conntrack_max;
 
 /* must be called with rcu read lock held */
diff --git a/init/init_task.c b/init/init_task.c
index 1539bfba1bef8..672462e616053 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -145,7 +145,8 @@ struct task_struct init_task
 	.rcu_tasks_idle_cpu = -1,
 #endif
 #ifdef CONFIG_CPUSETS
-	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
+	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
+						 &init_task.alloc_lock),
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
diff --git a/kernel/fork.c b/kernel/fork.c
index 9b7ebc1e32060..e74cccef70afa 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2040,7 +2040,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
 	p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
-	seqcount_init(&p->mems_allowed_seq);
+	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index fc6c6c8d31271..6416a10e7942e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1616,15 +1616,15 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 }
 EXPORT_SYMBOL(_down_write_nest_lock);
 
-#ifndef CONFIG_PREEMPT_RT
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
 	__down_read(sem);
+#ifndef CONFIG_PREEMPT_RT
 	__rwsem_set_reader_owned(sem, NULL);
+#endif
 }
 EXPORT_SYMBOL(down_read_non_owner);
-#endif
 
 void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
@@ -1649,13 +1649,13 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_write_killable_nested);
 
-#ifndef CONFIG_PREEMPT_RT
 void up_read_non_owner(struct rw_semaphore *sem)
 {
+#ifndef CONFIG_PREEMPT_RT
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+#endif
 	__up_read(sem);
 }
 EXPORT_SYMBOL(up_read_non_owner);
-#endif
 
 #endif
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 12ea6380dea80..6a36a02f45b3a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -135,7 +135,11 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
  * timer->base->cpu_base
  */
 static struct hrtimer_cpu_base migration_cpu_base = {
-	.clock_base = { { .cpu_base = &migration_cpu_base, }, },
+	.clock_base = { {
+		.cpu_base = &migration_cpu_base,
+		.seq      = SEQCNT_RAW_SPINLOCK_ZERO(migration_cpu_base.seq,
+						     &migration_cpu_base.lock),
+	}, },
 };
 
 #define migration_base	migration_cpu_base.clock_base[0]
@@ -2025,8 +2029,11 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	int i;
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		cpu_base->clock_base[i].cpu_base = cpu_base;
-		timerqueue_init_head(&cpu_base->clock_base[i].active);
+		struct hrtimer_clock_base *clock_b = &cpu_base->clock_base[i];
+
+		clock_b->cpu_base = cpu_base;
+		seqcount_raw_spinlock_init(&clock_b->seq, &cpu_base->lock);
+		timerqueue_init_head(&clock_b->active);
 	}
 
 	cpu_base->cpu = cpu;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 856280d2cbd4c..8ce7f5c5624d4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -39,18 +39,19 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
+static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
 static struct {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 } tk_core ____cacheline_aligned = {
-	.seq = SEQCNT_ZERO(tk_core.seq),
+	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
@@ -63,7 +64,7 @@ static struct timekeeper shadow_timekeeper;
  * See @update_fast_timekeeper() below.
  */
 struct tk_fast {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct tk_read_base	base[2];
 };
 
@@ -80,11 +81,13 @@ static struct clocksource dummy_clock = {
 };
 
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
@@ -157,7 +160,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * tk_clock_read - atomic clocksource read() helper
  *
  * This helper is necessary to use in the read paths because, while the
- * seqlock ensures we don't return a bad value while structures are updated,
+ * seqcount ensures we don't return a bad value while structures are updated,
  * it doesn't protect from potential crashes. There is the possibility that
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
@@ -222,10 +225,10 @@ static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 	unsigned int seq;
 
 	/*
-	 * Since we're called holding a seqlock, the data may shift
+	 * Since we're called holding a seqcount, the data may shift
 	 * under us while we're doing the calculation. This can cause
 	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqlock here to atomically
+	 * results away. So nest another seqcount here to atomically
 	 * grab the points we are checking with.
 	 */
 	do {
@@ -486,7 +489,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *
  * To keep it NMI safe since we're accessing from tracing, we're not using a
  * separate timekeeper with updates to monotonic clock and boot offset
- * protected with seqlocks. This has the following minor side effects:
+ * protected with seqcounts. This has the following minor side effects:
  *
  * (1) Its possible that a timestamp be taken after the boot offset is updated
  * but before the timekeeper is updated. If this happens, the new boot offset
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
diff --git a/net/core/dev.c b/net/core/dev.c
index 8476391551cb4..fbf66f197cf3d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -79,6 +79,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>
@@ -194,8 +195,7 @@ static DEFINE_SPINLOCK(napi_hash_lock);
 static unsigned int napi_gen_id = NR_CPUS;
 static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
-static seqcount_t devnet_rename_seq;
-static DEFINE_MUTEX(devnet_rename_mutex);
+static DECLARE_RWSEM(devnet_rename_sem);
 
 static inline void dev_base_seq_inc(struct net *net)
 {
@@ -931,34 +931,28 @@ EXPORT_SYMBOL(dev_get_by_napi_id);
  *	@net: network namespace
  *	@name: a pointer to the buffer where the name will be stored.
  *	@ifindex: the ifindex of the interface to get the name from.
- *
- *	The use of raw_seqcount_begin() and cond_resched() before
- *	retrying is required as we want to give the writers a chance
- *	to complete when CONFIG_PREEMPTION is not set.
  */
 int netdev_get_name(struct net *net, char *name, int ifindex)
 {
 	struct net_device *dev;
-	unsigned int seq;
+	int ret;
 
-retry:
-	seq = raw_seqcount_begin(&devnet_rename_seq);
+	down_read(&devnet_rename_sem);
 	rcu_read_lock();
+
 	dev = dev_get_by_index_rcu(net, ifindex);
 	if (!dev) {
-		rcu_read_unlock();
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	strcpy(name, dev->name);
-	rcu_read_unlock();
-	if (read_seqcount_retry(&devnet_rename_seq, seq)) {
-		mutex_lock(&devnet_rename_mutex);
-		mutex_unlock(&devnet_rename_mutex);
-		goto retry;
-	}
 
-	return 0;
+	ret = 0;
+out:
+	rcu_read_unlock();
+	up_read(&devnet_rename_sem);
+	return ret;
 }
 
 /**
@@ -1230,17 +1224,20 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	    likely(!(dev->priv_flags & IFF_LIVE_RENAME_OK)))
 		return -EBUSY;
 
-	mutex_lock(&devnet_rename_mutex);
-	__raw_write_seqcount_begin(&devnet_rename_seq);
+	down_write(&devnet_rename_sem);
 
-	if (strncmp(newname, dev->name, IFNAMSIZ) == 0)
-		goto outunlock;
+	if (strncmp(newname, dev->name, IFNAMSIZ) == 0) {
+		up_write(&devnet_rename_sem);
+		return 0;
+	}
 
 	memcpy(oldname, dev->name, IFNAMSIZ);
 
 	err = dev_get_valid_name(net, dev, newname);
-	if (err < 0)
-		goto outunlock;
+	if (err < 0) {
+		up_write(&devnet_rename_sem);
+		return err;
+	}
 
 	if (oldname[0] && !strchr(oldname, '%'))
 		netdev_info(dev, "renamed from %s\n", oldname);
@@ -1253,12 +1250,11 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	if (ret) {
 		memcpy(dev->name, oldname, IFNAMSIZ);
 		dev->name_assign_type = old_assign_type;
-		err = ret;
-		goto outunlock;
+		up_write(&devnet_rename_sem);
+		return ret;
 	}
 
-	__raw_write_seqcount_end(&devnet_rename_seq);
-	mutex_unlock(&devnet_rename_mutex);
+	up_write(&devnet_rename_sem);
 
 	netdev_adjacent_rename_links(dev, oldname);
 
@@ -1279,8 +1275,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
 		/* err >= 0 after dev_alloc_name() or stores the first errno */
 		if (err >= 0) {
 			err = ret;
-			mutex_lock(&devnet_rename_mutex);
-			__raw_write_seqcount_begin(&devnet_rename_seq);
+			down_write(&devnet_rename_sem);
 			memcpy(dev->name, oldname, IFNAMSIZ);
 			memcpy(oldname, newname, IFNAMSIZ);
 			dev->name_assign_type = old_assign_type;
@@ -1293,11 +1288,6 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	}
 
 	return err;
-
-outunlock:
-	__raw_write_seqcount_end(&devnet_rename_seq);
-	mutex_unlock(&devnet_rename_mutex);
-	return err;
 }
 
 /**
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7c503b4751c4c..c6b4f01385fc5 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);
 
 unsigned int nf_conntrack_max __read_mostly;
 EXPORT_SYMBOL_GPL(nf_conntrack_max);
-seqcount_t nf_conntrack_generation __read_mostly;
+seqcount_spinlock_t nf_conntrack_generation __read_mostly;
 static unsigned int nf_conntrack_hash_rnd __read_mostly;
 
 static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
@@ -2587,7 +2587,8 @@ int nf_conntrack_init_start(void)
 	/* struct nf_ct_ext uses u8 to store offsets/size */
 	BUILD_BUG_ON(total_extension_size() > 255u);
 
-	seqcount_init(&nf_conntrack_generation);
+	seqcount_spinlock_init(&nf_conntrack_generation,
+			       &nf_conntrack_locks_all_lock);
 
 	for (i = 0; i < CONNTRACK_LOCKS; i++)
 		spin_lock_init(&nf_conntrack_locks[i]);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index accbb54c2b714..5d6027cb45b6c 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -18,7 +18,7 @@
 struct nft_rbtree {
 	struct rb_root		root;
 	rwlock_t		lock;
-	seqcount_t		count;
+	seqcount_rwlock_t	count;
 	struct delayed_work	gc_work;
 };
 
@@ -516,7 +516,7 @@ static int nft_rbtree_init(const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 
 	rwlock_init(&priv->lock);
-	seqcount_init(&priv->count);
+	seqcount_rwlock_init(&priv->count, &priv->lock);
 	priv->root = RB_ROOT;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rbtree_gc);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6506fde3d0024..a97796d35ede2 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -871,7 +871,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 		lockdep_set_class(&sch->busylock, &dev->qdisc_tx_busylock_key);
 		lockdep_set_class(&sch->seqlock, &dev->qdisc_tx_busylock_key);
 #ifdef CONFIG_PREEMPT_RT
-		lockdep_set_class(&sch->running.seqcount, &dev->qdisc_running_key);
 		lockdep_set_class(&sch->running.lock, &dev->qdisc_running_key);
 #else
 		lockdep_set_class(&sch->running, &dev->qdisc_running_key);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5807356527541..98499cd9dbd2a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -122,7 +122,7 @@ struct xfrm_pol_inexact_bin {
 	/* list containing '*:*' policies */
 	struct hlist_head hhead;
 
-	seqcount_t count;
+	seqcount_spinlock_t count;
 	/* tree sorted by daddr/prefix */
 	struct rb_root root_d;
 
@@ -155,7 +155,7 @@ static struct xfrm_policy_afinfo const __rcu *xfrm_policy_afinfo[AF_INET6 + 1]
 						__read_mostly;
 
 static struct kmem_cache *xfrm_dst_cache __ro_after_init;
-static __read_mostly seqcount_t xfrm_policy_hash_generation;
+static __read_mostly seqcount_mutex_t xfrm_policy_hash_generation;
 
 static struct rhashtable xfrm_policy_inexact_table;
 static const struct rhashtable_params xfrm_pol_inexact_params;
@@ -719,7 +719,7 @@ xfrm_policy_inexact_alloc_bin(const struct xfrm_policy *pol, u8 dir)
 	INIT_HLIST_HEAD(&bin->hhead);
 	bin->root_d = RB_ROOT;
 	bin->root_s = RB_ROOT;
-	seqcount_init(&bin->count);
+	seqcount_spinlock_init(&bin->count, &net->xfrm.xfrm_policy_lock);
 
 	prev = rhashtable_lookup_get_insert_key(&xfrm_policy_inexact_table,
 						&bin->k, &bin->head,
@@ -1906,7 +1906,7 @@ static int xfrm_policy_match(const struct xfrm_policy *pol,
 
 static struct xfrm_pol_inexact_node *
 xfrm_policy_lookup_inexact_addr(const struct rb_root *r,
-				seqcount_t *count,
+				seqcount_spinlock_t *count,
 				const xfrm_address_t *addr, u16 family)
 {
 	const struct rb_node *parent;
@@ -4154,7 +4154,7 @@ void __init xfrm_init(void)
 {
 	register_pernet_subsys(&xfrm_net_ops);
 	xfrm_dev_init();
-	seqcount_init(&xfrm_policy_hash_generation);
+	seqcount_mutex_init(&xfrm_policy_hash_generation, &hash_resize_mutex);
 	xfrm_input_init();
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 170d6e7f31d3a..a08db2da3fbae 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -44,7 +44,7 @@ static void xfrm_state_gc_task(struct work_struct *work);
  */
 
 static unsigned int xfrm_state_hashmax __read_mostly = 1 * 1024 * 1024;
-static __read_mostly seqcount_t xfrm_state_hash_generation = SEQCNT_ZERO(xfrm_state_hash_generation);
+static __read_mostly seqcount_spinlock_t xfrm_state_hash_generation;
 static struct kmem_cache *xfrm_state_cache __ro_after_init;
 
 static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
@@ -139,6 +139,11 @@ static void xfrm_hash_resize(struct work_struct *work)
 		return;
 	}
 
+	/* XXX - the locking which protects the sequence counter appears
+	 * to be broken here. The sequence counter is global, but the
+	 * spinlock used for the sequence counter write serialization is
+	 * per network namespace...
+	 */
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	write_seqcount_begin(&xfrm_state_hash_generation);
 
@@ -2557,6 +2562,8 @@ int __net_init xfrm_state_init(struct net *net)
 	net->xfrm.state_num = 0;
 	INIT_WORK(&net->xfrm.state_hash_work, xfrm_hash_resize);
 	spin_lock_init(&net->xfrm.xfrm_state_lock);
+	seqcount_spinlock_init(&xfrm_state_hash_generation,
+			       &net->xfrm.xfrm_state_lock);
 	return 0;
 
 out_byspi:
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 67b6fc153e9c4..8694a2920ea94 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -303,7 +303,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	INIT_LIST_HEAD(&irqfd->list);
 	INIT_WORK(&irqfd->inject, irqfd_inject);
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
-	seqcount_init(&irqfd->irq_entry_sc);
+	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
 
 	f = fdget(args->fd);
 	if (!f.file) {
