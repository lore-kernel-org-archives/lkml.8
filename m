Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D6E20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjPYyTs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHwqk6Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgG2Odf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgG2Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:30 -0400
Date:   Wed, 29 Jul 2020 14:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hvHoUWwkSstgIOL6+VpKRpRx4x3nuNQBiOscZhSx2ic=;
        b=DjPYyTs1kaglGkoEb30KsOEEPIrsyBe6OqPxvC/pYKqL+8PQpyaprq8Y7hc1K5JUzhlS3t
        B8LWSRQDS2w3RUSMsUve9Zx0xvY2jmP4gs2OsGnaWILhos+bEn1Ry/UoHGV0AzLNN/Z5o6
        tBjvLfnlNtLsWci+0AAdLONmVua4uyDT14cPZfKPapCxbHX6bGmSgIIY39VJVPd5fRmIeE
        5ePaYvMMr59GTgHtfb+TE/jS5jG3Uh213v2s7BmkFMo+uwZq86mWbxpsy1h8TxHFLHOQEe
        86teNWQ6EaceYpkcSBT8QBGGQHZOH7Z7pC6qFTcj5X8tCiELYtYoTm4m0W7Fqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hvHoUWwkSstgIOL6+VpKRpRx4x3nuNQBiOscZhSx2ic=;
        b=hHwqk6LxQeXlVw2dCF6eI06qfa6vY/plYfik//yuZOWCdQ19TUvVkhC0WgFFoIGU7MhGSE
        TxNhaQibNguYLtAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Fold seqcount_LOCKNAME_t definition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159603320585.4006.1051434149678320527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a8772dccb2ec7b139db1b3ba782ecb12ed92d7c3
Gitweb:        https://git.kernel.org/tip/a8772dccb2ec7b139db1b3ba782ecb12ed92d7c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Jul 2020 11:56:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:30 +02:00

seqlock: Fold seqcount_LOCKNAME_t definition

Manual repetition is boring and error prone.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 142 ++++++++++-----------------------------
 1 file changed, 39 insertions(+), 103 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index c689aba..4b259bb 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -150,21 +150,6 @@ do {									\
 } while (0)
 
 /**
- * typedef seqcount_spinlock_t - sequence counter with spinlock associated
- * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated spinlock
- *
- * A plain sequence counter with external writer synchronization by a
- * spinlock. The spinlock is associated to the sequence count in the
- * static initializer or init function. This enables lockdep to validate
- * that the write side critical section is properly serialized.
- */
-typedef struct seqcount_spinlock {
-	seqcount_t	seqcount;
-	__SEQ_LOCK(spinlock_t	*lock);
-} seqcount_spinlock_t;
-
-/**
  * SEQCNT_SPINLOCK_ZERO - static initializer for seqcount_spinlock_t
  * @name:	Name of the seqcount_spinlock_t instance
  * @lock:	Pointer to the associated spinlock
@@ -181,21 +166,6 @@ typedef struct seqcount_spinlock {
 	seqcount_locktype_init(s, lock)
 
 /**
- * typedef seqcount_raw_spinlock_t - sequence count with raw spinlock associated
- * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated raw spinlock
- *
- * A plain sequence counter with external writer synchronization by a
- * raw spinlock. The raw spinlock is associated to the sequence count in
- * the static initializer or init function. This enables lockdep to
- * validate that the write side critical section is properly serialized.
- */
-typedef struct seqcount_raw_spinlock {
-	seqcount_t      seqcount;
-	__SEQ_LOCK(raw_spinlock_t	*lock);
-} seqcount_raw_spinlock_t;
-
-/**
  * SEQCNT_RAW_SPINLOCK_ZERO - static initializer for seqcount_raw_spinlock_t
  * @name:	Name of the seqcount_raw_spinlock_t instance
  * @lock:	Pointer to the associated raw_spinlock
@@ -212,21 +182,6 @@ typedef struct seqcount_raw_spinlock {
 	seqcount_locktype_init(s, lock)
 
 /**
- * typedef seqcount_rwlock_t - sequence count with rwlock associated
- * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated rwlock
- *
- * A plain sequence counter with external writer synchronization by a
- * rwlock. The rwlock is associated to the sequence count in the static
- * initializer or init function. This enables lockdep to validate that
- * the write side critical section is properly serialized.
- */
-typedef struct seqcount_rwlock {
-	seqcount_t      seqcount;
-	__SEQ_LOCK(rwlock_t		*lock);
-} seqcount_rwlock_t;
-
-/**
  * SEQCNT_RWLOCK_ZERO - static initializer for seqcount_rwlock_t
  * @name:	Name of the seqcount_rwlock_t instance
  * @lock:	Pointer to the associated rwlock
@@ -243,24 +198,6 @@ typedef struct seqcount_rwlock {
 	seqcount_locktype_init(s, lock)
 
 /**
- * typedef seqcount_mutex_t - sequence count with mutex associated
- * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated mutex
- *
- * A plain sequence counter with external writer synchronization by a
- * mutex. The mutex is associated to the sequence counter in the static
- * initializer or init function. This enables lockdep to validate that
- * the write side critical section is properly serialized.
- *
- * The write side API functions write_seqcount_begin()/end() automatically
- * disable and enable preemption when used with seqcount_mutex_t.
- */
-typedef struct seqcount_mutex {
-	seqcount_t      seqcount;
-	__SEQ_LOCK(struct mutex	*lock);
-} seqcount_mutex_t;
-
-/**
  * SEQCNT_MUTEX_ZERO - static initializer for seqcount_mutex_t
  * @name:	Name of the seqcount_mutex_t instance
  * @lock:	Pointer to the associated mutex
@@ -277,24 +214,6 @@ typedef struct seqcount_mutex {
 	seqcount_locktype_init(s, lock)
 
 /**
- * typedef seqcount_ww_mutex_t - sequence count with ww_mutex associated
- * @seqcount:	The real sequence counter
- * @lock:	Pointer to the associated ww_mutex
- *
- * A plain sequence counter with external writer synchronization by a
- * ww_mutex. The ww_mutex is associated to the sequence counter in the static
- * initializer or init function. This enables lockdep to validate that
- * the write side critical section is properly serialized.
- *
- * The write side API functions write_seqcount_begin()/end() automatically
- * disable and enable preemption when used with seqcount_ww_mutex_t.
- */
-typedef struct seqcount_ww_mutex {
-	seqcount_t      seqcount;
-	__SEQ_LOCK(struct ww_mutex	*lock);
-} seqcount_ww_mutex_t;
-
-/**
  * SEQCNT_WW_MUTEX_ZERO - static initializer for seqcount_ww_mutex_t
  * @name:	Name of the seqcount_ww_mutex_t instance
  * @lock:	Pointer to the associated ww_mutex
@@ -310,30 +229,50 @@ typedef struct seqcount_ww_mutex {
 #define seqcount_ww_mutex_init(s, lock)					\
 	seqcount_locktype_init(s, lock)
 
-/*
- * @preempt: Is the associated write serialization lock preemtpible?
+/**
+ * typedef seqcount_LOCKNAME_t - sequence counter with spinlock associated
+ * @seqcount:	The real sequence counter
+ * @lock:	Pointer to the associated spinlock
+ *
+ * A plain sequence counter with external writer synchronization by a
+ * spinlock. The spinlock is associated to the sequence count in the
+ * static initializer or init function. This enables lockdep to validate
+ * that the write side critical section is properly serialized.
  */
-#define SEQCOUNT_LOCKTYPE(locktype, preempt, lockmember)		\
-static inline seqcount_t *						\
-__seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
+
+/*
+ * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
+ * @locktype:		actual typename
+ * @lockname:		name
+ * @preemptible:	preemptibility of above locktype
+ * @lockmember:		argument for lockdep_assert_held()
+ */
+#define SEQCOUNT_LOCKTYPE(locktype, lockname, preemptible, lockmember)	\
+typedef struct seqcount_##lockname {					\
+	seqcount_t		seqcount;				\
+	__SEQ_LOCK(locktype	*lock);					\
+} seqcount_##lockname##_t;						\
+									\
+static __always_inline seqcount_t *					\
+__seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
 	return &s->seqcount;						\
 }									\
 									\
-static inline bool							\
-__seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
+static __always_inline bool						\
+__seqcount_##lockname##_preemptible(seqcount_##lockname##_t *s)		\
 {									\
-	return preempt;							\
+	return preemptible;						\
 }									\
 									\
-static inline void							\
-__seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
+static __always_inline void						\
+__seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
 
 /*
- * Similar hooks, but for plain seqcount_t
+ * __seqprop() for seqcount_t
  */
 
 static inline seqcount_t *__seqcount_ptr(seqcount_t *s)
@@ -351,17 +290,14 @@ static inline void __seqcount_assert(seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
-/*
- * @s: Pointer to seqcount_locktype_t, generated hooks first parameter.
- */
-SEQCOUNT_LOCKTYPE(raw_spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(spinlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(rwlock,	false,	s->lock)
-SEQCOUNT_LOCKTYPE(mutex,	true,	s->lock)
-SEQCOUNT_LOCKTYPE(ww_mutex,	true,	&s->lock->base)
-
-#define __seqprop_case(s, locktype, prop)				\
-	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
+SEQCOUNT_LOCKTYPE(raw_spinlock_t,	raw_spinlock,	false,	s->lock)
+SEQCOUNT_LOCKTYPE(spinlock_t,		spinlock,	false,	s->lock)
+SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
+SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
+SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
+
+#define __seqprop_case(s, lockname, prop)				\
+	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
 	seqcount_t:		__seqcount_##prop((void *)(s)),		\
