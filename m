Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52164C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FED2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b18OJRNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0oJNq9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgH1BHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:07:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7EC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 18:07:09 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMHp4I4VnbmMIqS7Xfr7gNMoE2MkejxqgGObv4mTWNA=;
        b=b18OJRNjJmcKxwnrqM1MjMJ8yV1PxBiDIP2kn9WxFB7oSrcyT8uhgxlSq9wBl6X5RHXrM+
        Nr0golvaZs9pkimikeeSKekwAdG09swYViy7EW9Goq+EahspOtihAydW3DPc+lknKm6j1f
        G0/6JKbY4F7Z5x/ZAREHKZk6kvb/KwzzlphSTWFdSzsNrjTPzREabFp/7295OxFkoNWB6H
        +dct5psMeGJGx6fPHhzqTQ1BKbEAk3xcLcxAOKlUKdvewc5M73eW7TfaLP1BU4QdTUx2uT
        i0+5AkR0alHXMOqRwXOygdHBl2Hv5pDwdw6/Tx8wF+CdCRHl2NlcOTw1aH9TAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMHp4I4VnbmMIqS7Xfr7gNMoE2MkejxqgGObv4mTWNA=;
        b=R0oJNq9ErcfSoGnRvmQxMDrj2sTKeGgpICshijKrFSLhr1uQRK+sc25bX+tc+GeibvmpdY
        HYMhI3A+J0PHf1Cw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 4/5] seqlock: seqcount_LOCKTYPE_t: Introduce PREEMPT_RT support
Date:   Fri, 28 Aug 2020 03:07:09 +0200
Message-Id: <20200828010710.5407-5-a.darwish@linutronix.de>
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preemption must be disabled before entering a sequence counter write
side critical section.  Failing to do so, the read side section can
preempt the write side section and spin for the entire scheduler tick.
If that reader belongs to a real-time scheduling class, it can spin
forever and the kernel will livelock.

Disabling preemption cannot be done for PREEMPT_RT. It can lead to
higher latencies and the write side sections will not be able to acquire
locks which become sleeping locks (e.g. spinlock_t).

To solve this dilemma, do not disable preemption for seqcount_LOCKTYPE_t
writers. Rather, detect if a seqcount_LOCKTYPE_t writer is in progress.
If that is the case, acquire then release the associated LOCKTYPE writer
serialization lock. This will allow any preempted writer to make progress
until the end of its writer serialization lock critical section.

Implement this technique for all of PREEMPT_RT sleeping locks.

Link: https://lkml.kernel.org/r/159708609435.2571.13948681727529247231.tglx@nanos
Link: https://lkml.kernel.org/r/20200519214547.352050-1-a.darwish@linutronix.de
References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 72 +++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 13 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d114a9f4e9d9..8d4bf12272ba 100644
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
+ * For PREEMPT_RT, seqcount_LOCKTYPE_t write side critical sections cannot
+ * disable preemption. It can lead to higher latencies, and the write side
+ * sections will not be able to acquire locks which become sleeping locks
+ * (e.g. spinlock_t).
+ *
+ * To remain preemptible while avoiding a possible livelock caused by the
+ * read side preempting the write side, use a different technique: detect
+ * if a seqcount_LOCKTYPE_t writer is in progress. If that is the case,
+ * acquire then release the associated LOCKTYPE writer serialization
+ * lock. This will allow any preempted writer to make progress until the
+ * end of its writer serialization lock critical section.
+ *
+ * This lock-unlock technique must be implemented for all of PREEMPT_RT
+ * sleeping locks.  See Documentation/locking/locktypes.rst
+ */
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
 #define __SEQ_LOCK(expr)	expr
 #else
 #define __SEQ_LOCK(expr)
@@ -162,8 +179,10 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @locktype_t:		canonical/full LOCKTYPE C data type
  * @preemptible:	preemptibility of above locktype
  * @lockmember:		argument for lockdep_assert_held()
+ * @lockbase:		associated lock release function (prefix only)
+ * @lock_acquire:	associated lock acquisition function (full call)
  */
-#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember)	\
+#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember, lockbase, lock_acquire) \
 typedef struct seqcount_##locktype {					\
 	seqcount_t		seqcount;				\
 	__SEQ_LOCK(locktype_t	*lock);					\
@@ -185,7 +204,23 @@ __seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
 static __always_inline unsigned						\
 __seqcount_##locktype##_sequence(const seqcount_##locktype##_t *s)	\
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
@@ -224,11 +259,13 @@ static inline void __seqcount_t_assert(const seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-SEQCOUNT_LOCKTYPE(raw_spinlock,	raw_spinlock_t,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(spinlock,	spinlock_t,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(rwlock,	rwlock_t,		false,	s->lock)
-SEQCOUNT_LOCKTYPE(mutex,	struct mutex,		true,	s->lock)
-SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
+#define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
+
+SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
+SEQCOUNT_LOCKTYPE(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
+SEQCOUNT_LOCKTYPE(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
+SEQCOUNT_LOCKTYPE(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
+SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
 
 /**
  * SEQCNT_LOCKTYPE_ZERO - static initializer for seqcount_LOCKTYPE_t
@@ -408,13 +445,22 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 	return __read_seqcount_t_retry(s, start);
 }
 
+/*
+ * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
+ * associated lock does not implicitly disable preemption.
+ *
+ * Don't do it for PREEMPT_RT. Check __SEQ_LOCK().
+ */
+#define __seq_enforce_preemption_protection(s)				\
+	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
+
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKTYPE_t variants
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_preemption_protection(s))			\
 		preempt_disable();					\
 									\
 	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -435,7 +481,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 do {									\
 	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_preemption_protection(s))			\
 		preempt_enable();					\
 } while (0)
 
@@ -458,7 +504,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_preemption_protection(s))			\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
@@ -485,7 +531,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 do {									\
 	__seqcount_assert_lock_held(s);					\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_preemption_protection(s))			\
 		preempt_disable();					\
 									\
 	write_seqcount_t_begin(__seqcount_ptr(s));			\
@@ -506,7 +552,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
 do {									\
 	write_seqcount_t_end(__seqcount_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (__seq_enforce_preemption_protection(s))			\
 		preempt_enable();					\
 } while (0)
 
-- 
2.28.0

