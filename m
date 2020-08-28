Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F90C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C5E2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HkJYplq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8c81H1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgH1BG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:06:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEEC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 18:06:56 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJRlqRCvPVbi/d5zxTnzp2bcbf+PJc30Zq0AjeaYZDE=;
        b=HkJYplq0XJMQFOo4laM0+ccgkaPS5d9Ahv2rghIa6sac2meRp2V8Y/u9Blo50DJBxvwVEi
        Va9IN2tYDOVpD1xn0J4IC76eBaxRxzVxJBBy44nWykPcs8tvaLpfEhAdWiYcsdTEWUyfTm
        yMI/jikWqO9psFzuKlB8InqoIENj5ybWxAIrdKZJqMMdbtuZAWQsIL74sjYVoF0nIJ2Dyo
        3D50312xyZ0d3ZEOKyFqysLD+6ri0CbA1+090dHKp3cys6TuaXdaFxQiihcpOiW9CVhx10
        PHSZ63huzCqSJILifYKvDiS5lyd5gLXU97Acp+lv516Gy++sgMTzzvBgBcU6Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJRlqRCvPVbi/d5zxTnzp2bcbf+PJc30Zq0AjeaYZDE=;
        b=X8c81H1zhlawbnrrDoCrcegWu5TGGoHIgJe1YXmwTv+F77b7+1y/lPtsXEY5uge0Fvqx0/
        jAlEO0DV/kE2SlBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 1/5] seqlock: seqcount_LOCKTYPE_t: Standardize naming convention
Date:   Fri, 28 Aug 2020 03:07:06 +0200
Message-Id: <20200828010710.5407-2-a.darwish@linutronix.de>
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At seqlock.h, sequence counters with associated locks are either called
seqcount_LOCKNAME_t, seqcount_LOCKTYPE_t, or seqcount_locktype_t.

Standardize on "seqcount_LOCKTYPE_t" for all instances in comments,
kernel-doc, and SEQCOUNT_LOCKTYPE() generative macro paramters.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 80 +++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 962d9768945f..598af597f74e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -138,56 +138,58 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #endif
 
 /**
- * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
+ * typedef seqcount_LOCKTYPE_t - sequence counter with associated lock
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated spinlock
  *
- * A plain sequence counter with external writer synchronization by a
- * spinlock. The spinlock is associated to the sequence count in the
+ * A plain sequence counter with external writer synchronization by
+ * LOCKTYPE @lock. The lock is associated to the sequence counter in the
  * static initializer or init function. This enables lockdep to validate
  * that the write side critical section is properly serialized.
+ *
+ * LOCKTYPE:	raw_spinlock, spinlock, rwlock, mutex, or ww_mutex.
  */
 
 /**
- * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
- * @s:		Pointer to the seqcount_LOCKNAME_t instance
+ * seqcount_LOCKTYPE_init() - runtime initializer for seqcount_LOCKTYPE_t
+ * @s:		Pointer to the seqcount_LOCKTYPE_t instance
  * @lock:	Pointer to the associated LOCKTYPE
  */
 
 /*
- * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
- * @locktype:		actual typename
- * @lockname:		name
+ * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKTYPE_t and helpers
+ * @locktype:		"LOCKTYPE" part of seqcount_LOCKTYPE_t
+ * @locktype_t:		canonical/full LOCKTYPE C data type
  * @preemptible:	preemptibility of above locktype
  * @lockmember:		argument for lockdep_assert_held()
  */
-#define SEQCOUNT_LOCKTYPE(locktype, lockname, preemptible, lockmember)	\
-typedef struct seqcount_##lockname {					\
+#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember)	\
+typedef struct seqcount_##locktype {					\
 	seqcount_t		seqcount;				\
-	__SEQ_LOCK(locktype	*lock);					\
-} seqcount_##lockname##_t;						\
+	__SEQ_LOCK(locktype_t	*lock);					\
+} seqcount_##locktype##_t;						\
 									\
 static __always_inline void						\
-seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
+seqcount_##locktype##_init(seqcount_##locktype##_t *s, locktype_t *lock)\
 {									\
 	seqcount_init(&s->seqcount);					\
 	__SEQ_LOCK(s->lock = lock);					\
 }									\
 									\
 static __always_inline seqcount_t *					\
-__seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
+__seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
 {									\
 	return &s->seqcount;						\
 }									\
 									\
 static __always_inline bool						\
-__seqcount_##lockname##_preemptible(seqcount_##lockname##_t *s)		\
+__seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
 {									\
 	return preemptible;						\
 }									\
 									\
 static __always_inline void						\
-__seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
+__seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
@@ -211,15 +213,15 @@ static inline void __seqcount_assert(seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-SEQCOUNT_LOCKTYPE(raw_spinlock_t,	raw_spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(spinlock_t,		spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
-SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
+SEQCOUNT_LOCKTYPE(raw_spinlock,	raw_spinlock_t,		false,	s->lock)
+SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,		false,	s->lock)
+SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,		false,	s->lock)
+SEQCOUNT_LOCKTYPE(mutex,	struct mutex,		true,	s->lock)
+SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 
 /**
- * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
- * @name:	Name of the seqcount_LOCKNAME_t instance
+ * SEQCNT_LOCKTYPE_ZERO - static initializer for seqcount_LOCKTYPE_t
+ * @name:	Name of the seqcount_LOCKTYPE_t instance
  * @lock:	Pointer to the associated LOCKTYPE
  */
 
@@ -235,8 +237,8 @@ SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 
-#define __seqprop_case(s, lockname, prop)				\
-	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
+#define __seqprop_case(s, locktype, prop)				\
+	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
 	seqcount_t:		__seqcount_##prop((void *)(s)),		\
@@ -252,7 +254,7 @@ SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -283,7 +285,7 @@ static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -299,7 +301,7 @@ static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -314,7 +316,7 @@ static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checking, and without checking or
@@ -337,7 +339,7 @@ static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * raw_seqcount_begin opens a read critical section of the given
  * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
@@ -365,7 +367,7 @@ static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
@@ -389,7 +391,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 
 /**
  * read_seqcount_retry() - end a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  * @start: count, from read_seqcount_begin()
  *
  * read_seqcount_retry closes the read critical section of given
@@ -409,7 +411,7 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
@@ -428,7 +430,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
@@ -448,7 +450,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
@@ -471,7 +473,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 
 /**
  * write_seqcount_begin() - start a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * write_seqcount_begin opens a write side critical section of the given
  * seqcount_t.
@@ -497,7 +499,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 
 /**
  * write_seqcount_end() - end a seqcount_t write side critical section
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * The write section must've been opened with write_seqcount_begin().
  */
@@ -517,7 +519,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
 
 /**
  * raw_write_seqcount_barrier() - do a seqcount_t write barrier
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * This can be used to provide an ordering guarantee instead of the usual
  * consistency guarantee. It is one wmb cheaper, because it can collapse
@@ -571,7 +573,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 /**
  * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
  *                               side operations
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  *
  * After write_seqcount_invalidate, no seqcount_t read side operations
  * will complete successfully and see data older than this.
-- 
2.28.0

