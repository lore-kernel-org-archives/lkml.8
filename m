Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0454B206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7tmWFYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgGHQB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgGHQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:01:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABFC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYqf/St3sL1G5ctpa1Ef8obuKeR8gEnybQPl9JXVaDE=; b=u7tmWFYazFCPAwRZovF0pEF8Q4
        COer82767rx9129wa8ls2dbM36RFMUMA6FJwC7gaPzUo5eVqFtQUXbyM83QTwbB/OKjzNc+oSAMY9
        WF9nHS9gZuC8KLcF+zla42DoKg6q7KRncBjskFK3RV/EVNDdzz8ArUIQyw0UwjEra0RRbnpl7EpJ1
        63RrWbYjU1Eq0jU9iTLD4fFG4fyoolmw53eroCWIPgI129oJzF86bvPH0nXKu4FPVUbKmPHgyZzmo
        lL01tipet0+NG+CO7pgzNXFI6k/pFpqe8901reusFfVSrVe83w8Fl+1IiOqZHDQm86/AWVHRXYLLn
        WmVYKXhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtCW6-0004w1-PA; Wed, 08 Jul 2020 16:01:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 855D33013E5;
        Wed,  8 Jul 2020 18:01:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E05E214ECDA0; Wed,  8 Jul 2020 18:01:49 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:01:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708160149.GS117543@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
 <20200708153522.GR4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708153522.GR4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:35:22PM +0200, Peter Zijlstra wrote:
> But I figured _that_ might've been one step too far ;-)

Damn, now you made me do it... and it's not too horrible. Included the
-rt part.

---
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8b97204f35a7..cc15a6aaab00 100644
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
- *
- * This is not as cache friendly as brlock. Also, this may not work well
- * for data that contains pointers, because any writer could
- * invalidate a pointer that a reader was following.
- *
- * Expected non-blocking reader usage:
- * 	do {
- *	    seq = read_seqbegin(&foo);
- * 	...
- *      } while (read_seqretry(&foo, seq));
+ * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
+ * lockless readers (read-only retry loops), and no writer starvation.
  *
+ * See Documentation/locking/seqlock.rst for full description.
  *
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
@@ -56,10 +35,28 @@
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
@@ -82,6 +79,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the &typedef seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -105,12 +106,139 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
-#define SEQCNT_ZERO(lockname) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(lockname)}
+/**
+ * SEQCNT_ZERO() - static initializer for seqcount_t
+ * @name: Name of the &typedef seqcount_t instance
+ */
+#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
+
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
+#define __SEQ_LOCK(expr)	expr
+#else
+#define __SEQ_LOCK(expr)
+#endif
+
+typedef seqcount_t * __seqprop_ptr_t;
+typedef bool	     __seqprop_preempt_t;
+typedef void	     __seqprop_assert_t;
+typedef unsigned     __seqprop_begin_t;
+
+#define __SEQPROP(name, prop)			\
+static __always_inline __seqprop_##prop##_t	\
+__seqprop##name##_##prop(seqcount##name##_t *s)
+
+__SEQPROP(, ptr) { return s; }
+__SEQPROP(, preempt) { return false; }
+__SEQPROP(, assert) { }
+__SEQPROP(, begin) { return smp_cond_load_relaxed(&s->sequence, !(VAL & 1)); }
+
+#define SEQCOUNT_LOCKTYPE(name, locktype, lockbase, blocking, lockmember)	\
+typedef struct seqcount_##name {					\
+	seqcount_t	seqcount;					\
+	__SEQ_LOCK(locktype *lock);					\
+} seqcount_##name##_t;							\
+									\
+static __always_inline void						\
+seqcount_##name##_init(seqcount_##name##_t *s, locktype *l)		\
+{									\
+	seqcount_init(&s->seqcount);					\
+	__SEQ_LOCK(s->lock = l);					\
+}									\
+									\
+__SEQPROP(_##name, ptr)	    { return &s->seqcount; }			\
+__SEQPROP(_##name, preempt) { return blocking; }			\
+__SEQPROP(_##name, assert)  {						\
+	__SEQ_LOCK(lockdep_assert_held(s->lockmember));			\
+}									\
+__SEQPROP(_##name, begin)   {						\
+	if (!__SEQ_RT || !blocking)					\
+		return __seqprop_begin(&s->seqcount);			\
+									\
+	__SEQ_LOCK(lockbase##_lock(&s->lock);				\
+		   lockbase##_unlock(&s->lock));			\
+									\
+	return READ_ONCE(s->seqcount.sequence);				\
+}
+
+#define SEQCNT_LOCKTYPE_ZERO(_name, _lock) {				\
+	.seqcount = SEQCNT_ZERO(_name.seqcount),			\
+	__SEQ_LOCK(.lock = (_lock))					\
+}
+
+#include <linux/spinlock.h>
+#include <linux/ww_mutex.h>
+
+#define __SEQ_RT	IS_BUILTIN(CONFIG_PREEMPT_RT)
+
+SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,	raw_spin, false,	lock)
+SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,	spin,     __SEQ_RT,	lock)
+SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,	read,     __SEQ_RT,	lock)
+SEQCOUNT_LOCKTYPE(mutex,	struct mutex,	mutex,    true,		lock)
+SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,ww_mutex, true,		lock->base)
 
+/*
+ *	seqcount_LOCKTYPE_t -- write APIs
+ *
+ * For associated lock types which do not implicitly disable preemption,
+ * enforce preemption protection in the write side functions.
+ *
+ * Never use lockdep for the raw write variants.
+ */
+
+#define __seqprop_pick(s, name, prop, otherwise)			\
+	__builtin_choose_expr(__same_type(*(s), seqcount##name##_t,	\
+			      __seqprop##name##_##prop((void *)(s)),	\
+			      otherwise)
+
+extern void __seqprop_invalid(void);
+
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
+
+#define __seqprop(s, prop)				\
+	__seqprop_pick((s), , prop,			\
+	  __seqprop_pick((s), _raw_spinlock, prop,	\
+	    __seqprop_pick((s), _spinlock, prop,	\
+	      __seqprop_pick((s), _rwlock, prop,	\
+	        __seqprop_pick((s), _mutex, prop,	\
+	          __seqprop_pick((s), _ww_mutex, prop,	\
+		    __seqprop_invalid()))))))
+
+#else
+
+#define __seqprop_case(s, name, prop) \
+	seqcount##name##_t: __seqprop##name##_##prop((void *)s)
+
+#define __seqprop(s, prop)					\
+	_Generic(*(s),						\
+		 __seqprop_case((s), , prop),			\
+		 __seqprop_case((s), _raw_spinlock, prop),	\
+		 __seqprop_case((s), _spinlock, prop),		\
+		 __seqprop_case((s), _rwlock, prop),		\
+		 __seqprop_case((s), _mutex, prop),		\
+		 __seqprop_case((s), _ww_mutex, prop))
+
+#endif
+
+#define __to_seqcount_t(s)			__seqprop(s, ptr)
+#define __associated_lock_is_preemptible(s)	__seqprop(s, preempt)
+#define __assert_associated_lock_held(s)	__seqprop(s, assert)
 
 /**
- * __read_seqcount_begin - begin a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_begin() - begin a seqcount read section (without barrier)
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * Returns: count to be passed to read_seqcount_retry
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
@@ -121,7 +249,15 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline unsigned __read_seqcount_begin(const seqcount_t *s)
+#define __read_seqcount_begin(s)				\
+({								\
+	unsigned ret = __seqprop(s, begin);			\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);		\
+	ret;							\
+})
+
+
+static inline unsigned do___read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
@@ -136,15 +272,18 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
+ * raw_read_seqcount() - Read the seqcount raw counter value
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
+#define raw_read_seqcount(s)	do_raw_read_seqcount(__to_seqcount_t(s))
+
+static inline unsigned do_raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -153,42 +292,44 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
- * @s: pointer to seqcount_t
+ * raw_read_seqcount_begin() - start a seqcount read section w/o lockdep
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
+#define raw_read_seqcount_begin(s)	do_raw_read_seqcount_begin(__to_seqcount_t(s))
+
+static inline unsigned do_raw_read_seqcount_begin(const seqcount_t *s)
 {
-	unsigned ret = __read_seqcount_begin(s);
+	unsigned ret = do___read_seqcount_begin(s);
 	smp_rmb();
 	return ret;
 }
 
 /**
- * read_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_begin() - start a seqcount read critical section
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
-{
-	seqcount_lockdep_reader_access(s);
-	return raw_read_seqcount_begin(s);
-}
+#define read_seqcount_begin(s)				\
+({							\
+	seqcount_lockdep_reader_access(s);		\
+	__read_seqcount_begin(s);			\
+})
 
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
@@ -197,7 +338,9 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
  * read_seqcount_retry() instead of stabilizing at the beginning of the
  * critical section.
  */
-static inline unsigned raw_seqcount_begin(const seqcount_t *s)
+#define raw_seqcount_begin(s)	do_raw_seqcount_begin(__to_seqcount_t(s))
+
+static inline unsigned do_raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -206,8 +349,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_retry() - end a seq-read critical section (without barrier)
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -219,38 +362,56 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
+#define __read_seqcount_retry(s, start)	do___read_seqcount_retry(__to_seqcount_t(s), start)
+
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
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
+#define read_seqcount_retry(s, start)	do_read_seqcount_retry(__to_seqcount_t(s), start)
+
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
+#define raw_write_seqcount_begin(s)					\
+do {									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	do_raw_write_seqcount_begin(__to_seqcount_t(s));		\
+} while (0)
 
-
-static inline void raw_write_seqcount_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
 
-static inline void raw_write_seqcount_end(seqcount_t *s)
+#define raw_write_seqcount_end(s)					\
+do {									\
+	do_raw_write_seqcount_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_enable();					\
+} while (0)
+
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -258,12 +419,12 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 }
 
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
  * Note that writes surrounding the barrier should be declared atomic (e.g.
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
@@ -298,7 +459,9 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *              WRITE_ONCE(X, false);
  *      }
  */
-static inline void raw_write_seqcount_barrier(seqcount_t *s)
+#define raw_write_seqcount_barrier(s)	do_raw_write_seqcount_barrier(__to_seqcount_t(s))
+
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -307,7 +470,24 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 	kcsan_nestable_atomic_end();
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
+#define raw_read_seqcount_latch(s)	do_raw_read_seqcount_latch(__to_seqcount_t(s))
+
+static inline int do_raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
 	int seq = READ_ONCE(s->sequence); /* ^^^ */
@@ -315,8 +495,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -332,101 +512,164 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
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
+ *
+ *	The non-requirement for atomic modifications does _NOT_ include
+ *	the publishing of new entries in the case where data is a dynamic
+ *	data structure.
+ *
+ *	An iteration might start in data[0] and get suspended long enough
+ *	to miss an entire modification sequence, once it resumes it might
+ *	observe the new entry.
  *
- *       An iteration might start in data[0] and get suspended long enough
- *       to miss an entire modification sequence, once it resumes it might
- *       observe the new entry.
+ * NOTE:
  *
- * NOTE: When data is a dynamic data structure; one should use regular RCU
- *       patterns to manage the lifetimes of the objects within.
+ *	When data is a dynamic data structure; one should use regular RCU
+ *	patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_t *s)
+#define raw_write_seqcount_latch(s)	do_raw_write_seqcount_latch(__to_seqcount_t(s))
+
+static inline void do_raw_write_seqcount_latch(seqcount_t *s)
 {
        smp_wmb();      /* prior stores before incrementing "sequence" */
        s->sequence++;
        smp_wmb();      /* increment "sequence" before following stores */
 }
 
+static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+	do_raw_write_seqcount_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+}
+
+#define write_seqcount_begin_nested(s, subclass)			\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	do_write_seqcount_begin_nested(__to_seqcount_t(s), subclass);	\
+} while (0)
+
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+//	lockdep_assert_preemption_disabled();
+	__write_seqcount_begin_nested(s, subclass);
+}
+
 /*
- * Sequence counter only version assumes that callers are using their
- * own mutexing.
+ * write_seqcount_t_begin() without lockdep non-preemptibility checks.
+ *
+ * Use for internal seqlock.h code where it's known that preemption is
+ * already disabled. For example, seqlock_t write side functions.
  */
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+static inline void __write_seqcount_begin(seqcount_t *s)
 {
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	__write_seqcount_begin_nested(s, 0);
 }
 
-static inline void write_seqcount_begin(seqcount_t *s)
+/**
+ * write_seqcount_begin() - start a seqcount write-side critical section
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
+ *
+ * write_seqcount_begin opens a write-side critical section of the given
+ * seqcount. Seqcount write-side critical sections must be externally
+ * serialized and non-preemptible.
+ */
+#define write_seqcount_begin(s)						\
+do {									\
+	__assert_associated_lock_held(s);				\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_disable();					\
+									\
+	do_write_seqcount_begin(__to_seqcount_t(s));			\
+} while (0)
+
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
 }
 
-static inline void write_seqcount_end(seqcount_t *s)
+/**
+ * write_seqcount_end() - end a seqcount_t write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * The write section must've been opened with write_seqcount_begin().
+ */
+#define write_seqcount_end(s)						\
+do {									\
+	do_write_seqcount_end(__to_seqcount_t(s));			\
+									\
+	if (__associated_lock_is_preemptible(s))			\
+		preempt_enable();					\
+} while (0)
+
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
 	raw_write_seqcount_end(s);
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
+ * @s: Pointer to &typedef seqcount_t or any of the seqcount_locktype_t variants
  *
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
  */
-static inline void write_seqcount_invalidate(seqcount_t *s)
+#define write_seqcount_invalidate(s)	do_write_seqcount_invalidate(__to_seqcount_t(s))
+
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -434,32 +677,53 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
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
@@ -470,6 +734,17 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
 	return ret;
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
 	/*
@@ -478,47 +753,94 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 	 */
 	kcsan_flat_atomic_end();
 
-	return read_seqcount_retry(&sl->seqcount, start);
+	return do_read_seqcount_retry(&sl->seqcount, start);
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
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
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
-	write_seqcount_end(&sl->seqcount);
+	do_write_seqcount_end(&sl->seqcount);
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
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
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
-	write_seqcount_end(&sl->seqcount);
+	do_write_seqcount_end(&sl->seqcount);
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
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
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
-	write_seqcount_end(&sl->seqcount);
+	do_write_seqcount_end(&sl->seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -527,44 +849,98 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
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
-	write_seqcount_end(&sl->seqcount);
+	do_write_seqcount_end(&sl->seqcount);
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
  *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
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
@@ -574,32 +950,90 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
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
@@ -613,15 +1047,59 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
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
@@ -635,6 +1113,18 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
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
