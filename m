Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D61205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgESVrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgESVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:47:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1AC08C5C1;
        Tue, 19 May 2020 14:47:17 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA4S-0002iy-5O; Tue, 19 May 2020 23:46:44 +0200
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
Subject: [PATCH v1 11/25] seqlock: Add missing kernel-doc annotations
Date:   Tue, 19 May 2020 23:45:33 +0200
Message-Id: <20200519214547.352050-12-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
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
 include/linux/seqlock.h | 414 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 361 insertions(+), 53 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index dfec0c9c19c4..dd55555ff607 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -57,6 +57,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the &typedef seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -80,13 +84,17 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
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
@@ -110,9 +118,9 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
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
  * seqcount without any lockdep checking and without checking or
@@ -126,13 +134,13 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
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
  * seqcount, but without any lockdep checking. Validity of the critical
- * section is tested by checking read_seqcount_retry function.
+ * section is tested by calling read_seqcount_retry().
  */
 static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 {
@@ -142,13 +150,13 @@ static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
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
+ * seqcount_t.  Validity of the critical section is tested by calling
+ * read_seqcount_retry().
  */
 static inline unsigned read_seqcount_begin(const seqcount_t *s)
 {
@@ -157,8 +165,8 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * raw_seqcount_begin() - begin a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * Returns: count to be passed to read_seqcount_retry
  *
  * raw_seqcount_begin opens a read critical section of the given seqcount.
@@ -178,8 +186,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_retry() - end a seq-read critical section (without barrier)
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -197,8 +205,8 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 }
 
 /**
- * read_seqcount_retry - end a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_retry() - end a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -225,8 +233,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_barrier - do a seq write barrier
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_barrier() - do a seq write barrier
+ * @s: Pointer to &typedef seqcount_t
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
@@ -267,6 +275,21 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
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
+ * which data copy to read. Full counter must then be passed to
+ * read_seqcount_retry().
+ */
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
@@ -275,8 +298,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: Pointer to &typedef seqcount_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -336,8 +359,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
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
@@ -391,11 +414,26 @@ static inline void __write_seqcount_begin(seqcount_t *s)
 	__write_seqcount_begin_nested(s, 0);
 }
 
+/**
+ * write_seqcount_begin() - start a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * write_seqcount_begin opens a write-side critical section of the given
+ * seqcount. Seqcount write-side critical sections must be externally
+ * serialized and non-preemptible.
+ */
 static inline void write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
 }
 
+/**
+ * write_seqcount_end() - end a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * write_seqcount_end closes a write-side critical section of the given
+ * seqcount.
+ */
 static inline void write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
@@ -403,8 +441,8 @@ static inline void write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
+ * @s: Pointer to &typedef seqcount_t
  *
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
@@ -435,32 +473,68 @@ typedef struct {
 		.lock =	__SPIN_LOCK_UNLOCKED(lockname)	\
 	}
 
-#define seqlock_init(x)					\
+/**
+ * seqlock_init() - dynamic initializer for seqlock_t
+ * @sl: Pointer to the seqlock_t instance
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
+ * read_seqretry() - end a seqlock_t read side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ * @start: count, from read_seqbegin()
+ *
+ * read_seqretry closes a read side critical section of the given
+ * seqlock_t. If the read side critical section was invalid, it must be
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
+ * seqlock_t.  It also acquires the spinlock embedded inside the
+ * sequential lock. All seqlock_t write side critical sections are thus
+ * automatically serialized and non-preemptible.
+ *
+ * If the seqlock_t read side section can be invoked from a hardirq or
+ * softirq context, the ``_irqsave`` and ``_bh`` variants of this
+ * function must be respectively used instead.
+ *
+ * The opened write side section must be closed with write_sequnlock().
  */
 static inline void write_seqlock(seqlock_t *sl)
 {
@@ -468,30 +542,74 @@ static inline void write_seqlock(seqlock_t *sl)
 	__write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock() - end a seqlock_t write side critical section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_sequnlock closes the (serialized and non-preemptible) write
+ * side critical section of the given seqlock_t.
+ */
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
+/**
+ * write_seqlock_bh() - start a softirqs-disabled seqlock_t write  section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_seqlock_bh is a write_seqlock() variant that disables softirqs
+ * before opening the serialized seqlock_t write side critical section.
+ * Use it only if the read side section, or other writers, can be
+ * invoked from a softirq context.
+ *
+ * The opened write section must be closed with write_sequnlock_bh().
+ */
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 	__write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_bh() - end a softirqs-disabled seqlock_t write section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_sequnlock_bh closes the serialized, softirqs-disabled,
+ * seqlock_t write side critical section. It enables softirqs if they
+ * were already enabled before calling the paired write_seqlock_bh().
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
+ * write_seqlock_irq is a write_seqlock() variant where hardirqs are
+ * disabled before opening the serialized and non-preemptible seqlock_t
+ * write side critical section.
+ */
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 	__write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_irq() - end a non-interruptible seqlock_t write side section
+ * @sl: Pointer to &typedef seqlock_t
+ *
+ * write_sequnlock_irq closes the serialized and non-interruptible write
+ * side critical section of the given seqlock_t. It enables local
+ * interrupts afterwards.
+ *
+ * The write critical section must've been opened with write_seqlock_irq().
+ */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
@@ -507,9 +625,36 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	return flags;
 }
 
+/**
+ * write_seqlock_irqsave() - start a non-interruptible seqlock_t write section
+ * @lock:  Pointer to &typedef seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to write_sequnlock_irqrestore().
+ *
+ * write_seqlock_irqsave is a write_seqlock() variant where the caller's
+ * local interrupts state is saved, then local interrupts are disabled,
+ * before opening the serialized and non-preemptible seqlock_t write
+ * side critical section.
+ *
+ * Use this only if the read side section can be invoked from a hardirq
+ * context.
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
+ * write_sequnlock_irq closes the serialized and non-interruptible write
+ * side critical section of the given seqlock_t. It then restores the
+ * caller's local interrupts saved state.
+ *
+ * The write section must've been opened with write_seqlock_irqsave().
+ */
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
@@ -517,30 +662,61 @@ write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
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
+ * and other locking readers, but doesn't update the sequence number.
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
+ * read_sequnlock_excl closes a locking reader critical section.  The
+ * read section must've been opened with read_seqlock_excl().
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
+ * and pass an even value in @seq so a lockless read is optimistically
+ * tried first.
  *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
+ * read_seqbegin_or_lock optimistically tries a lockless seqlock_t
+ * sequence counter read first. If an odd counter is found, the lockless
+ * read trial has failed, and the reader transforms to a full seqlock_t
+ * locking reader as in read_seqlock_excl().  This is typically used to
+ * avoid lockless seqlock_t readers starvation (too much retry loops) in
+ * the case of a sharp spike in write activity.
+ *
+ * The opened read section must be closed with done_seqretry().  Check
+ * Documentation/locking/seqlock.rst for template example code.
+ *
+ * Return: The read critical section status is returned through @seq,
+ * which is overloaded as a return parameter. This value must be passed
+ * to need_seqretry() to check the validity of the tried seqlock_t read
+ * section. If the read section must be retried, the returned value must
+ * also be passed to the next iteration of read_seqbegin_or_lock().
  */
 static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 {
@@ -550,32 +726,98 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
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
+ * started by read_seqbegin_or_lock(). Before finishing the critical
+ * section, the validity of the read side section must've been already
+ * verified with need_seqretry().
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
+ * read_seqlock_excl_bh is a variant of read_seqlock_excl() that saves
+ * softirqs state, then disables softirqs, before starting the locking
+ * reader read side section. Only use this variant if the seqlock_t
+ * write side section, *or other read sections*, can be invoked from a
+ * softirq context
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
+ * read_sequnlock_excl_bh ends the softirq-disabled seqlock_t locking
+ * reader read side section. It restores the softirqs state saved by
+ * read_seqlock_excl_bh() afterwards.
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
+ * read_seqlock_excl_irq is a variant of read_seqlock_excl() that
+ * disables interrupts before starting the locking reader read side
+ * section. Only use this variant if the seqlock_t write side section,
+ * *or other read sections*, can be invoked from a hardirq context
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
+ * read_sequnlock_excl_irq ends the interrupts-disabled seqlock_t
+ * locking reader read side critical section. It enables local
+ * interrupts afterwards.
+ *
+ * The read section must've been started with read_seqlock_excl_irq().
+ */
 static inline void read_sequnlock_excl_irq(seqlock_t *sl)
 {
 	spin_unlock_irq(&sl->lock);
@@ -589,15 +831,68 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
 	return flags;
 }
 
+/**
+ * read_seqlock_excl_irqsave() - start a non-interruptible seqlock_t
+ *				 locking reader section
+ * @lock: Pointer to &typedef seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to read_sequnlock_excl_irqrestore().
+ *
+ * read_seqlock_excl_irqsave is a read_seqlock_excl() variant which
+ * saves the caller's local interrupts state, then disables local
+ * interrupts, before opening the seqlock_t locking reader critical
+ * section.
+ *
+ * Use this only if the seqlock_t write side critical section, or other
+ * read side sections, can be invoked from a hardirq context.
+ *
+ * The opened locking reader critical section must be closed with
+ * read_sequnlock_excl_irqrestore().
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
+ * read_sequnlock_excl_irqrestore closes the non-interruptible seqlock_t
+ * locking reader section. It then restores the caller's local
+ * interrupts saved state.
+ *
+ * The read section must've been opened with read_seqlock_excl_irqsave().
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
+ * read_seqbegin_or_lock_irqsave is a variant of read_seqbegin_or_lock()
+ * which saves the local interrupts state, then disables local
+ * interrupts, before opening a seqlock_t *locking reader* critical
+ * section.
+ *
+ * The opened section must be closed with done_seqretry_irqrestore().
+ *
+ * Return:
+ *
+ *   1. The saved local interrupts state in case of a locking reader, to
+ *      be passed to done_seqretry_irqrestore().
+ *
+ *   2. The read critical section status, returned through @seq which is
+ *      overloaded as a return parameter. Check read_seqbegin_or_lock()
+ *      for more info.
+ */
 static inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
@@ -611,6 +906,19 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
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
+ * done_seqretry_irqrestore is a variant of done_seqretry() which
+ * restores the callers saved local interrupts state in case of a
+ * locking reader. Check done_seqretry() for more information. The read
+ * section must've been opened with read_seqbegin_or_lock_irqsave().
+ */
 static inline void
 done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 {
-- 
2.20.1

