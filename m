Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B0C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824C2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrAAVG+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IQ2Hm9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgGTP4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:56:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbgGTP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:19 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfpH5Rl9xdkV7Vb1DZl+6TEBkITnjoCxwY6EIOqqSRk=;
        b=BrAAVG+MgzQktdKZRJ/MMV+qpaH9PoZYmVwIFgFE/0891dFWKFwK89OXfZN4ovGVck4Ovm
        g6bT/WgjUxDTz7+orN6nDofv/et6/Co6RK9U+FPlunFX1FDIohmCUMhmZnuZVNgRZWMhKa
        Sz0HKKbhThbJkWbQgvLbFR8QDRkzUNqhdqSc0qUaX8jSav6FgA+9TyE/yxME22T1OFqKEA
        jvCEwLT8dt2klM1qazS6s4Ibiiyf4j3DusZDSvSbMRb9nk59z3PxYSEwWMyKF/+yQAHmYC
        ClXfg7jvjaFSwMlHu5cukfI8DkZVdz7U1GjwUZ7YX4yr2Er0b2IPvP7LSg9KFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfpH5Rl9xdkV7Vb1DZl+6TEBkITnjoCxwY6EIOqqSRk=;
        b=4IQ2Hm9QI4hdvmWlH2rHhwGLGe8CklAXLmZeqIu02icldF87tTg4xqWqugmS28MWYVSola
        bwIMqUtcaABG7LAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 09/24] seqlock: Extend seqcount API with associated locks
Date:   Mon, 20 Jul 2020 17:55:15 +0200
Message-Id: <20200720155530.1173732-10-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. If the serialization primitive is
not disabling preemption implicitly, preemption has to be explicitly
disabled before entering the write side critical section.

There is no built-in debugging mechanism to verify that the lock used
for writer serialization is held and preemption is disabled. Some usage
sites like dma-buf have explicit lockdep checks for the writer-side
lock, but this covers only a small portion of the sequence counter usage
in the kernel.

Add new sequence counter types which allows to associate a lock to the
sequence counter at initialization time. The seqcount API functions are
extended to provide appropriate lockdep assertions depending on the
seqcount/lock type.

For sequence counters with associated locks that do not implicitly
disable preemption, preemption protection is enforced in the sequence
counter write side functions. This removes the need to explicitly add
preempt_disable/enable() around the write side critical sections: the
write_begin/end() functions for these new sequence counter types
automatically do this.

Introduce the following seqcount types with associated locks:

     seqcount_spinlock_t
     seqcount_raw_spinlock_t
     seqcount_rwlock_t
     seqcount_mutex_t
     seqcount_ww_mutex_t

Extend the seqcount read and write functions to branch out to the
specific seqcount_LOCKTYPE_t implementation at compile-time. This avoids
kernel API explosion per each new seqcount_LOCKTYPE_t added. Add such
compile-time type detection logic into a new, internal, seqlock header.

Document the proper seqcount_LOCKTYPE_t usage, and rationale, at
Documentation/locking/seqlock.rst.

If lockdep is disabled, this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 Documentation/locking/seqlock.rst |  52 ++++
 include/linux/seqlock.h           | 462 +++++++++++++++++++++++++-----
 2 files changed, 446 insertions(+), 68 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 366dd368d90a..62c5ad98c11c 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -87,6 +87,58 @@ Read path::
 	} while (read_seqcount_retry(&foo_seqcount, seq));
 
 
+.. _seqcount_locktype_t:
+
+Sequence counters with associated locks (``seqcount_LOCKTYPE_t``)
+-----------------------------------------------------------------
+
+As discussed at :ref:`seqcount_t`, sequence count write side critical
+sections must be serialized and non-preemptible. This variant of
+sequence counters associate the lock used for writer serialization at
+initialization time, which enables lockdep to validate that the write
+side critical sections are properly serialized.
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
+The following sequence counters with associated locks are defined:
+
+  - ``seqcount_spinlock_t``
+  - ``seqcount_raw_spinlock_t``
+  - ``seqcount_rwlock_t``
+  - ``seqcount_mutex_t``
+  - ``seqcount_ww_mutex_t``
+
+The plain seqcount read and write APIs branch out to the specific
+seqcount_LOCKTYPE_t implementation at compile-time. This avoids kernel
+API explosion per each new seqcount LOCKTYPE.
+
+Initialization (replace "LOCKTYPE" with one of the supported locks)::
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
+Write path: same as in :ref:`seqcount_t`, while running from a context
+with the associated LOCKTYPE lock acquired.
+
+Read path: same as in :ref:`seqcount_t`.
+
 .. _seqlock_t:
 
 Sequential locks (``seqlock_t``)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 54bc20496392..8c16a494c968 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -10,13 +10,17 @@
  *
  * Copyrights:
  * - Based on x86_64 vsyscall gettimeofday: Keith Owens, Andrea Arcangeli
+ * - Sequence counters with associated locks, (C) 2020 Linutronix GmbH
  */
 
-#include <linux/spinlock.h>
-#include <linux/preempt.h>
-#include <linux/lockdep.h>
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <linux/lockdep.h>
+#include <linux/mutex.h>
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+#include <linux/ww_mutex.h>
+
 #include <asm/processor.h>
 
 /*
@@ -48,6 +52,10 @@
  * This mechanism can't be used if the protected data contains pointers,
  * as the writer can invalidate a pointer that a reader is following.
  *
+ * If the write serialization mechanism is one of the common kernel
+ * locking primitives, use a sequence counter with associated lock
+ * (seqcount_LOCKTYPE_t) instead.
+ *
  * If it's desired to automatically handle the sequence counter writer
  * serialization and non-preemptibility requirements, use a sequential
  * lock (seqlock_t) instead.
@@ -108,9 +116,267 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  */
 #define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
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
+ * Lockdep is never used in any for the raw write variants.
+ *
+ * See Documentation/locking/seqlock.rst
+ */
+
+#ifdef CONFIG_LOCKDEP
+#define __SEQ_LOCKDEP(expr)	expr
+#else
+#define __SEQ_LOCKDEP(expr)
+#endif
+
+#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
+	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
+	__SEQ_LOCKDEP(.lock	= (assoc_lock))				\
+}
+
+#define seqcount_locktype_init(s, assoc_lock)				\
+do {									\
+	seqcount_init(&(s)->seqcount);					\
+	__SEQ_LOCKDEP((s)->lock = (assoc_lock));			\
+} while (0)
+
+/**
+ * typedef seqcount_spinlock_t - sequence counter with spinlock associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated spinlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * spinlock. The spinlock is associated to the sequence count in the
+ * static initializer or init function. This enables lockdep to validate
+ * that the write side critical section is properly serialized.
+ */
+typedef struct seqcount_spinlock {
+	seqcount_t	seqcount;
+	__SEQ_LOCKDEP(spinlock_t	*lock);
+} seqcount_spinlock_t;
+
+/**
+ * SEQCNT_SPINLOCK_ZERO - static initializer for seqcount_spinlock_t
+ * @name:	Name of the seqcount_spinlock_t instance
+ * @lock:	Pointer to the associated spinlock
+ */
+#define SEQCNT_SPINLOCK_ZERO(name, lock)				\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_spinlock_init - runtime initializer for seqcount_spinlock_t
+ * @s:		Pointer to the seqcount_spinlock_t instance
+ * @lock:	Pointer to the associated spinlock
+ */
+#define seqcount_spinlock_init(s, lock)					\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_raw_spinlock_t - sequence count with raw spinlock associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated raw spinlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * raw spinlock. The raw spinlock is associated to the sequence count in
+ * the static initializer or init function. This enables lockdep to
+ * validate that the write side critical section is properly serialized.
+ */
+typedef struct seqcount_raw_spinlock {
+	seqcount_t      seqcount;
+	__SEQ_LOCKDEP(raw_spinlock_t	*lock);
+} seqcount_raw_spinlock_t;
+
+/**
+ * SEQCNT_RAW_SPINLOCK_ZERO - static initializer for seqcount_raw_spinlock_t
+ * @name:	Name of the seqcount_raw_spinlock_t instance
+ * @lock:	Pointer to the associated raw_spinlock
+ */
+#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)				\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_raw_spinlock_init - runtime initializer for seqcount_raw_spinlock_t
+ * @s:		Pointer to the seqcount_raw_spinlock_t instance
+ * @lock:	Pointer to the associated raw_spinlock
+ */
+#define seqcount_raw_spinlock_init(s, lock)				\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_rwlock_t - sequence count with rwlock associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated rwlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * rwlock. The rwlock is associated to the sequence count in the static
+ * initializer or init function. This enables lockdep to validate that
+ * the write side critical section is properly serialized.
+ */
+typedef struct seqcount_rwlock {
+	seqcount_t      seqcount;
+	__SEQ_LOCKDEP(rwlock_t		*lock);
+} seqcount_rwlock_t;
+
+/**
+ * SEQCNT_RWLOCK_ZERO - static initializer for seqcount_rwlock_t
+ * @name:	Name of the seqcount_rwlock_t instance
+ * @lock:	Pointer to the associated rwlock
+ */
+#define SEQCNT_RWLOCK_ZERO(name, lock)					\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_rwlock_init - runtime initializer for seqcount_rwlock_t
+ * @s:		Pointer to the seqcount_rwlock_t instance
+ * @lock:	Pointer to the associated rwlock
+ */
+#define seqcount_rwlock_init(s, lock)					\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_mutex_t - sequence count with mutex associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated mutex
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
+	__SEQ_LOCKDEP(struct mutex	*lock);
+} seqcount_mutex_t;
+
+/**
+ * SEQCNT_MUTEX_ZERO - static initializer for seqcount_mutex_t
+ * @name:	Name of the seqcount_mutex_t instance
+ * @lock:	Pointer to the associated mutex
+ */
+#define SEQCNT_MUTEX_ZERO(name, lock)					\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_mutex_init - runtime initializer for seqcount_mutex_t
+ * @s:		Pointer to the seqcount_mutex_t instance
+ * @lock:	Pointer to the associated mutex
+ */
+#define seqcount_mutex_init(s, lock)					\
+	seqcount_locktype_init(s, lock)
+
+/**
+ * typedef seqcount_ww_mutex_t - sequence count with ww_mutex associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated ww_mutex
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
+	__SEQ_LOCKDEP(struct ww_mutex	*lock);
+} seqcount_ww_mutex_t;
+
+/**
+ * SEQCNT_WW_MUTEX_ZERO - static initializer for seqcount_ww_mutex_t
+ * @name:	Name of the seqcount_ww_mutex_t instance
+ * @lock:	Pointer to the associated ww_mutex
+ */
+#define SEQCNT_WW_MUTEX_ZERO(name, lock)				\
+	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+/**
+ * seqcount_ww_mutex_init - runtime initializer for seqcount_ww_mutex_t
+ * @s:		Pointer to the seqcount_ww_mutex_t instance
+ * @lock:	Pointer to the associated ww_mutex
+ */
+#define seqcount_ww_mutex_init(s, lock)					\
+	seqcount_locktype_init(s, lock)
+
+/*
+ * @preempt: Is the associated write serialization lock preemtpible?
+ */
+#define SEQCOUNT_LOCKTYPE(locktype, preempt, lockmember)		\
+static inline seqcount_t *						\
+__seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
+{									\
+	return &s->seqcount;						\
+}									\
+									\
+static inline bool							\
+__seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
+{									\
+	return preempt;							\
+}									\
+									\
+static inline void							\
+__seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
+{									\
+	__SEQ_LOCKDEP(lockdep_assert_held(lockmember));			\
+}
+
+/*
+ * Similar hooks, but for plain seqcount_t
+ */
+
+static inline seqcount_t *__seqcount_ptr(seqcount_t *s)
+{
+	return s;
+}
+
+static inline bool __seqcount_preemptible(seqcount_t *s)
+{
+	return false;
+}
+
+static inline void __seqcount_assert(seqcount_t *s)
+{
+	lockdep_assert_preemption_disabled();
+}
+
+/*
+ * @s: Pointer to seqcount_locktype_t, generated hooks first parameter.
+ */
+SEQCOUNT_LOCKTYPE(raw_spinlock,	false,	s->lock)
+SEQCOUNT_LOCKTYPE(spinlock,	false,	s->lock)
+SEQCOUNT_LOCKTYPE(rwlock,	false,	s->lock)
+SEQCOUNT_LOCKTYPE(mutex,	true,	s->lock)
+SEQCOUNT_LOCKTYPE(ww_mutex,	true,	&s->lock->base)
+
+#define __seqprop_case(s, locktype, prop)				\
+	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
+
+#define __seqprop(s, prop) _Generic(*(s),				\
+	seqcount_t:		__seqcount_##prop((void *)(s)),		\
+	__seqprop_case((s),	raw_spinlock,	prop),			\
+	__seqprop_case((s),	spinlock,	prop),			\
+	__seqprop_case((s),	rwlock,		prop),			\
+	__seqprop_case((s),	mutex,		prop),			\
+	__seqprop_case((s),	ww_mutex,	prop))
+
+#define __to_seqcount_t(s)				__seqprop(s, ptr)
+#define __associated_lock_exists_and_is_preemptible(s)	__seqprop(s, preemptible)
+#define __assert_write_section_is_protected(s)		__seqprop(s, assert)
+
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -122,7 +388,10 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-static inline unsigned __read_seqcount_begin(const seqcount_t *s)
+#define __read_seqcount_begin(s)					\
+	__read_seqcount_t_begin(__to_seqcount_t(s))
+
+static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
@@ -138,32 +407,38 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
+#define raw_read_seqcount_begin(s)					\
+	raw_read_seqcount_t_begin(__to_seqcount_t(s))
+
+static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
 {
-	unsigned ret = __read_seqcount_begin(s);
+	unsigned ret = __read_seqcount_t_begin(s);
 	smp_rmb();
 	return ret;
 }
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-static inline unsigned read_seqcount_begin(const seqcount_t *s)
+#define read_seqcount_begin(s)						\
+	read_seqcount_t_begin(__to_seqcount_t(s))
+
+static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
 {
 	seqcount_lockdep_reader_access(s);
-	return raw_read_seqcount_begin(s);
+	return raw_read_seqcount_t_begin(s);
 }
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checking, and without checking or
@@ -172,7 +447,10 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
+#define raw_read_seqcount(s)						\
+	raw_read_seqcount_t(__to_seqcount_t(s))
+
+static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -183,7 +461,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * raw_seqcount_begin opens a read critical section of the given
  * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
@@ -197,18 +475,21 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-static inline unsigned raw_seqcount_begin(const seqcount_t *s)
+#define raw_seqcount_begin(s)						\
+	raw_seqcount_t_begin(__to_seqcount_t(s))
+
+static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
 {
 	/*
 	 * If the counter is odd, let read_seqcount_retry() fail
 	 * by decrementing the counter.
 	 */
-	return raw_read_seqcount(s) & ~1;
+	return raw_read_seqcount_t(s) & ~1;
 }
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
@@ -221,7 +502,10 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  *
  * Return: true if a read section retry is required, else false
  */
-static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define __read_seqcount_retry(s, start)					\
+	__read_seqcount_t_retry(__to_seqcount_t(s), start)
+
+static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -229,7 +513,7 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 /**
  * read_seqcount_retry() - end a seqcount_t read critical section
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin()
  *
  * read_seqcount_retry closes the read critical section of given
@@ -238,17 +522,28 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
  *
  * Return: true if a read section retry is required, else false
  */
-static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define read_seqcount_retry(s, start)					\
+	read_seqcount_t_retry(__to_seqcount_t(s), start)
+
+static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_retry(s, start);
+	return __read_seqcount_t_retry(s, start);
 }
 
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  */
-static inline void raw_write_seqcount_begin(seqcount_t *s)
+#define raw_write_seqcount_begin(s)					\
+do {									\
+	if (__associated_lock_exists_and_is_preemptible(s))		\
+		preempt_disable();					\
+									\
+	raw_write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -257,49 +552,50 @@ static inline void raw_write_seqcount_begin(seqcount_t *s)
 
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  */
-static inline void raw_write_seqcount_end(seqcount_t *s)
+#define raw_write_seqcount_end(s)					\
+do {									\
+	raw_write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_exists_and_is_preemptible(s))		\
+		preempt_enable();					\
+} while (0)
+
+static inline void raw_write_seqcount_t_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
 	kcsan_nestable_atomic_end();
 }
 
-static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
-{
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
-}
-
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
  */
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
-{
-	lockdep_assert_preemption_disabled();
-	__write_seqcount_begin_nested(s, subclass);
-}
+#define write_seqcount_begin_nested(s, subclass)			\
+do {									\
+	__assert_write_section_is_protected(s);				\
+									\
+	if (__associated_lock_exists_and_is_preemptible(s))		\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin_nested(__to_seqcount_t(s), subclass);	\
+} while (0)
 
-/*
- * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
- *
- * Use for internal seqlock.h code where it's known that preemption is
- * already disabled. For example, seqlock_t write side functions.
- */
-static inline void __write_seqcount_begin(seqcount_t *s)
+static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 {
-	__write_seqcount_begin_nested(s, 0);
+	raw_write_seqcount_t_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
 /**
  * write_seqcount_begin() - start a seqcount_t write side critical section
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * write_seqcount_begin opens a write side critical section of the given
  * seqcount_t.
@@ -308,26 +604,44 @@ static inline void __write_seqcount_begin(seqcount_t *s)
  * non-preemptible. If readers can be invoked from hardirq or softirq
  * context, interrupts or bottom halves must be respectively disabled.
  */
-static inline void write_seqcount_begin(seqcount_t *s)
+#define write_seqcount_begin(s)						\
+do {									\
+	__assert_write_section_is_protected(s);				\
+									\
+	if (__associated_lock_exists_and_is_preemptible(s))		\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+static inline void write_seqcount_t_begin(seqcount_t *s)
 {
-	write_seqcount_begin_nested(s, 0);
+	write_seqcount_t_begin_nested(s, 0);
 }
 
 /**
  * write_seqcount_end() - end a seqcount_t write side critical section
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * The write section must've been opened with write_seqcount_begin().
  */
-static inline void write_seqcount_end(seqcount_t *s)
+#define write_seqcount_end(s)						\
+do {									\
+	write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_exists_and_is_preemptible(s))		\
+		preempt_enable();					\
+} while (0)
+
+static inline void write_seqcount_t_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_end(s);
+	raw_write_seqcount_t_end(s);
 }
 
 /**
  * raw_write_seqcount_barrier() - do a seqcount_t write barrier
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * This can be used to provide an ordering guarantee instead of the usual
  * consistency guarantee. It is one wmb cheaper, because it can collapse
@@ -366,7 +680,10 @@ static inline void write_seqcount_end(seqcount_t *s)
  *		WRITE_ONCE(X, false);
  *      }
  */
-static inline void raw_write_seqcount_barrier(seqcount_t *s)
+#define raw_write_seqcount_barrier(s)					\
+	raw_write_seqcount_t_barrier(__to_seqcount_t(s))
+
+static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -378,12 +695,15 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 /**
  * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
  *                               side operations
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * After write_seqcount_invalidate, no seqcount_t read side operations
  * will complete successfully and see data older than this.
  */
-static inline void write_seqcount_invalidate(seqcount_t *s)
+#define write_seqcount_invalidate(s)					\
+	write_seqcount_t_invalidate(__to_seqcount_t(s))
+
+static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -393,7 +713,7 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
 
 /**
  * raw_read_seqcount_latch() - pick even/odd seqcount_t latch data copy
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * Use seqcount_t latching to switch between two storage places protected
  * by a sequence counter. Doing so allows having interruptible, preemptible,
@@ -406,7 +726,10 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
  * picking which data copy to read. The full counter value must then be
  * checked with read_seqcount_retry().
  */
-static inline int raw_read_seqcount_latch(seqcount_t *s)
+#define raw_read_seqcount_latch(s)					\
+	raw_read_seqcount_t_latch(__to_seqcount_t(s))
+
+static inline int raw_read_seqcount_t_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
 	int seq = READ_ONCE(s->sequence); /* ^^^ */
@@ -415,7 +738,7 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 
 /**
  * raw_write_seqcount_latch() - redirect readers to even/odd copy
- * @s: Pointer to seqcount_t
+ * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -494,7 +817,10 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_t *s)
+#define raw_write_seqcount_latch(s)					\
+	raw_write_seqcount_t_latch(__to_seqcount_t(s))
+
+static inline void raw_write_seqcount_t_latch(seqcount_t *s)
 {
        smp_wmb();      /* prior stores before incrementing "sequence" */
        s->sequence++;
@@ -592,7 +918,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -604,7 +930,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -618,7 +944,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -631,7 +957,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -645,7 +971,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -657,7 +983,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -666,7 +992,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount);
 	return flags;
 }
 
@@ -695,13 +1021,13 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
 /**
  * read_seqlock_excl() - begin a seqlock_t locking reader section
- * @sl: Pointer to seqlock_t
+ * @sl:	Pointer to seqlock_t
  *
  * read_seqlock_excl opens a seqlock_t locking reader critical section.  A
  * locking reader exclusively locks out *both* other writers *and* other
-- 
2.20.1

