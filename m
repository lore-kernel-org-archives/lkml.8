Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A181DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AB1207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcbvQMAq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZjsm6Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgF3Fp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgF3FpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:45:22 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SblpqUf6hJobOC81SbDiPOeMTfbw20a932vHtX4XhSk=;
        b=IcbvQMAqe11EpwpoCp4N0YeRv1Gxl/Akp9s137luzYdoF/Dq3DZO+RqhKVQ9ghE0JToTqn
        vXAwxTBVIrdJQCc14lQ4Ed7xfg5P0z45Hhb3BH5A++g89/SXg3wKW7TTTNYmeCi6mbSsIO
        heXbMvwMD2S7YfEdImdPfAfl64CZlWjP2bTmjbAV6s2D2BjBX+eOalcPUZd6eJWda/zGye
        EbMJa0niDHVgawJX2psT/xi13nT2bYYifns8nsREt8iaTOu5BB30h0EyJh3xFDUiO6NaSr
        Io5V0ivYHcGG3+vXDnjBKd1xHyaTdBOiKQhQ8K6ErOciarfuHO8fdWJ6vATT3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SblpqUf6hJobOC81SbDiPOeMTfbw20a932vHtX4XhSk=;
        b=SZjsm6EgQTbbhT/XRa4p/6W0QcsN2aXGYmTKOpsSAx/qkkgyF+PcNlOIHYHs3ASsSY7WbN
        mBiRS/8gBEURJTDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 06/20] seqlock: Extend seqcount API with associated locks
Date:   Tue, 30 Jun 2020 07:44:38 +0200
Message-Id: <20200630054452.3675847-7-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
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
 Documentation/locking/seqlock.rst      |  64 ++++-
 MAINTAINERS                            |   2 +-
 include/linux/seqlock.h                | 372 ++++++++++++++++++++-----
 include/linux/seqlock_types_internal.h | 186 +++++++++++++
 4 files changed, 558 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/seqlock_types_internal.h

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index c9916efe038e..2d526dc95408 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -48,9 +48,11 @@ write side section. If the read section can be invoked from hardirq or
 softirq contexts, interrupts or bottom halves must also be respectively
 disabled before entering the write section.
 
-If it's desired to automatically handle the sequence counter
-requirements of writer serialization and non-preemptibility, use a
-:ref:`sequential lock <seqlock_t>` instead.
+If the write serialization mechanism is one of the common kernel locking
+primitives, use :ref:`sequence counters with associated locks
+<seqcount_locktype_t>` instead. If it's desired to automatically handle
+the sequence counter writer serialization and non-preemptibility
+requirements, use a :ref:`sequential lock <seqlock_t>`.
 
 Initialization:
 
@@ -70,6 +72,7 @@ Initialization:
 
 Write path:
 
+.. _seqcount_write_ops:
 .. code-block:: c
 
 	/* Serialized context with disabled preemption */
@@ -82,6 +85,7 @@ Write path:
 
 Read path:
 
+.. _seqcount_read_ops:
 .. code-block:: c
 
 	do {
@@ -91,6 +95,60 @@ Read path:
 
 	} while (read_seqcount_retry(&foo_seqcount, seq));
 
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
 .. _seqlock_t:
 
 Sequential locks (:c:type:`seqlock_t`)
diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..84a859bc8b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10077,7 +10077,7 @@ F:	include/linux/lockdep.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/rwsem*.h
-F:	include/linux/seqlock.h
+F:	include/linux/seqlock*.h
 F:	include/linux/spinlock*.h
 F:	kernel/locking/
 F:	lib/locking*.[ch]
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 679c440b17fe..fb0fe5b7c4f4 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -48,6 +48,10 @@
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
@@ -108,11 +112,223 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
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
+ * See Documentation/locking/seqlock.rst
+ */
 
 /**
- * __read_seqcount_begin() - begin a seqcount_t read section (without barrier)
- * @s: Pointer to &typedef seqcount_t
- * Returns: count to be passed to read_seqcount_retry()
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
+#ifdef CONFIG_LOCKDEP
+	spinlock_t	*lock;
+#endif
+} seqcount_spinlock_t;
+
+#ifdef CONFIG_LOCKDEP
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
+#else /* !CONFIG_LOCKDEP */
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
+#endif
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
+#ifdef CONFIG_LOCKDEP
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
+#ifdef CONFIG_LOCKDEP
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
+#ifdef CONFIG_LOCKDEP
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
+#ifdef CONFIG_LOCKDEP
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
+/**
+ * __read_seqcount_begin() - begin a seqcount read section (without barrier)
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ * Returns: count to be passed to read_seqcount_retry
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -122,7 +338,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline unsigned __read_seqcount_begin(const seqcount_t *s)
+#define __read_seqcount_begin(s)	do___read_seqcount_begin(s)
+
+static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
@@ -137,16 +355,18 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount() - Read the seqcount_t raw counter value
- * @s: Pointer to &typedef seqcount_t
- * Returns: count to be passed to read_seqcount_retry()
+ * raw_read_seqcount() - Read the seqcount raw counter value
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ * Returns: count to be passed to read_seqcount_retry
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checks and without checking or
  * masking the sequence counter LSB. Calling code is responsible for
  * handling that.
  */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
+#define raw_read_seqcount(s)	do_raw_read_seqcount(s)
+
+static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -155,39 +375,43 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_begin() - start a seqcount_t read section w/o lockdep
- * @s: Pointer to &typedef seqcount_t
- * Returns: count to be passed to read_seqcount_retry()
+ * raw_read_seqcount_begin() - start a seqcount read section w/o lockdep
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ * Returns: count to be passed to read_seqcount_retry
  *
  * raw_read_seqcount_begin opens a read critical section of the given
  * seqcount_t, but without any lockdep checking. Validity of the read
  * section must be checked with read_seqcount_retry().
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
- * read_seqcount_begin() - start a seqcount_t read critical section
- * @s: Pointer to &typedef seqcount_t
- * Returns: count to be passed to read_seqcount_retry()
+ * read_seqcount_begin() - start a seqcount read critical section
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ * Returns: count to be passed to read_seqcount_retry
  *
  * read_seqcount_begin opens a read critical section of the given
  * seqcount_t. Validity of the read section must be checked with
  * read_seqcount_retry().
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
  * raw_seqcount_begin() - begin a seq-read critical section
- * @s: Pointer to &typedef seqcount_t
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
  * raw_seqcount_begin opens a read critical section of the given seqcount_t.
@@ -199,7 +423,9 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
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
@@ -209,7 +435,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 
 /**
  * __read_seqcount_retry() - end a seq-read critical section (without barrier)
- * @s: Pointer to &typedef seqcount_t
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -221,7 +447,9 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define __read_seqcount_retry(s, start)		do___read_seqcount_retry(s, start)
+
+static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -229,7 +457,7 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 /**
  * read_seqcount_retry() - end a seq-read critical section
- * @s: Pointer to &typedef seqcount_t
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -237,22 +465,28 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
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
 
 
 
-static inline void raw_write_seqcount_begin(seqcount_t *s)
+#define raw_write_seqcount_begin(s)	do_raw_write_seqcount_begin(s)
+
+static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
 
-static inline void raw_write_seqcount_end(seqcount_t *s)
+#define raw_write_seqcount_end(s)	do_raw_write_seqcount_end(s)
+
+static inline void raw_write_seqcount_t_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -261,7 +495,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 
 /**
  * raw_write_seqcount_barrier() - do a seq write barrier
- * @s: Pointer to &typedef seqcount_t
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
@@ -300,7 +534,9 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *              WRITE_ONCE(X, false);
  *      }
  */
-static inline void raw_write_seqcount_barrier(seqcount_t *s)
+#define raw_write_seqcount_barrier(s)	do_raw_write_seqcount_barrier(s)
+
+static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -310,8 +546,8 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_latch() - pick even or odd seqcount_t latch data copy
- * @s: Pointer to &typedef seqcount_t
+ * raw_read_seqcount_latch() - pick even or odd seqcount latch data copy
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * Use seqcount latching to switch between two storage places with
  * sequence protection to allow interruptible, preemptible, writer
@@ -324,7 +560,9 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
  * which data copy to read. Full counter must then be checked with
  * read_seqcount_retry().
  */
-static inline int raw_read_seqcount_latch(seqcount_t *s)
+#define raw_read_seqcount_latch(s)	do_raw_read_seqcount_latch(s)
+
+static inline int raw_read_seqcount_t_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
 	int seq = READ_ONCE(s->sequence); /* ^^^ */
@@ -333,7 +571,7 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 
 /**
  * raw_write_seqcount_latch() - redirect readers to even/odd copy
- * @s: Pointer to &typedef seqcount_t
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -412,49 +650,54 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
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
 
-static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
+static inline void __write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_begin(s);
+	raw_write_seqcount_t_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+#define write_seqcount_begin_nested(s, subclass)		\
+	do_write_seqcount_begin_nested(s, subclass)
+
+static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 {
 	lockdep_assert_preemption_disabled();
-	__write_seqcount_begin_nested(s, subclass);
+	__write_seqcount_t_begin_nested(s, subclass);
 }
 
 /*
- * write_seqcount_begin() without lockdep non-preemptibility checks.
+ * write_seqcount_t_begin() without lockdep non-preemptibility checks.
  *
  * Use for internal seqlock.h code where it's known that preemption is
  * already disabled. For example, seqlock_t write side functions.
  */
-static inline void __write_seqcount_begin(seqcount_t *s)
+static inline void __write_seqcount_t_begin(seqcount_t *s)
 {
-	__write_seqcount_begin_nested(s, 0);
+	__write_seqcount_t_begin_nested(s, 0);
 }
 
 /**
- * write_seqcount_begin() - start a seqcount_t write-side critical section
- * @s: Pointer to &typedef seqcount_t
+ * write_seqcount_begin() - start a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * write_seqcount_begin opens a write-side critical section of the given
- * seqcount_t. Sequence counter write-side critical sections must be
- * serialized and non-preemptible. If readers can be invoked from
- * hardirq or softirq contexts, interrupts or bottom halves must be
- * respectively disabled.
+ * seqcount. Seqcount write-side critical sections must be externally
+ * serialized and non-preemptible.
  */
-static inline void write_seqcount_begin(seqcount_t *s)
+#define write_seqcount_begin(s)		do_write_seqcount_begin(s)
+
+static inline void write_seqcount_t_begin(seqcount_t *s)
 {
-	write_seqcount_begin_nested(s, 0);
+	write_seqcount_t_begin_nested(s, 0);
 }
 
 /**
@@ -463,7 +706,9 @@ static inline void write_seqcount_begin(seqcount_t *s)
  *
  * The write section must've been opened with write_seqcount_begin().
  */
-static inline void write_seqcount_end(seqcount_t *s)
+#define write_seqcount_end(s)		do_write_seqcount_end(s)
+
+static inline void write_seqcount_t_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
 	raw_write_seqcount_end(s);
@@ -471,12 +716,14 @@ static inline void write_seqcount_end(seqcount_t *s)
 
 /**
  * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
- * @s: Pointer to &typedef seqcount_t
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
 	kcsan_nestable_atomic_begin();
@@ -534,7 +781,7 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	unsigned ret = read_seqcount_begin(&sl->seqcount);
+	unsigned ret = read_seqcount_t_begin(&sl->seqcount);
 
 	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
 	kcsan_flat_atomic_begin();
@@ -560,7 +807,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 	 */
 	kcsan_flat_atomic_end();
 
-	return read_seqcount_retry(&sl->seqcount, start);
+	return read_seqcount_t_retry(&sl->seqcount, start);
 }
 
 /**
@@ -580,7 +827,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -592,7 +839,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -608,7 +855,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -621,7 +868,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -635,7 +882,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_t_begin(&sl->seqcount);
 }
 
 /**
@@ -647,7 +894,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -656,7 +903,8 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	__write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_t_begin(&sl->seqcount);
+
 	return flags;
 }
 
@@ -685,7 +933,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
diff --git a/include/linux/seqlock_types_internal.h b/include/linux/seqlock_types_internal.h
new file mode 100644
index 000000000000..a70bf38e6eb5
--- /dev/null
+++ b/include/linux/seqlock_types_internal.h
@@ -0,0 +1,186 @@
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
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	raw_write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+#define do_raw_write_seqcount_end(s)					\
+do {									\
+	raw_write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_enable();					\
+} while (0)
+
+#define do_write_seqcount_begin_nested(s, subclass)			\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin_nested(__to_seqcount_t(s), subclass);	\
+} while (0)
+
+#define do_write_seqcount_begin(s)					\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	write_seqcount_t_begin(__to_seqcount_t(s));			\
+} while (0)
+
+#define do_write_seqcount_end(s)					\
+do {									\
+	write_seqcount_t_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_is_preemptible(s))			\
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
-- 
2.20.1

