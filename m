Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DA4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D151C2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYTnkIZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zuByDtNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgG2OeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgG2Odq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:46 -0400
Date:   Wed, 29 Jul 2020 14:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYYjSyZ0DKXXajKQyU33vrOS6wuEIP5ci2xRnem5QwA=;
        b=BYTnkIZkPgMCKJ0r1Qx+68dLw+irpF1D9dPHYrDMKR2VzHfAxGxlvF/GGYqEZxYNuS/27s
        VTIJSDdxYoxhRCWsJqyE3dTdW2dqm7SwIGG6zAoEj2dJiXWXkfWb3dQtz0HimGusUvu9zF
        fMBSZQmGvcroFurVPugqEONq26CZd6ccVzgNSvBbYjPaxVoHVp3SdsCtqr4SXPzNXJydJO
        Ah3mg9thNcAf/PWw88MtzLaPLQc5GqKNS71Wk3QV43jUPuBwpAoq4PjjUCYWiSmwvttipt
        nSWex9oLiSPM5PVJwEteVqMGv1F3fYiowQ5aENn/T9r0uCFV/GZthlGQCDZVpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYYjSyZ0DKXXajKQyU33vrOS6wuEIP5ci2xRnem5QwA=;
        b=zuByDtNPjHKB+xgov459GjIqR4OTPt2/hDk3LZpCMazHqV5KkbjuRxlpABoMgwNMAyJFlh
        rjRLhCmTNPFTTfCg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Add kernel-doc for seqcount_t and seqlock_t APIs
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-6-a.darwish@linutronix.de>
References: <20200720155530.1173732-6-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321998.4006.15372561721308898557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     89b88845e05752b3d684eaf147f457c8dfa99c5f
Gitweb:        https://git.kernel.org/tip/89b88845e05752b3d684eaf147f457c8dfa99c5f
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:23 +02:00

seqlock: Add kernel-doc for seqcount_t and seqlock_t APIs

seqlock.h is now included by kernel's RST documentation, but a small
number of the the exported seqlock.h functions are kernel-doc annotated.

Add kernel-doc for all seqlock.h exported APIs.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-6-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 425 +++++++++++++++++++++++++++++++--------
 1 file changed, 348 insertions(+), 77 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4c14560..85fb3ac 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -75,6 +75,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -98,13 +102,15 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
-#define SEQCNT_ZERO(lockname) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(lockname)}
-
+/**
+ * SEQCNT_ZERO() - static initializer for seqcount_t
+ * @name: Name of the seqcount_t instance
+ */
+#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 /**
- * __read_seqcount_begin - begin a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
+ * @s: Pointer to seqcount_t
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -113,6 +119,8 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  *
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
+ *
+ * Return: count to be passed to read_seqcount_retry()
  */
 static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 {
@@ -129,13 +137,10 @@ repeat:
 }
 
 /**
- * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
+ * @s: Pointer to seqcount_t
  *
- * raw_read_seqcount_begin opens a read critical section of the given
- * seqcount, but without any lockdep checking. Validity of the critical
- * section is tested by checking read_seqcount_retry function.
+ * Return: count to be passed to read_seqcount_retry()
  */
 static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 {
@@ -145,13 +150,10 @@ static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * read_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * read_seqcount_begin() - begin a seqcount_t read critical section
+ * @s: Pointer to seqcount_t
  *
- * read_seqcount_begin opens a read critical section of the given seqcount.
- * Validity of the critical section is tested by checking read_seqcount_retry
- * function.
+ * Return: count to be passed to read_seqcount_retry()
  */
 static inline unsigned read_seqcount_begin(const seqcount_t *s)
 {
@@ -160,13 +162,15 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount() - read the raw seqcount_t counter value
+ * @s: Pointer to seqcount_t
  *
  * raw_read_seqcount opens a read critical section of the given
- * seqcount without any lockdep checking and without checking or
- * masking the LSB. Calling code is responsible for handling that.
+ * seqcount_t, without any lockdep checking, and without checking or
+ * masking the sequence counter LSB. Calling code is responsible for
+ * handling that.
+ *
+ * Return: count to be passed to read_seqcount_retry()
  */
 static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
@@ -177,18 +181,21 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
+ *                        lockdep and w/o counter stabilization
+ * @s: Pointer to seqcount_t
  *
- * raw_seqcount_begin opens a read critical section of the given seqcount.
- * Validity of the critical section is tested by checking read_seqcount_retry
- * function.
+ * raw_seqcount_begin opens a read critical section of the given
+ * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
+ * for the count to stabilize. If a writer is active when it begins, it
+ * will fail the read_seqcount_retry() at the end of the read critical
+ * section instead of stabilizing at the beginning of it.
  *
- * Unlike read_seqcount_begin(), this function will not wait for the count
- * to stabilize. If a writer is active when we begin, we will fail the
- * read_seqcount_retry() instead of stabilizing at the beginning of the
- * critical section.
+ * Use this only in special kernel hot paths where the read section is
+ * small and has a high probability of success through other external
+ * means. It will save a single branching instruction.
+ *
+ * Return: count to be passed to read_seqcount_retry()
  */
 static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
@@ -199,10 +206,9 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
- * @start: count, from read_seqcount_begin
- * Returns: 1 if retry is required, else 0
+ * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
+ * @s: Pointer to seqcount_t
+ * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -211,6 +217,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  *
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
+ *
+ * Return: true if a read section retry is required, else false
  */
 static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
@@ -219,14 +227,15 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 }
 
 /**
- * read_seqcount_retry - end a seq-read critical section
- * @s: pointer to seqcount_t
- * @start: count, from read_seqcount_begin
- * Returns: 1 if retry is required, else 0
+ * read_seqcount_retry() - end a seqcount_t read critical section
+ * @s: Pointer to seqcount_t
+ * @start: count, from read_seqcount_begin()
  *
- * read_seqcount_retry closes a read critical section of the given seqcount.
- * If the critical section was invalid, it must be ignored (and typically
- * retried).
+ * read_seqcount_retry closes the read critical section of given
+ * seqcount_t.  If the critical section was invalid, it must be ignored
+ * (and typically retried).
+ *
+ * Return: true if a read section retry is required, else false
  */
 static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
@@ -234,6 +243,10 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 	return __read_seqcount_retry(s, start);
 }
 
+/**
+ * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
+ * @s: Pointer to seqcount_t
+ */
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
@@ -241,6 +254,10 @@ static inline void raw_write_seqcount_begin(seqcount_t *s)
 	smp_wmb();
 }
 
+/**
+ * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
+ * @s: Pointer to seqcount_t
+ */
 static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
@@ -248,17 +265,42 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+/**
+ * write_seqcount_begin_nested() - start a seqcount_t write section with
+ *                                 custom lockdep nesting level
+ * @s: Pointer to seqcount_t
+ * @subclass: lockdep nesting level
+ *
+ * See Documentation/locking/lockdep-design.rst
+ */
 static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
 	raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
+/**
+ * write_seqcount_begin() - start a seqcount_t write side critical section
+ * @s: Pointer to seqcount_t
+ *
+ * write_seqcount_begin opens a write side critical section of the given
+ * seqcount_t.
+ *
+ * Context: seqcount_t write side critical sections must be serialized and
+ * non-preemptible. If readers can be invoked from hardirq or softirq
+ * context, interrupts or bottom halves must be respectively disabled.
+ */
 static inline void write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
 }
 
+/**
+ * write_seqcount_end() - end a seqcount_t write side critical section
+ * @s: Pointer to seqcount_t
+ *
+ * The write section must've been opened with write_seqcount_begin().
+ */
 static inline void write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
@@ -266,12 +308,12 @@ static inline void write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_barrier - do a seq write barrier
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_barrier() - do a seqcount_t write barrier
+ * @s: Pointer to seqcount_t
  *
- * This can be used to provide an ordering guarantee instead of the
- * usual consistency guarantee. It is one wmb cheaper, because we can
- * collapse the two back-to-back wmb()s.
+ * This can be used to provide an ordering guarantee instead of the usual
+ * consistency guarantee. It is one wmb cheaper, because it can collapse
+ * the two back-to-back wmb()s.
  *
  * Note that writes surrounding the barrier should be declared atomic (e.g.
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
@@ -316,11 +358,12 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
+ *                               side operations
+ * @s: Pointer to seqcount_t
  *
- * After write_seqcount_invalidate, no read-side seq operations will complete
- * successfully and see data older than this.
+ * After write_seqcount_invalidate, no seqcount_t read side operations
+ * will complete successfully and see data older than this.
  */
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
@@ -330,6 +373,21 @@ static inline void write_seqcount_invalidate(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+/**
+ * raw_read_seqcount_latch() - pick even/odd seqcount_t latch data copy
+ * @s: Pointer to seqcount_t
+ *
+ * Use seqcount_t latching to switch between two storage places protected
+ * by a sequence counter. Doing so allows having interruptible, preemptible,
+ * seqcount_t write side critical sections.
+ *
+ * Check raw_write_seqcount_latch() for more details and a full reader and
+ * writer usage example.
+ *
+ * Return: sequence counter raw value. Use the lowest bit as an index for
+ * picking which data copy to read. The full counter value must then be
+ * checked with read_seqcount_retry().
+ */
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
@@ -338,8 +396,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: Pointer to seqcount_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -446,17 +504,28 @@ typedef struct {
 		.lock =	__SPIN_LOCK_UNLOCKED(lockname)	\
 	}
 
-#define seqlock_init(x)					\
+/**
+ * seqlock_init() - dynamic initializer for seqlock_t
+ * @sl: Pointer to the seqlock_t instance
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
+ * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
+ * @sl: Name of the seqlock_t instance
+ */
+#define DEFINE_SEQLOCK(sl) \
+		seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
 
-/*
- * Read side functions for starting and finalizing a read side section.
+/**
+ * read_seqbegin() - start a seqlock_t read side critical section
+ * @sl: Pointer to seqlock_t
+ *
+ * Return: count, to be passed to read_seqretry()
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
@@ -467,6 +536,17 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
 	return ret;
 }
 
+/**
+ * read_seqretry() - end a seqlock_t read side section
+ * @sl: Pointer to seqlock_t
+ * @start: count, from read_seqbegin()
+ *
+ * read_seqretry closes the read side critical section of given seqlock_t.
+ * If the critical section was invalid, it must be ignored (and typically
+ * retried).
+ *
+ * Return: true if a read section retry is required, else false
+ */
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
 	/*
@@ -478,10 +558,18 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
-/*
- * Lock out other writers and update the count.
- * Acts like a normal spin_lock/unlock.
- * Don't need preempt_disable() because that is in the spin_lock already.
+/**
+ * write_seqlock() - start a seqlock_t write side critical section
+ * @sl: Pointer to seqlock_t
+ *
+ * write_seqlock opens a write side critical section for the given
+ * seqlock_t.  It also implicitly acquires the spinlock_t embedded inside
+ * that sequential lock. All seqlock_t write side sections are thus
+ * automatically serialized and non-preemptible.
+ *
+ * Context: if the seqlock_t read section, or other write side critical
+ * sections, can be invoked from hardirq or softirq contexts, use the
+ * _irqsave or _bh variants of this function instead.
  */
 static inline void write_seqlock(seqlock_t *sl)
 {
@@ -489,30 +577,66 @@ static inline void write_seqlock(seqlock_t *sl)
 	write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock() - end a seqlock_t write side critical section
+ * @sl: Pointer to seqlock_t
+ *
+ * write_sequnlock closes the (serialized and non-preemptible) write side
+ * critical section of given seqlock_t.
+ */
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
+/**
+ * write_seqlock_bh() - start a softirqs-disabled seqlock_t write section
+ * @sl: Pointer to seqlock_t
+ *
+ * _bh variant of write_seqlock(). Use only if the read side section, or
+ * other write side sections, can be invoked from softirq contexts.
+ */
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 	write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_bh() - end a softirqs-disabled seqlock_t write section
+ * @sl: Pointer to seqlock_t
+ *
+ * write_sequnlock_bh closes the serialized, non-preemptible, and
+ * softirqs-disabled, seqlock_t write side critical section opened with
+ * write_seqlock_bh().
+ */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
+/**
+ * write_seqlock_irq() - start a non-interruptible seqlock_t write section
+ * @sl: Pointer to seqlock_t
+ *
+ * _irq variant of write_seqlock(). Use only if the read side section, or
+ * other write sections, can be invoked from hardirq contexts.
+ */
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 	write_seqcount_begin(&sl->seqcount);
 }
 
+/**
+ * write_sequnlock_irq() - end a non-interruptible seqlock_t write section
+ * @sl: Pointer to seqlock_t
+ *
+ * write_sequnlock_irq closes the serialized and non-interruptible
+ * seqlock_t write side section opened with write_seqlock_irq().
+ */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
@@ -528,9 +652,28 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	return flags;
 }
 
+/**
+ * write_seqlock_irqsave() - start a non-interruptible seqlock_t write
+ *                           section
+ * @lock:  Pointer to seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to write_sequnlock_irqrestore().
+ *
+ * _irqsave variant of write_seqlock(). Use it only if the read side
+ * section, or other write sections, can be invoked from hardirq context.
+ */
 #define write_seqlock_irqsave(lock, flags)				\
 	do { flags = __write_seqlock_irqsave(lock); } while (0)
 
+/**
+ * write_sequnlock_irqrestore() - end non-interruptible seqlock_t write
+ *                                section
+ * @sl:    Pointer to seqlock_t
+ * @flags: Caller's saved interrupt state, from write_seqlock_irqsave()
+ *
+ * write_sequnlock_irqrestore closes the serialized and non-interruptible
+ * seqlock_t write section previously opened with write_seqlock_irqsave().
+ */
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
@@ -538,36 +681,79 @@ write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-/*
- * A locking reader exclusively locks out other writers and locking readers,
- * but doesn't update the sequence number. Acts like a normal spin_lock/unlock.
- * Don't need preempt_disable() because that is in the spin_lock already.
+/**
+ * read_seqlock_excl() - begin a seqlock_t locking reader section
+ * @sl: Pointer to seqlock_t
+ *
+ * read_seqlock_excl opens a seqlock_t locking reader critical section.  A
+ * locking reader exclusively locks out *both* other writers *and* other
+ * locking readers, but it does not update the embedded sequence number.
+ *
+ * Locking readers act like a normal spin_lock()/spin_unlock().
+ *
+ * Context: if the seqlock_t write section, *or other read sections*, can
+ * be invoked from hardirq or softirq contexts, use the _irqsave or _bh
+ * variant of this function instead.
+ *
+ * The opened read section must be closed with read_sequnlock_excl().
  */
 static inline void read_seqlock_excl(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl() - end a seqlock_t locking reader critical section
+ * @sl: Pointer to seqlock_t
+ */
 static inline void read_sequnlock_excl(seqlock_t *sl)
 {
 	spin_unlock(&sl->lock);
 }
 
+/**
+ * read_seqlock_excl_bh() - start a seqlock_t locking reader section with
+ *			    softirqs disabled
+ * @sl: Pointer to seqlock_t
+ *
+ * _bh variant of read_seqlock_excl(). Use this variant only if the
+ * seqlock_t write side section, *or other read sections*, can be invoked
+ * from softirq contexts.
+ */
 static inline void read_seqlock_excl_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl_bh() - stop a seqlock_t softirq-disabled locking
+ *			      reader section
+ * @sl: Pointer to seqlock_t
+ */
 static inline void read_sequnlock_excl_bh(seqlock_t *sl)
 {
 	spin_unlock_bh(&sl->lock);
 }
 
+/**
+ * read_seqlock_excl_irq() - start a non-interruptible seqlock_t locking
+ *			     reader section
+ * @sl: Pointer to seqlock_t
+ *
+ * _irq variant of read_seqlock_excl(). Use this only if the seqlock_t
+ * write side section, *or other read sections*, can be invoked from a
+ * hardirq context.
+ */
 static inline void read_seqlock_excl_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 }
 
+/**
+ * read_sequnlock_excl_irq() - end an interrupts-disabled seqlock_t
+ *                             locking reader section
+ * @sl: Pointer to seqlock_t
+ */
 static inline void read_sequnlock_excl_irq(seqlock_t *sl)
 {
 	spin_unlock_irq(&sl->lock);
@@ -581,9 +767,26 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
 	return flags;
 }
 
+/**
+ * read_seqlock_excl_irqsave() - start a non-interruptible seqlock_t
+ *				 locking reader section
+ * @lock:  Pointer to seqlock_t
+ * @flags: Stack-allocated storage for saving caller's local interrupt
+ *         state, to be passed to read_sequnlock_excl_irqrestore().
+ *
+ * _irqsave variant of read_seqlock_excl(). Use this only if the seqlock_t
+ * write side section, *or other read sections*, can be invoked from a
+ * hardirq context.
+ */
 #define read_seqlock_excl_irqsave(lock, flags)				\
 	do { flags = __read_seqlock_excl_irqsave(lock); } while (0)
 
+/**
+ * read_sequnlock_excl_irqrestore() - end non-interruptible seqlock_t
+ *				      locking reader section
+ * @sl:    Pointer to seqlock_t
+ * @flags: Caller saved interrupt state, from read_seqlock_excl_irqsave()
+ */
 static inline void
 read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
 {
@@ -591,14 +794,35 @@ read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
 }
 
 /**
- * read_seqbegin_or_lock - begin a sequence number check or locking block
- * @lock: sequence lock
- * @seq : sequence number to be checked
- *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
+ * read_seqbegin_or_lock() - begin a seqlock_t lockless or locking reader
+ * @lock: Pointer to seqlock_t
+ * @seq : Marker and return parameter. If the passed value is even, the
+ * reader will become a *lockless* seqlock_t reader as in read_seqbegin().
+ * If the passed value is odd, the reader will become a *locking* reader
+ * as in read_seqlock_excl().  In the first call to this function, the
+ * caller *must* initialize and pass an even value to @seq; this way, a
+ * lockless read can be optimistically tried first.
+ *
+ * read_seqbegin_or_lock is an API designed to optimistically try a normal
+ * lockless seqlock_t read section first.  If an odd counter is found, the
+ * lockless read trial has failed, and the next read iteration transforms
+ * itself into a full seqlock_t locking reader.
+ *
+ * This is typically used to avoid seqlock_t lockless readers starvation
+ * (too much retry loops) in the case of a sharp spike in write side
+ * activity.
+ *
+ * Context: if the seqlock_t write section, *or other read sections*, can
+ * be invoked from hardirq or softirq contexts, use the _irqsave or _bh
+ * variant of this function instead.
+ *
+ * Check Documentation/locking/seqlock.rst for template example code.
+ *
+ * Return: the encountered sequence counter value, through the @seq
+ * parameter, which is overloaded as a return parameter. This returned
+ * value must be checked with need_seqretry(). If the read section need to
+ * be retried, this returned value must also be passed as the @seq
+ * parameter of the next read_seqbegin_or_lock() iteration.
  */
 static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 {
@@ -608,17 +832,52 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 		read_seqlock_excl(lock);
 }
 
+/**
+ * need_seqretry() - validate seqlock_t "locking or lockless" read section
+ * @lock: Pointer to seqlock_t
+ * @seq: sequence count, from read_seqbegin_or_lock()
+ *
+ * Return: true if a read section retry is required, false otherwise
+ */
 static inline int need_seqretry(seqlock_t *lock, int seq)
 {
 	return !(seq & 1) && read_seqretry(lock, seq);
 }
 
+/**
+ * done_seqretry() - end seqlock_t "locking or lockless" reader section
+ * @lock: Pointer to seqlock_t
+ * @seq: count, from read_seqbegin_or_lock()
+ *
+ * done_seqretry finishes the seqlock_t read side critical section started
+ * with read_seqbegin_or_lock() and validated by need_seqretry().
+ */
 static inline void done_seqretry(seqlock_t *lock, int seq)
 {
 	if (seq & 1)
 		read_sequnlock_excl(lock);
 }
 
+/**
+ * read_seqbegin_or_lock_irqsave() - begin a seqlock_t lockless reader, or
+ *                                   a non-interruptible locking reader
+ * @lock: Pointer to seqlock_t
+ * @seq:  Marker and return parameter. Check read_seqbegin_or_lock().
+ *
+ * This is the _irqsave variant of read_seqbegin_or_lock(). Use it only if
+ * the seqlock_t write section, *or other read sections*, can be invoked
+ * from hardirq context.
+ *
+ * Note: Interrupts will be disabled only for "locking reader" mode.
+ *
+ * Return:
+ *
+ *   1. The saved local interrupts state in case of a locking reader, to
+ *      be passed to done_seqretry_irqrestore().
+ *
+ *   2. The encountered sequence counter value, returned through @seq
+ *      overloaded as a return parameter. Check read_seqbegin_or_lock().
+ */
 static inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
@@ -632,6 +891,18 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 	return flags;
 }
 
+/**
+ * done_seqretry_irqrestore() - end a seqlock_t lockless reader, or a
+ *				non-interruptible locking reader section
+ * @lock:  Pointer to seqlock_t
+ * @seq:   Count, from read_seqbegin_or_lock_irqsave()
+ * @flags: Caller's saved local interrupt state in case of a locking
+ *	   reader, also from read_seqbegin_or_lock_irqsave()
+ *
+ * This is the _irqrestore variant of done_seqretry(). The read section
+ * must've been opened with read_seqbegin_or_lock_irqsave(), and validated
+ * by need_seqretry().
+ */
 static inline void
 done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 {
