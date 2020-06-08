Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E318FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D2F2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgFHA5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgFHA5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:57:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C57C08C5C3;
        Sun,  7 Jun 2020 17:57:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1ji66j-0000kP-FE; Mon, 08 Jun 2020 02:57:45 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 03/18] seqlock: Add missing kernel-doc annotations
Date:   Mon,  8 Jun 2020 02:57:14 +0200
Message-Id: <20200608005729.1874024-4-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608005729.1874024-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small number of the the exported seqlock.h functions are kernel-doc
annotated.

Since seqlock.h is now included by the kernel's RST documentation, add
kernel-doc annotations for all of the remaining functions.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 388 ++++++++++++++++++++++++++++++++++------
 1 file changed, 329 insertions(+), 59 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 7296af778301..a11b113ed396 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -59,6 +59,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the &typedef seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -82,13 +86,17 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
-#define SEQCNT_ZERO(lockname) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(lockname)}
+/**
+ * SEQCNT_ZERO() - static initializer for seqcount_t
+ * @name: Name of the &typedef seqcount_t instance
+ */
+#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 
 /**
- * __read_seqcount_begin - begin a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * __read_seqcount_begin() - begin a seq-read critical section (without barrier)
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -112,13 +120,14 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount() - Read the raw seqcount
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * raw_read_seqcount opens a read critical section of the given
- * seqcount without any lockdep checking and without checking or
- * masking the LSB. Calling code is responsible for handling that.
+ * seqcount_t, without any lockdep checks and without checking or
+ * masking the sequence counter LSB. Calling code is responsible for
+ * handling that.
  */
 static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
@@ -128,13 +137,13 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount_begin() - start seq-read critical section w/o lockdep
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * raw_read_seqcount_begin opens a read critical section of the given
- * seqcount, but without any lockdep checking. Validity of the critical
- * section is tested by checking read_seqcount_retry function.
+ * seqcount_t, but without any lockdep checking. Validity of the read
+ * section must be checked with read_seqcount_retry().
  */
 static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 {
@@ -144,13 +153,13 @@ static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * read_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * read_seqcount_begin() - begin a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
- * read_seqcount_begin opens a read critical section of the given seqcount.
- * Validity of the critical section is tested by checking read_seqcount_retry
- * function.
+ * read_seqcount_begin opens a read critical section of the given
+ * seqcount_t. Validity of the read section must be checked with
+ * read_seqcount_retry().
  */
 static inline unsigned read_seqcount_begin(const seqcount_t *s)
 {
@@ -159,11 +168,11 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * raw_seqcount_begin() - begin a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * Returns: count to be passed to read_seqcount_retry
  *
- * raw_seqcount_begin opens a read critical section of the given seqcount.
+ * raw_seqcount_begin opens a read critical section of the given seqcount_t.
  * Validity of the critical section is tested by checking read_seqcount_retry
  * function.
  *
@@ -180,8 +189,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_retry() - end a seq-read critical section (without barrier)
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -199,12 +208,12 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 }
 
 /**
- * read_seqcount_retry - end a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_retry() - end a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
- * read_seqcount_retry closes a read critical section of the given seqcount.
+ * read_seqcount_retry closes a read critical section of given seqcount_t.
  * If the critical section was invalid, it must be ignored (and typically
  * retried).
  */
@@ -227,8 +236,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_barrier - do a seq write barrier
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_barrier() - do a seq write barrier
+ * @s: Pointer to &typedef seqcount_t
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
@@ -267,6 +276,21 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 	s->sequence++;
 }
 
+/**
+ * raw_read_seqcount_latch() - pick even or odd seqcount latch data copy
+ * @s: Pointer to &typedef seqcount_t
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
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
@@ -275,8 +299,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: Pointer to &typedef seqcount_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -330,8 +354,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *			smp_rmb();
- *		} while (seq != latch->seq);
+ *			// read_seqcount_retry() includes necessary smp_rmb()
+ *		} while (read_seqcount_retry(&latch->seq, seq);
  *
  *		return entry;
  *	}
@@ -373,6 +397,12 @@ static inline void write_seqcount_begin(seqcount_t *s)
 	write_seqcount_begin_nested(s, 0);
 }
 
+/**
+ * write_seqcount_end() - end a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * The write section must've been opened with write_seqcount_begin().
+ */
 static inline void write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
@@ -380,8 +410,8 @@ static inline void write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
+ * @s: Pointer to &typedef seqcount_t
  *
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
@@ -413,32 +443,67 @@ typedef struct {
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
 
-/*
- * Read side functions for starting and finalizing a read side section.
+/**
+ * read_seqbegin() - start a seqlock_t read-side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * read_seqbegin opens a read side critical section of the given
+ * seqlock_t. Validity of the critical section is tested by checking
+ * read_seqretry().
+ *
+ * Return: count to be passed to read_seqretry()
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	return read_seqcount_begin(&sl->seqcount);
 }
 
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
 	return read_seqcount_retry(&sl->seqcount, start);
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
@@ -446,30 +511,68 @@ static inline void write_seqlock(seqlock_t *sl)
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
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
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
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
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
@@ -485,9 +588,28 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
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
@@ -495,30 +617,64 @@ write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
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
- *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
+ * read_seqbegin_or_lock() - begin a seqlock_t lockless or locking reader
+ * @lock: Pointer to &typedef seqlock_t
+ * @seq : Marker and return parameter. If the passed value is even, the
+ * reader will become a *lockless* seqlock_t sequence counter reader as
+ * in read_seqbegin(). If the passed value is odd, the reader will
+ * become a fully locking reader, as in read_seqlock_excl().  In the
+ * first call to read_seqbegin_or_lock(), the caller **must** initialize
+ * and pass an even value to @seq so a lockless read is optimistically
+ * tried first.
+ *
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
@@ -528,32 +684,90 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
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
@@ -567,15 +781,59 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
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
@@ -589,6 +847,18 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
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
-- 
2.20.1

