Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07225C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6966206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZ468xFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRW57YfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgF3FpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgF3FpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C4C061755;
        Mon, 29 Jun 2020 22:45:09 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ialJ0ne0LIpn4VUrs7OrCjsvngeTyzSVT+3I3PJxR8M=;
        b=mZ468xFQimqzh5JJW8ZHumM2imqCeuMKnuHpTRyH+zkLcGSIr5nFHXgTIKh9w14a/VsyoZ
        l8dTlOMka3InIE6yOifRUGZ6BS61/ibdePk9oaiNjZG7VqswA+zOvxLqAZ9P0IAQq6VX7R
        T8eUxWlpW4KW6YuehSMHdhoVAlPX3BoD7SlXnFMUZjJq14m/DIMFy+JwsXVFDHhxJasHkI
        l5/as47yI7KALLICTbduhaV3Vf8gZ59AIHFnkLwnuLpt9wFqoA4LvixKji8zVJcoSdhB+R
        8emNheHLJunyeFgRCiRbEhyorW3EagQe+/75OK8zTxj0WubHiAWAOmPVKjsULA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ialJ0ne0LIpn4VUrs7OrCjsvngeTyzSVT+3I3PJxR8M=;
        b=vRW57YfYMdR/A720iHXR3x90+boBnfjlAYa3bHSIrCzYRD8m5j+6vr3yHTBMs91jZc8oZ3
        YfaFIyzuol/xhECA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v3 03/20] seqlock: Add missing kernel-doc annotations
Date:   Tue, 30 Jun 2020 07:44:35 +0200
Message-Id: <20200630054452.3675847-4-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small number of the the exported seqlock.h functions are kernel-doc
annotated.

Since seqlock.h is now included by the kernel's RST documentation, add
kernel-doc annotations for all of the remaining functions.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 398 ++++++++++++++++++++++++++++++++++------
 1 file changed, 339 insertions(+), 59 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d3bba59eb4df..057f7326a877 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -75,6 +75,10 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 # define SEQCOUNT_DEP_MAP_INIT(lockname) \
 		.dep_map = { .name = #lockname } \
 
+/**
+ * seqcount_init() - runtime initializer for seqcount_t
+ * @s: Pointer to the &typedef seqcount_t instance
+ */
 # define seqcount_init(s)				\
 	do {						\
 		static struct lock_class_key __key;	\
@@ -98,13 +102,17 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
-#define SEQCNT_ZERO(lockname) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(lockname)}
+/**
+ * SEQCNT_ZERO() - static initializer for seqcount_t
+ * @name: Name of the &typedef seqcount_t instance
+ */
+#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
 
 
 /**
- * __read_seqcount_begin - begin a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * __read_seqcount_begin() - begin a seqcount_t read section (without barrier)
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -129,13 +137,14 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount() - Read the seqcount_t raw counter value
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * raw_read_seqcount opens a read critical section of the given
- * seqcount without any lockdep checking and without checking or
- * masking the LSB. Calling code is responsible for handling that.
+ * seqcount_t, without any lockdep checks and without checking or
+ * masking the sequence counter LSB. Calling code is responsible for
+ * handling that.
  */
 static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
@@ -146,13 +155,13 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 }
 
 /**
- * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * raw_read_seqcount_begin() - start a seqcount_t read section w/o lockdep
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
  * raw_read_seqcount_begin opens a read critical section of the given
- * seqcount, but without any lockdep checking. Validity of the critical
- * section is tested by checking read_seqcount_retry function.
+ * seqcount_t, but without any lockdep checking. Validity of the read
+ * section must be checked with read_seqcount_retry().
  */
 static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 {
@@ -162,13 +171,13 @@ static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * read_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
+ * read_seqcount_begin() - start a seqcount_t read critical section
+ * @s: Pointer to &typedef seqcount_t
+ * Returns: count to be passed to read_seqcount_retry()
  *
- * read_seqcount_begin opens a read critical section of the given seqcount.
- * Validity of the critical section is tested by checking read_seqcount_retry
- * function.
+ * read_seqcount_begin opens a read critical section of the given
+ * seqcount_t. Validity of the read section must be checked with
+ * read_seqcount_retry().
  */
 static inline unsigned read_seqcount_begin(const seqcount_t *s)
 {
@@ -177,11 +186,11 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * raw_seqcount_begin - begin a seq-read critical section
- * @s: pointer to seqcount_t
+ * raw_seqcount_begin() - begin a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * Returns: count to be passed to read_seqcount_retry
  *
- * raw_seqcount_begin opens a read critical section of the given seqcount.
+ * raw_seqcount_begin opens a read critical section of the given seqcount_t.
  * Validity of the critical section is tested by checking read_seqcount_retry
  * function.
  *
@@ -199,8 +208,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 }
 
 /**
- * __read_seqcount_retry - end a seq-read critical section (without barrier)
- * @s: pointer to seqcount_t
+ * __read_seqcount_retry() - end a seq-read critical section (without barrier)
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
@@ -219,12 +228,12 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 }
 
 /**
- * read_seqcount_retry - end a seq-read critical section
- * @s: pointer to seqcount_t
+ * read_seqcount_retry() - end a seq-read critical section
+ * @s: Pointer to &typedef seqcount_t
  * @start: count, from read_seqcount_begin
  * Returns: 1 if retry is required, else 0
  *
- * read_seqcount_retry closes a read critical section of the given seqcount.
+ * read_seqcount_retry closes a read critical section of given seqcount_t.
  * If the critical section was invalid, it must be ignored (and typically
  * retried).
  */
@@ -251,8 +260,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_barrier - do a seq write barrier
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_barrier() - do a seq write barrier
+ * @s: Pointer to &typedef seqcount_t
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
@@ -300,6 +309,21 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+/**
+ * raw_read_seqcount_latch() - pick even or odd seqcount_t latch data copy
+ * @s: Pointer to &typedef seqcount_t
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
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
@@ -308,8 +332,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
 }
 
 /**
- * raw_write_seqcount_latch - redirect readers to even/odd copy
- * @s: pointer to seqcount_t
+ * raw_write_seqcount_latch() - redirect readers to even/odd copy
+ * @s: Pointer to &typedef seqcount_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -363,8 +387,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *			smp_rmb();
- *		} while (seq != latch->seq);
+ *			// read_seqcount_retry() includes necessary smp_rmb()
+ *		} while (read_seqcount_retry(&latch->seq, seq);
  *
  *		return entry;
  *	}
@@ -401,11 +425,27 @@ static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
+/**
+ * write_seqcount_begin() - start a seqcount_t write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * write_seqcount_begin opens a write-side critical section of the given
+ * seqcount_t. Sequence counter write-side critical sections must be
+ * serialized and non-preemptible. If readers can be invoked from
+ * hardirq or softirq contexts, interrupts or bottom halves must be
+ * respectively disabled.
+ */
 static inline void write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
 }
 
+/**
+ * write_seqcount_end() - end a seqcount_t write-side critical section
+ * @s: Pointer to &typedef seqcount_t
+ *
+ * The write section must've been opened with write_seqcount_begin().
+ */
 static inline void write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
@@ -413,8 +453,8 @@ static inline void write_seqcount_end(seqcount_t *s)
 }
 
 /**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
+ * write_seqcount_invalidate() - invalidate in-progress read-side seq operations
+ * @s: Pointer to &typedef seqcount_t
  *
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
@@ -448,17 +488,32 @@ typedef struct {
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
@@ -469,6 +524,17 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
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
@@ -480,10 +546,19 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 	return read_seqcount_retry(&sl->seqcount, start);
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
@@ -491,30 +566,68 @@ static inline void write_seqlock(seqlock_t *sl)
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
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
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
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
 	write_seqcount_begin(&sl->seqcount);
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
 	write_seqcount_end(&sl->seqcount);
@@ -530,9 +643,28 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
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
@@ -540,30 +672,64 @@ write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
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
- *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
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
+ *
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
@@ -573,32 +739,90 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
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
@@ -612,15 +836,59 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
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
@@ -634,6 +902,18 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
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
-- 
2.20.1

