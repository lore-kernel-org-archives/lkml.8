Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9922C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2CE21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rd7YcCMW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8R0ICbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIJT3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBCC06134A;
        Thu, 10 Sep 2020 08:08:26 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIInR5wlnZ0uM2CwiFxFRLaAPmFK9WKvzv7GezjqOKY=;
        b=rd7YcCMW5XP1Je7kgyVfhhCQIzvR0w/NY4C81nIucHnZTTq3fRfdb5RjO5gjtlHl2tjKMO
        ya86Ihr8TcuBRmzff72z4xJwBhFZRlKv9Q2MfRztodQML/CdaUam/At1CNFFT3BzgbEyQH
        MrSSWLwCdh2HY7GeCaw2Ov+qXkSpCX9TpFrXm34RiMu8Pl6tnm92sdw56ynqLM9Ls06Su0
        +EEQjk+Z5GIHfHvTA50UPjOrgXDSnH7p1ryH9E2mai9w9u6+sVq04KWnkgOhXUUPZWRMVT
        K8XfXnessz1EJD4rArf2PJfWLFMwfrFt3thXZrmqv3GTcKhT/bPruozJmJwg/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIInR5wlnZ0uM2CwiFxFRLaAPmFK9WKvzv7GezjqOKY=;
        b=q8R0ICbKjA16v6lxK0jbkR4OMXRjn0mHjIY3qLPSLqr8AwQ5acxMd5KJAwXc4/93Wdzxmx
        VhNqNYETSI77RHDA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: seqcount_LOCKNAME_t: Introduce
 PREEMPT_RT support
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050414.20229.15047242407953588716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8117ab508f9c476e0a10b9db7f4818f784cf3176
Gitweb:        https://git.kernel.org/tip/8117ab508f9c476e0a10b9db7f4818f784cf3176
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Fri, 04 Sep 2020 17:32:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:31 +02:00

seqlock: seqcount_LOCKNAME_t: Introduce PREEMPT_RT support

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

References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200519214547.352050-1-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 61 +++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f3b7827..2bc9510 100644
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
@@ -187,13 +206,33 @@ __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 static __always_inline unsigned						\
 __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
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
 __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
-	return preemptible;						\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return preemptible;					\
+									\
+	/* PREEMPT_RT relies on the above LOCK+UNLOCK */		\
+	return false;							\
 }									\
 									\
 static __always_inline void						\
@@ -226,11 +265,13 @@ static inline void __seqprop_assert(const seqcount_t *s)
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
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
