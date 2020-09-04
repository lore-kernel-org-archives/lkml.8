Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B27F20772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kloZIbAl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkkMYlZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIDPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CDEC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:32:24 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOlCusGec2Wr1Dy0U85d2jgNpxQ1a2nd3MeDLyvmhrk=;
        b=kloZIbAlxwvkE63TlwCQDi5p9UVaKC8SvcIQWjvl2L0OGMc1fLB8nbf/IdrISsCi6J2Cax
        vLEaAtBFW5poSlN99epvErd+YZGNHEPtrYH2OxkS66Q/roiiKNUjJ2D/Xpt7IuItz5i254
        dEpYSJorwCUsLX07IBjxcUJOkVnT9ykL99PpwM26cnIgfnyUzJ5Uk0XWZNRu1QYBXtkkFj
        8YzzVv0zNFcrZFUc9FOdY0siZsKyuRAq8zRpE83VNsbA9Nkv49tb2du1GEfX2LRsPBaWOK
        CnfbiQ9BnOamgnHovJSTr0SxtrWPwO4JMVjhNR49jlO2kfiHTIO5dbw9GhAU2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOlCusGec2Wr1Dy0U85d2jgNpxQ1a2nd3MeDLyvmhrk=;
        b=ZkkMYlZMpMLhFWuFV7tbp+CWN8FQPpJaRE0y9pcqoerqbBUhiuO2gE/y0B+UB1tlcAmjha
        e9PkxSG4DFKA9CCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 4/5] seqlock: seqcount_LOCKNAME_t: Introduce PREEMPT_RT support
Date:   Fri,  4 Sep 2020 17:32:30 +0200
Message-Id: <20200904153231.11994-5-a.darwish@linutronix.de>
In-Reply-To: <20200904153231.11994-1-a.darwish@linutronix.de>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preemption must be disabled before entering a sequence counter write
side critical section.  Otherwise the read side section can preempt the
write side section and spin for the entire scheduler tick.  If that
reader belongs to a real-time scheduling class, it can spin forever and
the kernel will livelock.

Disabling preemption cannot be done for PREEMPT_RT though: it can lead
to higher latencies, and the write side sections will not be able to
acquire locks which become sleeping locks (e.g. spinlock_t).

To remain preemptible, while avoiding a possible livelock caused by the
reader preempting the writer, use a different technique: let the reader
detect if a seqcount_LOCKNAME_t writer is in progress. If that's the
case, acquire then release the associated LOCKNAME writer serialization
lock. This will allow any possibly-preempted writer to make progress
until the end of its writer serialization lock critical section.

Implement this lock-unlock technique for all seqcount_LOCKNAME_t with
an associated (PREEMPT_RT) sleeping lock.

Link: https://lkml.kernel.org/r/159708609435.2571.13948681727529247231.tglx@nanos
Link: https://lkml.kernel.org/r/20200519214547.352050-1-a.darwish@linutronix.de
References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 72 +++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ed1c6c0ff8bb..6ac5a63fc536 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -17,6 +17,7 @@
 #include <linux/kcsan-checks.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
+#include <linux/ww_mutex.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 
@@ -131,7 +132,23 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * See Documentation/locking/seqlock.rst
  */
 
-#ifdef CONFIG_LOCKDEP
+/*
+ * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
+ * disable preemption. It can lead to higher latencies, and the write side
+ * sections will not be able to acquire locks which become sleeping locks
+ * (e.g. spinlock_t).
+ *
+ * To remain preemptible while avoiding a possible livelock caused by the
+ * reader preempting the writer, use a different technique: let the reader
+ * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
+ * case, acquire then release the associated LOCKNAME writer serialization
+ * lock. This will allow any possibly-preempted writer to make progress
+ * until the end of its writer serialization lock critical section.
+ *
+ * This lock-unlock technique must be implemented for all of PREEMPT_RT
+ * sleeping locks.  See Documentation/locking/locktypes.rst
+ */
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
 #define __SEQ_LOCK(expr)	expr
 #else
 #define __SEQ_LOCK(expr)
@@ -162,10 +179,12 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  *
  * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
  * @locktype:		LOCKNAME canonical C data type
- * @preemptible:	preemptibility of above lockname
+ * @preemptible:	preemptibility of above locktype
  * @lockmember:		argument for lockdep_assert_held()
+ * @lockbase:		associated lock release function (prefix only)
+ * @lock_acquire:	associated lock acquisition function (full call)
  */
-#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember)	\
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
 typedef struct seqcount_##lockname {					\
 	seqcount_t		seqcount;				\
 	__SEQ_LOCK(locktype	*lock);					\
@@ -187,7 +206,23 @@ __seqprop_seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)		\
 static __always_inline unsigned						\
 __seqprop_seqcount_##lockname##_sequence(const seqcount_##lockname##_t *s)\
 {									\
-	return READ_ONCE(s->seqcount.sequence);				\
+	unsigned seq = READ_ONCE(s->seqcount.sequence);			\
+									\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return seq;						\
+									\
+	if (preemptible && unlikely(seq & 1)) {				\
+		__SEQ_LOCK(lock_acquire);				\
+		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
+									\
+		/*							\
+		 * Re-read the sequence counter since the (possibly	\
+		 * preempted) writer made progress.			\
+		 */							\
+		seq = READ_ONCE(s->seqcount.sequence);			\
+	}								\
+									\
+	return seq;							\
 }									\
 									\
 static __always_inline bool						\
@@ -226,11 +261,13 @@ static inline void __seqprop_seqcount_assert(const seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-SEQCOUNT_LOCKNAME(raw_spinlock,	raw_spinlock_t,		false,	s->lock)
-SEQCOUNT_LOCKNAME(spinlock,	spinlock_t,		false,	s->lock)
-SEQCOUNT_LOCKNAME(rwlock,	rwlock_t,		false,	s->lock)
-SEQCOUNT_LOCKNAME(mutex,	struct mutex,		true,	s->lock)
-SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
+#define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
+
+SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
+SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
+SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
+SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
+SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
 
 /**
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
@@ -406,13 +443,20 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 	return __read_seqcount_t_retry(s, start);
 }
 
+/*
+ * Enforce non-preemptibility for all seqcount_LOCKNAME_t writers. Don't
+ * do it for PREEMPT_RT, for the reasons outlined at __SEQ_LOCK().
+ */
+#define __seq_enforce_writer_non_preemptibility(s)			\
+	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
+
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_writer_non_preemptibility(s))			\
 		preempt_disable();					\
 									\
 	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -433,7 +477,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 do {									\
 	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_writer_non_preemptibility(s))			\
 		preempt_enable();					\
 } while (0)
 
@@ -456,7 +500,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_writer_non_preemptibility(s))			\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
@@ -483,7 +527,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_writer_non_preemptibility(s))			\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -504,7 +548,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 do {									\
 	write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_writer_non_preemptibility(s))			\
 		preempt_enable();					\
 } while (0)
 
-- 
2.28.0

