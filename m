Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3993C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D6B206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7aBRlqK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7e/MDkNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgF3FpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3FpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F48C061755;
        Mon, 29 Jun 2020 22:45:01 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahCqArCQ3J4S3y3Oq01qNAzHEryvvr63rPwr0737Hdc=;
        b=M7aBRlqKkZiGU6BKsNeDn1x6lArv5sY+l+T3w5H7j31IcLZy8V5Cj9FcLhlJucYUrAYEjc
        yKeBJ+S/DCFRfaNfvkZ/orkT6IqvJSEwrEj25l5exQRMX3eyWMNh8dO5TB4UPQ9gqlIR0E
        vnVMh0obSGTtCv72hs3S9DajD5pKiOnPAUL74SpbBNMNQQliyD0pW/uiU9OlH5LKuJknmU
        33yUWe/4Kyqh3YFXKJYxr8wB0VQekTQKM/tlcFjAwkz8RzwTDCRqvfUbPIAmudsNu9+Pmr
        JHgMzOUWFhSpp/pXZ6XWt+bTxSg2NkxKnvKz6rfThYiS5LDVx1s4FCT+BwVwPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahCqArCQ3J4S3y3Oq01qNAzHEryvvr63rPwr0737Hdc=;
        b=7e/MDkNJfUEdvKABxo6U2Yx7cS8OoKM3yoWaI3VRQaKwx9ehrm8zAG5xphQToroGIpKRja
        Ol2OJUpEy6qdrtAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v3 01/20] Documentation: locking: Describe seqlock design and usage
Date:   Tue, 30 Jun 2020 07:44:33 +0200
Message-Id: <20200630054452.3675847-2-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proper documentation for the design and usage of sequence counters and
sequential locks does not exist. Complete the seqlock.h documentation as
follows:

  - Divide all documentation on a seqcount_t vs. seqlock_t basis. The
    description for both mechanisms was intermingled, which is incorrect
    since the usage constrains for each type are vastly different.

  - Add an introductory paragraph describing the internal design of, and
    rationale for, sequence counters.

  - Document seqcount_t writer non-preemptibility requirement, which was
    not previously documented anywhere, and provide a clear rationale.

  - Provide template code for seqcount_t and seqlock_t initialization
    and reader/writer critical sections.

  - Recommend using seqlock_t by default. It implicitly handles the
    serialization and non-preemptibility requirements of writers.

At seqlock.h:

  - Remove references to brlocks as they've long been removed from the
    kernel.

  - Remove references to gcc-3.x since the kernel's minimum supported
    gcc version is 4.6.

References: 0f6ed63b1707 ("no need to keep brlock macros anymore...")
References: cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 Documentation/locking/index.rst   |   1 +
 Documentation/locking/seqlock.rst | 184 ++++++++++++++++++++++++++++++
 include/linux/seqlock.h           |  77 ++++++-------
 3 files changed, 221 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/locking/seqlock.rst

diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index d785878cad65..7003bd5aeff4 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -14,6 +14,7 @@ locking
     mutex-design
     rt-mutex-design
     rt-mutex
+    seqlock
     spinlocks
     ww-mutex-design
     preempt-locking
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
new file mode 100644
index 000000000000..c9916efe038e
--- /dev/null
+++ b/Documentation/locking/seqlock.rst
@@ -0,0 +1,184 @@
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
+If it's desired to automatically handle the sequence counter
+requirements of writer serialization and non-preemptibility, use a
+:ref:`sequential lock <seqlock_t>` instead.
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
+.. code-block:: c
+
+	do {
+		seq = read_seqcount_begin(&foo_seqcount);
+
+		/* ... [[read-side critical section]] ... */
+
+	} while (read_seqcount_retry(&foo_seqcount, seq));
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
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8b97204f35a7..e54ff48e87f8 100644
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
@@ -41,8 +20,8 @@
 #include <asm/processor.h>
 
 /*
- * The seqlock interface does not prescribe a precise sequence of read
- * begin/retry/end. For readers, typically there is a call to
+ * The seqlock seqcount_t interface does not prescribe a precise sequence of
+ * read begin/retry/end. For readers, typically there is a call to
  * read_seqcount_begin() and read_seqcount_retry(), however, there are more
  * esoteric cases which do not follow this pattern.
  *
@@ -56,10 +35,24 @@
 #define KCSAN_SEQLOCK_REGION_MAX 1000
 
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
+ * If it's desired to automatically handle the sequence counter writer
+ * serialization and non-preemptibility requirements, use a sequential
+ * lock (seqlock_t) instead.
+ *
+ * See Documentation/locking/seqlock.rst
  */
 typedef struct seqcount {
 	unsigned sequence;
@@ -398,10 +391,6 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
        smp_wmb();      /* increment "sequence" before following stores */
 }
 
-/*
- * Sequence counter only version assumes that callers are using their
- * own mutexing.
- */
 static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
 	raw_write_seqcount_begin(s);
@@ -434,15 +423,21 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
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
-- 
2.20.1

