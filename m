Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A100C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265E520770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMGplgwj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVsk6kOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIDPcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33716 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:12 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R934rOnIO1PRPsvb5yWqCJgyv0C3gxi/LdzU4OfaLNg=;
        b=BMGplgwjGqbCC1vOveoxlRrU1t02C87C7wceR0O/Uysi0vznM/ASI/cyc5kqj6tEAMGaN9
        j/TQtp24S7Bf7cyUTD3sS6uZ676z2ZbYHLbZkGnHqCUcK0k2OQAAWQsnRqCnOJMUbV3Zet
        PnrL+Iy3WibAuEeoTUBdJXhhEhLpHMmBZMyOS3ZbVRkfKd3ojLfpKsTDGBOGRJ6Tb+5JTC
        6H9fGwLWQim8A8ZJ50SjFO3ZCQl6SlfO1s81WvQB82a61whwjbH67yYir7ookHudH7G20W
        AAFCsfbBzy1x4E6rPSI9c8uzWVmUtM3rhkK0WRf8C9RYQ1q1cSknCqT8DHXpbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R934rOnIO1PRPsvb5yWqCJgyv0C3gxi/LdzU4OfaLNg=;
        b=fVsk6kOqqfd/Ra/ZeG2p1AqTpLGPRyesQv+utLkvq+WpS+jx3f7k/vh2ORcbjiYltrFlk4
        WBiC7r0x978/O3AQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 1/5] seqlock: seqcount_LOCKNAME_t: Standardize naming convention
Date:   Fri,  4 Sep 2020 17:32:27 +0200
Message-Id: <20200904153231.11994-2-a.darwish@linutronix.de>
In-Reply-To: <20200904153231.11994-1-a.darwish@linutronix.de>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At seqlock.h, sequence counters with associated locks are either called
seqcount_LOCKNAME_t, seqcount_LOCKTYPE_t, or seqcount_locktype_t.

Standardize on seqcount_LOCKNAME_t for all instances in comments,
kernel-doc, and SEQCOUNT_LOCKNAME() generative macro paramters.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 83 +++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 962d9768945f..4f219df659b1 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -53,7 +53,7 @@
  *
  * If the write serialization mechanism is one of the common kernel
  * locking primitives, use a sequence counter with associated lock
- * (seqcount_LOCKTYPE_t) instead.
+ * (seqcount_LOCKNAME_t) instead.
  *
  * If it's desired to automatically handle the sequence counter writer
  * serialization and non-preemptibility requirements, use a sequential
@@ -117,7 +117,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 /*
- * Sequence counters with associated locks (seqcount_LOCKTYPE_t)
+ * Sequence counters with associated locks (seqcount_LOCKNAME_t)
  *
  * A sequence counter which associates the lock used for writer
  * serialization at initialization time. This enables lockdep to validate
@@ -138,30 +138,32 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #endif
 
 /**
- * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
+ * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
  * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated spinlock
+ * @lock:	Pointer to the associated lock
  *
- * A plain sequence counter with external writer synchronization by a
- * spinlock. The spinlock is associated to the sequence count in the
+ * A plain sequence counter with external writer synchronization by
+ * LOCKNAME @lock. The lock is associated to the sequence counter in the
  * static initializer or init function. This enables lockdep to validate
  * that the write side critical section is properly serialized.
+ *
+ * LOCKNAME:	raw_spinlock, spinlock, rwlock, mutex, or ww_mutex.
  */
 
 /**
  * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
  * @s:		Pointer to the seqcount_LOCKNAME_t instance
- * @lock:	Pointer to the associated LOCKTYPE
+ * @lock:	Pointer to the associated lock
  */
 
 /*
- * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
- * @locktype:		actual typename
- * @lockname:		name
- * @preemptible:	preemptibility of above locktype
+ * SEQCOUNT_LOCKNAME() - Instantiate seqcount_LOCKNAME_t and helpers
+ * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
+ * @locktype:		LOCKNAME canonical C data type
+ * @preemptible:	preemptibility of above lockname
  * @lockmember:		argument for lockdep_assert_held()
  */
-#define SEQCOUNT_LOCKTYPE(locktype, lockname, preemptible, lockmember)	\
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember)	\
 typedef struct seqcount_##lockname {					\
 	seqcount_t		seqcount;				\
 	__SEQ_LOCK(locktype	*lock);					\
@@ -211,29 +213,28 @@ static inline void __seqcount_assert(seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-SEQCOUNT_LOCKTYPE(raw_spinlock_t,	raw_spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(spinlock_t,		spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
-SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
+SEQCOUNT_LOCKNAME(raw_spinlock,	raw_spinlock_t,		false,	s->lock)
+SEQCOUNT_LOCKNAME(spinlock,	spinlock_t,		false,	s->lock)
+SEQCOUNT_LOCKNAME(rwlock,	rwlock_t,		false,	s->lock)
+SEQCOUNT_LOCKNAME(mutex,	struct mutex,		true,	s->lock)
+SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 
 /**
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
  * @name:	Name of the seqcount_LOCKNAME_t instance
- * @lock:	Pointer to the associated LOCKTYPE
+ * @lock:	Pointer to the associated LOCKNAME
  */
 
-#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
+#define SEQCOUNT_LOCKNAME_ZERO(seq_name, assoc_lock) {			\
 	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
 	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
-#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-#define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKNAME_ZERO(name, lock)
+#define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
 #define __seqprop_case(s, lockname, prop)				\
 	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
@@ -252,7 +253,7 @@ SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -283,7 +284,7 @@ static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -299,7 +300,7 @@ static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -314,7 +315,7 @@ static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checking, and without checking or
@@ -337,7 +338,7 @@ static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * raw_seqcount_begin opens a read critical section of the given
  * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
@@ -365,7 +366,7 @@ static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
@@ -389,7 +390,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 
 /**
  * read_seqcount_retry() - end a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @start: count, from read_seqcount_begin()
  *
  * read_seqcount_retry closes the read critical section of given
@@ -409,7 +410,7 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
@@ -428,7 +429,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
@@ -448,7 +449,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
@@ -471,7 +472,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 
 /**
  * write_seqcount_begin() - start a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * write_seqcount_begin opens a write side critical section of the given
  * seqcount_t.
@@ -497,7 +498,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * write_seqcount_end() - end a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * The write section must've been opened with write_seqcount_begin().
  */
@@ -517,7 +518,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
 
 /**
  * raw_write_seqcount_barrier() - do a seqcount_t write barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * This can be used to provide an ordering guarantee instead of the usual
  * consistency guarantee. It is one wmb cheaper, because it can collapse
@@ -571,7 +572,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 /**
  * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
  *                               side operations
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * After write_seqcount_invalidate, no seqcount_t read side operations
  * will complete successfully and see data older than this.
@@ -589,7 +590,7 @@ static inline void write_seqcount_t_invalidate(seqcount_t *s)
 
 /**
  * raw_read_seqcount_latch() - pick even/odd seqcount_t latch data copy
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * Use seqcount_t latching to switch between two storage places protected
  * by a sequence counter. Doing so allows having interruptible, preemptible,
@@ -614,7 +615,7 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
 
 /**
  * raw_write_seqcount_latch() - redirect readers to even/odd copy
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
-- 
2.28.0

