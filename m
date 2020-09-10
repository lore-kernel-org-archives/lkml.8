Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD286C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E03207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfkVNFlx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bm5PkQ57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIJT3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B7C06134D;
        Thu, 10 Sep 2020 08:08:27 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXkNgR15KoVsXX1rbejrVwc9XQ+pCCMPvkqDCDGAejU=;
        b=AfkVNFlxbP8pJP7Wlmt1id4FYHINXxdDcJTBTO/KCCDSSTVwJploHPruLPALa1MIxD8U08
        JlHsjpj8Toi/PXepwg6kg0FySX4+hN5Yoo5D+vaAlDhNGHHE0H8t1NwCiHk2B3Hk8cd76j
        t3cUYsR4xusUs0wIArEjcgmU+19Kw+jrkgN7UMfGQPTCJprYpmLb4cFGGos63aWRu8DU7l
        JRmaUVdSkGGxNkBTBU4Kk0zVyM+Bi2QJmoBL7FhhQVhkIjkIQ3hIJVuBoZ7ukyTiDsh8p7
        hjG+wEDDz069pH8mLEmduQizan98rG2jMyVZXiOhDnWLSTdJVv+0xHSzWX3ldw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXkNgR15KoVsXX1rbejrVwc9XQ+pCCMPvkqDCDGAejU=;
        b=bm5PkQ57WVdYehphQ0/URqfRsYDiip/GGPixUcRNr8ghHG/ft8/Ugwwa2bLCwqbFdUf8os
        DEcRnZagIIzc5+Dw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: seqcount_LOCKNAME_t: Standardize naming
 convention
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904153231.11994-2-a.darwish@linutronix.de>
References: <20200904153231.11994-2-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050559.20229.7547255102795734456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6dd699b13d53f26a7603702d8bada3482312df74
Gitweb:        https://git.kernel.org/tip/6dd699b13d53f26a7603702d8bada3482312df74
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Fri, 04 Sep 2020 17:32:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:30 +02:00

seqlock: seqcount_LOCKNAME_t: Standardize naming convention

At seqlock.h, sequence counters with associated locks are either called
seqcount_LOCKNAME_t, seqcount_LOCKTYPE_t, or seqcount_locktype_t.

Standardize on seqcount_LOCKNAME_t for all instances in comments,
kernel-doc, and SEQCOUNT_LOCKNAME() generative macro paramters.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200904153231.11994-2-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 79 ++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f2a7a46..820ace2 100644
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
- * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPE associated
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
 
 /*
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
 
 /*
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
@@ -283,7 +284,7 @@ repeat:
 
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
